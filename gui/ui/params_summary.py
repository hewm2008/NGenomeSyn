"""“参数总览” tab: every enabled parameter across all sections on ONE page,
rendered in the same row style as the section forms — and editable.

Edits write straight into the model and are announced through
`param_changed(scope, key, value)`; MainWindow routes them to the owning
tabs (mutual sync, origin skipped via Qt sender()).
Genome/link file rows carry working 浏览/× buttons and join the sync chain."""
from PySide6.QtCore import Signal
from PySide6.QtWidgets import (QFileDialog, QFrame, QHBoxLayout, QLabel, QLineEdit,
                               QListWidget, QPushButton, QScrollArea, QSizePolicy,
                               QVBoxLayout, QWidget)

from ..core.conf_io import abspath_for
from ..core.schema import Schema
from ..i18n import I18N
from ..theme import make_card
from .param_form import ParamRow


class ParamsSummaryTab(QWidget):
    param_changed = Signal(object, str, object)   # scope, key, value
    genomes_changed = Signal(list)
    links_changed = Signal(list)

    def __init__(self, model, parent=None):
        super().__init__(parent)
        self.model = model
        self._rows = {}          # (scope, key) -> ParamRow
        self._genome_rows = {}   # genome index -> QLineEdit
        self._link_rows = {}     # link ordinal -> (a_spin, b_spin, edit)
        self._headers = {}
        self._sec_order = []
        self._building = False

        self.sec_list = QListWidget()
        self.sec_list.setMaximumWidth(175)
        self.sec_list.currentRowChanged.connect(self._nav_to_section)
        self.scroll = QScrollArea()
        self.scroll.setWidgetResizable(True)
        self.scroll.setFrameShape(QScrollArea.NoFrame)

        left = QVBoxLayout()
        left.setContentsMargins(0, 0, 0, 0)
        self.sec_title = QLabel("<b>%s</b>" % I18N.tr("show_params"))
        left.addWidget(self.sec_title)
        left.addWidget(self.sec_list)
        note = QLabel(I18N.tr("summary_nav_note"))
        note.setWordWrap(True)
        note.setStyleSheet("color: palette(mid);")
        left.addWidget(note)

        root = QHBoxLayout(self)
        root.setContentsMargins(4, 4, 4, 4)
        root.addLayout(left, 0)
        root.addWidget(self.scroll, 1)

        self.refresh()

    # ------------------------------------------------------------- refresh
    def set_model(self, model):
        self.model = model
        self.refresh()

    def refresh(self):
        if self._building:
            return
        self._building = True
        try:
            old = self.scroll.takeWidget()
            if old is not None:
                old.setParent(None)
                old.deleteLater()
            self._rows.clear()
            self._genome_rows.clear()
            self._link_rows.clear()
            self._headers.clear()
            self._sec_order = []

            central = QFrame()
            central.setObjectName("formPage")
            lay = QVBoxLayout(central)
            lay.setContentsMargins(10, 10, 10, 10)
            lay.setSpacing(12)

            secs = self._sections()
            if not secs:
                lay.addWidget(QLabel(I18N.tr("params_none")))
            for sec in secs:
                card, v = make_card(self._section_label(sec))
                self._headers[sec] = card
                self._sec_order.append(sec)
                if sec == "global":
                    for i, f in enumerate(self.model.genome_files):
                        if f:
                            v.addWidget(self._make_genome_row(i, f))
                    for n, lf in enumerate(self.model.link_files, 1):
                        v.addWidget(self._make_link_row(n, lf))
                    entries = [(k, self.model.global_params[k])
                               for k in sorted(self.model.global_params)]
                elif sec == "genome_all":
                    entries = [(k, self.model.genome_all[k])
                               for k in sorted(self.model.genome_all)]
                elif sec == "link_all":
                    entries = [(k, self.model.link_all[k])
                               for k in sorted(self.model.link_all)]
                elif isinstance(sec, tuple) and sec[0] == "genome":
                    tp = self.model.genomes.get(sec[1], {})
                    entries = [(k, tp[k]) for k in sorted(tp)]
                else:
                    tp = self.model.links.get(sec[1], {})
                    entries = [(k, tp[k]) for k in sorted(tp)]
                if not entries and sec != "global":
                    v.addWidget(QLabel(I18N.tr("params_none")))
                for key, value in entries:
                    row = self._make_param_row(sec, key, value)
                    v.addWidget(row)
                    self._rows[(sec, key)] = row
                lay.addWidget(card)

            lay.addStretch(1)
            self.scroll.setWidget(central)
            self._sync_sec_list(secs)
        finally:
            self._building = False

    def _sections(self):
        secs = []
        if any(self.model.genome_files) or self.model.link_files \
                or self.model.global_params:
            secs.append("global")
        if self.model.genome_all:
            secs.append("genome_all")
        secs += [("genome", i) for i in sorted(self.model.genomes)
                 if self.model.genomes[i]]
        if self.model.link_all:
            secs.append("link_all")
        secs += [("link", i) for i in sorted(self.model.links)
                 if self.model.links[i]]
        return secs

    @staticmethod
    def _section_label(sec):
        if sec == "global":
            return I18N.tr("global_tab")
        if sec == "genome_all":
            return I18N.tr("genome_all_tab")
        if sec == "link_all":
            return I18N.tr("link_all_tab")
        if sec[0] == "genome":
            return I18N.tr("genome_tab", n=sec[1])
        return I18N.tr("link_n", n=sec[1])

    def _sync_sec_list(self, secs):
        cur = self.sec_list.currentRow()
        self.sec_list.blockSignals(True)
        self.sec_list.clear()
        for sec in secs:
            self.sec_list.addItem(self._section_label(sec))
        if 0 <= cur < len(secs):
            self.sec_list.setCurrentRow(cur)
        self.sec_list.blockSignals(False)

    def _nav_to_section(self, row_i):
        if self._building or not (0 <= row_i < len(self._sec_order)):
            return
        header = self._headers.get(self._sec_order[row_i])
        if header is not None:
            self.scroll.verticalScrollBar().setValue(max(0, header.y() - 8))
            self.scroll.horizontalScrollBar().setValue(0)

    # ------------------------------------------------------------- sync
    def sync_value(self, scope, key, value):
        row = self._rows.get((scope, key))
        if row is not None:
            row.set_external(value)
            row.setVisible(value not in (None, ""))

    def sync_genomes(self, files):
        """In-place text update (no focus loss while typing); the page is
        rebuilt only when the structural set of non-empty files changes."""
        new_ids = [i for i, f in enumerate(files) if f]
        if new_ids != list(self._genome_rows.keys()):
            self.refresh()
            return
        for idx, edit in self._genome_rows.items():
            new = files[idx] if idx < len(files) else ""
            if edit.text() != new:
                edit.setText(new)
                edit.setToolTip(new)

    def sync_links(self, links):
        """In-place update for link rows (ordinal-keyed)."""
        if len(links) != len(self._link_rows):
            self.refresh()
            return
        for n, (a, b, edit) in self._link_rows.items():
            lf = links[n - 1]
            if edit.text() != lf["path"]:
                edit.setText(lf["path"])
                edit.setToolTip(lf["path"])
            if a.value() != lf["a"]:
                a.setValue(lf["a"])
            if b.value() != lf["b"]:
                b.setValue(lf["b"])

    # ------------------------------------------------------------- rows
    def _make_param_row(self, scope, key, value):
        p = dict(Schema.param(key) or {
            "name": key, "type": "text", "importance": 0,
            "label_zh": key, "label_en": key, "desc_zh": "", "desc_en": "",
            "old_names": [], "choices": None, "min": None, "max": None,
            "default": None, "scope": [],
        })
        row = ParamRow(p, value)
        row.changed.connect(lambda k, v, s=scope: self._on_row_changed(s, k, v))
        return row

    # ---- genome file rows
    def _make_genome_row(self, idx, path):
        cont = QWidget()
        lay = QHBoxLayout(cont)
        lay.setContentsMargins(0, 0, 0, 0)
        lay.setSpacing(4)
        lab = QLabel("GenomeInfoFile%d" % (idx + 1))
        lab.setMinimumWidth(118)
        edit = QLineEdit(path)
        edit.setMinimumWidth(80)
        edit.setSizePolicy(QSizePolicy.Ignored, QSizePolicy.Fixed)
        edit.setToolTip(path)
        edit.textEdited.connect(lambda s, i=idx: self._genome_edited(i, s))
        edit.textEdited.connect(edit.setToolTip)
        browse = QPushButton(I18N.tr("choose"))
        browse.setFixedWidth(70)
        browse.clicked.connect(lambda _c=False, i=idx: self._genome_browse(i))
        rm = QPushButton("×")
        rm.setObjectName("fileRemoveBtn")
        rm.setFixedWidth(24)
        rm.setToolTip(I18N.tr("remove_file"))
        rm.clicked.connect(lambda _c=False, i=idx: self._genome_removed(i))
        lay.addWidget(lab)
        lay.addWidget(edit, 1)
        lay.addWidget(browse)
        lay.addWidget(rm)
        self._genome_rows[idx] = edit
        return cont

    def _genome_edited(self, idx, text):
        while len(self.model.genome_files) <= idx:
            self.model.genome_files.append("")
        self.model.genome_files[idx] = text.strip()
        self.genomes_changed.emit(list(self.model.genome_files))

    def _genome_browse(self, idx):
        start = self.model.genome_files[idx] \
            if idx < len(self.model.genome_files) else ""
        f, _ = QFileDialog.getOpenFileName(self, I18N.tr("add_file"),
                                           start or ".", "Data (*.len *.gz *.txt);;All (*)")
        if f:
            while len(self.model.genome_files) <= idx:
                self.model.genome_files.append("")
            self.model.genome_files[idx] = f
            self.refresh()
            self.genomes_changed.emit(list(self.model.genome_files))

    def _genome_removed(self, idx):
        files = self.model.genome_files
        if idx == 0:
            files[0] = ""                    # GenomeInfoFile1 stays
        else:
            del files[idx]
        self.refresh()
        self.genomes_changed.emit(list(files))

    # ---- link file rows
    def _make_link_row(self, ordinal, lf):
        cont = QWidget()
        lay = QHBoxLayout(cont)
        lay.setContentsMargins(0, 0, 0, 0)
        lay.setSpacing(4)
        lab = QLabel("Link%d" % ordinal)
        lab.setMinimumWidth(118)
        a = self._spin(lf["a"])
        b = self._spin(lf["b"])
        edit = QLineEdit(lf["path"])
        edit.setMinimumWidth(80)
        edit.setSizePolicy(QSizePolicy.Ignored, QSizePolicy.Fixed)
        edit.setToolTip(lf["path"])
        a.valueChanged.connect(lambda v, n=ordinal: self._link_changed(n, a=v))
        b.valueChanged.connect(lambda v, n=ordinal: self._link_changed(n, b=v))
        edit.textEdited.connect(lambda s, n=ordinal: self._link_changed(n, p=s))
        browse = QPushButton(I18N.tr("choose"))
        browse.setFixedWidth(70)
        browse.clicked.connect(lambda _c=False, n=ordinal: self._link_browse(n))
        rm = QPushButton("×")
        rm.setObjectName("fileRemoveBtn")
        rm.setFixedWidth(24)
        rm.clicked.connect(lambda _c=False, n=ordinal: self._link_removed(n))
        for w in (lab, a, b, edit, browse, rm):
            lay.addWidget(w)
        self._link_rows[ordinal] = (a, b, edit)
        return cont

    @staticmethod
    def _spin(value):
        from PySide6.QtWidgets import QSpinBox
        sp = QSpinBox()
        sp.setRange(1, 99)
        sp.setPrefix("A:" if value else "")
        sp.setValue(value)
        sp.setFixedWidth(70)
        return sp

    def _link_changed(self, ordinal, a=None, b=None, p=None):
        if ordinal <= len(self.model.link_files):
            lf = self.model.link_files[ordinal - 1]
            if a is not None:
                lf["a"] = int(a)
            if b is not None:
                lf["b"] = int(b)
            if p is not None:
                lf["path"] = p.strip()
            self.links_changed.emit(list(self.model.link_files))

    def _link_browse(self, ordinal):
        start = self.model.link_files[ordinal - 1]["path"] \
            if ordinal <= len(self.model.link_files) else ""
        f, _ = QFileDialog.getOpenFileName(self, I18N.tr("add_file"),
                                           start or ".", "Data (*.link *.gz *.txt);;All (*)")
        if f:
            self._link_changed(ordinal, p=f)
            self.refresh()

    def _link_removed(self, ordinal):
        if ordinal <= len(self.model.link_files):
            self.model.link_files.pop(ordinal - 1)
            self.refresh()
            self.links_changed.emit(list(self.model.link_files))

    def _on_row_changed(self, scope, key, value):
        self.model.set_param(scope, key, value)
        self.param_changed.emit(scope, key, value)

    # kept for callers resolving typed paths
    @staticmethod
    def _abs(value, base):
        return abspath_for(value, base)
