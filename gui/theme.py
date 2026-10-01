"""System-following theme (light/dark) for the NGenomeSyn GUI.

The UI follows the OS color scheme (Qt 6.5+ styleHints, live via
colorSchemeChanged) and installs a card-based, teal-accented QSS in both
light and dark variants. The plot preview itself always renders the SVG on
a white "paper" sheet (see gui/ui/preview.py), so figures stay correct in
dark mode — matching the white-background PNG export."""
from PySide6.QtCore import Qt
from PySide6.QtGui import QColor, QGuiApplication, QPalette

GUI_VERSION_PLACEHOLDER = None          # (version lives in gui/__init__.py)

_ACCENT = {
    "light": {"accent": "#0E9488", "hover": "#0C7F75", "soft": "#E0F2F0",
              "on_accent": "#FFFFFF"},
    "dark":  {"accent": "#2DD4BF", "hover": "#5EEAD4", "soft": "#1F3D3A",
              "on_accent": "#06302B"},
}


def _tokens(dark):
    a = _ACCENT["dark" if dark else "light"]
    if dark:
        t = {**a, "text": "#d0d0d0", "mid": "#969696", "disabled": "#6f6f6f",
             "border": "#454c54", "border_strong": "#6b7480", "base": "#23272b",
             "alt": "#2a2f34", "window": "#303438", "hover_bg": "#3a4148",
             "card": "#2b3036", "card_border": "#3f464d", "header": "#282c31",
             "tab_bar_bg": "#203D3A", "tab_bar_border": "#42645F"}
    else:
        t = {**a, "text": "#1a1a1a", "mid": "#8a8a8a", "disabled": "#a5a5a5",
             "border": "#c9d1d9", "border_strong": "#9aa4ae", "base": "#ffffff",
             "alt": "#f6f8fa", "window": "#f0f2f5", "hover_bg": "#e7eef6",
             "card": "#ffffff", "card_border": "#dde3ea", "header": "#e9edf2",
             "tab_bar_bg": "#DCEBE9", "tab_bar_border": "#A7C5C0"}
    return t


