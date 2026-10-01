"""Lazy per-genome / per-link tabs (one sparse section each).

Same lazy machinery as RectChr's track tabs: a conf with many Genome/Link
sections must not build thousands of widgets on import or language switch —
each page materializes on first show, and the model stays the single source
of truth.
"""
from PySide6.QtCore import Signal
from PySide6.QtWidgets import QLabel, QVBoxLayout, QWidget

from ..i18n import I18N
from .param_form import ParamForm


def genome_tab_title(model, index):
    return I18N.tr("genome_tab", n=index)


def link_tab_title(model, index):
    lf = model.link_files[index - 1] if index <= len(model.link_files) else None
    base = I18N.tr("link_n", n=index)
    if lf:
        return "%s · %d↔%d" % (base, lf["a"], lf["b"])
    return base


class LazyPage(QWidget):
    """Placeholder tab that builds its content the first time it is shown."""

    def __init__(self, build, title_fn=None, on_built=None, parent=None):
        super().__init__(parent)
        self._build = build
        self._title_fn = title_fn
        self._on_built = on_built
        self.widget = None
        self._lay = QVBoxLayout(self)
        self._lay.setContentsMargins(0, 0, 0, 0)

    def materialized(self):
        return self.widget is not None

    def materialize(self):
        if self.widget is None:
            self.widget = self._build()
            self._lay.addWidget(self.widget)
            if self._on_built is not None:
                self._on_built(self)
        return self.widget

    def tab_title(self):
        return self._title_fn() if self._title_fn is not None else ""

    def sync_param(self, key, value):
        if self.materialized():
            self.widget.sync_param(key, value)

    def sync_header(self):
        if self.materialized() and hasattr(self.widget, "refresh_header"):
            self.widget.refresh_header()


class LazyGenomePage(LazyPage):
    def __init__(self, model, index, on_built=None, parent=None):
        super().__init__(build=None,
                         title_fn=lambda: genome_tab_title(model, index),
                         on_built=on_built, parent=parent)
        self.model = model
        self.index = index                    # 1-based genome number
        self.tab = None
        self._build = self._make_tab

    def _make_tab(self):
        self.tab = GenomeTab(self.model, self.index)
        return self.tab


class LazyLinkPage(LazyPage):
    def __init__(self, model, index, on_built=None, parent=None):
        super().__init__(build=None,
                         title_fn=lambda: link_tab_title(model, index),
                         on_built=on_built, parent=parent)
        self.model = model
        self.index = index                    # 1-based link ordinal
        self.tab = None
        self._build = self._make_tab

    def _make_tab(self):
        self.tab = LinkTab(self.model, self.index)
        return self.tab


class _SectionTab(QWidget):
    """Shared tab body: context header + ParamForm for a tuple scope."""
    changed = Signal()
    param_changed = Signal(object, str, object)

    def __init__(self, scope, model, hint_fn, parent=None):
        super().__init__(parent)
        self.scope = scope
        self.model = model
        self._hint_fn = hint_fn
        self.header = QLabel("")
        self.header.setStyleSheet("color: palette(mid); padding: 2px 6px;")
        self.form = ParamForm(scope, model)
        self.form.any_changed.connect(self._on_any)
        self.form.param_changed.connect(
            lambda s, k, v: self.param_changed.emit(s, k, v))
        root = QVBoxLayout(self)
        root.setContentsMargins(2, 2, 2, 2)
        root.addWidget(self.header)
        root.addWidget(self.form, 1)
        self.refresh_header()

    def refresh_header(self):
        self.header.setText(self._hint_fn())

    def sync_param(self, key, value):
        self.form.sync_row(key, value)

    def _on_any(self, *_a):
        self.changed.emit()
        self.refresh_header()


def _genome_name(path):
    from .files_panel import genome_name_for
    return genome_name_for(path)


class GenomeTab(_SectionTab):
    """One GenomeN section: header shows the genome file + derived name."""

    def __init__(self, model, index, parent=None):
        self._index = index
        self._model = model
        super().__init__(("genome", index), model, self._hint, parent=parent)

    @property
    def index(self):
        """1-based genome number (same name as LazyGenomePage.index)."""
        return self._index

    def _hint(self):
        files = self._model.genome_files
        f = files[self._index - 1] if self._index <= len(files) else ""
        if not f:
            return "%s — (%s)" % (I18N.tr("genome_tab", n=self._index),
                                  I18N.tr("genome_file_hint"))
        return "GenomeInfoFile%d: %s   →   %s" % (
            self._index, f, _genome_name(f))


class LinkTab(_SectionTab):
    """One LinkN section: header shows the link file + genome pair."""

    def __init__(self, model, index, parent=None):
        self._index = index
        self._model = model
        super().__init__(("link", index), model, self._hint, parent=parent)

    @property
    def index(self):
        """1-based link ordinal (same name as LazyLinkPage.index)."""
        return self._index

    def _hint(self):
        lf = self._model.link_files[self._index - 1] \
            if self._index <= len(self._model.link_files) else None
        if not lf:
            return I18N.tr("link_n", n=self._index)
        return "LinkFileRef%dVsRef%d: %s" % (lf["a"], lf["b"], lf["path"])
