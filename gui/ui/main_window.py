"""NGenomeSyn GUI main window: toolbar, files dock, parameter tabs, preview, runner."""
import re
import sys
from pathlib import Path

from PySide6.QtCore import QSettings, QTimer, Qt, QUrl
from PySide6.QtGui import QAction, QKeySequence
from PySide6.QtWidgets import (QApplication, QCheckBox, QComboBox, QDialog,
                               QDialogButtonBox, QDockWidget, QFileDialog,
                               QFrame, QHBoxLayout, QLabel, QMainWindow, QMenu,
                               QMessageBox, QPlainTextEdit, QPushButton,
                               QSizePolicy, QSpinBox, QTabBar, QTabWidget,
                               QToolBar, QToolButton, QVBoxLayout, QWidget)

from .. import GUI_VERSION
from ..core.conf_io import ConfModel
from ..core.gzcache import map_all_paths
from ..core import validate as _validate_mod
from ..core.runner import ENGINE, GUI_DIR, ROOT, Runner, find_perl
from ..i18n import I18N
from ..theme import make_card
from .files_panel import LeftFilesPanel
from .genome_tab import (LazyGenomePage, LazyLinkPage, LazyPage,
                         genome_tab_title, link_tab_title)
from .params_summary import ParamsSummaryTab
from .param_form import ParamForm
from .preview import PreviewView
from .logo import application_icon, logo_pixmap


