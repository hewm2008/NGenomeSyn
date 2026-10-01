#!/usr/bin/env python3
"""NGenomeSyn GUI entry point.

Requires: Python 3.9+ with PySide6.
Run:  python3 gui/main.py             (from the NGenomeSyn root, any cwd works)
      python3 gui/main.py --selftest  (environment check, no window)
      python3 gui/main.py --safe      (no theme/icon, for bisecting a crash)

"""
import os
import sys
import time
import traceback
from pathlib import Path

GUI_DIR = Path(__file__).resolve().parent
ROOT = GUI_DIR.parent
for p in (str(GUI_DIR), str(ROOT)):
    if p not in sys.path:
        sys.path.insert(0, p)


def _log(msg):
    """Progress breadcrumb on stderr (a console is attached in dev mode)."""
    try:
        sys.stderr.write("[%s] %s\n" % (time.strftime("%H:%M:%S"), msg))
        sys.stderr.flush()
    except Exception:                                  # noqa: BLE001
        pass


def _fatal(where, exc):
    """Last-resort reporting: console text plus a native message box.

    The box works without PySide6 (ctypes only), so a broken install still
    tells the user what happened instead of closing silently."""
    text = "NGenomeSyn GUI failed during %s:\n\n%s" % (
        where, "".join(traceback.format_exception(type(exc), exc, exc.__traceback__)))
    _log(text)
    try:
        import ctypes
        ctypes.windll.user32.MessageBoxW(0, text[:2000], "NGenomeSyn GUI Error", 0x10)
    except Exception:                                  # noqa: BLE001
        pass
    return 1


def selftest():
    """Verify everything the GUI needs BEFORE showing a window.

    Run with the console python so a failure is visible instead of a flash.
    """
    print("NGenomeSyn GUI self-test")
    print("  root       :", ROOT)
    ok = True

    def step(label, fn):
        nonlocal ok
        try:
            detail = fn()
            print("  [ OK ] %-22s %s" % (label, detail if detail else ""))
        except Exception as e:                          # noqa: BLE001
            ok = False
            print("  [FAIL] %-22s %s: %s" % (label, type(e).__name__, e))

    def _pyside():
        import PySide6
        return "PySide6 " + PySide6.__version__
    step("PySide6", _pyside)

    def _platform_plugins():
        from PySide6.QtGui import QGuiApplication
        app = QGuiApplication.instance() or QGuiApplication([])
        ok_str, _ = app.platformName(), ""
        return "platform plugin: %s" % (ok_str or "?")
    step("Qt platform plugin", _platform_plugins)

    def _schema():
        from gui.core.schema import Schema
        return "%d params, %d palettes" % (len(Schema.params()),
                                           len(Schema.palettes()["builtin"]))
    step("parameter schema", _schema)

    def _logo():
        from gui.ui import logo as _logo_mod
        path = _logo_mod._LOGO_FILE
        if not path.is_file():
            raise FileNotFoundError(str(path))
        return path.name
    step("logo asset", _logo)

    def _engine():
        from gui.core.runner import find_engine
        e = find_engine()
        if not e or not Path(e).is_file():
            raise FileNotFoundError("bin/NGenomeSyn not found next to gui/")
        return Path(e).name
    step("perl engine", _engine)

    def _svgkit():
        from gui.core.runner import find_engine
        e = find_engine()
        if not e:
            raise FileNotFoundError("engine missing")
        kit = Path(e).parent / "svg_kit" / "SVG.pm"
        if not kit.is_file():
            raise FileNotFoundError("bin/svg_kit/SVG.pm missing")
        return "svg_kit/SVG.pm"
    step("bundled svg_kit", _svgkit)

    def _perl():
        from gui.core.runner import find_perl
        p = find_perl()
        if not p:
            raise FileNotFoundError(
                "no perl in PATH (Windows: unzip portable Strawberry Perl "
                "into gui_runtime/perl/)")
        return p
    step("perl runtime", _perl)

    def _perl_runs():
        """Perl must actually EXECUTE the engine (module load, FindBin, svg_kit).
        This is the check that catches a broken portable Perl on Windows."""
        import subprocess
        from gui.core.runner import find_engine, find_perl
        eng, per = find_engine(), find_perl()
        if not (eng and per):
            raise RuntimeError("engine or perl missing")
        r = subprocess.run([per, "-c", str(eng)], cwd=str(ROOT),
                           capture_output=True, text=True, timeout=180)
        if r.returncode != 0:
            raise RuntimeError((r.stderr or r.stdout).strip()[-300:])
        return "perl -c NGenomeSyn OK"
    step("engine compiles", _perl_runs)

    def _qt():
        from PySide6.QtWidgets import QApplication
        QApplication.instance() or QApplication([])
        from gui.ui.logo import logo_pixmap
        pm = logo_pixmap(square=True, size=32)          # renders the app icon
        if pm.isNull():
            from gui.ui import logo as _m
            raise RuntimeError("icon empty (%s)" % (_m._LOGO_ERROR or "bad SVG"))
        return "app icon renders (%dx%d)" % (pm.width(), pm.height())
    step("Qt rendering", _qt)

    def _write():
        d = Path(os.environ.get("TEMP") or os.environ.get("TMP") or str(ROOT)) / "ngs_gui_probe"
        d.mkdir(parents=True, exist_ok=True)
        p = d / "probe.txt"
        p.write_text("ok", encoding="utf-8")
        p.unlink()
        return str(d)
    step("temp dir writable", _write)

    print("  result     :", "PASS" if ok else "FAIL")
    return 0 if ok else 1


