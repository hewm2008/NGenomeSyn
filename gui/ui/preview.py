"""SVG preview (QGraphicsView + QGraphicsSvgItem) with zoom and PNG/PDF export."""
from PySide6.QtCore import QRectF, QSizeF, Qt
from PySide6.QtGui import QColor, QImage, QPainter, QPdfWriter, QPageSize, QPen, QBrush
from PySide6.QtWidgets import QGraphicsRectItem, QGraphicsScene, QGraphicsView, QLabel, QVBoxLayout, QWidget
from PySide6.QtSvg import QSvgRenderer
from PySide6.QtSvgWidgets import QGraphicsSvgItem

from ..i18n import I18N


class _SvgView(QGraphicsView):
    """QGraphicsView with wheel zoom + hand-drag panning."""

    def __init__(self, owner, parent=None):
        super().__init__(parent)
        self._owner = owner
        self.setDragMode(QGraphicsView.ScrollHandDrag)          # drag to pan
        self.setTransformationAnchor(QGraphicsView.AnchorUnderMouse)
        self.setResizeAnchor(QGraphicsView.ViewportAnchor.AnchorViewCenter)
        self.setCursor(Qt.OpenHandCursor)

    def wheelEvent(self, ev):
        delta = ev.angleDelta().y()
        if delta > 0:
            self._owner.zoom_in()
        elif delta < 0:
            self._owner.zoom_out()
        ev.accept()


class PreviewView(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._renderer = None
        self._item = None
        self._source_path = ""
        self._zoom = 1.0
        self._animated = False

        self.view = _SvgView(self)
        self.scene = QGraphicsScene(self)
        self.view.setScene(self.scene)
        self.view.setRenderHints(QPainter.Antialiasing | QPainter.SmoothPixmapTransform)

        self.hint = QLabel("")
        self.hint.setWordWrap(True)
        self.hint.setStyleSheet("color: palette(mid); padding:2px;")
        self.hint.hide()

        # stale-hint overlay (bottom-LEFT inside the preview, no layout impact)
        self.stale_label = QLabel("", self)
        self.stale_label.setStyleSheet(
            "color: white; background: rgba(138,109,26,215);"
            "border-radius: 5px; padding: 4px 14px; font-weight: 600;")
        self.stale_label.hide()

        # install the layout exactly once (NOT in hide_stale: doing it there
        # made Qt warn "already has a layout" and, worse, orphaned the view)
        lay = QVBoxLayout(self)
        lay.setContentsMargins(0, 0, 0, 0)
        lay.addWidget(self.view, 1)
        lay.addWidget(self.hint)

    def resizeEvent(self, ev):
        self._reposition_stale()
        super().resizeEvent(ev)

    def _reposition_stale(self):
        self.stale_label.adjustSize()
        self.stale_label.move(12, self.height() - self.stale_label.height() - 10)

    def show_stale(self, text, error=False):
        """Floating hint at the BOTTOM-LEFT of the preview (no layout impact)."""
        self.stale_label.setText(text)
        self.stale_label.setStyleSheet(
            ("color: white; background: rgba(190,60,60,230);"
             "border-radius: 5px; padding: 4px 14px; font-weight: 600;") if error else
            ("color: white; background: rgba(138,109,26,215);"
             "border-radius: 5px; padding: 4px 14px; font-weight: 600;"))
        self.stale_label.show()
        self.stale_label.raise_()
        self._reposition_stale()

    def hide_stale(self):
        self.stale_label.hide()

    def reset(self):
        """Forget the current figure (new project). Without this has_svg()
        stayed true and exporting kept writing the previous project's SVG."""
        self.scene.clear()
        self._renderer = None
        self._item = None
        self._source_path = ""
        self._zoom = 1.0
        self._animated = False
        self.hint.setVisible(False)
        self.hide_stale()

    # ------------------------------------------------------------- loading
    def load_svg(self, path):
        self._renderer = QSvgRenderer(path)
        if not self._renderer.isValid():
            return False
        self._source_path = str(path)
        self.scene.clear()
        self._item = QGraphicsSvgItem()
        self._item.setSharedRenderer(self._renderer)
        # white "paper" sheet behind the SVG: figures keep a light canvas in
        # dark mode, matching the white-filled PNG/PDF export
        bounds = QRectF(self._item.boundingRect())
        paper = self.scene.addRect(bounds.adjusted(-2, -2, 2, 2),
                                   QPen(QColor(128, 128, 128)),
                                   QBrush(QColor("#ffffff")))
        paper.setZValue(-1)
        self.scene.addItem(self._item)
        self.scene.setSceneRect(bounds.adjusted(-2, -2, 2, 2))
        self._zoom = 1.0
        self.fit_view()
        try:
            with open(path, "r", encoding="utf-8", errors="ignore") as fh:
                head = fh.read(200000)
            self._animated = "<animate" in head or "<animateTransform" in head
        except OSError:
            self._animated = False
        self.hint.setVisible(self._animated)
        if self._animated:
            self.hint.setText(I18N.tr("animated_hint", f=path))
        return True

    def has_svg(self):
        return self._renderer is not None and self._renderer.isValid()

    def source_path(self):
        """File the current preview was loaded from ('' if none)."""
        return self._source_path if self.has_svg() else ""

    # ------------------------------------------------------------- zoom
    def _apply_zoom(self):
        self.view.resetTransform()
        self.view.scale(self._zoom, self._zoom)

    def zoom_in(self):
        self._zoom = min(self._zoom * 1.25, 16)
        self._apply_zoom()

    def zoom_out(self):
        self._zoom = max(self._zoom / 1.25, 0.05)
        self._apply_zoom()

    def fit_view(self):
        if self.scene.sceneRect().isEmpty():
            return
        self.view.resetTransform()
        self.view.fitInView(self.scene.sceneRect(), Qt.KeepAspectRatio)
        m11 = self.view.transform().m11()
        self._zoom = m11 if m11 > 0 else 1.0

    def scale_view(self, factor):
        self._zoom = min(max(factor, 0.05), 16)
        self._apply_zoom()

    # ------------------------------------------------------------- export
    def export_png(self, path, width=None):
        if not self.has_svg():
            return False
        dsize = self._renderer.defaultSize()
        if dsize.width() <= 0 or dsize.height() <= 0:
            return False                      # no intrinsic size: cannot scale
        if not width:
            width = dsize.width() * 2
        width = max(64, int(width))
        height = max(64, int(round(width * dsize.height() / dsize.width())))
        img = QImage(width, height, QImage.Format_ARGB32)
        img.fill(QColor(Qt.white))
        p = QPainter(img)
        self._renderer.render(p, QRectF(0, 0, width, height))
        p.end()
        return img.save(path, "PNG")

    def export_pdf(self, path):
        if not self.has_svg():
            return False
        dsize = self._renderer.defaultSize()
        if dsize.width() <= 0 or dsize.height() <= 0:
            return False
        writer = QPdfWriter(path)
        size = QPageSize(QSizeF(self._mm(dsize.width()), self._mm(dsize.height())),
                         QPageSize.Millimeter)
        writer.setPageSize(size)
        writer.setResolution(96)
        p = QPainter(writer)
        if not p.isActive():
            return False                      # unwritable path / bad page size
        # white sheet behind the figure, matching the PNG export
        p.fillRect(QRectF(0, 0, writer.width(), writer.height()), QColor(Qt.white))
        self._renderer.render(p, QRectF(0, 0, writer.width(), writer.height()))
        p.end()
        return True

    @staticmethod
    def _mm(px):
        return px * 25.4 / 96.0