class ParameterTabBar(QTabBar):
    def _position_close_buttons(self):
        for index in range(self.count()):
            button = self.tabButton(index, QTabBar.RightSide)
            if button is None:
                continue
            rect = self.tabRect(index)
            button.move(rect.right() - 7 - button.width(), rect.top() + 5)

    def tabLayoutChange(self):
        super().tabLayoutChange()
        self._position_close_buttons()

    def paintEvent(self, event):
        self._position_close_buttons()
        super().paintEvent(event)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowIcon(application_icon())
        self.settings = QSettings("NGenomeSyn", "NGenomeSynGUI")
        lang = self.settings.value("language", "zh")
        I18N.set_lang(str(lang))

        self.model = ConfModel()
        self.out_dir = Path(self.settings.value("out_dir", str(Path.home())))
        self.out_name = "NGenomeSynGUI"
        self.runner = Runner(self)
        self.runner.output.connect(self._on_runner_output)
        self.runner.finished_ok.connect(self._on_run_ok)
        self.runner.failed.connect(self._on_run_fail)
        self._dirty = False

        self._build_central()
        self._build_dock()
        self._build_toolbar()
        self._build_statusbar()
        self._rebuild_param_tabs()
        self._resize_initial()
        self._update_title()

    def _resize_initial(self):
        """Open at 1400x900, clamped to the screen (Wayland-safe)."""
        w, h = 1400, 900
        screen = QApplication.primaryScreen()
        if screen is not None:
            avail = screen.availableGeometry()
            if avail.width() > 0 and avail.height() > 0:
                w, h = min(w, avail.width()), min(h, avail.height())
        self.resize(w, h)

    # ================================================================ UI
    def _build_toolbar(self):
        tb = QToolBar("main")
        tb.setObjectName("toolbar")
        tb.setMovable(False)
        self.addToolBar(tb)

        self.act_new = QAction(I18N.tr("new_project"), self)
        self.act_new.triggered.connect(self._new_project)
        self.act_open = QAction(I18N.tr("open_conf"), self)
        self.act_open.setShortcut(QKeySequence.Open)
        self.act_open.triggered.connect(self._open_conf)
        self.act_save = QAction(I18N.tr("save_conf"), self)
        self.act_save.setShortcut(QKeySequence.Save)
        self.act_save.triggered.connect(self._save_conf)
        self.act_run = QAction(I18N.tr("run"), self)
        self.act_run.triggered.connect(self._run)
        self.act_svg = QAction(I18N.tr("export_svg"), self)
        self.act_svg.triggered.connect(self._export_svg)
        self.act_png = QAction(I18N.tr("export_png"), self)
        self.act_png.triggered.connect(self._export_png)
        self.act_pdf = QAction(I18N.tr("export_pdf"), self)
        self.act_pdf.triggered.connect(self._export_pdf)
        self.act_help = QAction(I18N.tr("help"), self)
        self.act_help.setShortcut(QKeySequence.HelpContents)
        self.act_help.setToolTip(I18N.tr("help_tip"))
        self.act_help.triggered.connect(self._open_manual)
        self.act_about = QAction(I18N.tr("about"), self)
        self.act_about.setToolTip(I18N.tr("about_tip"))
        self.act_about.triggered.connect(self._show_about)
        self.act_reset_layout = QAction(I18N.tr("reset_layout"), self)
        self.act_reset_layout.triggered.connect(self._reset_layout)

        self.menu_file = QMenu(I18N.tr("menu_file"), self)
        for a in (self.act_new, self.act_open, self.act_save):
            self.menu_file.addAction(a)
        self.menu_file.addSeparator()
        for a in (self.act_svg, self.act_png, self.act_pdf):
            self.menu_file.addAction(a)
        self.menu_view = QMenu(I18N.tr("view_menu"), self)
        for d in (self.files_dock, self.params_dock, self.log_dock):
            self.menu_view.addAction(d.toggleViewAction())
        self.menu_view.addSeparator()
        self.menu_view.addAction(self.act_reset_layout)
        self.menu_help = QMenu(I18N.tr("help"), self)
        self.menu_help.addAction(self.act_help)
        self.menu_help.addAction(self.act_about)

        self.btn_file_menu = QToolButton()
        self.btn_file_menu.setMenu(self.menu_file)
        self.btn_file_menu.setPopupMode(QToolButton.InstantPopup)
        self.btn_file_menu.setText(I18N.tr("menu_file"))
        tb.addWidget(self.btn_file_menu)
        self.btn_view_menu = QToolButton()
        self.btn_view_menu.setMenu(self.menu_view)
        self.btn_view_menu.setPopupMode(QToolButton.InstantPopup)
        self.btn_view_menu.setText(I18N.tr("view_menu"))
        tb.addWidget(self.btn_view_menu)
        tb.addSeparator()

        self.act_new_btn = QAction(I18N.tr("new_project"), self)
        self.act_new_btn.triggered.connect(self._new_project)
        tb.addAction(self.act_new_btn)
        self.act_open_btn = QAction(I18N.tr("open_conf"), self)
        self.act_open_btn.triggered.connect(self._open_conf)
        tb.addAction(self.act_open_btn)
        self.act_refresh = QAction(I18N.tr("refresh_preview"), self)
        self.act_refresh.setShortcut(QKeySequence.Refresh)
        self.act_refresh.triggered.connect(self._run)
        tb.addAction(self.act_refresh)
        tb.addAction(self.act_run)
        tb.widgetForAction(self.act_run).setObjectName("primaryBtn")

        spacer = QWidget()
        spacer.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Preferred)
        tb.addWidget(spacer)
        self.btn_cite = QToolButton()
        self.btn_cite.setObjectName("citationButton")
        self.btn_cite.setText(I18N.tr("cite"))
        self.btn_cite.clicked.connect(self._show_citation)
        tb.addWidget(self.btn_cite)
        self.btn_help_menu = QToolButton()
        self.btn_help_menu.setMenu(self.menu_help)
        self.btn_help_menu.setPopupMode(QToolButton.InstantPopup)
        self.btn_help_menu.setText(I18N.tr("help"))
        tb.addWidget(self.btn_help_menu)
        self.lang_combo = QComboBox()
        self.lang_combo.addItem("中文", "zh")
        self.lang_combo.addItem("English", "en")
        self.lang_combo.setCurrentIndex(0 if I18N.lang() == "zh" else 1)
        self.lang_combo.currentIndexChanged.connect(self._switch_lang)
        tb.addWidget(QLabel(I18N.tr("language") + ": "))
        tb.addWidget(self.lang_combo)

    _MANUALS = [
        ("engine_zh", "NGenomeSyn_manual_Chinese.pdf", "help_engine_zh"),
        ("engine_en", "NGenomeSyn_manual_English.pdf", "help_engine_en"),
        ("gui_zh", "NGenomeSyn_GUI_manual_Chinese.pdf", "help_gui_zh"),
        ("gui_en", "NGenomeSyn_GUI_manual_English.pdf", "help_gui_en"),
        # The WeChat/social-media article draft (gui/doc/*.docx|md) is a
        # publishing asset, not user documentation: deliberately NOT listed
        # in the Help dialog.
    ]

    @staticmethod
    def _manual_bases(kind):
        exe_dir = Path(sys.executable).parent
        if kind.startswith("gui"):
            return (ROOT / "gui" / "doc", exe_dir / "gui" / "doc",
                    exe_dir, ROOT)
        return (ROOT, exe_dir, ROOT.parent)

    @classmethod
    def _find_manual(cls, kind, name):
        for base in cls._manual_bases(kind):
            cand = base / name
            if cand.is_file():
                return cand
        return None

    def _gui_doc_dir(self):
        for d in (ROOT / "gui" / "doc",
                  Path(sys.executable).parent / "gui" / "doc",
                  self.out_dir):
            try:
                d.mkdir(parents=True, exist_ok=True)
                probe = d / ".probe"
                probe.write_text("", encoding="utf-8")
                probe.unlink()
                return d
            except OSError:
                continue
        return self.out_dir

    def _generate_gui_manual(self, kind, name):
        try:
            import importlib.util
            script = None
            for base in (GUI_DIR, ROOT, Path(sys.executable).parent):
                cand = base / "tools" / "gen_gui_manual.py"
                if cand.is_file():
                    script = cand
                    break
            if script is None:
                raise FileNotFoundError("gen_gui_manual.py not found")
            spec = importlib.util.spec_from_file_location("gen_gui_manual", script)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            dest = self._gui_doc_dir()
            written = mod.generate(dest, langs=(kind[-2:],),
                                   gui_ver=GUI_VERSION,
                                   engine_ver=self._engine_version())
            return written.get(kind[-2:])
        except Exception as e:                    # noqa: BLE001
            self._show_error("generate-manual", e)
            return None

    def _open_manual(self):
        dlg = self._build_help_dialog()
        dlg.exec()

    def _build_help_dialog(self):
        dlg = QDialog(self)
        dlg.setWindowTitle(I18N.tr("help_pick_title"))
        lay = QVBoxLayout(dlg)
        intro = QLabel(I18N.tr("help_pick_intro"))
        intro.setWordWrap(True)
        lay.addWidget(intro)

        def open_path(p):
            self._open_url(QUrl.fromLocalFile(str(p)))

        for kind, name, i18n_key in self._MANUALS:
            row = QHBoxLayout()
            found = self._find_manual(kind, name)
            desc = I18N.tr(i18n_key)
            btn = QPushButton(desc)
            btn.setStyleSheet("text-align:left; padding:6px;")
            row.addWidget(btn, 1)
            status = QLabel()
            if found is not None:
                status.setText(I18N.tr("help_bundled"))
                status.setStyleSheet("color: palette(mid);")
                btn.clicked.connect(lambda _c=False, p=found: open_path(p))
                # the Word companion button is for the manuals; the article
                # draft already has its own .docx entry
                if kind.startswith("gui") and "manual" in name.lower():
                    docx_path = found.with_suffix(".docx")
                    word_btn = QPushButton(I18N.tr("help_word"))
                    word_btn.setToolTip(I18N.tr("help_word_tip"))
                    word_btn.setEnabled(docx_path.is_file())
                    word_btn.clicked.connect(
                        lambda _c=False, p=docx_path: open_path(p))
                    row.addWidget(word_btn)
            elif kind.startswith("gui") and "manual" in name.lower():
                btn.setText(desc + "  ·  " + I18N.tr("help_generate"))
                btn.clicked.connect(
                    lambda _c=False, k=kind, n=name, st=status, b=open_path:
                    self._generate_and_open(k, n, st, b))
                status.setText(I18N.tr("help_missing_tag"))
                status.setStyleSheet("color: palette(mid);")
            else:
                btn.setEnabled(False)
                status.setText(I18N.tr("help_missing_tag"))
                status.setStyleSheet("color: palette(mid);")
            row.addWidget(status)
            lay.addLayout(row)
        tip = QLabel(I18N.tr("help_pick_footer"))
        tip.setWordWrap(True)
        tip.setStyleSheet("color: palette(mid);")
        lay.addWidget(tip)
        bb = QDialogButtonBox(QDialogButtonBox.Close)
        bb.rejected.connect(dlg.reject)
        bb.clicked.connect(dlg.accept)
        lay.addWidget(bb)
        return dlg

    def _generate_and_open(self, kind, name, status_label, open_fn):
        path = self._generate_gui_manual(kind, name)
        if path is None:
            return
        path = Path(path)
        status_label.setText(I18N.tr("help_generated", f=path.name))
        open_fn(path)

    def _open_url(self, url):
        from PySide6.QtGui import QDesktopServices
        if not QDesktopServices.openUrl(url):
            self.statusBar().showMessage(I18N.tr("open_failed"), 6000)

    def _show_citation(self):
        self._build_citation_dialog().exec()

    # citation text: GitHub + the published paper (README §5 Citation)
    PAPER = ("He W, Yang J, Jing Y, Xu L, Yu K, Fang X. NGenomeSyn: an easy-to-use "
             "and flexible tool for publication-ready visualization of syntenic "
             "relationships across multiple genomes. Bioinformatics, 2023; "
             "btad121. https://doi.org/10.1093/bioinformatics/btad121")

    def _build_citation_dialog(self):
        url = "https://github.com/hewm2008/NGenomeSyn"
        doi = "https://doi.org/10.1093/bioinformatics/btad121"
        dlg = QDialog(self)
        dlg.setWindowTitle(I18N.tr("cite"))
        lay = QVBoxLayout(dlg)
        intro = QLabel(I18N.tr("cite_intro"))
        intro.setWordWrap(True)
        lay.addWidget(intro)
        text = QPlainTextEdit("NGenomeSyn — GitHub repository. " + url
                              + "\n\n" + self.PAPER)
        text.setObjectName("citationText")
        text.setReadOnly(True)
        text.setMinimumWidth(520)
        text.setMaximumHeight(150)
        lay.addWidget(text)
        buttons = QDialogButtonBox(QDialogButtonBox.Close)
        copy = buttons.addButton(I18N.tr("copy_citation"), QDialogButtonBox.ActionRole)
        copy.setObjectName("copyCitationButton")

        def copy_citation():
            QApplication.clipboard().setText(text.toPlainText())
            copy.setText(I18N.tr("citation_copied"))
        copy.clicked.connect(copy_citation)
        github = buttons.addButton(I18N.tr("open_github"), QDialogButtonBox.ActionRole)
        github.setObjectName("openCitationGithubButton")
        github.clicked.connect(lambda: self._open_url(QUrl(url)))
        paper = buttons.addButton(I18N.tr("paper_doi"), QDialogButtonBox.ActionRole)
        paper.setObjectName("openCitationPaperButton")
        paper.clicked.connect(lambda: self._open_url(QUrl(doi)))
        buttons.rejected.connect(dlg.reject)
        lay.addWidget(buttons)
        return dlg

    def _show_about(self):
        self._build_about_dialog().exec()

    def _build_about_dialog(self):
        dlg = QDialog(self)
        dlg.setWindowTitle(I18N.tr("about_title"))
        lay = QVBoxLayout(dlg)
        logo = QLabel()
        logo.setObjectName("aboutLogo")
        logo.setAccessibleName("NGenomeSyn")
        logo.setPixmap(logo_pixmap())
        logo.setAlignment(Qt.AlignCenter)
        lay.addWidget(logo)
        body = QLabel(I18N.tr("about_body", gui_ver=GUI_VERSION,
                              engine_ver=self._engine_version()))
        body.setTextFormat(Qt.RichText)
        body.setOpenExternalLinks(True)
        body.setTextInteractionFlags(Qt.TextBrowserInteraction | Qt.TextSelectableByMouse)
        lay.addWidget(body)
        bb = QDialogButtonBox(QDialogButtonBox.Close)
        bb.rejected.connect(dlg.reject)
        bb.clicked.connect(dlg.accept)
        lay.addWidget(bb)
        return dlg

    @staticmethod
    def _engine_version():
        try:
            m = re.search(r"Version\s*:\s*(\d+\.\d+)",
                          ENGINE.read_text(errors="replace"))
            return m.group(1) if m else "1.50"
        except OSError:
            return "1.50"

    def _build_central(self):
        self.preview = PreviewView()
        self.btn_refresh = QPushButton(I18N.tr("refresh_preview"))
        self.btn_refresh.setToolTip(I18N.tr("refresh_tip"))
        self.btn_refresh.setShortcut(QKeySequence.Refresh)
        self.btn_refresh.clicked.connect(self._run)
        self.chk_auto = QCheckBox(I18N.tr("auto_refresh"))
        self.chk_auto.setToolTip(I18N.tr("auto_refresh_tip"))
        self.chk_auto.setChecked(self.settings.value("auto_refresh", "0") in ("1", "true", True))
        self.chk_auto.toggled.connect(self._auto_toggled)
        self.btn_svg = QPushButton(I18N.tr("export_svg"))
        self.btn_svg.setToolTip(I18N.tr("export_svg_tip"))
        self.btn_svg.clicked.connect(self._export_svg)
        self.btn_pdf = QPushButton(I18N.tr("export_pdf"))
        self.btn_pdf.clicked.connect(self._export_pdf)
        strip_frame = QFrame()
        strip_frame.setObjectName("previewStrip")
        strip = QHBoxLayout(strip_frame)
        strip.setContentsMargins(8, 6, 8, 6)
        strip.setSpacing(6)
        strip.addWidget(self.btn_refresh)
        strip.addWidget(self.chk_auto)
        strip.addWidget(self.btn_svg)
        strip.addWidget(self.btn_pdf)
        strip.addStretch(1)
        pwrap = QWidget()
        play = QVBoxLayout(pwrap)
        play.setContentsMargins(8, 8, 8, 8)
        play.addWidget(strip_frame)
        play.addWidget(self.preview, 1)
        self._preview_stale = False
        self._preview_page = pwrap
        self.setCentralWidget(self._preview_page)

        self._auto_timer = QTimer(self)
        self._auto_timer.setSingleShot(True)
        self._auto_timer.setInterval(1500)
        self._auto_timer.timeout.connect(self._flush_auto)
        self._auto_pending = False
        self._pending_manual = False
        self._last_run_auto = False

    def _build_dock(self):
        # left: genome files (top) + link files (bottom)
        self.files_panel = LeftFilesPanel()
        self.files_panel.set_base_dir(self.out_dir)
        self.files_panel.genomes_changed.connect(self._on_genomes_changed)
        self.files_panel.links_changed.connect(self._on_links_changed)
        self.files_panel.selection_changed.connect(self._on_row_selected)
        dock = QDockWidget(I18N.tr("data_files") + " / " + I18N.tr("link_files"), self)
        dock.setObjectName("filesDock")
        dock.setWidget(self.files_panel)
        dock.setFeatures(QDockWidget.DockWidgetMovable | QDockWidget.DockWidgetClosable)
        self.addDockWidget(Qt.LeftDockWidgetArea, dock)
        self.files_dock = dock

        # right: parameter tabs + genome/link manager row
        self._build_mgr_row()
        self.param_tabs = QTabWidget()
        self._param_tab_bar = ParameterTabBar()
        self.param_tabs.setTabBar(self._param_tab_bar)
        self.param_tabs.tabBar().setObjectName("parameterTabBar")
        self.param_tabs.setUsesScrollButtons(True)
        self.param_tabs.setDocumentMode(True)
        self.param_tabs.currentChanged.connect(lambda _i: self._refresh_summary_if_current())
        self.param_tabs.currentChanged.connect(self._on_tab_changed)
        right_wrap = QWidget()
        rlay = QVBoxLayout(right_wrap)
        rlay.setContentsMargins(4, 4, 4, 4)
        rlay.addWidget(self.mgr_row)
        rlay.addWidget(self.param_tabs, 1)
        rdock = QDockWidget(I18N.tr("right_dock_title"), self)
        rdock.setObjectName("paramsDock")
        rdock.setWidget(right_wrap)
        rdock.setFeatures(QDockWidget.DockWidgetMovable)   # not closable
        self.addDockWidget(Qt.RightDockWidgetArea, rdock)
        self.params_dock = rdock

        # bottom: run log
        self.log = QPlainTextEdit()
        self.log.setReadOnly(True)
        ldock = QDockWidget(I18N.tr("log_dock_title"), self)
        ldock.setObjectName("logDock")
        ldock.setFeatures(QDockWidget.DockWidgetMovable | QDockWidget.DockWidgetClosable
                          | QDockWidget.DockWidgetFloatable)
        ldock.setWidget(self.log)
        self.addDockWidget(Qt.BottomDockWidgetArea, ldock)
        self.log_dock = ldock

        state = self.settings.value("dock_state")
        if state:
            self.restoreState(state)
        self.resizeDocks([ldock], [120], Qt.Vertical)

    def _build_mgr_row(self):
        """Compact 基因组/链接管理 card: add/remove genome sections and links."""
        card, card_lay = make_card(I18N.tr("genome_manage"))
        self.mgr_row = card
        card_lay.setContentsMargins(10, 6, 10, 8)

        title_item = card_lay.takeAt(0)
        title_label = title_item.widget()
        trow = QHBoxLayout()
        trow.addWidget(title_label)
        trow.addStretch(1)
        self.mgr_status = QLabel()
        self.mgr_status.setStyleSheet("color: palette(mid); font-size: 9pt;")
        trow.addWidget(self.mgr_status)
        card_lay.insertLayout(0, trow)

        def _spin():
            s = QSpinBox()
            s.setRange(1, 999)
            s.setFixedWidth(64)
            return s
        n_max = max(self.model.genomes) if self.model.genomes else 0
        grow = QHBoxLayout()
        grow.setSpacing(4)
        self.g_add_spin = _spin()
        self.g_add_spin.setValue(n_max + 1)
        self.g_add_spin.setToolTip(I18N.tr("genome_add_which"))
        g_add_label = QLabel("Genome ID")
        g_add_label.setBuddy(self.g_add_spin)
        grow.addWidget(g_add_label)
        grow.addWidget(self.g_add_spin)
        self.g_add_btn = QPushButton(I18N.tr("add_genome"))
        self.g_add_btn.setToolTip(I18N.tr("add_genome_tip"))
        self.g_add_btn.clicked.connect(self._add_genome)
        grow.addWidget(self.g_add_btn)
        grow.addSpacing(10)
        self.g_rem_spin = _spin()
        self.g_rem_spin.setValue(max(n_max, 1))
        self.g_rem_spin.setToolTip(I18N.tr("genome_remove_which"))
        g_rem_label = QLabel("Genome ID")
        g_rem_label.setBuddy(self.g_rem_spin)
        grow.addWidget(g_rem_label)
        grow.addWidget(self.g_rem_spin)
        self.g_rem_btn = QPushButton(I18N.tr("remove_genome"))
        self.g_rem_btn.clicked.connect(self._remove_genome)
        grow.addWidget(self.g_rem_btn)
        grow.addStretch(1)
        card_lay.addLayout(grow)

        lrow = QHBoxLayout()
        lrow.setSpacing(4)
        self.l_add_btn = QPushButton(I18N.tr("add_link"))
        self.l_add_btn.clicked.connect(self._add_link)
        lrow.addWidget(self.l_add_btn)
        lrow.addSpacing(10)
        self.l_rem_spin = _spin()
        self.l_rem_spin.setToolTip(I18N.tr("genome_remove_which"))
        l_rem_label = QLabel("Link ID")
        l_rem_label.setBuddy(self.l_rem_spin)
        lrow.addWidget(l_rem_label)
        lrow.addWidget(self.l_rem_spin)
        self.l_rem_btn = QPushButton(I18N.tr("remove_link"))
        self.l_rem_btn.clicked.connect(self._remove_link)
        lrow.addWidget(self.l_rem_btn)
        lrow.addStretch(1)
        card_lay.addLayout(lrow)

    def _update_mgr_state(self):
        n_max = max(self.model.genomes) if self.model.genomes else 0
        self.g_add_spin.setValue(n_max + 1)
        self.g_rem_spin.setValue(max(n_max, 1))
        has_g = n_max > 0
        self.g_rem_spin.setEnabled(has_g)
        self.g_rem_btn.setEnabled(has_g)
        n_links = len(self.model.link_files)
        self.l_rem_spin.setValue(max(n_links, 1))
        self.l_rem_spin.setEnabled(n_links > 0)
        self.l_rem_btn.setEnabled(n_links > 0)
        self.mgr_status.setText(I18N.tr("genomes_count",
                                        g=n_genomes_declared(self.model),
                                        l=n_links))
        self.files_panel.sync_genome_count(max(1, len(self.model.genome_files)))

    def _reset_layout(self):
        self.settings.remove("dock_state")
        for dock, area in ((self.files_dock, Qt.LeftDockWidgetArea),
                           (self.params_dock, Qt.RightDockWidgetArea),
                           (self.log_dock, Qt.BottomDockWidgetArea)):
            self.removeDockWidget(dock)
            self.addDockWidget(area, dock)
            dock.setVisible(True)

    def _build_statusbar(self):
        self.statusBar().showMessage("Perl: %s" % (find_perl() or I18N.tr("perl_missing")))

    # ================================================================ tabs
    def _rebuild_param_tabs(self, select=None):
        """(Re)create the tabs of the right-hand parameter dock.

        Tab set: Global · GenomeALL · Genome 1..N · LinkALL · Link 1..M ·
        参数总览. Per-section pages are lazy placeholders: only the page the
        user opens is built."""
        self._rebuilding_tabs = True
        QApplication.setOverrideCursor(Qt.WaitCursor)
        try:
            pages = [getattr(self, "global_form", None),
                     getattr(self, "genome_all_form", None),
                     getattr(self, "link_all_form", None),
                     getattr(self, "summary_tab", None)]
            pages += list((getattr(self, "genome_pages", None) or {}).values())
            pages += list((getattr(self, "link_pages", None) or {}).values())
            for w in pages:
                if w is None:
                    continue
                i = self.param_tabs.indexOf(w)
                if i >= 0:
                    self.param_tabs.removeTab(i)
                w.setParent(None)
                w.deleteLater()

            pos = 0
            self.global_form = ParamForm("global", self.model)
            self.global_form.any_changed.connect(self._mark_dirty)
            self.global_form.param_changed.connect(self._route_param_change)
            self.global_form.files_changed.connect(self._on_bar_genomes_changed)
            self.global_form.links_changed.connect(self._on_bar_links_changed)
            self.global_form.row_selected.connect(self._on_bar_row_selected)
            self.param_tabs.insertTab(pos, self.global_form, I18N.tr("global_tab"))
            pos += 1

            self.genome_all_form = ParamForm("genome_all", self.model)
            self.genome_all_form.any_changed.connect(self._mark_dirty)
            self.genome_all_form.param_changed.connect(self._route_param_change)
            self.param_tabs.insertTab(pos, self.genome_all_form,
                                      I18N.tr("genome_all_tab"))
            pos += 1

            self.genome_tabs = []
            self.genome_pages = {}
            for idx in sorted(self.model.genomes):
                page = LazyGenomePage(self.model, idx,
                                      on_built=self._on_genome_page_built)
                self.genome_pages[idx] = page
                self.param_tabs.insertTab(pos, page, page.tab_title())
                self._attach_close_btn(pos, idx, "genome")
                pos += 1

            self.link_all_form = ParamForm("link_all", self.model)
            self.link_all_form.any_changed.connect(self._mark_dirty)
            self.link_all_form.param_changed.connect(self._route_param_change)
            self.param_tabs.insertTab(pos, self.link_all_form,
                                      I18N.tr("link_all_tab"))
            pos += 1

            self.link_tabs = []
            self.link_pages = {}
            for idx in sorted(self.model.links):
                page = LazyLinkPage(self.model, idx,
                                    on_built=self._on_link_page_built)
                self.link_pages[idx] = page
                self.param_tabs.insertTab(pos, page, page.tab_title())
                self._attach_close_btn(pos, idx, "link")
                pos += 1

            self.summary_tab = LazyPage(build=lambda: ParamsSummaryTab(self.model),
                                        title_fn=lambda: I18N.tr("show_params"),
                                        on_built=self._on_summary_built)
            self.param_tabs.insertTab(pos, self.summary_tab, I18N.tr("show_params"))

            if select is not None:
                self.param_tabs.setCurrentWidget(select)
        finally:
            self._rebuilding_tabs = False
            QApplication.restoreOverrideCursor()
        self._materialize_current_tab()
        self._update_mgr_state()

    def _attach_close_btn(self, pos, idx, kind):
        btn = QToolButton(self.param_tabs.tabBar())
        btn.setObjectName("trackCloseButton")
        btn.setText("×")
        btn.setAutoRaise(True)
        btn.setFixedSize(16, 16)
        tip = (I18N.tr("remove_genome") if kind == "genome"
               else I18N.tr("remove_link")) + " " + str(idx)
        btn.setToolTip(tip)
        btn.setAccessibleName(tip)
        btn.clicked.connect(
            lambda _checked=False, t=idx, k=kind: self._remove_by_index(t, k))
        self.param_tabs.tabBar().setTabButton(pos, QTabBar.RightSide, btn)

    def _materialize_current_tab(self):
        w = self.param_tabs.currentWidget()
        if isinstance(w, (LazyGenomePage, LazyLinkPage)):
            self._materialize_section(w)
        elif isinstance(w, LazyPage):
            self._materialize_lazy(w)

    def _on_tab_changed(self, _i):
        if getattr(self, "_rebuilding_tabs", False):
            return
        self._materialize_current_tab()

    def _materialize_lazy(self, page):
        if page.materialized():
            return page.widget
        QApplication.setOverrideCursor(Qt.WaitCursor)
        try:
            page.materialize()
        finally:
            QApplication.restoreOverrideCursor()
        return page.widget

    def _materialize_section(self, page):
        if page.materialized():
            return page.tab
        QApplication.setOverrideCursor(Qt.WaitCursor)
        self.statusBar().showMessage(I18N.tr("loading_genomes", n=page.index))
        try:
            page.materialize()
        finally:
            QApplication.restoreOverrideCursor()
            self.statusBar().clearMessage()
        return page.tab

    def _on_genome_page_built(self, page):
        gt = page.tab
        gt.changed.connect(self._mark_dirty)
        gt.param_changed.connect(self._route_param_change)
        if gt not in self.genome_tabs:
            self.genome_tabs.append(gt)
        i = self.param_tabs.indexOf(page)
        if i >= 0:
            self.param_tabs.setTabText(i, page.tab_title())

    def _on_link_page_built(self, page):
        lt = page.tab
        lt.changed.connect(self._mark_dirty)
        lt.param_changed.connect(self._route_param_change)
        if lt not in self.link_tabs:
            self.link_tabs.append(lt)
        i = self.param_tabs.indexOf(page)
        if i >= 0:
            self.param_tabs.setTabText(i, page.tab_title())

    def _on_summary_built(self, page):
        st = page.widget
        st.param_changed.connect(self._route_param_change)
        st.genomes_changed.connect(self._on_genomes_changed)
        st.links_changed.connect(self._on_links_changed)

    # ================================================================ events
    def _switch_lang(self, _i):
        I18N.set_lang(self.lang_combo.currentData())
        self.settings.setValue("language", I18N.lang())
        try:
            self._refresh_texts()
        except Exception as e:
            self.log.appendPlainText("[i18n ERROR] %s" % e)
        self._rebuild_param_tabs()

    def _refresh_texts(self):
        self.act_new.setText(I18N.tr("new_project"))
        self.act_open.setText(I18N.tr("open_conf"))
        self.act_save.setText(I18N.tr("save_conf"))
        self.act_run.setText(I18N.tr("run"))
        self.act_png.setText(I18N.tr("export_png"))
        self.act_pdf.setText(I18N.tr("export_pdf"))
        self.act_help.setText(I18N.tr("help"))
        self.act_help.setToolTip(I18N.tr("help_tip"))
        self.act_about.setText(I18N.tr("about"))
        self.act_about.setToolTip(I18N.tr("about_tip"))
        self.btn_refresh.setText(I18N.tr("refresh_preview"))
        self.btn_refresh.setToolTip(I18N.tr("refresh_tip"))
        self.btn_svg.setText(I18N.tr("export_svg"))
        self.btn_svg.setToolTip(I18N.tr("export_svg_tip"))
        self.btn_pdf.setText(I18N.tr("export_pdf"))
        self.params_dock.setWindowTitle(I18N.tr("right_dock_title"))
        self.log_dock.setWindowTitle(I18N.tr("log_dock_title"))
        self.files_dock.setWindowTitle(I18N.tr("data_files") + " / " + I18N.tr("link_files"))
        self.menu_file.setTitle(I18N.tr("menu_file"))
        self.menu_view.setTitle(I18N.tr("view_menu"))
        self.menu_help.setTitle(I18N.tr("help"))
        self.btn_file_menu.setText(I18N.tr("menu_file"))
        self.btn_view_menu.setText(I18N.tr("view_menu"))
        self.btn_help_menu.setText(I18N.tr("help"))
        self.btn_cite.setText(I18N.tr("cite"))
        self.act_new_btn.setText(I18N.tr("new_project"))
        self.act_open_btn.setText(I18N.tr("open_conf"))
        self.act_refresh.setText(I18N.tr("refresh_preview"))
        self.act_refresh.setToolTip(I18N.tr("refresh_tip"))
        self.g_add_btn.setText(I18N.tr("add_genome"))
        self.g_add_btn.setToolTip(I18N.tr("add_genome_tip"))
        self.g_rem_btn.setText(I18N.tr("remove_genome"))
        self.l_add_btn.setText(I18N.tr("add_link"))
        self.l_rem_btn.setText(I18N.tr("remove_link"))
        self.act_svg.setText(I18N.tr("export_svg"))
        self.act_png.setText(I18N.tr("export_png"))
        self.act_pdf.setText(I18N.tr("export_pdf"))
        self.act_reset_layout.setText(I18N.tr("reset_layout"))
        self.btn_file_menu.setToolTip(I18N.tr("menu_file"))
        self.btn_view_menu.setToolTip(I18N.tr("view_menu"))
        self.btn_help_menu.setToolTip(I18N.tr("help"))

    def _refresh_summary_if_current(self):
        if getattr(self, "_rebuilding_tabs", False):
            return
        st = getattr(self, "summary_tab", None)
        if st is not None and self.param_tabs.currentWidget() is st \
                and st.materialized():
            st.widget.refresh()

    def _route_param_change(self, scope, key, value):
        """Fan a param edit out to every OTHER editor of the same key."""
        origin = self.sender()
        holders = [("global", self.global_form),
                   ("genome_all", self.genome_all_form),
                   ("link_all", self.link_all_form)]
        holders += [(("genome", gt.index), gt) for gt in self.genome_tabs]
        holders += [(("link", lt.index), lt) for lt in self.link_tabs]
        for fscope, holder in holders:
            if holder is origin or fscope != scope:
                continue
            holder.sync_row(key, value)
        st = getattr(self, "summary_tab", None)
        if st is not None and st is not origin and st.materialized():
            st.widget.sync_value(scope, key, value)
        self._mark_dirty()

    def _mark_dirty(self, *_a):
        self._dirty = True
        self._preview_stale = True
        if self.chk_auto.isChecked():
            self.preview.show_stale(I18N.tr("stale_running"))
        else:
            self.preview.show_stale(I18N.tr("stale_manual"))
        if self.chk_auto.isChecked():
            self._auto_timer.start()

    def _auto_toggled(self, on):
        self.settings.setValue("auto_refresh", "1" if on else "0")
        if not on:
            self._auto_timer.stop()

    def _flush_auto(self):
        if not self.chk_auto.isChecked() or not self._preview_stale:
            return
        self._run(auto=True)

    def _set_run_busy(self, busy):
        self.act_run.setEnabled(not busy)
        self.act_refresh.setEnabled(not busy)
        self.btn_refresh.setEnabled(not busy)
        self.btn_svg.setEnabled(not busy)
        self.btn_pdf.setEnabled(not busy)

    # ================================================================ files
    def _on_genomes_changed(self, files):
        self.model.genome_files = list(files)
        if getattr(self, "_in_run_normalize", False):
            return
        if getattr(self, "global_form", None) is not None:
            self.global_form.sync_bars()
        st = getattr(self, "summary_tab", None)
        if st is not None and st.materialized():
            st.widget.sync_genomes(files)
        self._update_mgr_state()
        self._mark_dirty()

    def _on_links_changed(self, links):
        self.model.link_files = list(links)
        if getattr(self, "_in_run_normalize", False):
            return
        if getattr(self, "global_form", None) is not None:
            self.global_form.sync_bars()
        st = getattr(self, "summary_tab", None)
        if st is not None and st.materialized():
            st.widget.sync_links(links)
        self._update_mgr_state()
        self._mark_dirty()

    def _on_bar_genomes_changed(self, files):
        self.files_panel.sync_genomes(files)

    def _on_bar_links_changed(self, links):
        self.files_panel.sync_links(links)

    def _on_row_selected(self, kind, index):
        """Left dock row picked: mirror the selection in the right dock."""
        gf = getattr(self, "global_form", None)
        if gf is not None:
            gf.set_selected_row(kind, index)

    def _on_bar_row_selected(self, kind, index):
        """Right dock row picked: select + preview it in the left dock."""
        self.files_panel.select_row(kind, index)

    # ====================================================== genomes / links
    def _add_genome(self):
        """Create (or just jump to) the genome section chosen by number.

        Sections are sparse: adding Genome3 does not create Genome1/Genome2 —
        untouched genomes render with GenomeALL/global defaults. The user is
        asked to add the matching GenomeInfoFile in the left panel."""
        n = self.g_add_spin.value()
        existed = n in self.model.genomes
        self.model.genomes.setdefault(n, {})
        while len(self.model.genome_files) < n:
            self.model.genome_files.append("")
        self._rebuild_param_tabs()
        page = (getattr(self, "genome_pages", None) or {}).get(n)
        if page is not None:
            self.param_tabs.setCurrentWidget(page)
        if not existed:
            self._mark_dirty()

    def _remove_genome(self):
        self._remove_by_index(self.g_rem_spin.value(), "genome")

    def _add_link(self):
        if len(self.model.genome_files) < 2 \
                or not any(self.model.genome_files):
            QMessageBox.information(self, I18N.tr("warn_title"),
                                    I18N.tr("link_too_few"))
            return
        n = len(self.model.link_files) + 1
        a = min(2, len(self.model.genome_files))
        b = 1
        self.model.link_files.append({"a": a, "b": b, "path": ""})
        self.model.links.setdefault(n, {})   # make the tab appear right away
        self._rebuild_param_tabs()
        page = (getattr(self, "link_pages", None) or {}).get(n)
        if page is not None:
            self.param_tabs.setCurrentWidget(page)
        self._mark_dirty()

    def _remove_link(self):
        self._remove_by_index(self.l_rem_spin.value(), "link")

    def _remove_by_index(self, target, kind):
        if kind == "genome":
            if target not in self.model.genomes:
                return
            if len(self.model.genomes) == 1:
                ret = QMessageBox.question(self, I18N.tr("warn_title"),
                                           I18N.tr("remove_last_genome"),
                                           QMessageBox.Yes | QMessageBox.No)
                if ret != QMessageBox.Yes:
                    return
            self.model.genomes.pop(target, None)
            self._rebuild_param_tabs()
            self._mark_dirty()
            return
        # link: the ordinal IS the LinkN index -> later links renumber
        if not (1 <= target <= len(self.model.link_files)):
            return
        self.model.link_files.pop(target - 1)
        self.model.links.pop(target, None)
        renumbered = {}
        for idx, sec in self.model.links.items():
            if idx > target:
                renumbered[idx - 1] = sec
            else:
                renumbered[idx] = sec
        self.model.links = renumbered
        self._rebuild_param_tabs()
        self._mark_dirty()

    # ================================================================ conf
    def _new_project(self):
        self.model = ConfModel()
        self.files_panel.sync_genomes(self.model.genome_files)
        self.files_panel.sync_links(self.model.link_files, force=True)
        self._rebuild_param_tabs()
        self.preview.reset()
        self._dirty = False
        self._update_title()

    def _open_conf(self):
        path, _ = QFileDialog.getOpenFileName(self, I18N.tr("open_conf_title"),
                                              str(self.out_dir),
                                              "Conf (*.conf *.cofi *.txt *.gz);;All (*)")
        if not path:
            return
        try:
            self.model = ConfModel().load(path)
        except OSError as e:
            QMessageBox.critical(self, I18N.tr("err_title"), str(e))
            return
        self.files_panel.sync_genomes(self.model.genome_files)
        self.files_panel.sync_links(self.model.link_files, force=True)
        self._rebuild_param_tabs()
        self._dirty = False
        self.out_dir = Path(path).parent
        self.out_name = Path(path).stem
        self.files_panel.set_base_dir(self.out_dir)
        self.settings.setValue("out_dir", str(self.out_dir))
        self.statusBar().showMessage(I18N.tr("conf_loaded", f=path))
        self._report_alias_log()
        self._update_title()

    def _report_alias_log(self):
        """Historical misspellings were rewritten on load — never silently."""
        log = getattr(self.model, "alias_log", None) or []
        if not log:
            return
        keys = ", ".join(sorted({old for _n, old, _new in log}))
        self.log.appendPlainText("[conf] %s" % I18N.tr(
            "conf_aliases", n=len(log), keys=keys))
        for lineno, old, new in log:
            self.log.appendPlainText("    line %d: %s -> %s" % (lineno, old, new))
        self.log_dock.setVisible(True)

    def _save_conf(self):
        path, _ = QFileDialog.getSaveFileName(
            self, I18N.tr("save_conf_title"),
            str(self.out_dir / "ngenomesyn_gui.conf"),
            "Conf (*.conf);;All (*)")
        if not path:
            return
        self.model.absolutize_paths(self.out_dir)
        self.model.save(path)
        self.out_dir = Path(path).parent
        self.out_name = Path(path).stem
        self.files_panel.set_base_dir(self.out_dir)
        self.settings.setValue("out_dir", str(self.out_dir))
        self.statusBar().showMessage(I18N.tr("conf_written", f=path))
        self._update_title()

    def _validate(self, auto=False):
        errors, warnings = _validate_mod.validate(self.model)
        if warnings:
            self.log.appendPlainText("[check] " + " | ".join(warnings))
        if not errors:
            return True
        if auto:
            self.log.appendPlainText("[check] " + " | ".join(errors))
            return False
        dlg = QMessageBox(self)
        dlg.setIcon(QMessageBox.Critical)
        dlg.setWindowTitle(I18N.tr("validate_title"))
        dlg.setText(I18N.tr("validate_intro"))
        dlg.setDetailedText("\n".join(errors))
        dlg.setTextInteractionFlags(Qt.TextSelectableByMouse)
        dlg.exec()
        return False

    # ================================================================ run
    def _run(self, auto=False):
        self._last_run_auto = auto
        try:
            self._run_impl(auto=auto)
        except Exception as e:                    # noqa: BLE001
            self._show_error("run", e, auto=auto)
            self._set_run_busy(False)

    def _run_impl(self, auto=False):
        if self.runner.running():
            self._auto_pending = True
            self._pending_manual = self._pending_manual or (not auto)
            if not auto:
                self.statusBar().showMessage(I18N.tr("already_running"))
            return
        if not self._validate(auto=auto):
            return
        if not find_perl():
            QMessageBox.critical(self, I18N.tr("err_title"), I18N.tr("perl_missing"))
            return
        self.out_dir.mkdir(parents=True, exist_ok=True)
        self.settings.setValue("out_dir", str(self.out_dir))
        # absolutize user-typed relative paths, then swap .gz inputs for
        # pre-decompressed cache copies (the engine would shell out to gzip
        # otherwise). The model keeps the ORIGINAL paths; only the runtime
        # conf gets the mapped ones, so Save conf stays portable.
        self._in_run_normalize = True
        try:
            self.model.absolutize_paths(self.out_dir)
            self.files_panel.sync_genomes(self.model.genome_files)
            self.files_panel.sync_links(self.model.link_files, force=True)
        finally:
            self._in_run_normalize = False
        conf_path = self.out_dir / "ngs_gui_run.conf"
        conf_path.write_text(
            self.model.to_conf_text(map_path=map_all_paths(self.model)),
            encoding="utf-8")
        # drop the stale SVG: a failed run must never leave the old figure
        self._svg_mtime_before = None
        old_svg = self.out_dir / (self.out_name + ".svg")
        if old_svg.is_file():
            self._svg_mtime_before = old_svg.stat().st_mtime
            try:
                old_svg.unlink()
            except OSError:
                pass
        self.log.appendPlainText(
            "$ perl bin/NGenomeSyn -InConf %s -OutPut %s -NoPng"
            % (conf_path, self.out_dir / self.out_name))
        self.statusBar().showMessage(I18N.tr("running"))
        self._set_run_busy(True)
        self.runner.run(conf_path, self.out_dir / self.out_name)

    def _on_runner_output(self, text):
        self.log.appendPlainText(text.rstrip())

    def _on_run_ok(self, svg_path):
        self._set_run_busy(False)
        try:
            svg = Path(svg_path)
            if not svg.is_file():
                self._on_run_fail("no-svg-file")
                return
            mtime = svg.stat().st_mtime
            if self._svg_mtime_before is not None and mtime <= self._svg_mtime_before:
                self._on_run_fail("stale-svg")
                return
            if not self.preview.load_svg(svg_path):
                QTimer.singleShot(150, lambda: self._retry_load(svg_path, 1))
                return
            self.statusBar().showMessage(I18N.tr("done_ok", f=svg_path))
            self._preview_stale = False
            self.preview.hide_stale()
            self._flush_pending()
        except Exception as e:                    # noqa: BLE001
            self._show_error("run-ok", e)

    def _flush_pending(self):
        if self._auto_pending:
            self._auto_pending = False
            pm = self._pending_manual
            self._pending_manual = False
            QTimer.singleShot(0, lambda a=not pm: self._run(auto=a))

    def _retry_load(self, svg_path, attempt):
        if self.preview.load_svg(svg_path):
            self.statusBar().showMessage(I18N.tr("done_ok", f=svg_path))
            self._preview_stale = False
            self.preview.hide_stale()
            self._flush_pending()
        elif attempt < 3:
            QTimer.singleShot(200, lambda: self._retry_load(svg_path, attempt + 1))
        else:
            self._on_run_fail("svg-render-failed")

    def _on_run_fail(self, reason):
        self._set_run_busy(False)
        tail = self.log.toPlainText()[-600:]
        self.log.appendPlainText("\n[FAIL] %s" % reason)
        self.statusBar().showMessage(I18N.tr("done_fail"))
        self.log_dock.setVisible(True)
        self.preview.show_stale(I18N.tr("stale_fail_hint"), error=True)
        self._flush_pending()
        if not self._last_run_auto:
            QMessageBox.warning(self, I18N.tr("run_fail_title"),
                                I18N.tr("run_fail_msg", reason=reason) + "\n\n" + tail)

    def _show_error(self, where, exc, auto=False):
        import traceback
        tb = "".join(traceback.format_exception_only(type(exc), exc)).strip()
        self.log.appendPlainText("[%s ERROR] %s" % (where, tb))
        if auto:
            self.statusBar().showMessage("[%s] %s" % (where, tb))
            return
        try:
            QMessageBox.critical(self, I18N.tr("err_title"), "[%s] %s" % (where, tb))
        except Exception:                          # noqa: BLE001
            pass

    # ================================================================ export
    def _export_png(self):
        if not self.preview.has_svg():
            QMessageBox.information(self, I18N.tr("warn_title"), I18N.tr("no_preview"))
            return
        from PySide6.QtWidgets import QDialogButtonBox, QFormLayout, QSpinBox
        dlg = QDialog(self)
        dlg.setWindowTitle(I18N.tr("export_png"))
        form = QFormLayout(dlg)
        dsize = self.preview._renderer.defaultSize()
        spin = QSpinBox()
        spin.setRange(64, 30000)
        spin.setValue(dsize.width() * 2)
        form.addRow("width(px)", spin)
        bb = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        bb.accepted.connect(dlg.accept)
        bb.rejected.connect(dlg.reject)
        form.addRow(bb)
        if dlg.exec() != QDialog.Accepted:
            return
        out, _ = QFileDialog.getSaveFileName(self, I18N.tr("export_png"),
                                             str(self.out_dir / (self.out_name + ".png")), "PNG (*.png)")
        if not out:
            return
        if self.preview.export_png(out, spin.value()):
            self.statusBar().showMessage(I18N.tr("export_done", f=out))

    def _export_svg(self):
        """Save the exact SVG the preview is showing (byte-identical copy)."""
        try:
            src_path = self.preview.source_path()
            if not src_path:
                QMessageBox.information(self, I18N.tr("warn_title"), I18N.tr("no_preview"))
                return
            default = str(self.out_dir / (self.out_name + ".svg"))
            target, _ = QFileDialog.getSaveFileName(self, I18N.tr("export_svg"),
                                                    default, "SVG (*.svg);;All (*)")
            if not target:
                return
            import shutil
            if Path(target).resolve() == Path(src_path).resolve():
                self.statusBar().showMessage(I18N.tr("export_done", f=target))
                return
            shutil.copyfile(src_path, target)
            self.statusBar().showMessage(I18N.tr("export_done", f=target))
        except Exception as e:                    # noqa: BLE001
            self._show_error("export-svg", e)

    def _export_pdf(self):
        if not self.preview.has_svg():
            QMessageBox.information(self, I18N.tr("warn_title"), I18N.tr("no_preview"))
            return
        out, _ = QFileDialog.getSaveFileName(self, I18N.tr("export_pdf"),
                                             str(self.out_dir / (self.out_name + ".pdf")), "PDF (*.pdf)")
        if not out:
            return
        if self.preview.export_pdf(out):
            self.statusBar().showMessage(I18N.tr("export_done", f=out))

    # ================================================================ misc
    def _update_title(self, conf_stem=None):
        name = conf_stem or self.out_name
        self.setWindowTitle("%s — %s (%s)" % (I18N.tr("app_title"), name, self.out_dir))

    def closeEvent(self, ev):
        self.settings.setValue("dock_state", self.saveState())
        if self.runner.running():
            try:
                self.runner.finished_ok.disconnect()
                self.runner.failed.disconnect()
                self.runner.output.disconnect()
            except (RuntimeError, TypeError):
                pass
        self.runner.stop()
        super().closeEvent(ev)


def n_genomes_declared(model):
    """Number of genomes the engine would infer (max file index / section)."""
    n_files = len(model.genome_files)
    n_secs = max(model.genomes) if model.genomes else 0
    return max(n_files, n_secs)