def stylesheet(dark):
    """Card-based, teal-accented QSS matching the light/dark palettes."""
    t = _tokens(dark)
    qss = (
        "QWidget { font-size: 10.5pt; }\n"
        "QMainWindow, QDialog { background: %(window)s; }\n"
        "QToolTip { background: %(base)s; color: %(text)s; border: 1px solid %(border)s; padding: 3px; }\n"
        "\n"
        "QToolBar#toolbar { background: %(header)s; border: none; border-bottom: 1px solid %(border)s; padding: 4px 8px; spacing: 4px; }\n"
        "QToolBar::separator { background: %(border)s; width: 1px; margin: 8px 32px; }\n"
        "QToolBar#toolbar QToolButton { background: transparent; border: none; border-radius: 6px; padding: 6px 10px; color: %(text)s; }\n"
        "QToolBar#toolbar QToolButton:hover { background: %(hover_bg)s; }\n"
        "QToolBar#toolbar QToolButton:pressed { background: %(soft)s; }\n"
        "QToolButton#primaryBtn { background: %(accent)s; color: %(on_accent)s; font-weight: 600; padding: 6px 16px; }\n"
        "QToolButton#primaryBtn:hover { background: %(hover)s; }\n"
        "QToolButton#primaryBtn:disabled { background: %(disabled)s; color: %(window)s; }\n"
        "\n"
        "QTabWidget::pane { border: 1px solid %(border)s; border-radius: 8px; background: %(base)s; top: -1px; }\n"
        "QTabBar::tab { background: transparent; color: %(mid)s; padding: 7px 16px; margin-right: 2px; border-bottom: 2px solid transparent; }\n"
        "QTabBar::tab:hover { color: %(text)s; }\n"
        "QTabBar::tab:selected { color: %(accent)s; border-bottom: 2px solid %(accent)s; font-weight: 600; }\n"
        "QTabBar#parameterTabBar { background: %(tab_bar_bg)s; border: 1px solid %(tab_bar_border)s; border-radius: 8px; }\n"
        "QTabBar#parameterTabBar::tab { background: %(alt)s; color: %(text)s; border: 1px solid %(border)s; border-radius: 7px; padding: 7px 4px 7px 10px; margin: 2px 5px 6px 0px; }\n"
        "QTabBar#parameterTabBar::tab:hover:!selected { background: %(hover_bg)s; border-color: %(accent)s; }\n"
        "QTabBar#parameterTabBar::tab:selected { background: %(accent)s; color: %(on_accent)s; border: 1px solid %(accent)s; font-weight: 600; }\n"
        "QToolButton#trackCloseButton { background: transparent; color: %(text)s; border: none; border-radius: 4px; padding: 0px; font-size: 12px; font-weight: 400; }\n"
        "QToolButton#trackCloseButton:hover { background: #fbe5e5; color: #a52a2a; }\n"
        "\n"
        "QPushButton { background: %(base)s; color: %(text)s; border: 1px solid %(border)s; border-radius: 6px; padding: 5px 14px; min-height: 22px; }\n"
        "QPushButton:hover { border-color: %(accent)s; color: %(accent)s; }\n"
        "QPushButton:pressed { background: %(soft)s; }\n"
        "QPushButton:disabled { color: %(disabled)s; border-color: %(border)s; background: transparent; }\n"
        "QPushButton:checked { background: %(soft)s; border-color: %(accent)s; color: %(accent)s; font-weight: 600; }\n"
        "\n"
        "QLineEdit, QSpinBox, QDoubleSpinBox, QComboBox, QPlainTextEdit { background: %(base)s; color: %(text)s; border: 1px solid %(border)s; border-radius: 6px; padding: 3px 8px; selection-background-color: %(accent)s; }\n"
        "QLineEdit:focus, QSpinBox:focus, QDoubleSpinBox:focus, QComboBox:focus, QPlainTextEdit:focus { border-color: %(accent)s; }\n"
        "QLineEdit:disabled, QSpinBox:disabled, QDoubleSpinBox:disabled { color: %(disabled)s; }\n"
        "QComboBox::drop-down { border: none; width: 22px; }\n"
        "QComboBox QAbstractItemView { background: %(base)s; color: %(text)s; selection-background-color: %(soft)s; selection-color: %(text)s; }\n"
        "\n"
        "QListWidget { background: %(base)s; color: %(text)s; border: 1px solid %(border)s; border-radius: 8px; padding: 4px; }\n"
        "QListWidget::item { border-radius: 6px; padding: 6px 8px; margin: 1px 2px; }\n"
        "QListWidget::item:hover { background: %(hover_bg)s; }\n"
        "QListWidget::item:selected { background: %(soft)s; color: %(text)s; border-left: 3px solid %(accent)s; }\n"
        "\n"
        "QTableWidget { background: %(base)s; color: %(text)s; alternate-background-color: %(alt)s; gridline-color: %(border)s; border: 1px solid %(border)s; border-radius: 6px; }\n"
        "QHeaderView::section { background: %(header)s; color: %(text)s; border: none; border-bottom: 1px solid %(border)s; padding: 4px 6px; }\n"
        "\n"
        "QScrollBar:vertical { background: transparent; width: 10px; margin: 2px; }\n"
        "QScrollBar::handle:vertical { background: %(border)s; border-radius: 4px; min-height: 30px; }\n"
        "QScrollBar::handle:vertical:hover { background: %(mid)s; }\n"
        "QScrollBar:horizontal { background: transparent; height: 10px; margin: 2px; }\n"
        "QScrollBar::handle:horizontal { background: %(border)s; border-radius: 4px; min-width: 30px; }\n"
        "QScrollBar::handle:horizontal:hover { background: %(mid)s; }\n"
        "QScrollBar::add-line, QScrollBar::sub-line { width: 0; height: 0; }\n"
        "QScrollBar::add-page, QScrollBar::sub-page { background: transparent; }\n"
        "\n"
        "QSplitter::handle { background: transparent; }\n"
        "QSplitter::handle:horizontal { width: 5px; }\n"
        "QSplitter::handle:hover { background: %(soft)s; }\n"
        "\n"
        "QDockWidget::title { background: %(header)s; padding: 6px 8px; border-bottom: 1px solid %(border)s; }\n"
        "QStatusBar { background: %(header)s; color: %(mid)s; }\n"
        "\n"
        "QFrame#card { background: %(card)s; border: 1px solid %(card_border)s; border-radius: 10px; }\n"
        "QPushButton#fileRemoveBtn { background: #c75050; color: white; border: none; border-radius: 4px; font-size: 11pt; font-weight: 700; padding: 0px; }\n"
        "QPushButton#fileRemoveBtn:hover { background: #a53d3d; }\n"
        "QPushButton#fileRemoveBtn:disabled { background: %(disabled)s; }\n"
        "QPushButton#fileBrowseBtn { background: %(card)s; color: %(accent)s; border: 1px solid %(accent)s; border-radius: 4px; font-size: 10.5pt; padding: 0px 6px; }\n"
        "QPushButton#fileBrowseBtn:hover { background: %(accent)s; color: %(on_accent)s; }\n"
        "QPushButton#fileRemoveBtn:disabled, QPushButton#fileBrowseBtn:disabled { color: %(disabled)s; border-color: %(border)s; }\n"
        "QLabel#cardTitle { font-weight: 600; color: %(text)s; background: transparent; }\n"
        "QFrame#previewStrip { background: %(card)s; border: 1px solid %(card_border)s; border-radius: 8px; }\n"
        "QFrame#formPage { background: transparent; }\n"
    ) % t
    return qss


