#!/usr/bin/env python3
"""Capture the GUI screenshots used by the README, manuals and article.

Runs headless (offscreen QPA) with an isolated QSettings, then:
  1. loads a real example conf (Example/example2/in1.conf)
  2. ACTUALLY RUNS the engine, so the centre pane shows a real figure
  3. selects a non-default genome so the selection feature is visible
  4. grabs:
       gui/doc/GUI_Home.png  whole main window (light theme, with figure)
       gui/doc/GUI_Data.png  left dock: the two file lists + preview

The SVG is written next to the example conf (that is where the GUI would put
it); pass --clean to remove it afterwards.

Run:  python3 gui/tools/gen_screenshots.py [--clean]
"""
import os
import sys
import tempfile
from pathlib import Path

os.environ.setdefault("QT_QPA_PLATFORM", "offscreen")

ROOT = Path(__file__).resolve().parents[2]
DOC = ROOT / "gui" / "doc"
SHOT = DOC / "GUI_Home.png"
SHOT_DATA = DOC / "GUI_Data.png"
EXAMPLE = ROOT / "Example/example2/in1.conf"
RUN_TIMEOUT_MS = 180000


def _grab(widget, path, settle=True):
    """Grab a widget and normalise the PNG.

    Qt's grab() can emit a PNG that PIL/python-docx refuse, so the file is
    re-encoded through PIL - that also shrinks the manuals."""
    if settle:
        from PySide6.QtWidgets import QApplication
        QApplication.processEvents()
    pm = widget.grab()
    tmp = Path(str(path) + ".raw.png")
    pm.save(str(tmp), "PNG")
    ok = _normalise(tmp, path)
    tmp.unlink(missing_ok=True)
    size = path.stat().st_size if path.is_file() else 0
    print("  %-22s %s  (%d bytes)%s" % (path.name, _fmt(pm), size,
                                        "" if ok else "   !! invalid"))
    return ok and size > 5000


def _fmt(pm):
    return "%dx%d" % (pm.width(), pm.height())


def _normalise(src, dst):
    """Re-encode through PIL so python-docx can embed the PNG.

    On failure nothing is written: copying the raw bytes once produced a file
    that was not a PNG at all, which only surfaced later inside python-docx."""
    try:
        from PIL import Image
        im = Image.open(src)
        im.load()
        im.convert("RGB").save(dst, "PNG", optimize=True)
        return dst.read_bytes()[:8] == b"\x89PNG\r\n\x1a\n"
    except Exception as e:                              # noqa: BLE001
        Path(dst).unlink(missing_ok=True)
        print("     (PIL failed: %s)" % e)
        return False


def _run_engine(win, app):
    """Run the engine on the loaded conf and show the figure in the preview."""
    from PySide6.QtCore import QEventLoop, QTimer
    win._dirty = True                    # in case auto-refresh is off
    win._auto_timer.stop()
    win.chk_auto.setChecked(False)
    loop = QEventLoop()
    result = {}
    win.runner.finished_ok.connect(lambda p: (result.update(svg=p), loop.quit()))
    win.runner.failed.connect(lambda r: (result.update(fail=r), loop.quit()))
    print("  running the engine (example2/in1.conf) ...")
    app.processEvents()
    win._run_impl(auto=True)
    QTimer.singleShot(RUN_TIMEOUT_MS, loop.quit)
    loop.exec()
    svg = result.get("svg")
    if not svg:
        print("  !! engine failed: %s" % result.get("fail"))
        return None
    if not win.preview.load_svg(svg):
        print("  !! preview refused the SVG")
        return None
    # settle: the scene needs a paint pass before grab()
    win.preview.fit_view()
    app.processEvents()
    return svg


def _select_last_genome(win, app):
    panel = win.files_panel.genome_panel
    n = len(panel.preview.items())
    if n >= 2:
        panel.select_row(n - 1)
    app.processEvents()


def main(clean=False):
    from PySide6.QtCore import QSettings
    QSettings.setPath(QSettings.IniFormat, QSettings.UserScope,
                      tempfile.mkdtemp(prefix="ngs_shots_"))
    from PySide6.QtWidgets import QApplication
    app = QApplication.instance() or QApplication(sys.argv)
    from gui.theme import apply_system_theme
    apply_system_theme(app)

    from gui.ui.main_window import MainWindow
    win = MainWindow()
    # wide window + narrow side docks: the synteny figure is wide, so give the
    # centre pane as much room as possible
    win.resize(1760, 900)
    win.files_dock.setMinimumWidth(300)
    win.files_dock.setMaximumWidth(330)
    win.params_dock.setMinimumWidth(560)
    win.params_dock.setMaximumWidth(700)
    win.model.load(str(EXAMPLE))
    win.files_panel.sync_genomes(win.model.genome_files)
    win.files_panel.sync_links(win.model.link_files, force=True)
    # put the output next to the example, exactly like a normal run would
    win.out_dir = EXAMPLE.parent
    win.out_name = EXAMPLE.stem
    win._rebuild_param_tabs()
    win.show()
    app.processEvents()

    svg = _run_engine(win, app)
    if svg is None:
        win.close()
        return 1
    print("  engine ok: %s" % svg)
    win._preview_stale = False
    win.preview.hide_stale()
    win.chk_auto.setChecked(False)       # keep the checkbox readable
    # the log would otherwise expose this machine's absolute paths
    win.log.clear()
    win.log.appendPlainText("$ perl bin/NGenomeSyn -InConf in1.conf "
                            "-OutPut OUT -NoPng")
    win.log.appendPlainText("Warining: SVG module in Perl is missing, "
                            "trying to loading the built-in [SVG.pm]...")
    win.log.appendPlainText("Loading SVG module done")
    win.log.appendPlainText("Para [NoPng] ,so only SVG file...")
    win.statusBar().showMessage(I18N_done := "完成 / Done: %s" % Path(svg).name)
    app.processEvents()
    # the Global params tab shows the data-grouping cards: pick that page
    win.param_tabs.setCurrentIndex(0)
    app.processEvents()
    _select_last_genome(win, app)
    app.processEvents()

    DOC.mkdir(parents=True, exist_ok=True)
    print("rendering screenshots:")
    ok = _grab(win, SHOT)
    # the detail shot needs the full row width: at the 300px dock width the
    # file rows and the preview columns are cut off on the right
    win.files_dock.setMinimumWidth(430)
    win.files_dock.setMaximumWidth(430)
    app.processEvents()
    _grab(win.files_panel, SHOT_DATA)
    win.close()
    if clean and Path(svg).is_file():
        Path(svg).unlink()
        print("  removed %s" % svg)
    print("done." if ok else "WARNING: main screenshot looks empty")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.path.insert(0, str(ROOT))
    sys.exit(main(clean="--clean" in sys.argv))
