# 🌍 Localization Comparison Tool

[![Flutter](https://img.shields.io/badge/Flutter-3.19%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Windows-blue?style=for-the-badge)](https://flutter.dev/desktop)
[![License](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/KhazP/LocalizerAppMain?style=for-the-badge)](https://github.com/KhazP/LocalizerAppMain/stargazers)

**A powerful, modern desktop application for comparing, analyzing, and managing localization files. Built with Flutter for native performance.**

<div align="center">
  <img src="docs/images/comparisonpage.png" alt="Localization Comparison Tool Main View" width="100%">
</div>

---

## 🎯 What It Does

The **Localization Comparison Tool** helps developers, translators, and localization teams efficiently manage their translation workflows. Beyond just comparing files, it offers a complete suite of tools for validating translations, tracking changes, and ensuring quality across your entire project.

## ✨ Key Features

### 📊 **Intelligent Comparison & Analysis**
Stop squinting at JSON files. Our advanced diff engine automatically highlights added, removed, and modified keys.
- **Visual Diff**: Clear color-coded indicators for all changes.
- **Deep Dive**: Switch to the **Advanced Diff** view for a granular, row-by-row analysis of changes.
- **Similarity Detection**: Smart algorithms detect how much a modified string has changed.

<div align="center">
  <img src="docs/images/advanceddiff.png" alt="Advanced Diff View" width="100%">
</div>

### 📁 **Batch Processing & Directories**
Need to compare entire languages? Drag and drop folders to compare multiple files at once.
- **Directory Comparison**: Compare matching files across two different directories.
- **Smart Matching**: Automatically pairs files based on structure and naming.

<div align="center">
  <img src="docs/images/directorycomparisonindirectorypage.png" alt="Directory Comparison" width="100%">
</div>

### 📈 **Quality Dashboard**
Keep your localization health in check with the integrated Quality Dashboard.
- **Analytics**: See translation progress, missing keys, and potential issues at a glance.
- **Visual Reports**: Charts and graphs to visualize your project's localization status.

<div align="center">
  <img src="docs/images/dashboard.png" alt="Quality Dashboard" width="100%">
</div>

### 🕒 **History & Session Management**
Never lose track of a comparison. The History allows you to revisit past sessions instantly.
- **Session Tracking**: Every comparison is saved automatically.
- **Quick Restore**: One-click to reload previous file pairs and settings.

<div align="center">
  <img src="docs/images/history.png" alt="History View" width="100%">
</div>

### ⚙️ **Comprehensive Settings**
Tailor the tool to your workflow.
- **AI Integration**: Configure API keys for AI-powered translation suggestions (Gemini, etc.).
- **Theming**: Choose between Light, Dark, and AMOLED modes with custom accent colors.
- **Ignored Patterns**: Set up regex rules to ignore specific keys (like metadata or IDs).

<div align="center">
  <img src="docs/images/settings.png" alt="Settings View" width="100%">
</div>

---

## 🔧 Supported File Formats

The tool supports a wide range of industry-standard formats:

| Format | Extensions | Description |
|--------|------------|-------------|
| **JSON** | `.json`, `.arb` | Standard JSON and Flutter ARB files |
| **XML** | `.xml` | Android strings.xml and generic XML |
| **XLIFF** | `.xliff`, `.xlf` | Translation industry standard |
| **TMX** | `.tmx` | Translation Memory eXchange |
| **CSV** | `.csv` | Comma-separated values |
| **YAML** | `.yaml`, `.yml` | YAML configuration/locale files |
| **Properties** | `.properties` | Java/Kotlin properties |
| **RESX** | `.resx` | .NET resource files |

---

## 🚀 Installation & Setup

### Option 1: Quick Start (Windows)
1. Download the latest release from the [Releases Page](https://github.com/KhazP/LocalizerAppMain/releases).
2. Unzip and run the executable.

### Option 2: Build from Source
**Prerequisites:**
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.19+)
- Windows 10/11

```bash
# 1. Clone the repository
git clone https://github.com/KhazP/LocalizerAppMain.git
cd LocalizerAppMain

# 2. Install dependencies
flutter pub get

# 3. Generate data models
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run -d windows
```

---

## 🤝 Contributing

Contributions are welcome! This project uses:
- **Flutter** & **Dart**
- **BLoC** pattern for state management
- **Hive** for local persistence
- **Material Design 3**

Please read our [Contributing Guide](CONTRIBUTING.md) before getting started.

---

## 📜 License

This project is licensed under the **Mozilla Public License 2.0**. See the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with ❤️ and Flutter**

*Streamline your localization workflow today!*

</div>
