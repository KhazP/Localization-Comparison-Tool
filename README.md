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
- **Multi-Format Support**: JSON, XML, XLIFF, TMX, CSV, YAML, Properties, RESX, TXT, DOCX, and more
- **Intelligent Diff Detection**: Automatically identifies added, removed, and modified strings
- **Similarity Analysis**: Advanced algorithms detect how much modified strings have changed
- **Batch Processing**: Compare entire directories with matching file pairs
- **AI-Powered Translations**: Generate suggestions and translations using Gemini AI
- **Super Drag & Drop**: Advanced file interactions with visual feedback


<img src="https://github.com/user-attachments/assets/15a392c6-2c9f-4bd9-9ec7-019d9d63fef9" width="800">

### 🎨 **Modern Interface**
- **Material Design 3**: Beautiful, intuitive interface that follows platform conventions
- **Advanced Theming**: Light, Dark, and Amoled modes with customizable accent colors
- **Drag & Drop**: Simply drag files from your desktop for instant comparison
- **Responsive Design**: Optimized for different screen sizes and resolutions

<img src="https://github.com/user-attachments/assets/c7cab91c-47a1-4300-b354-dd8a6abfd680" width="800">

### 🚀 **Performance & Usability**
- **Real-Time File Watching**: Automatically recompares files when they change on disk
- **Large Dataset Support**: Handle files with thousands of entries using smart pagination
- **Export Capabilities**: Export comparison results to CSV for documentation
- **Comparison History**: Keep track of past comparisons with full session history

### ⚙️ **Professional Features**
- **Advanced Filtering**: Filter results by change type, similarity levels, and custom patterns
- **Custom Settings**: Configure ignore patterns, case sensitivity, and default file formats
- **Progress Tracking**: Real-time progress indicators for large file operations
- **Cross-Platform**: Native desktop performance on Windows, macOS, and Linux
- **Glassmorphism Toasts**: Beautiful, non-intrusive notification system


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

### Windows
- **OS**: Windows 10 version 1903 (build 18362) or later
- **Architecture**: x64, ARM64
- **Memory**: 4GB RAM minimum, 8GB recommended
- **Storage**: ~10MB available space

## 🎯 Quick Start Guide

1. **Launch the Application**
   - Use `run_localizer_app.bat` (Windows) or run `flutter run` from the terminal

2. **Select Files to Compare**
   - **Drag & Drop**: Drag your source and target files directly onto the selection areas
   - **Browse**: Click the "Browse" buttons to select files using the file picker

3. **Start Comparison**
   - Click "Compare Files" to analyze the differences
   - View results instantly in the main comparison view

4. **Explore Results**
   - **Basic View**: See an overview with filters for Added, Removed, and Modified entries
   - **Advanced View**: Detailed analysis with pagination for large datasets
   - **Export**: Save results as CSV for documentation or further analysis

5. **Configure Settings** (Optional)
   - **Auto-Reload**: Enable automatic recomparison when files change
   - **Themes**: Choose Light, Dark, or Amoled mode
   - **File Formats**: Set default formats and encoding preferences
   - **Ignore Patterns**: Configure regex patterns to ignore specific keys

## 🎨 Interface Overview

### Main Views
- **Basic Comparison**: Quick overview with filtering and analytics
- **Advanced Diff**: Detailed table view with pagination and export options
- **History**: Browse and reload previous comparison sessions
- **Files**: Directory-based comparison for batch operations
- **Settings**: Comprehensive customization options

### Key Controls
- **Filter Buttons**: Quickly filter by Added, Removed, Modified, or All changes
- **Analytics Bar**: Real-time statistics showing total keys and change counts
- **Auto-Reload Indicator**: Shows when file watching is active
- **Theme Toggle**: Quick access to light/dark theme switching

## 🔄 Advanced Features

### Auto-Reload File Watching
Enable in Settings to automatically detect and recompare files when they change on disk. Perfect for active development workflows where you're editing localization files and want immediate feedback.

### Smart Filtering
- **Change Type**: Filter by Added, Removed, or Modified entries
- **Similarity Levels**: For modified strings, filter by how much they've changed
- **Custom Patterns**: Use regex patterns to ignore specific keys during comparison
- **Search**: Find specific keys or values within comparison results

### Performance Optimization
- **Pagination**: Large files (1000+ keys) are automatically paginated for smooth navigation
- **Background Processing**: File parsing happens in the background without blocking the UI
- **Memory Efficient**: Optimized data structures handle large datasets efficiently
- **Progress Indicators**: Clear feedback during processing operations

## 🛠️ Development

### Prerequisites
- Flutter 3.19+ installed and configured
- Dart SDK 3.0+
- Platform-specific development tools (Visual Studio on Windows, Xcode on macOS, etc.)

### Development Setup
```bash
# Clone the repository
git clone https://github.com/KhazP/LocalizerAppMain.git
cd LocalizerAppMain

# Install dependencies
flutter pub get

# Generate code for data models
flutter packages pub run build_runner build

# Run in development mode
flutter run -d windows  # or macos, linux

# Run tests
flutter test
```

### Project Structure
```
lib/
├── business_logic/blocs/    # State management (BLoC pattern)
├── core/services/           # Core business services
├── data/                    # Data models and repositories
├── presentation/            # UI components and screens
└── main.dart               # Application entry point
```

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

**Made with ❤️ and Flutter**

*Streamline your localization workflow today!*

</div>
