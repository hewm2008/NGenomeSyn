# -*- mode: python ; coding: utf-8 -*-
# PyInstaller spec for NGenomeSyn GUI (Windows/Linux, onedir).
# Build:  pyinstaller gui/tools/NGenomeSynGUI.spec --distpath dist
# The resulting layout is assembled further by gui/tools/build_windows.py
import sys
from pathlib import Path

ROOT = Path(SPECPATH).resolve().parent.parent      # repo root (spec lives in gui/tools)

datas = [(str(ROOT / "gui" / "resources" / "params_schema.json"), "gui/resources")]
if sys.platform == "darwin":
    datas += [(str(ROOT / "bin"), "bin")]
    datas += [(str(p), ".") for p in ROOT.glob("NGenomeSyn_manual_*.pdf")]
    datas += [(str(p), "gui/doc") for p in (ROOT / "gui/doc").glob("NGenomeSyn_GUI_manual_*.*")]

a = Analysis(
    [str(ROOT / "gui" / "main.py")],
    pathex=[str(ROOT)],
    binaries=[],
    datas=datas,
    hiddenimports=[],
    hookspath=[],
    runtime_hooks=[],
    excludes=["tkinter", "matplotlib", "numpy.tests"],
    noarchive=False,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name="NGenomeSynGUI",
    debug=False,
    strip=False,
    upx=False,
    console=False,          # windowed app
    icon=None,
)
coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=False,
    name="NGenomeSynGUI",
)

if sys.platform == "darwin":
    import runpy
    version = runpy.run_path(str(ROOT / "gui" / "__init__.py"))["GUI_VERSION"].lstrip("v")
    app = BUNDLE(
        coll,
        name="NGenomeSyn.app",
        icon=str(ROOT / "gui" / "resources" / "NGenomeSyn.icns"),
        bundle_identifier="org.hewm2008.NGenomeSyn",
        info_plist={
            "CFBundleName": "NGenomeSyn",
            "CFBundleDisplayName": "NGenomeSyn",
            "CFBundleShortVersionString": version,
            "CFBundleVersion": version,
            "NSHighResolutionCapable": True,
        },
    )
