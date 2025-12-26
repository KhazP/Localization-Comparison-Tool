# 🌍 Localization Comparison Tool

[![Flutter](https://img.shields.io/badge/Flutter-3.19%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Windows-blue?style=for-the-badge)](https://flutter.dev/desktop)
[![License](https://img.shields.io/badge/License-GPLv3-red?style=for-the-badge)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/KhazP/Localization-Comparison-Tool?style=for-the-badge)](https://github.com/KhazP/Localization-Comparison-Tool/stargazers)

**A powerful, modern desktop application for comparing and analyzing localization files. Built with Flutter for native performance.**

---

## 🎯 What It Does

The **Localization Comparison Tool** helps developers, translators, and localization teams efficiently compare different versions of language files. Whether you're tracking changes between releases, validating translations, or managing multilingual projects, this tool provides a clear, visual way to identify what's been added, removed, or modified.

## ✨ Key Features

### 📊 **Smart File Comparison**
- **Multi-Format Support**: JSON, XML, XLIFF, TMX, CSV, YAML, Properties, RESX, TXT, DOCX, and more.
- **Intelligent Diff Detection**: Automatically identifies added, removed, and modified strings.
- **Similarity Analysis**: Advanced algorithms detect how much modified strings have changed.
- **Batch Processing**: Compare entire directories with matching file pairs.

### 🎨 **Modern Interface**
- **Material Design 3**: Beautiful, intuitive interface that follows platform conventions.
- **Advanced Theming**: Light, Dark, and Amoled modes with customizable accent colors.
- **Drag & Drop**: Simply drag files from your desktop for instant comparison.

### 🚀 **Performance & Usability**
- **Real-Time File Watching**: Automatically recompares files when they change on disk.
- **Large Dataset Support**: Handle files with thousands of entries using smart pagination.
- **Export Capabilities**: Export comparison results to CSV for documentation.

---

## 🔧 Supported File Formats

| Format | Extensions | Description |
|--------|------------|-------------|
| **JSON** | `.json` | Standard JSON localization files |
| **XML** | `.xml` | Android strings.xml and generic XML files |
| **XLIFF** | `.xliff`, `.xlf` | Translation industry standard format |
| **TMX** | `.tmx` | Translation Memory eXchange format |
| **CSV** | `.csv` | Comma-separated values |
| **YAML** | `.yaml`, `.yml` | YAML configuration files |
| **Properties** | `.properties` | Java properties files |
| **RESX** | `.resx` | .NET resource files |
| **Text** | `.txt` | Plain text files (line-by-line processing) |
| **Word** | `.docx` | Microsoft Word documents |
| **Language** | `.lang` | Android language files |

---

## 🚀 Installation & Setup

### Option 1: Quick Start (Windows)
1. Download the latest release from the [Releases Page](https://github.com/KhazP/Localization-Comparison-Tool/releases).
2. Unzip and run the executable.

### Option 2: Build from Source
**Prerequisites:**
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.19+)
- Windows 10/11 (for Windows build)

```bash
# 1. Clone the repository
git clone https://github.com/KhazP/Localization-Comparison-Tool.git
cd Localization-Comparison-Tool

# 2. Install dependencies
flutter pub get

# 3. Generate data models (Hive/JSON)
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run -d windows
```

---

## 💻 System Requirements

- **OS**: Windows 10 version 1903 (build 18362) or later.
- **Architecture**: x64, ARM64.
- **Memory**: 4GB RAM minimum.
- **Storage**: 200MB available space.

---

## 🤝 Contributing

Contributions are welcome! This project uses:
- **Flutter** & **Dart**
- **BLoC** pattern for state management
- **Hive** for local persistence
- **Material Design 3**

Please read our [Contributing Guide](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) before getting started.

---

## 🔒 Security

For security concerns, please refer to our [Security Policy](SECURITY.md).

---

## 📜 License

This project is licensed under the **GNU General Public License v3.0**. See the [LICENSE](LICENSE) file for details.

---

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/KhazP/Localization-Comparison-Tool/issues)
- **Maintainer**: Alp Yalay ([@KhazP](https://github.com/KhazP))

---

<div align="center">
  <strong>Made with ❤️ and Flutter</strong>
</div>