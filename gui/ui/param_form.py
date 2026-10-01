"""Reusable parameter form built from the schema (one instance per section)."""
from PySide6.QtCore import QSize, Qt, Signal
from PySide6.QtGui import QColor, QPainter, QPixmap
from PySide6.QtWidgets import (QCheckBox, QColorDialog, QComboBox, QDialog,
                               QDialogButtonBox, QDoubleSpinBox, QFrame,
                               QHBoxLayout, QLabel, QLineEdit, QListWidget,
                               QListWidgetItem, QPushButton, QScrollArea,
                               QSpinBox, QVBoxLayout, QWidget)

from ..core.schema import Schema
from ..i18n import I18N
from ..theme import make_card
from .files_panel import GenomeFilesBar, LinkFilesBar

WIDE = 999999999

# params rendered with the palette picker (engine-enum validated)
PALETTE_KEYS = ("GenomeColorBrewer", "ChrColorBrewer", "SpeRegionColorBrewer")


def _schema_scope(scope):
    """UI scope -> schema scope ('global' | 'genome' | 'link')."""
    if isinstance(scope, tuple):
        return scope[0]
    return {"genome_all": "genome", "link_all": "link"}.get(scope, scope)


def _fmt_label(p):
    lang = I18N.lang()
    label = p.get("label_zh" if lang == "zh" else "label_en") or p["name"]
    if label == p["name"]:
        return p["name"]
    return "%s  (%s)" % (label, p["name"])


def _fmt_tooltip(p):
    zh = p.get("desc_zh") or ""
    en = p.get("desc_en") or ""
    tip = p["name"]
    if zh:
        tip += "\nZH: " + zh
    if en:
        tip += "\nEN: " + en
    rng = _range_text(p)
    if rng:
        tip += "\n" + rng
    d = p.get("default")
    if d not in (None, ""):
        tip += "\n" + (("默认: %s" if I18N.lang() == "zh" else "Default: %s") % d)
    old = p.get("old_names") or []
    if old:
        tip += "\nlegacy: " + ", ".join(old)
    return tip


def _range_text(p):
    if p.get("type") not in ("int", "float"):
        return ""
    mn, mx = p.get("min"), p.get("max")
    if mn is None and mx is None:
        return ""
    lo = "-∞" if mn is None else str(mn)
    hi = "∞" if mx is None else str(mx)
    return ("范围 %s–%s" if I18N.lang() == "zh" else "range %s–%s") % (lo, hi)


def _default_hint_text(p):
    lang = I18N.lang()
    rng = _range_text(p)
    d = p.get("default")
    if d in (None, ""):
        return rng
    base = ("默认: %s" if lang == "zh" else "Default: %s") % d
    return "%s（%s）" % (base, rng) if rng else base


class ColorButton(QPushButton):
    picked = Signal(str)

    def __init__(self, value="", parent=None):
        super().__init__(parent)
        self.setFixedWidth(70)
        self.value = value
        self._apply()
        self.clicked.connect(self._pick)

    def _apply(self):
        if self.value and self.value.startswith("#"):
            self.setText("")
            self.setStyleSheet("background-color:%s;border:1px solid palette(mid);"
                               % self.value)
        else:
            self.setStyleSheet("")
            self.setText(self.value or "…")

    def _pick(self):
        c = QColorDialog.getColor(QColor(self.value) if self.value.startswith("#") else QColor("#888888"),
                                  self, "", QColorDialog.ShowAlphaChannel)
        if c.isValid():
            self.value = c.name(QColor.HexArgb) if c.alpha() < 255 else c.name()
            self._apply()
            self.picked.emit(self.value)


