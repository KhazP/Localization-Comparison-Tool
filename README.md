## Localization Comparison Tool
![Screenshot 2025-02-15 163044](https://github.com/user-attachments/assets/b5ac42fb-eb45-46e5-9cf4-d4976bc9e816)

A GUI application, built with [Flet](https://flet.dev/) (which uses Flutter), for comparing localization files and identifying differences in translations.  This tool is designed to help streamline the localization process by making it easy to see what's changed between two versions of a translation file.

## Features

- 🐞 Modern, responsive UI with dark/light theme support
- 🐞 Automatic file format detection (XML/CSV)
- 🐞 Advanced comparison options:
  - Ignore case sensitivity
  - Ignore whitespace
  - Show only missing keys
- 🐞 Detailed comparison results with syntax highlighting
- 🐞 One-click results copying

## Supported File Formats

- XML (`.lang`, `.xml`)
- CSV files
- Text files (`.txt`)

## Usage

1. Run the application via CMD or download from Releases:
   ```bash
   python GUI/flet_gui.py
   ```
2. Select source and target files using either:
   - Browse buttons
3. Configure comparison options:
   - Ignore Case: Ignore letter casing differences
   - Ignore Whitespace: Ignore spacing differences
   - Only Missing Keys: Show only keys missing from target
4. Click "Compare Files" to see the results

## Sample Files

The repository includes sample files in the `Sample Translation` folder to help you get started:

- `sourcetranslation.csv`: Example source file
- `targettranslation.csv`: Example target file with differences

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

Copyright (c) 2025 Alp Yalay
