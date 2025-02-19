# -*- mode: python ; coding: utf-8 -*-


a = Analysis(
    ['GUI\\flet_gui.py'],
    pathex=[],
    binaries=[],
    datas=[('GUI', 'GUI'), ('MixedParser', 'MixedParser'), ('runtime_hooks', 'runtimehooks'), ('models', 'models'), ('components', 'components'), ('compare_files.py', '.'), ('config.json', '.'), ('config.py', '.'), ('constants.py', '.'), ('themes.py', '.')],
    hiddenimports=['darkdetect', 'git'],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='Localization Comparison Tool',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
