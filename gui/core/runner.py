"""Locate the Perl runtime + engine and run NGenomeSyn in a QProcess.

Engine contract notes (bin/NGenomeSyn 1.50):
  - invoked as:  perl bin/NGenomeSyn -InConf <conf> -OutPut <base> [-NoPng]
  - output is <base>.svg (+ <base>.png via ImageMagick unless -NoPng)
  - SUCCESS exits with status 1 when -NoPng is given (:3031), while several
    error paths exit 0 — so the exit code is meaningless here. Success is
    declared only when the SVG exists and is non-empty.
  - the GUI always passes -NoPng and renders PNG/PDF itself (QSvgRenderer),
    which also keeps ImageMagick completely out of the loop.
"""
import shutil
import sys
from pathlib import Path

from PySide6.QtCore import QObject, QTimer, QProcess, Signal

GUI_DIR = Path(__file__).resolve().parents[1]
ROOT = GUI_DIR.parent
if sys.platform == "darwin" and getattr(sys, "frozen", False):
    ROOT = Path(sys.executable).resolve().parent.parent / "Resources"
ENGINE = ROOT / "bin" / "NGenomeSyn"


def find_perl():
    """Portable bundled perl first (Windows), then system PATH."""
    import os
    if os.name == "nt":
        candidates = []
        exe_dir = Path(sys.executable).parent          # PyInstaller onedir
        for base in (exe_dir, GUI_DIR, ROOT, Path.cwd()):
            candidates += [
                base / "gui_runtime" / "perl" / "perl" / "bin" / "perl.exe",
                base / "gui_runtime" / "perl" / "bin" / "perl.exe",
            ]
        for c in candidates:
            if c.is_file():
                return str(c)
    return shutil.which("perl") or shutil.which("perl.exe")


def find_engine():
    for base in (Path(sys.executable).parent, ROOT, Path.cwd()):
        cand = base / "bin" / "NGenomeSyn" if base != ROOT else ENGINE
        if cand.is_file():
            return cand
    return ENGINE if ENGINE.is_file() else None


class Runner(QObject):
    output = Signal(str)
    finished_ok = Signal(str)      # svg path
    failed = Signal(str)

    ENGINE_TIMEOUT_MS = 600000          # hard kill after 10 minutes

    def __init__(self, parent=None):
        super().__init__(parent)
        self._proc = None
        self._out_base = ""
        self._reported = False
        self._timeout = QTimer(self)
        self._timeout.setSingleShot(True)
        self._timeout.setInterval(self.ENGINE_TIMEOUT_MS)
        self._timeout.timeout.connect(self._on_engine_timeout)

    def running(self):
        return self._proc is not None and self._proc.state() != QProcess.NotRunning

    def stop(self):
        if self.running():
            self._proc.kill()

    def run(self, conf_path, out_base):
        perl = find_perl()
        engine = find_engine()
        if not perl:
            self.failed.emit("perl-not-found")
            return
        if not engine or not engine.is_file():
            self.failed.emit("engine-not-found")
            return

        out_base = str(out_base)
        if out_base.lower().endswith(".svg"):
            out_base = out_base[:-4]

        self._proc = QProcess(self)
        self._proc.setWorkingDirectory(str(ROOT))
        self._proc.readyReadStandardOutput.connect(self._drain_out)
        self._proc.readyReadStandardError.connect(self._drain_err)
        self._proc.finished.connect(self._on_finished)
        # Qt does NOT emit finished() when the process cannot start, so
        # without this a bad launch left the UI busy forever
        self._proc.errorOccurred.connect(self._on_proc_error)
        self._out_base = out_base
        self._reported = False
        self._timeout.start()
        self._proc.start(perl, [str(engine), "-InConf", str(conf_path),
                                "-OutPut", out_base, "-NoPng"])

    def _on_engine_timeout(self):
        if self.running():
            self._proc.kill()
            self._fail("engine-timeout (>600s)")

    def _fail(self, reason):
        """Emit `failed` at most once per run."""
        if self._reported:
            return
        self._reported = True
        self.failed.emit(reason)

    # ------------------------------------------------------------- slots
    def _drain_out(self):
        data = bytes(self._proc.readAllStandardOutput()).decode("utf-8", "replace")
        if data:
            self.output.emit(data)

    def _drain_err(self):
        data = bytes(self._proc.readAllStandardError()).decode("utf-8", "replace")
        if data:
            self.output.emit(data)

    def _on_proc_error(self, err):
        from PySide6.QtCore import QProcess as _QP
        if err == _QP.FailedToStart:
            self._timeout.stop()
            self._fail("engine-start-failed")

    def _on_finished(self, code, _status):
        self._timeout.stop()
        self._drain_out()
        self._drain_err()
        svg = Path(self._out_base + ".svg")
        # the exit code is unreliable in this engine: -NoPng success exits 1,
        # some error paths exit 0. The SVG existing and being non-empty is
        # the only trustworthy signal.
        if svg.is_file() and svg.stat().st_size > 0:
            self._reported = True
            self.finished_ok.emit(str(svg))
        else:
            self._fail("no-svg (exit=%s)" % code)