def make_card(title):
    """Grouped-card container: QFrame#card with a bold card title."""
    from PySide6.QtWidgets import QFrame, QLabel, QVBoxLayout
    card = QFrame()
    card.setObjectName("card")
    v = QVBoxLayout(card)
    v.setContentsMargins(10, 8, 10, 10)
    v.setSpacing(4)
    t = QLabel(title)
    t.setObjectName("cardTitle")
    v.addWidget(t)
    return card, v


def _disabled_updates(p, text, window, button):
    p.setColor(QPalette.Disabled, QPalette.WindowText, QColor(text))
    p.setColor(QPalette.Disabled, QPalette.Text, QColor(text))
    p.setColor(QPalette.Disabled, QPalette.ButtonText, QColor(button))
    p.setColor(QPalette.Disabled, QPalette.Window, QColor(window))


def dark_palette():
    p = QPalette()
    p.setColor(QPalette.Window, QColor(53, 53, 53))
    p.setColor(QPalette.WindowText, QColor(208, 208, 208))
    p.setColor(QPalette.Base, QColor(37, 37, 37))
    p.setColor(QPalette.AlternateBase, QColor(53, 53, 53))
    p.setColor(QPalette.ToolTipBase, QColor(53, 53, 53))
    p.setColor(QPalette.ToolTipText, QColor(208, 208, 208))
    p.setColor(QPalette.Text, QColor(208, 208, 208))
    p.setColor(QPalette.Button, QColor(53, 53, 53))
    p.setColor(QPalette.ButtonText, QColor(208, 208, 208))
    p.setColor(QPalette.BrightText, QColor(255, 70, 70))
    p.setColor(QPalette.Link, QColor(42, 130, 218))
    p.setColor(QPalette.Highlight, QColor(42, 130, 218))
    p.setColor(QPalette.HighlightedText, QColor(Qt.black))
    p.setColor(QPalette.Mid, QColor(150, 150, 150))
    p.setColor(QPalette.PlaceholderText, QColor(154, 154, 154))
    p.setColor(QPalette.Disabled, QPalette.WindowText, QColor(158, 158, 158))
    p.setColor(QPalette.Disabled, QPalette.Text, QColor(158, 158, 158))
    p.setColor(QPalette.Disabled, QPalette.ButtonText, QColor(158, 158, 158))
    p.setColor(QPalette.Disabled, QPalette.Window, QColor(45, 45, 45))
    return p


def light_palette():
    p = QPalette()
    p.setColor(QPalette.Window, QColor(240, 240, 240))
    p.setColor(QPalette.WindowText, QColor(Qt.black))
    p.setColor(QPalette.Base, QColor(Qt.white))
    p.setColor(QPalette.AlternateBase, QColor(247, 247, 247))
    p.setColor(QPalette.ToolTipBase, QColor(Qt.white))
    p.setColor(QPalette.ToolTipText, QColor(Qt.black))
    p.setColor(QPalette.Text, QColor(Qt.black))
    p.setColor(QPalette.Button, QColor(240, 240, 240))
    p.setColor(QPalette.ButtonText, QColor(Qt.black))
    p.setColor(QPalette.BrightText, QColor(Qt.red))
    p.setColor(QPalette.Link, QColor(42, 130, 218))
    p.setColor(QPalette.Highlight, QColor(48, 140, 198))
    p.setColor(QPalette.HighlightedText, QColor(Qt.white))
    p.setColor(QPalette.Mid, QColor(138, 138, 138))
    p.setColor(QPalette.PlaceholderText, QColor(138, 138, 138))
    p.setColor(QPalette.Disabled, QPalette.WindowText, QColor(116, 116, 116))
    p.setColor(QPalette.Disabled, QPalette.Text, QColor(116, 116, 116))
    p.setColor(QPalette.Disabled, QPalette.ButtonText, QColor(180, 180, 180))
    return p


def _scheme_is_dark():
    try:
        return QGuiApplication.styleHints().colorScheme() == Qt.ColorScheme.Dark
    except Exception:                     # Qt < 6.5 / offscreen quirks
        return False


def apply_system_theme(app):
    """Fusion style + palette + QSS that follow the OS light/dark scheme."""
    app.setStyle("Fusion")

    def _apply(*_a):
        dark = _scheme_is_dark()
        app.setPalette(dark_palette() if dark else light_palette())
        app.setStyleSheet(stylesheet(dark))

    _apply()
    try:
        QGuiApplication.styleHints().colorSchemeChanged.connect(_apply)
    except Exception:
        pass                              # older Qt: stays on the initial scheme
    return _apply
