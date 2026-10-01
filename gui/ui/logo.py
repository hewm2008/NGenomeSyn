from functools import lru_cache
from pathlib import Path as _Path

from PySide6.QtCore import QByteArray, QRectF, Qt
from PySide6.QtGui import QIcon, QPainter, QPixmap
from PySide6.QtSvg import QSvgRenderer

_LOGO_FILE = _Path(__file__).resolve().parent.parent.parent / "doc" / "NGenomeSyn_logo.svg"

# Read lazily/tolerantly: a missing or unreadable logo must not abort the whole
# GUI at import time (that showed up as an instant exit on launch). The icon
# then simply renders empty and --selftest reports the real cause.
try:
    LOGO_SVG = _LOGO_FILE.read_text(encoding="utf-8")
except OSError as _exc:                                   # pragma: no cover
    LOGO_SVG = ""
    _LOGO_ERROR = "%s: %s" % (_LOGO_FILE, _exc)
else:
    _LOGO_ERROR = ""

SQUARE_VIEWBOX = QRectF(0, 0, 172, 172)     # just the app mark (left part)


def logo_pixmap(square=False, size=64):
    """Render the logo; return a blank pixmap (never raise) if it is broken.

    Raising here used to abort the GUI at startup, because the About dialog and
    the window icon both call this during window construction."""
    if not LOGO_SVG:
        return QPixmap()
    renderer = QSvgRenderer(QByteArray(LOGO_SVG.encode("utf-8")))
    if not renderer.isValid():
        return QPixmap()
    if square:
        renderer.setViewBox(SQUARE_VIEWBOX)
        pixmap = QPixmap(size, size)
        pixmap.fill(Qt.transparent)
        painter = QPainter(pixmap)
        try:
            renderer.render(painter, QRectF(pixmap.rect()))
        finally:
            painter.end()
    else:
        pixmap = QPixmap(538, 172)
        pixmap.fill(Qt.white)
        painter = QPainter(pixmap)
        try:
            renderer.setViewBox(QRectF(0, 0, 538, 172))
            renderer.render(painter, QRectF(pixmap.rect()))
        finally:
            painter.end()
        pixmap.setDevicePixelRatio(2)
    return pixmap


@lru_cache(maxsize=1)
def application_icon():
    icon = QIcon()
    for size in (16, 24, 32, 48, 64, 128, 256):
        icon.addPixmap(logo_pixmap(square=True, size=size))
    return icon
