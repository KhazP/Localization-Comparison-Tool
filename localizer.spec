# python: localizer.spec
# -*- mode: python ; coding: utf-8 -*-

import sys
from pathlib import Path
from PyInstaller.utils.hooks import Tree

block_cipher = None
PROJECT_ROOT = Path().absolute()

# Locate the Python DLL from your conda env
python_dll = sys.executable.replace("python.exe", "python312.dll")
binaries = [(python_dll, ".")]

# Include the entire project directory except the Sample Translation folder and some unnecessary folders
datas = Tree(
    str(PROJECT_ROOT),
    excludes=["Sample Translation", "__pycache__", ".pytest_cache", "localizer.egg-info"],
)

# Define any hidden imports needed by your project
hiddenimports = [
    "flet_core",
    "gitpython",
    "yaml",       # For PyYAML
    "colorama",
    "darkdetect",
    "PIL",        # Pillow
    "pydantic",
]

a = Analysis(
    ['GUI/flet_gui.py'],
    pathex=[str(PROJECT_ROOT)],
    binaries=binaries,
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    cipher=block_cipher,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name="LocalizerApp",
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    console=False,  # Set to True if you need a console window
    disable_windowed_traceback=False,
)

coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    name="LocalizerApp",
)