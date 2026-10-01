"""Genome/link file management widgets.

NGenomeSyn has TWO ordered file lists, unlike RectChr's single File1..FileN:
  - GenomeInfoFile1..N  (.len, order = figure order, no gaps allowed)
  - LinkFileRefA VsRefB (.link, the line's ordinal IS the LinkN index)

Each list exists as a compact Bar (embedded in the Global form's data-files
category) and a full Panel (left dock, with a data preview). Bars and panels
stay in sync through the model + idempotent set_* early-returns.
"""
import gzip
from pathlib import Path

from PySide6.QtCore import Qt, Signal
from PySide6.QtWidgets import (QButtonGroup, QFileDialog, QHBoxLayout, QHeaderView,
                               QLabel, QLineEdit, QPushButton, QScrollArea,
                               QSizePolicy, QSpinBox, QSplitter, QTableWidget,
                               QTableWidgetItem, QToolButton, QVBoxLayout,
                               QWidget)

from ..i18n import I18N

ROW_LIMIT = 8
PREVIEW_ROWS = 8
ROW_H = 28              # one file row incl. spacing
FOLD_MAX_HEIGHT = 260   # right dock: data-grouping cards (roomier)
FOLD_MAX_HEIGHT_TIGHT = 150   # left dock: leave room for the preview below


def read_rows(path, limit=20):
    """First `limit` non-empty rows of a (possibly .gz) data file."""
    rows = []
    p = Path(path)
    try:
        opener = gzip.open if p.suffix.lower() == ".gz" else open
        with opener(p, "rt", encoding="utf-8", errors="replace") as fh:
            for line in fh:
                parts = line.split()
                if parts:
                    rows.append(parts)
                if len(rows) >= limit:
                    break
    except OSError:
        pass
    return rows


def genome_name_for(path):
    """The engine derives the default genome label from the file basename
    (split on '/', then on '.', take [0], bin/NGenomeSyn:1571-1572)."""
    base = Path(str(path)).name
    return base.split(".")[0] if base else ""


def _del_button():
    b = QPushButton("×")
    b.setObjectName("fileRemoveBtn")
    b.setFixedSize(20, 20)
    b.setToolTip(I18N.tr("remove_file"))
    return b


def _browse_button():
    b = QPushButton(I18N.tr("choose"))
    b.setObjectName("fileBrowseBtn")
    b.setFixedWidth(58)      # narrower: the path field needs the room
    return b


def resolve_data_path(path, base_dir):
    """Resolve a data path for reading: absolute stays as-is; a relative path
    is tried against base_dir first, then the cwd and the repo Example dir.

    Returns the first existing candidate, else the base_dir-resolved path
    (so the caller can report the file as missing)."""
    p = str(path or "").strip()
    if not p:
        return p
    q = Path(p).expanduser()
    if q.is_absolute():
        return str(q)
    here = Path(__file__).resolve().parents[2]
    for base in (Path(base_dir or "."), Path.cwd(), here,
                 here / "Example", here.parent):
        cand = (base / q)
        try:
            if cand.is_file():
                return str(cand.resolve())
        except OSError:
            continue
    return str((Path(base_dir or ".") / q))


