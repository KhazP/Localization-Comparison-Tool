# 🛠️ Localization Comparison Tool 🛠️

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/KhazP/LocalizerAppMain?style=for-the-badge&label=version)](https://github.com/KhazP/LocalizerAppMain/releases)
[![GitHub stars](https://img.shields.io/github/stars/KhazP/LocalizerAppMain?style=for-the-badge)](https://github.com/KhazP/LocalizerAppMain/stargazers)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-orange.svg?style=for-the-badge)](#-contributing)

![image](https://github.com/user-attachments/assets/2a19bfb0-9ecf-40b4-9286-02ac368618b9)

> **Effortlessly compare and analyze your localization files with this modern, open-source tool!**
> Built with Flet, this tool helps streamline the localization process by making it easy to identify changes between different versions of your language files.

---

## 📖 Table of Contents

* [Overview](#overview)
* [🔍 Features](#-features)
* [⚙️ How It Works Briefly](#️-how-it-works-briefly)
* [💻 Tech Stack Highlights](#-tech-stack-highlights)
* [📋 Prerequisites](#-prerequisites)
* [🚀 Installation](#-installation)
* [🛠️ Usage](#️-usage)
* [📚 Documentation](#-documentation)
* [📁 Key Files Overview](#-key-files-overview)
* [⚠️ Known Issues & Limitations](#️-known-issues--limitations)
* [🔮 Future Enhancements](#-future-enhancements)
* [🤝 Contributing](#-contributing)
* [📜 Disclaimer](#-disclaimer)
* [📄 License](#-license)
* [📞 Contact](#-contact)

---

## Overview

The **Localization Comparison Tool** is a desktop application designed for developers, translators, and localization managers. It provides a clear and efficient way to compare different versions of localization files, highlighting added, removed, or modified strings. By supporting various common file formats and offering a user-friendly interface, it aims to reduce the time and effort spent on managing and verifying translations.

This tool tackles the complexity of tracking changes in localization files, especially in projects with frequent updates or multiple languages, ensuring consistency and accuracy across all localized content.

---

## 🔍 Features

* **Comprehensive Comparison**: Identify added, removed, and (optionally) modified strings between localization files.
* **Multi-Format Support**:
    * **GUI Validated Formats**: Actively validates `.csv`, `.lang`, `.txt`, `.json`, `.yaml`, `.yml` through the file picker.
    * **Extended Parsing Capability**: Parses a wider range of formats including Android XML (`.xml`), Angular i18n JSON (`.json`), Java Properties (`.properties`), .NET Resources (`.resx`), XLIFF (`.xliff`), and generic XML/JSON/YAML/CSV/LANG files.
* **Visual Difference Highlighting**: Easily spot changes within the application's UI.
* **User-Friendly Interface**: Modern and intuitive GUI built with Flet.
* **Directory Comparison**: Compare all matching files within specified source and target directories.
* **File Previews**: Option to preview the content of selected source and target files.
* **Comparison Statistics**: Detailed statistics panel showing total, missing, and obsolete keys.
* **Machine Translation Integration**: Translate missing keys using Google Cloud Translate (requires API key).
* **Comparison History**: View and revisit past comparison reports.
* **Customizable Themes**: Choose between Light, Dark, Amoled, or sync with System theme.
* **Advanced Comparison Options**:
    * Ignore specific key patterns using regular expressions.
    * Optionally ignore whitespace or case differences.
* **Export/Copy Results**: Copy comparison results for documentation or further analysis.
* **Onboarding Tutorial**: Built-in tutorial to guide new users.
* **Developer-Ready**: Open-source with a clear structure for easy customization and extension.

---

## ⚙️ How It Works Briefly

1.  **File/Directory Selection**: User selects source and target localization files or directories through the Flet-based GUI.
2.  **Asynchronous Parsing & Comparison**: The tool asynchronously parses the selected files based on their format. It then performs a key-by-key comparison.
3.  **Difference Calculation**: Identifies added, removed, or (optionally) modified strings, taking into account user-defined ignore patterns and options (e.g., ignore case/whitespace).
4.  **Results Display**: Differences are presented clearly in the UI, often with visual cues and detailed statistics. Directory comparisons may show results in tabs per file pair.
5.  **History & Output**: Comparison summaries can be saved to history. Results can be copied to the clipboard. Missing strings can optionally be sent to Google Cloud Translate.

---

## 💻 Tech Stack Highlights

* **Core Framework**: [Flet](https://flet.dev/) (Python GUI framework).
* **Language**: Python 3.8+.
* **Key Runtime Dependencies**:
    * PyYAML (for `.yaml`/`.yml` parsing).
    * xmltodict (for XML parsing, likely used by some XML-based parsers).
    * Colorama (for colored terminal output, possibly for CLI or logging).
* **Notable Optional/Dev Dependencies**:
    * darkdetect (for system theme detection).
    * google-cloud-translate (for machine translation feature).
    * `requests`, `lxml`, testing libraries (`pytest`, `pylint`, `flake8`, `isort`).

---

## 📋 Prerequisites

### For End-Users (Using Executable):
* No specific prerequisites other than a compatible OS for the provided executable.

### For Running from Source / Developers:
* **Git**: Download and install the latest version of [Git](https://git-scm.com/downloads).
* **Python 3.8+**: Ensure Python is installed and added to your PATH.

---

## 🚀 Installation

<details>
<summary>Click to expand installation instructions</summary>

### For End-Users (Translators, QA):
1.  **Download**: Get the latest release from the [Releases page](https://github.com/KhazP/LocalizerAppMain/releases).
2.  **Run**: Execute the downloaded application file (`.exe` for Windows, etc.).
3.  No further installation steps are typically required.

### For Developers:
1.  **Clone the Repository**:
    ```bash
    git clone [https://github.com/KhazP/LocalizerAppMain.git](https://github.com/KhazP/LocalizerAppMain.git)
    ```
2.  **Navigate to Project Directory**:
    ```bash
    cd LocalizerAppMain
    ```
3.  **Set up Virtual Environment & Install Dependencies**:
    It's highly recommended to use a virtual environment.
    ```bash
    # Create a virtual environment
    python -m venv venv

    # Activate it
    # Windows:
    .\venv\Scripts\activate
    # macOS/Linux:
    # source venv/bin/activate

    # Install required packages
    pip install -r requirements.txt #

    # Optional: For development (tests, linting)
    # pip install -r requirements-dev.txt # (If requirements-dev.txt exists)

    # Optional: Install the package in editable mode to use the `localizer` command
    pip install -e .
    ```
</details>

---

## 🛠️ Usage

After installation or setup:

### 1. Using the Executable (for End-Users):
* Simply run the downloaded executable file from the [Releases page](https://github.com/KhazP/LocalizerAppMain/releases).

### 2. Using the `localizer` Command (if installed via pip):
* If you installed the package (e.g., with `pip install .` or `pip install -e .`), you can start the GUI by typing:
    ```bash
    localizer
    ```
    *(This is defined in `setup.py`'s entry_points)*

### 3. Running from Source (for Developers):
* Ensure you are in the project's root directory (`LocalizerAppMain`) and your virtual environment is activated.
* Run the GUI application using:
    ```bash
    python GUI/flet_gui.py
    ```
    *(This is the main GUI script)*

### 4. Using the `.bat` file (Windows, if running from source):
* The `start_localizer.bat` file (if present in the root of the repository) can be used to launch the application on Windows.
    1.  Double-click on `start_localizer.bat`.

### In-App Usage:
1.  Launch the application using one of the methods above.
2.  If it's your first time, an onboarding tutorial may appear.
3.  Use the interface to select your base and target localization files or directories.
4.  Configure comparison options in Settings if needed (e.g., ignore patterns, theme).
5.  Click "Compare Files" or "Compare Directories".
6.  Review the displayed differences, statistics, and previews.
7.  Use "Copy Results" or the Machine Translation features as needed.

---

## 📚 Documentation

Comprehensive documentation, including detailed usage instructions, information on supported file formats, advanced comparison options, and troubleshooting, is available in the [`docs/`](./docs/) folder. The `docs/README.md` (Source 9) also serves as the main description for the PyPI package.

Key topics covered in the `docs/` folder often include:
* Detailed usage instructions
* Supported file formats and their specifics
* Advanced comparison options
* Troubleshooting common issues

---

## 📁 Key Files Overview

Based on the project structure outlined in `docs/CONTRIBUTING.md`:

<details>
<summary>Click to expand key files & directories list</summary>

* `LICENSE`: License information.
* `requirements.txt`: List of project dependencies.
* `setup.py`: Installation and packaging script.
* `start_localizer.bat`: Batch file to launch the application on Windows.
* `GUI/flet_gui.py`: Main entry point for the Flet-based GUI application.
* `GUI/logic.py`: Shared GUI logic functions.
* `cli/compare_files.py`: Script for comparing localization files via the Command Line Interface.
* `components/`: Reusable Flet UI components (e.g., file input, results view, settings dialog).
* `core/`: Core application logic, constants, configuration management, and themes.
* `parsers/`: Individual file format parsers (e.g., for JSON, XML, CSV, YAML, LANG, RESX, XLIFF, Properties, Android XML, Angular JSON).
* `utils/`: Utility services like logging, history management, file caching, and processing.
* `assets/`: Static assets like images and icons.
* `docs/`: Documentation files, including `CONTRIBUTING.md` and `README.md`.
* `tests/`: Automated test suite.
</details>

---

## ⚠️ Known Issues & Limitations

* **Performance**: Very large localization files (e.g., tens of thousands of strings or multi-megabyte files) might take some time to process, though efforts are made for asynchronous operations.
* **Complex Structures**: Highly complex or unusually structured data within supported file formats might have parsing limitations for some specific edge cases.
* **File Encodings**: The tool primarily attempts UTF-8 and may fall back to latin-1. For best results, ensure files use common encodings.
    *(Please refer to project issues on GitHub for an up-to-date list.)*

---

## 🔮 Future Enhancements

* Support for additional localization file formats (e.g., `.po`).
* Direct integration with version control systems (e.g., Git) to compare file versions across branches or commits.
* Advanced Batch Comparison (e.g., providing a list of specific source-target file pairs to process).
* More sophisticated filtering and sorting options for comparison results.
* A plugin system to allow users to easily add custom file parsers or comparison logic.

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**! Please see `docs/CONTRIBUTING.md` for detailed guidelines.

1.  **Fork** the Project (`https://github.com/KhazP/LocalizerAppMain/fork`).
2.  Create your **Feature Branch** (`git checkout -b feature/AmazingFeature`).
3.  **Develop** and **test** your changes. (Run tests using `python -m pytest tests/`).
4.  Consider installing development dependencies if a `requirements-dev.txt` is available (`pip install -r requirements-dev.txt`).
5.  **Commit** your Changes (`git commit -m 'feat: Add some AmazingFeature'`).
6.  **Push** to the Branch (`git push origin feature/AmazingFeature`).
7.  Open a **Pull Request**.

For major changes, please open an issue first to discuss what you would like to change. Please make sure to update tests as appropriate.

---

## 📜 Disclaimer

> This tool is provided "as-is" without any warranty, express or implied. The developers assume no liability for any damages or data loss caused by its use. Always back up your files before using any new software to modify or analyze them. Use responsibly.

---

## 📄 License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.

---

## 📞 Contact

* **Maintainer:** Alp Yalay
* **GitHub:** [@KhazP](https://github.com/KhazP)
* **Project Link:** [https://github.com/KhazP/LocalizerAppMain](https://github.com/KhazP/LocalizerAppMain)

---

*Happy localizing!*
