# Localization Comparison Tool

**An Open-Source Localization File Comparison Tool**

![image](https://github.com/user-attachments/assets/2a19bfb0-9ecf-40b4-9286-02ac368618b9)

A modern, open-source localization tool built with [Flet](https://flet.dev/) for comparing and analyzing localization files. This tool helps streamline the localization process by making it easy to identify differences between translation files.

[![GitHub stars](https://img.shields.io/github/stars/KhazP/LocalizerAppMain)](https://github.com/KhazP/LocalizerAppMain/stargazers)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Table of Contents

- [Features](#-features)
- [Prerequisites](#prerequisites)
- [Installation](#️-installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## 🔍 Features

- **Streamline Comparisons**: Identify added/removed strings in seconds
- **Multi-Format Support**: Works with CSV, XML, LANG, JSON, and more
- **Visual Difference Highlighting**: Easily spot changes between files
- **Export Results**: Copy comparison results for further analysis
- **Developer-Ready**: Built with Python and Flet for easy customization

## Prerequisites

### Required:
- **Git**: Download and install the latest version of [Git](https://git-scm.com/downloads/win)
  - Use default settings for each option

### Optional:
- **Python 3.8+**: Only needed if building from source

## 🛠️ Installation

### For Translators:
1. Download the latest [release](https://github.com/KhazP/LocalizerAppMain/releases)
2. Run the executable file
3. No additional setup required

### For Developers:
```bash
# Clone the repository
git clone https://github.com/KhazP/LocalizerAppMain.git

# Navigate to project directory
cd LocalizerAppMain

# Install dependencies
pip install -r requirements.txt
```

## Usage

Run the application using the following command:

```bash
python main.py
```

The tool will open with an intuitive interface:
1. Load your source and target localization files
2. Select comparison options
3. View the differences highlighted in the comparison view
4. Copy results if needed

## Documentation

Comprehensive documentation is available in the [`docs/`](./docs/) folder. Here you will find guides on:
- Detailed usage instructions
- Supported file formats
- Advanced comparison options
- Troubleshooting common issues

## Contributing

I welcome contributions! To contribute:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Contact

- **Maintainer:** Alp Yalay
- **GitHub:** [@KhazP](https://github.com/KhazP)

---

*Happy localizing!*