class _ScrollableRowsBar(QWidget):
    """Row list whose height is CAPPED: past FOLD_MAX_HEIGHT it scrolls.

    Without the cap a long genome list pushed the link section out of the left
    dock with no way to reach it (the splitter had nothing to scroll).

    Clicking a row's path field also marks it as "current" (row_selected), so
    the owning panel can preview that file — the RectChr pattern, where the
    file list itself is the preview selector."""
    changed = Signal(list)
    row_selected = Signal(int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._rows = []
        self._building = False
        self._roomy = False
        self._sel = -1
        root = QVBoxLayout(self)
        root.setContentsMargins(0, 0, 0, 0)
        root.setSpacing(3)
        self._scroll = QScrollArea()
        self._scroll.setWidgetResizable(True)
        self._scroll.setFrameShape(QScrollArea.NoFrame)
        self._scroll.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self._scroll.viewport().setAutoFillBackground(False)
        self._inner = QWidget()
        self.lay = QVBoxLayout(self._inner)
        self.lay.setContentsMargins(0, 0, 0, 0)
        self.lay.setSpacing(3)
        self._scroll.setWidget(self._inner)
        root.addWidget(self._scroll)
        self.add_btn = QPushButton("+")
        self.add_btn.setFixedWidth(36)
        self.add_btn.setToolTip(I18N.tr("add_file"))
        self.add_btn.clicked.connect(self._add_clicked)
        root.addWidget(self.add_btn, 0, Qt.AlignLeft)

    def _add_clicked(self):
        pass                                # overridden

    def _rebuild_rows(self, items):
        for row in self._rows:
            for w in row["widgets"]:
                w.setParent(None)
                w.deleteLater()
        self._rows = []
        for i, item in enumerate(items):
            self._add_row(i, item)
        self._apply_height_cap()

    def selected_index(self):
        return self._sel

    def set_selected(self, i):
        """Highlight one row (no signal): lets the other dock show the same
        selection. The whole ROW is highlighted so the short label text
        'GenomeInfoFile3' stays readable when the panel is narrow."""
        if not (-1 <= i < len(self._rows)):
            i = -1
        if i == self._sel:
            return
        for k, row in enumerate(self._rows):
            on = (k == i)
            row["lab"].setStyleSheet(
                "font-weight: 600; color: palette(highlight);" if on else "")
            row["edit"].setStyleSheet(
                "border: 1px solid palette(highlight);" if on else "")
        self._sel = i

    def _apply_height_cap(self):
        cap = FOLD_MAX_HEIGHT if self._roomy else FOLD_MAX_HEIGHT_TIGHT
        want = len(self._rows) * ROW_H
        self._scroll.setMaximumHeight(max(ROW_H + 2, min(want, cap)))
        self._scroll.setMinimumHeight(min(want, cap))
        self._scroll.setVisible(True)

    def set_roomy(self, on=True):
        """Give the rows more depth (used by the Global form's data-grouping
        cards, where the dock is tall and few rows would be wasted space)."""
        self._roomy = bool(on)
        self._apply_height_cap()
        for row in self._rows:
            row["edit"].setMinimumHeight(ROW_H - 2)

    def eventFilter(self, obj, ev):
        'Clicking a row path field selects that file for previewing.'
        from PySide6.QtCore import QEvent
        idx = getattr(obj, '_ngs_row', None)
        if idx is not None and ev.type() in (QEvent.MouseButtonPress,
                                             QEvent.FocusIn):
            self.set_selected(idx)
            self.row_selected.emit(idx)
        return super().eventFilter(obj, ev)

    def _browse(self, edit):
        f, _ = QFileDialog.getOpenFileName(self)
        if f:
            edit.setText(f)

    def _remove(self, entry):                     # overridden per list type
        raise NotImplementedError

    def _emit(self, *_a):
        if not self._building:
            self.changed.emit(self.current())


class GenomeFilesBar(_ScrollableRowsBar):
    """Compact GenomeInfoFile1..N editor (embedded in the Global form)."""

    def _add_clicked(self):
        self.set_files(self.files() + [""], force=True)

    def files(self):
        out = []
        for row in self._rows:
            t = row["edit"].text().strip()
            if t:
                out.append(t)
        return out

    def current(self):
        return self.files()

    def set_files(self, files, force=False):
        norm = [str(f) for f in (files or []) if str(f).strip()]
        if not force and norm == self.files():
            return                                  # idempotent: stops sync loops
        self._building = True
        try:
            self._rebuild_rows(list(files) or [""])
        finally:
            self._building = False

    def _add_row(self, idx, value):
        lab = QLabel("GenomeInfoFile%d" % (idx + 1))
        lab.setMinimumWidth(118)
        edit = QLineEdit(value)
        edit.setSizePolicy(QSizePolicy.Ignored, QSizePolicy.Fixed)
        edit.setMinimumWidth(90)
        btn = _browse_button()
        dele = _del_button()
        row = QHBoxLayout()
        row.setSpacing(3)
        for w in (lab, edit, btn, dele):
            row.addWidget(w)
        self.lay.insertLayout(len(self._rows), row)
        entry = {"lab": lab, "edit": edit, "widgets": (lab, edit, btn, dele)}
        self._rows.append(entry)
        edit.textChanged.connect(self._emit)
        edit.installEventFilter(self)
        edit._ngs_row = len(self._rows) - 1  # 0-based row index
        lab.setCursor(Qt.PointingHandCursor)
        lab.setToolTip(I18N.tr("preview_select"))
        lab.installEventFilter(self)
        lab._ngs_row = edit._ngs_row
        btn.clicked.connect(lambda _c=False, e=edit: self._browse(e))
        dele.clicked.connect(lambda _c=False, en=entry: self._remove(en))

    def _remove(self, entry):
        i = self._rows.index(entry)
        if i == 0:
            entry["edit"].clear()                   # GenomeInfoFile1 stays
            self.changed.emit(self.files())
            return
        texts = [r["edit"].text().strip() for r in self._rows]
        del texts[i]
        self.set_files(texts)
        self.changed.emit(self.files())

    def _emit(self, *_a):
        if not self._building:
            self.changed.emit(self.files())


class LinkFilesBar(_ScrollableRowsBar):
    """Compact ordered LinkFileRefA VsRefB editor (ordinal = LinkN)."""

    def __init__(self, parent=None):
        self.genome_count = 2
        super().__init__(parent)

    def _add_clicked(self):
        links = self.links()
        n = len(links) + 1
        a = min(2, max(1, self.genome_count))
        b = 1 if a > 1 else min(2, max(1, self.genome_count))
        links.append({"a": a, "b": b, "path": ""})
        self.set_links(links, force=True)
        if n >= 1:
            self.changed.emit(self.links())

    def links(self):
        out = []
        for row in self._rows:
            p = row["edit"].text().strip()
            if p:
                out.append({"a": row["a"].value(), "b": row["b"].value(),
                            "path": p})
        return out

    def current(self):
        return self.links()

    def set_links(self, links, force=False):
        norm = [{"a": int(l["a"]), "b": int(l["b"]), "path": str(l["path"])}
                for l in (links or [])]
        if not force and norm == self.links():
            return
        self._building = True
        try:
            for row in self._rows:
                for w in row["widgets"]:
                    w.setParent(None)
                    w.deleteLater()
            self._rows = []
            for l in norm:
                self._add_row(l)
            self._apply_height_cap()
        finally:
            self._building = False

    def set_genome_count(self, n):
        """Widen the A:/B: range to cover every configured genome.

        Only the lower bound is enforced: an upper bound set with setRange()
        silently CLAMPS an already-loaded value (a conf with 3 genomes loaded
        while the count was still 2 turned a valid 2<->3 link into 2<->2)."""
        self.genome_count = max(1, int(n))
        for row in self._rows:
            for sp in (row["a"], row["b"]):
                sp.setMinimum(1)
                sp.setMaximum(max(self.genome_count, sp.value()))

    def _add_row(self, link, ordinal=None):          # noqa: ARG002
        n = len(self._rows) + 1
        lab = QLabel(I18N.tr("link_n", n=n))
        lab.setMinimumWidth(52)
        a = QSpinBox()
        a.setMinimum(1)
        a.setMaximum(max(self.genome_count, link["a"]))
        a.setValue(link["a"])
        a.setPrefix("A:")
        a.setFixedWidth(70)
        b = QSpinBox()
        b.setMinimum(1)
        b.setMaximum(max(self.genome_count, link["b"]))
        b.setValue(link["b"])
        b.setPrefix("B:")
        b.setFixedWidth(70)
        edit = QLineEdit(link["path"])
        edit.setSizePolicy(QSizePolicy.Ignored, QSizePolicy.Fixed)
        edit.setMinimumWidth(90)
        btn = _browse_button()
        dele = _del_button()
        row = QHBoxLayout()
        row.setSpacing(3)
        for w in (lab, a, b, edit, btn, dele):
            row.addWidget(w)
        self.lay.insertLayout(len(self._rows), row)
        entry = {"a": a, "b": b, "edit": edit, "lab": lab,
                 "widgets": (lab, a, b, edit, btn, dele)}
        self._rows.append(entry)
        for sp in (a, b):
            sp.valueChanged.connect(self._emit)
        edit.textChanged.connect(self._emit)
        edit.installEventFilter(self)
        edit._ngs_row = len(self._rows) - 1  # 0-based row index
        lab.setCursor(Qt.PointingHandCursor)
        lab.setToolTip(I18N.tr("preview_select"))
        lab.installEventFilter(self)
        lab._ngs_row = edit._ngs_row
        btn.clicked.connect(lambda _c=False, e=edit: self._browse(e))
        dele.clicked.connect(lambda _c=False, en=entry: self._remove(en))

    def _remove(self, entry):
        i = self._rows.index(entry)
        links = self.links()
        links.pop(i)
        self.set_links(links, force=True)
        self.changed.emit(self.links())

class _PreviewTable(QTableWidget):
    def __init__(self, parent=None):
        super().__init__(PREVIEW_ROWS, 8, parent)
        self.horizontalHeader().setSectionResizeMode(QHeaderView.ResizeToContents)
        self.horizontalHeader().setStretchLastSection(True)
        self.verticalHeader().setVisible(False)
        self.setEditTriggers(QTableWidget.NoEditTriggers)
        self.setAlternatingRowColors(True)
        # the preview must never claim the whole dock: the link section below
        # has to stay reachable no matter how many genomes are configured
        self.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        self.verticalHeader().setDefaultSectionSize(20)

    def show_rows(self, rows):
        rows = rows[:PREVIEW_ROWS]
        self.setRowCount(max(1, len(rows)))
        for r, row in enumerate(rows):
            for c in range(8):
                item = QTableWidgetItem(row[c] if c < len(row) else "")
                self.setItem(r, c, item)
        if not rows:
            self.setRowCount(0)


class _PreviewBox(QWidget):
    """Data preview table (top rows), like RectChr's.

    The preview target is NOT chosen here: the file list above IS the selector
    (click a GenomeInfoFileN / LinkN row to preview it), which is exactly how
    RectChr drives it from `itemSelectionChanged`."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Fixed)
        v = QVBoxLayout(self)
        v.setContentsMargins(0, 0, 0, 0)
        v.setSpacing(3)
        self.title = QLabel("<b>%s</b>" % I18N.tr("data_preview"))
        v.addWidget(self.title)
        self.table = _PreviewTable()
        self.table.setFixedHeight(PREVIEW_ROWS * 20 + 32)
        v.addWidget(self.table)
        self._items = []          # [(label, path)]
        self._cur = -1
        self._building = False

    def set_items(self, items):
        """items: [(label, path)]; keeps the current selection if still valid."""
        cur = self._cur
        self._items = list(items)
        if not (0 <= cur < len(self._items)):
            cur = 0 if self._items else -1
        self.select(cur)

    def items(self):
        return self._items

    def current_index(self):
        return self._cur

    def select(self, i):
        if not (0 <= i < len(self._items)):
            self._cur = -1
            self._emit()
            return
        self._cur = i
        self._emit()

    def current_path(self):
        return self._items[self._cur][1] if 0 <= self._cur < len(self._items) else ""

    def _emit(self, *_a):
        if not self._building:
            self.refresh()

    def refresh(self):
        path = self.current_path()
        if not path:
            self.table.setRowCount(0)
            self.table.setColumnCount(0)
            self.title.setText("<b>%s</b>" % I18N.tr("data_preview"))
            return
        label = self._items[self._cur][0] if 0 <= self._cur < len(self._items) else ""
        self.title.setText("<b>%s</b> — %s" % (I18N.tr("data_preview"), label))
        rows = read_rows(path)
        if not rows:
            p = Path(path)
            msg = I18N.tr("file_missing", f=path) if not p.is_file() else ""
            self.table.setRowCount(1 if msg else 0)
            self.table.setColumnCount(1 if msg else 0)
            if msg:
                self.table.setItem(0, 0, QTableWidgetItem(msg))
            return
        ncol = max(len(r) for r in rows)
        self.table.setColumnCount(min(ncol, 12))
        self.table.setRowCount(min(len(rows), PREVIEW_ROWS))
        for i, r in enumerate(rows[:PREVIEW_ROWS]):
            for j in range(self.table.columnCount()):
                self.table.setItem(i, j, QTableWidgetItem(r[j] if j < len(r) else ""))
        self.table.resizeColumnsToContents()


class GenomeFilesPanel(QWidget):
    """Full genome-file editor with data preview (left dock, top)."""
    changed = Signal(list)
    selection_changed = Signal(str, int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.base_dir = str(Path.home())
        self._building = False
        v = QVBoxLayout(self)
        v.setContentsMargins(6, 6, 6, 6)
        v.setSpacing(4)
        self.bar = GenomeFilesBar()
        self.bar.changed.connect(self._on_bar)
        self.bar.row_selected.connect(self._on_row_selected)
        v.addWidget(self.bar)
        self.hint = QLabel(I18N.tr("genome_file_hint"))
        self.hint.setWordWrap(True)
        self.hint.setStyleSheet("color: palette(mid);")
        v.addWidget(self.hint)
        self.name_lab = QLabel("")
        self.name_lab.setStyleSheet("color: palette(mid);")
        v.addWidget(self.name_lab)
        self.preview = _PreviewBox()
        v.addWidget(self.preview, 1)

    def set_base_dir(self, d):
        self.base_dir = str(d)

    def files(self):
        return self.bar.files()

    def set_files(self, files):
        if (files or []) == self.bar.files():
            return
        self._building = True
        try:
            self.bar.set_files(files)
        finally:
            self._building = False
        self._refresh_preview()
        self.name_lab.setText("")

    def _on_bar(self, files):
        if self._building:
            return
        self._refresh_preview()
        self.changed.emit(files)

    def _on_row_selected(self, index):
        """Clicking a file row previews it (RectChr pattern)."""
        items = self.preview.items()
        idx = min(index, len(items) - 1)
        if idx >= 0:
            self.preview.select(idx)
            self.bar.set_selected(idx)
            self.selection_changed.emit("genome", idx)

    def select_row(self, index):
        """External selection (e.g. from the right dock): highlight + preview."""
        self._on_row_selected(index)

    def _refresh_preview(self):
        files = self.bar.files()
        names = []
        items = []
        for i, f in enumerate(files, 1):
            if f:
                f = resolve_data_path(f, self.base_dir)
                gname = genome_name_for(f)
                names.append("Genome%d=%s" % (i, gname))
                items.append(("GenomeInfoFile%d · %s" % (i, gname), f))
        self.name_lab.setText(" → ".join(names) if names else "")
        self.preview.set_items(items)
        self.bar.set_selected(self.preview.current_index())


class LinkFilesPanel(QWidget):
    """Full link-file editor with data preview (left dock, bottom)."""
    changed = Signal(list)
    selection_changed = Signal(str, int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.base_dir = str(Path.home())
        self._building = False
        v = QVBoxLayout(self)
        v.setContentsMargins(6, 6, 6, 6)
        v.setSpacing(4)
        self.bar = LinkFilesBar()
        self.bar.changed.connect(self._on_bar)
        self.bar.row_selected.connect(self._on_row_selected)
        v.addWidget(self.bar)
        self.hint = QLabel(I18N.tr("link_file_hint"))
        self.hint.setWordWrap(True)
        self.hint.setStyleSheet("color: palette(mid);")
        v.addWidget(self.hint)
        self.preview = _PreviewBox()
        v.addWidget(self.preview, 1)

    def set_base_dir(self, d):
        self.base_dir = str(d)

    def links(self):
        return self.bar.links()

    def set_links(self, links, force=False):
        if not force and (links or []) == self.bar.links():
            return
        self._building = True
        try:
            self.bar.set_links(links)
        finally:
            self._building = False
        self._refresh_preview()

    def set_genome_count(self, n):
        self.bar.set_genome_count(n)

    def _on_bar(self, links):
        if self._building:
            return
        self._refresh_preview()
        self.changed.emit(links)

    def _on_row_selected(self, index):
        items = self.preview.items()
        idx = min(index, len(items) - 1)
        if idx >= 0:
            self.preview.select(idx)
            self.bar.set_selected(idx)
            self.selection_changed.emit("link", idx)

    def select_row(self, index):
        """External selection (e.g. from the right dock): highlight + preview."""
        self._on_row_selected(index)

    def _refresh_preview(self):
        links = self.bar.links()
        items = []
        for n, lf in enumerate(links, 1):
            p = resolve_data_path(lf["path"], self.base_dir)
            items.append(("%s · %d↔%d" % (I18N.tr("link_n", n=n), lf["a"], lf["b"]), p))
        self.preview.set_items(items)
        self.bar.set_selected(self.preview.current_index())


class LeftFilesPanel(QWidget):
    """Left dock: genome files and link files stacked in ONE scroll area.

    Splitting the dock in two made the two halves fight over the available
    height: with several genomes the genome half needed more room, and its
    preview chips were clipped away with no handle to scroll to. One column
    with one scrollbar keeps everything reachable at any dock size."""
    genomes_changed = Signal(list)
    links_changed = Signal(list)
    selection_changed = Signal(str, int)      # ("genome"|"link", index)

    def __init__(self, parent=None):
        super().__init__(parent)
        lay = QVBoxLayout(self)
        lay.setContentsMargins(0, 0, 0, 0)
        self._area = QScrollArea()
        self._area.setWidgetResizable(True)
        self._area.setFrameShape(QScrollArea.NoFrame)
        self._area.setHorizontalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        host = QWidget()
        self._host_lay = QVBoxLayout(host)
        self._host_lay.setContentsMargins(6, 6, 6, 6)
        self._host_lay.setSpacing(8)
        self.genome_panel = GenomeFilesPanel()
        self.link_panel = LinkFilesPanel()
        self._host_lay.addWidget(self.genome_panel)
        self._host_lay.addWidget(self.link_panel)
        self._host_lay.addStretch(1)
        self._area.setWidget(host)
        lay.addWidget(self._area)
        self.genome_panel.changed.connect(self.genomes_changed.emit)
        self.link_panel.changed.connect(self.links_changed.emit)
        self.genome_panel.selection_changed.connect(self.selection_changed.emit)
        self.link_panel.selection_changed.connect(self.selection_changed.emit)

    # pass-through API used by MainWindow
    def set_base_dir(self, d):
        self.genome_panel.set_base_dir(d)
        self.link_panel.set_base_dir(d)

    def sync_genomes(self, files):
        self.genome_panel.set_files(files)

    def sync_links(self, links, force=False):
        self.link_panel.set_links(links, force=force)

    def sync_genome_count(self, n):
        self.link_panel.set_genome_count(n)

    def select_row(self, kind, index):
        """Select a row from the other dock (mirrors it here + in the preview)."""
        panel = self.genome_panel if kind == "genome" else self.link_panel
        panel.select_row(index)
