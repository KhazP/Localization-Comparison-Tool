# 🌍 Localization Comparison Tool

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20macOS%20%7C%20Linux-blue?style=for-the-badge)](https://flutter.dev/desktop)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Version](https://img.shields.io/badge/Version-1.0.0-orange?style=for-the-badge)](https://github.com/KhazP/LocalizerAppMain/releases)

A powerful, modern desktop application for comparing and analyzing localization files. Built with Flutter for native performance across Windows, macOS, and Linux.

## 🎯 What It Does

The Localization Comparison Tool helps developers, translators, and localization teams efficiently compare different versions of language files. Whether you're tracking changes between releases, validating translations, or managing multilingual projects, this tool provides a clear, visual way to identify what's been added, removed, or modified.

## ✨ Key Features

### 📊 **Smart File Comparison**
- **Multi-Format Support**: JSON, XML, XLIFF, TMX, CSV, YAML, Properties, RESX, TXT, DOCX, and more
- **Intelligent Diff Detection**: Automatically identifies added, removed, and modified strings
- **Similarity Analysis**: Advanced algorithms detect how much modified strings have changed
- **Batch Processing**: Compare entire directories with matching file pairs

### 🎨 **Modern Interface**
- **Material Design 3**: Beautiful, intuitive interface that follows platform conventions
- **Advanced Theming**: Light, Dark, and Amoled modes with customizable accent colors
- **Drag & Drop**: Simply drag files from your desktop for instant comparison
- **Responsive Design**: Optimized for different screen sizes and resolutions

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

## 🚀 Installation & Setup

### Option 1: Quick Start (Windows)
1. Download or clone this repository
2. Double-click `run_localizer_app.bat` in the project directory
3. The app will launch automatically

### Option 2: Manual Launch
```bash
# Navigate to the project directory
cd LocalizerAppMain

# Install dependencies
flutter pub get

# Generate required code
flutter packages pub run build_runner build

# Launch the application
flutter run
```

### Option 3: Build Release Version
```bash
# Build for your platform
flutter build windows  # or macos, linux

# Find the executable in build/windows/runner/Release/
```

## 💻 System Requirements

### Windows
- **OS**: Windows 10 version 1903 (build 18362) or later
- **Architecture**: x64, ARM64
- **Memory**: 4GB RAM minimum, 8GB recommended
- **Storage**: 200MB available space

### macOS
- **OS**: macOS 10.14 (Mojave) or later
- **Architecture**: Intel x64, Apple Silicon (M1/M2)
- **Memory**: 4GB RAM minimum, 8GB recommended
- **Storage**: 200MB available space

### Linux
- **Distribution**: Ubuntu 18.04 LTS or equivalent
- **Desktop**: GNOME, KDE, or other GTK-compatible environment
- **Dependencies**: GTK 3.0+, required system libraries
- **Memory**: 4GB RAM minimum, 8GB recommended
- **Storage**: 200MB available space

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
- **Flutter/Dart** for cross-platform desktop development
- **BLoC pattern** for state management
- **Hive** for local data persistence
- **Material Design 3** for UI components

### Areas for Contribution
- Additional file format parsers
- Enhanced export options (PDF, Excel)
- Git integration for version comparison
- Translation memory features
- Performance optimizations

Please see the issues page for current development priorities.

## 📚 Tips & Best Practices

### For Best Performance
- Use auto-reload sparingly with very large files
- Consider using directory comparison for batch operations
- Export large comparison results to CSV for analysis in external tools

### Workflow Recommendations
- Enable auto-reload during active development
- Use custom ignore patterns for generated or timestamp-based keys
- Save frequently used comparison settings as defaults
- Export results before making major changes to source files

## ⚠️ Known Limitations

- **Very Large Files**: Files with 50,000+ keys may require patience during initial parsing
- **Complex XML**: Highly nested XML structures might need preprocessing
- **Memory Usage**: Large comparison sessions consume RAM proportional to file size
- **File Encoding**: Works best with UTF-8 encoded files

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support & Contact

- **Issues**: [GitHub Issues](https://github.com/KhazP/LocalizerAppMain/issues)
- **Discussions**: [GitHub Discussions](https://github.com/KhazP/LocalizerAppMain/discussions)
- **Maintainer**: Alp Yalay (@KhazP)

---

<div align="center">

**Made with ❤️ and Flutter**

*Streamline your localization workflow today!*

</div>