def main():
    if "--selftest" in sys.argv:
        return selftest()
    safe = "--safe" in sys.argv
    _log("stage: interpreter OK (safe=%s)" % safe)

    try:
        from PySide6.QtWidgets import QApplication
    except ImportError as e:
        return _fatal("startup (PySide6 missing)", e)
    _log("stage: PySide6 imported")
    try:
        from gui.ui.logo import application_icon
        from gui.ui.main_window import MainWindow
    except Exception as e:                              # noqa: BLE001
        return _fatal("startup (module import)", e)
    _log("stage: GUI modules imported")

    try:
        app = QApplication(sys.argv)
    except Exception as e:                              # noqa: BLE001
        return _fatal("startup (QApplication)", e)
    app.setApplicationName("NGenomeSyn")
    app.setApplicationDisplayName("NGenomeSyn")
    app.setOrganizationName("NGenomeSyn")
    _log("stage: QApplication created (platform=%s)" % app.platformName())

    if not safe:
        try:
            from gui.theme import apply_system_theme
            apply_system_theme(app)
            _log("stage: theme applied")
        except Exception as e:                          # noqa: BLE001
            _log("theme failed (continuing): %r" % (e,))

    # uncaught exceptions (including inside Qt slots) must never vanish,
    # especially under pythonw where there is no console at all
    def _excepthook(etype, value, tb):
        msg = "".join(traceback.format_exception(etype, value, tb))[-4000:]
        _log(msg)
        try:
            from PySide6.QtCore import Qt
            from PySide6.QtWidgets import QMessageBox
            box = QMessageBox(QMessageBox.Critical, "NGenomeSyn GUI Error", msg)
            box.setTextInteractionFlags(Qt.TextSelectableByMouse)
            box.exec()
        except Exception:                              # noqa: BLE001
            pass
    sys.excepthook = _excepthook

    try:
        if not safe:
            app.setWindowIcon(application_icon())
        _log("stage: icon set")
        win = MainWindow()
        _log("stage: MainWindow constructed")
        win.show()
        _log("stage: window shown - entering event loop")
    except Exception as e:                              # noqa: BLE001
        return _fatal("startup (window creation)", e)
    rc = app.exec()
    _log("stage: event loop finished rc=%s" % rc)
    return rc


if __name__ == "__main__":
    sys.exit(main())
