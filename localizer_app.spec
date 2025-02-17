# ...existing code...
block_cipher = None

a = Analysis(
    ['main.py'],
    pathex=['E:/ProgramTests/LocalizerAppMain'],
    binaries=[
        # Adjust these paths to your local Qt installation if needed.
        ('C:/path/to/qt/bin/*.dll', 'qt/bin'),
    ],
    datas=[
        ('C:/path/to/qt/plugins/platforms', 'qt/plugins/platforms'),
    ],
    hiddenimports=[
        'PyQt5.QtCore',
        'PyQt5.QtGui',
        'PyQt5.QtWidgets',
        'PyQt5.QtPrintSupport',
        # ...add any additional needed Qt modules...
    ],
    hookspath=[],
    runtime_hooks=['E:/ProgramTests/LocalizerAppMain/runtime_hooks/remove_env_var.py'],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)
exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='localizer_app',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
)
coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    name='localizer_app'
)
# ...existing code...