def _swatch_icon(colors, w=110, h=13):
    """Small color-chip strip as a QIcon (palette preview)."""
    pm = QPixmap(QSize(w, h))
    pm.fill(Qt.transparent)
    p = QPainter(pm)
    if colors:
        n = len(colors)
        cw = max(2, w // n)
        for i, c in enumerate(colors[: w // cw]):
            p.fillRect(i * cw, 0, cw, h, QColor(c))
    else:
        p.fillRect(0, 0, w, h, QColor("#dddddd"))
    p.end()
    from PySide6.QtGui import QIcon
    return QIcon(pm)


class PaletteButton(QPushButton):
    """Shows the current palette name + mini swatch strip; opens the picker."""

    def __init__(self, value="", parent=None):
        super().__init__(parent)
        self.value = value or ""
        self.setFixedWidth(170)
        self._apply()

    def _apply(self):
        colors = Schema.palette_colors(self.value)
        self.setIcon(_swatch_icon(colors))
        self.setIconSize(QSize(80, 13))
        self.setText(" " + (self.value if self.value else I18N.tr("palette_none")))

    def set_palette(self, name):
        self.value = (name or "").strip()
        self._apply()


class PaletteDialog(QDialog):
    """Searchable chooser over the 35 engine-built-in RColorBrewer palettes."""

    def __init__(self, current="", parent=None):
        super().__init__(parent)
        self.setWindowTitle(I18N.tr("palette_pick"))
        self.setMinimumSize(430, 520)
        self.chosen = None
        self._rows = []

        lay = QVBoxLayout(self)
        self.search = QLineEdit()
        self.search.setPlaceholderText(I18N.tr("filter"))
        self.search.textChanged.connect(self._filter)
        lay.addWidget(self.search)

        clear = QPushButton(I18N.tr("palette_clear"))
        clear.clicked.connect(self._clear)
        lay.addWidget(clear)

        area = QScrollArea()
        area.setWidgetResizable(True)
        central = QWidget()
        v = QVBoxLayout(central)
        v.setContentsMargins(2, 2, 2, 2)
        pals = Schema.palettes()
        groups = [
            (I18N.tr("palette_builtin_qual"), [n for n, e in sorted(pals["builtin"].items())
                                               if e.get("qualitative")]),
            (I18N.tr("palette_builtin_seq"), [n for n, e in sorted(pals["builtin"].items())
                                              if not e.get("qualitative")]),
        ]
        for title, names in groups:
            names = [n for n in names if Schema.palette_colors(n)]
            if not names:
                continue
            v.addWidget(QLabel("<b>%s</b>" % title))
            for n in names:
                entry = pals["builtin"].get(n)
                cnt = entry.get("max") or len(entry.get("colors") or [])
                btn = QPushButton(" %s (%s)" % (n, cnt))
                btn.setIcon(_swatch_icon(Schema.palette_colors(n)))
                btn.setIconSize(QSize(110, 13))
                btn.setStyleSheet("text-align:left;")
                if n == current:
                    btn.setStyleSheet("text-align:left;border:2px solid #4a90d9;")
                btn.clicked.connect(lambda _c=False, name=n: self._select(name))
                v.addWidget(btn)
                self._rows.append((btn, n.lower()))
        v.addStretch(1)
        area.setWidget(central)
        lay.addWidget(area, 1)

        bb = QDialogButtonBox(QDialogButtonBox.Close)
        bb.rejected.connect(self.reject)
        lay.addWidget(bb)

    def _select(self, name):
        self.chosen = name
        self.accept()

    def _clear(self):
        self.chosen = ""
        self.accept()

    def _filter(self, text):
        text = text.strip().lower()
        for btn, key in self._rows:
            btn.setVisible(text in key)


class ParamRow(QWidget):
    """One parameter row: [enable] key  editor."""
    changed = Signal(str, object)          # key, value ('' = unset)

    def __init__(self, param, value, parent=None):
        super().__init__(parent)
        self.param = param
        self.key = param["name"]
        self._building = True

        self.enable = QCheckBox()
        self.enable.setToolTip(I18N.tr("enabled"))
        self.label = QLabel(_fmt_label(param))
        self.label.setToolTip(_fmt_tooltip(param))
        self.label.setMinimumWidth(230)
        self.label.setTextInteractionFlags(Qt.TextSelectableByMouse)

        self.editor = self._make_editor(param, value)

        self.default_label = None
        hint = _default_hint_text(param)
        if hint:
            self.default_label = QLabel(hint)
            self.default_label.setStyleSheet("color: palette(mid);")
            self.default_label.setToolTip(hint)
            self.editor_lay.addWidget(self.default_label)
        self._apply_placeholder(param, value)

        if param.get("type") in ("int", "float"):
            self.editor_lay.addStretch(1)

        lay = QHBoxLayout(self)
        lay.setContentsMargins(2, 1, 2, 1)
        lay.addWidget(self.enable)
        lay.addWidget(self.label)
        lay.addLayout(self.editor_lay, 1)

        self.enable.toggled.connect(self._on_toggle)
        self.enable.setChecked(value != "" and value is not None)
        self._building = False
        self._sync_enabled()

    # ------------------------------------------------------------- editors
    def _apply_placeholder(self, p, value):
        d = p.get("default")
        if d in (None, "") or value not in ("", None):
            return
        if hasattr(self, "_color_txt"):
            self._color_txt.setPlaceholderText(str(d))
        elif hasattr(self, "_file_edit"):
            self._file_edit.setPlaceholderText(str(d))
        elif isinstance(getattr(self, "_editor", None), QLineEdit):
            self._editor.setPlaceholderText(str(d))

    @staticmethod
    def _initial_value(p, value):
        if value not in ("", None):
            return str(value)
        d = p.get("default")
        return "" if d in (None, "") else str(d)

    def _make_palette_editor(self, p, value):
        lay = self.editor_lay = QHBoxLayout()
        lay.setContentsMargins(0, 0, 0, 0)
        lay.setSpacing(4)
        init = self._initial_value(p, value)
        btn = PaletteButton(init)
        txt = QLineEdit(init)
        txt.setPlaceholderText("Dark2 / Paired / Set3 …")
        btn.clicked.connect(self._pick_palette)
        lay.addWidget(btn)
        lay.addWidget(txt, 1)
        self._editor = txt
        self._palette_btn = btn
        self._bind_line(txt)
        return lay

    def _pick_palette(self):
        dlg = PaletteDialog(self._palette_btn.value, self)
        if dlg.exec() == QDialog.Accepted and dlg.chosen is not None:
            self._palette_btn.set_palette(dlg.chosen)
            self._editor.setText(dlg.chosen)       # fires textChanged -> emit

    def _make_editor(self, p, value):
        t = p.get("type") or "text"
        lay = self.editor_lay = QHBoxLayout()
        lay.setContentsMargins(0, 0, 0, 0)
        lay.setSpacing(4)
        w = None

        if p["name"] in PALETTE_KEYS:
            return self._make_palette_editor(p, value)

        if t == "bool":
            w = QComboBox()
            w.addItem("", "")
            w.addItem("1", "1")
            if p.get("presence_only"):
                # the engine acts on the key merely EXISTING: writing 0 would
                # silently trigger the behaviour — only offer unset / enabled
                val = "" if value is None else str(value)
                if val not in ("", "1"):
                    w.addItem(val, val)
                idx = w.findData(val) if val else 0
                w.setCurrentIndex(idx if idx >= 0 else 0)
                w.setToolTip(I18N.tr("presence_only_tip"))
            else:
                w.addItem("0", "0")
                w.setCurrentIndex(
                    {None: 0, "": 0, "1": 1, "0": 2, 1: 1, 0: 2}.get(value, 0)
                    if not isinstance(value, bool) else (1 if value else 2))
        elif t == "enum":
            w = QComboBox()
            w.addItem("", "")
            for c in p.get("choices") or []:
                w.addItem(str(c), str(c))
            if value != "" and w.findData(str(value)) < 0:
                w.addItem(str(value), str(value))
            init = self._initial_value(p, value)
            idx = w.findData(init) if init else 0
            w.setCurrentIndex(idx if idx >= 0 else 0)
        elif t == "int":
            w = QSpinBox()
            lo = p.get("min") if p.get("min") is not None else -WIDE
            hi = p.get("max") if p.get("max") is not None else WIDE
            if lo == hi:
                hi = lo + 1
            w.setRange(lo, hi)
            w.setFixedWidth(140)
            try:
                init = int(float(self._initial_value(p, value) or 0))
                w.setValue(min(max(init, lo), hi))
            except (TypeError, ValueError, OverflowError):
                w.setValue(0)
        elif t == "float":
            w = QDoubleSpinBox()
            w.setDecimals(6)
            lo = p.get("min") if p.get("min") is not None else -1e18
            hi = p.get("max") if p.get("max") is not None else 1e18
            if lo == hi:
                hi = lo + 1
            w.setRange(lo, hi)
            w.setFixedWidth(160)
            try:
                init = float(self._initial_value(p, value) or 0.0)
                w.setValue(min(max(init, lo), hi))
            except (TypeError, ValueError):
                w.setValue(0.0)
        elif t == "color":
            w = ColorButton(self._initial_value(p, value))
            txt = QLineEdit()
            txt.setPlaceholderText("#RRGGBB")
            txt.setText(self._initial_value(p, value))
            txt.textChanged.connect(lambda s, b=w: (setattr(b, "value", s), b._apply()))
            w.picked.connect(txt.setText)
            lay.addWidget(w)
            lay.addWidget(txt, 1)
            self._color_btn, self._color_txt = w, txt
            self._bind_color()
            return lay
        elif t == "file":
            w = QLineEdit()
            w.setText("" if value is None else str(value))
            btn = QPushButton(I18N.tr("choose"))
            btn.setFixedWidth(70)
            btn.clicked.connect(self._browse)
            lay.addWidget(w, 1)
            lay.addWidget(btn)
            self._file_edit = w
            self._bind_line(w)
            return lay
        else:  # text
            w = QLineEdit()
            w.setText(self._initial_value(p, value))
            lay.addWidget(w, 1)
            self._editor = w
            self._bind_line(w)
            return lay

        lay.addWidget(w, 1 if t in ("bool", "enum") else 0)
        if t in ("bool", "enum"):
            w.currentIndexChanged.connect(self._emit_combo)
        elif t == "int":
            w.valueChanged.connect(lambda v: self._emit_value(int(v)))
        elif t == "float":
            w.valueChanged.connect(lambda v: self._emit_value(float(v)))
        self._editor = w
        return lay

    def _bind_line(self, edit):
        edit.textChanged.connect(lambda s: self._emit_value(s))

    def _bind_color(self):
        self._color_txt.textChanged.connect(lambda s: self._emit_value(s))

    def _browse(self):
        from PySide6.QtWidgets import QFileDialog
        f, _ = QFileDialog.getOpenFileName(self)
        if f:
            self._file_edit.setText(f)

    # ------------------------------------------------------------- events
    @staticmethod
    def _fmt_num(v):
        if isinstance(v, float) and v == int(v) and abs(v) < 1e15:
            return str(int(v))
        return str(v)

    def _emit_value(self, v):
        if self._building:
            return
        if isinstance(v, float):
            v = self._fmt_num(v)
        self.changed.emit(self.key, "" if v in (None, "") else str(v))

    def _emit_combo(self, _i):
        self._emit_value(self._editor.currentData())

    def _on_toggle(self, on):
        if self._building:
            return
        self._sync_enabled()
        if not on:
            self._emit_value("")
        elif self.param.get("type") == "bool":
            self._emit_value("1")
        else:
            cur = self._current_editor_value()
            self._emit_value(cur)

    def _current_editor_value(self):
        t = self.param.get("type")
        # palette keys are schema enums but render as a QLineEdit + swatch
        # button, so they must be handled BEFORE the combo-based branches
        if self.param["name"] in PALETTE_KEYS:
            return self._editor.text() if hasattr(self, "_editor") else ""
        if t in ("bool", "enum"):
            return self._editor.currentData() or ""
        if t == "int":
            return str(self._editor.value())
        if t == "float":
            return self._fmt_num(self._editor.value())
        if t == "color":
            return self._color_txt.text()
        if t == "file":
            return self._file_edit.text() if hasattr(self, "_file_edit") else ""
        return self._editor.text() if hasattr(self, "_editor") else ""

    def _sync_enabled(self):
        for w in self.findChildren(QWidget):
            if w is self.enable or w is self.label or w is self.default_label:
                continue
            w.setEnabled(self.enable.isChecked())

    def set_external(self, value):
        """Update editors from the model WITHOUT re-emitting (cross-tab sync)."""
        self._building = True
        value = "" if value is None else str(value)
        try:
            self.enable.setChecked(value != "")
            t = self.param.get("type") or "text"
            if self.param["name"] in PALETTE_KEYS:
                # QLineEdit + swatch button, not a combo (see _make_editor)
                self._editor.setText(value)
                self._palette_btn.set_palette(value)   # keep the swatch in sync
            elif t == "bool":
                if self.param.get("presence_only"):
                    idx = self._editor.findData(value)
                    self._editor.setCurrentIndex(idx if idx >= 0 else 0)
                else:
                    idx = {None: 0, "": 0, "1": 1, "0": 2}.get(value, 0)
                    self._editor.setCurrentIndex(idx)
            elif t == "enum":
                idx = self._editor.findData(value)
                if idx < 0 and value:
                    self._editor.addItem(value, value)
                    idx = self._editor.findData(value)
                self._editor.setCurrentIndex(idx if idx >= 0 else 0)
            elif t == "int":
                try:
                    self._editor.setValue(int(float(value)) if value else 0)
                except (TypeError, ValueError, OverflowError):
                    self._editor.setValue(0)
            elif t == "float":
                try:
                    self._editor.setValue(float(value) if value else 0.0)
                except (TypeError, ValueError, OverflowError):
                    self._editor.setValue(0.0)
            elif t == "color":
                self._color_txt.setText(value)
                self._color_btn.value = value
                self._color_btn._apply()
            elif t == "file":
                self._file_edit.setText(value)
            else:
                self._editor.setText(value)
            self._apply_placeholder(self.param, value)
        finally:
            self._building = False
        self._sync_enabled()

    def current_value(self):
        if not self.enable.isChecked():
            return ""
        return self._current_editor_value()


class ParamForm(QWidget):
    """Category list + scrollable rows for one conf section."""
    any_changed = Signal(str, object)
    files_changed = Signal(list)                   # genome files
    links_changed = Signal(list)                   # link files
    param_changed = Signal(object, str, object)    # scope, key, value
    row_selected = Signal(str, int)                # ("genome"|"link", index)

    def __init__(self, scope, model, parent=None, exclude=None):
        super().__init__(parent)
        self.scope = scope
        self._schema_scope = _schema_scope(scope)
        self.model = model
        self.exclude = exclude or set()
        self.show_all = False
        self._rows = {}
        self.genome_bar = None           # embedded bars (files category only)
        self.link_bar = None

        self.cat_list = QListWidget()
        self.cat_list.setMaximumWidth(175)
        self.filter_edit = QLineEdit()
        self.filter_edit.setPlaceholderText(I18N.tr("filter"))
        self.filter_edit.setToolTip(I18N.tr("filter_tip"))
        self.filter_edit.setMaximumWidth(175)
        self.show_all_cb = QCheckBox(I18N.tr("show_all_params"))
        self.show_all_cb.setToolTip(I18N.tr("show_all_tip"))
        self.show_all_cb.setMaximumWidth(175)
        self.scroll = QScrollArea()
        self.scroll.setWidgetResizable(True)
        self.scroll.setFrameShape(QScrollArea.NoFrame)

        left = QVBoxLayout()
        left.setContentsMargins(0, 0, 0, 0)
        left.addWidget(self.filter_edit)
        left.addWidget(self.cat_list)
        left.addWidget(self.show_all_cb)

        root = QHBoxLayout(self)
        root.setContentsMargins(4, 4, 4, 4)
        root.addLayout(left, 0)
        root.addWidget(self.scroll, 1)

        self.cat_list.currentTextChanged.connect(lambda _s: self._fill_rows())
        self.filter_edit.textChanged.connect(lambda _s: self._fill_rows())
        self.show_all_cb.toggled.connect(self._toggled_all)

        # persistent file bars (global form only): reparented into the card on
        # demand instead of recreated (and deleteLater'd) on every category
        # switch — a stale reference to the deleted C++ object crashed macOS
        if self.scope == "global":
            self.genome_bar = GenomeFilesBar()
            self.genome_bar.set_roomy(True)       # right dock: more row depth
            self.genome_bar.set_files(list(self.model.genome_files))
            self.genome_bar.changed.connect(self._on_genome_bar_changed)
            self.genome_bar.row_selected.connect(
                lambda i: self.row_selected.emit("genome", i))
            self.link_bar = LinkFilesBar()
            self.link_bar.set_roomy(True)
            self.link_bar.set_links(list(self.model.link_files))
            self.link_bar.set_genome_count(max(1, len(self.model.genome_files)))
            self.link_bar.changed.connect(self._on_link_bar_changed)
            self.link_bar.row_selected.connect(
                lambda i: self.row_selected.emit("link", i))

        self.rebuild()

    # ------------------------------------------------------------- build
    def rebuild(self):
        self.cat_list.blockSignals(True)
        self.cat_list.clear()
        self._cats = Schema.by_category(self._schema_scope)
        # data-grouping card first (global form only), like RectChr.
        # The count shows both lists: "3+2" = 3 genome files + 2 link files.
        if self._schema_scope == "global":
            n_gen = len([f for f in self.model.genome_files if f])
            n_lnk = len(self.model.link_files)
            it = QListWidgetItem("%s (%d+%d)" % (self._lang_cat("files"), n_gen, n_lnk))
            it.setData(Qt.UserRole, "files")
            self.cat_list.addItem(it)
        for cat, params in self._cats.items():
            n = self._lang_cat(cat)
            it = QListWidgetItem("%s (%d)" % (n, len(params)))
            it.setData(Qt.UserRole, cat)
            self.cat_list.addItem(it)
        self.cat_list.blockSignals(False)
        if self.cat_list.count():
            self.cat_list.setCurrentRow(0)
        self._fill_rows()

    def _lang_cat(self, cat):
        c = Schema.categories().get(cat, {})
        return c.get(I18N.lang(), c.get("zh", cat))

    def _toggled_all(self, _on):
        self.show_all = self.show_all_cb.isChecked()
        self._fill_rows()

    @staticmethod
    def _param_allowed(p, show_all):
        if not show_all and p.get("importance", 0) == 0 and not p.get("default"):
            return False
        return True

    def _fill_rows(self):
        # retire the previous central widget; detach the persistent bars
        # first so deleting the old card cannot destroy them
        if self.genome_bar is not None:
            self.genome_bar.setParent(self)
        if self.link_bar is not None:
            self.link_bar.setParent(self)
        old = self.scroll.takeWidget()
        if old is not None:
            old.setParent(None)
            old.deleteLater()
        central = QFrame()
        central.setObjectName("formPage")
        lay = QVBoxLayout(central)
        lay.setContentsMargins(10, 10, 10, 10)
        lay.setSpacing(12)

        sel = self.cat_list.currentItem()
        want = sel.data(Qt.UserRole) if sel else None
        flt = self.filter_edit.text().strip().lower()
        self._rows = {}

        # ---- special section: data grouping = two cards, genome group and
        # link group (one homogeneous list each, like RectChr's single list)
        if self.scope == "global" and want == "files" and not flt:
            g_card, gv = make_card(I18N.tr("group_genome"))
            self.genome_bar.set_files(list(self.model.genome_files))
            gv.addWidget(QLabel(I18N.tr("genome_file_hint")))
            gv.addWidget(self.genome_bar)
            lay.addWidget(g_card)

            l_card, lv = make_card(I18N.tr("group_link"))
            self.link_bar.set_links(list(self.model.link_files))
            self.link_bar.set_genome_count(max(1, len(self.model.genome_files)))
            lv.addWidget(QLabel(I18N.tr("link_file_hint")))
            lv.addWidget(self.link_bar)
            lay.addWidget(l_card)
            lay.addStretch(1)
            self.scroll.setWidget(central)
            return

        if flt:
            for cat, params in self._cats.items():
                matched = [p for p in params
                           if p["name"] not in self.exclude
                           and (flt in p["name"].lower()
                                or flt in (p.get("label_zh") or "")
                                or flt in (p.get("label_en") or "").lower())]
                if not matched:
                    continue
                card, v = make_card(self._lang_cat(cat))
                for p in matched:
                    value = self.model.get_param(self.scope, p["name"])
                    row = ParamRow(p, value)
                    row.changed.connect(self._on_row_changed)
                    v.addWidget(row)
                    self._rows[p["name"]] = row
                lay.addWidget(card)
            if not self._rows:
                lay.addWidget(QLabel(I18N.tr("filter_nomatch")))
            lay.addStretch(1)
            self.scroll.setWidget(central)
            return

        for cat, params in self._cats.items():
            if want is not None and cat != want:
                continue
            visible = [p for p in params
                       if p["name"] not in self.exclude
                       and self._param_allowed(p, self.show_all)]
            card, v = make_card(self._lang_cat(cat))
            for p in visible:
                value = self.model.get_param(self.scope, p["name"])
                row = ParamRow(p, value)
                row.changed.connect(self._on_row_changed)
                v.addWidget(row)
                self._rows[p["name"]] = row
            if not visible:
                cand = [p for p in params if p["name"] not in self.exclude]
                if cand and not self.show_all \
                        and all(self._param_allowed(p, True) for p in cand) \
                        and any(not self._param_allowed(p, False) for p in cand):
                    msg = I18N.tr("cat_all_lowfreq")
                else:
                    msg = I18N.tr("filter_nomatch")
                hint = QLabel(msg)
                hint.setWordWrap(True)
                hint.setStyleSheet("color: palette(mid);")
                v.addWidget(hint)
            lay.addWidget(card)
        lay.addStretch(1)
        self.scroll.setWidget(central)

    def _on_genome_bar_changed(self, files):
        self.model.genome_files = list(files)
        self.files_changed.emit(list(files))

    def _on_link_bar_changed(self, links):
        self.model.link_files = list(links)
        self.links_changed.emit(list(links))

    def _on_row_changed(self, key, value):
        self.model.set_param(self.scope, key, value)
        self.any_changed.emit(key, value)
        self.param_changed.emit(self.scope, key, value)

    def sync_row(self, key, value):
        """Cross-tab sync: update one row editor from an external change."""
        row = self._rows.get(key)
        if row is not None:
            row.set_external(value)

    def set_selected_row(self, kind, index):
        bar = self.genome_bar if kind == "genome" else self.link_bar
        if bar is not None:
            bar.set_selected(index)

    def sync_bars(self):
        """Refresh the embedded file bars from the model (no events)."""
        if self.genome_bar is not None:
            self.genome_bar.set_files(list(self.model.genome_files))
        if self.link_bar is not None:
            self.link_bar.set_links(list(self.model.link_files))
            self.link_bar.set_genome_count(max(1, len(self.model.genome_files)))
