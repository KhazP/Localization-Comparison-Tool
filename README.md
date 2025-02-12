# Localization Comparison Tool

![Screenshot of Application](screenshot.png) <!-- Add actual screenshot later -->

A GUI application for comparing localization files (CSV, LANG, XML) across different versions or branches, with Git integration and smart CSV handling.

## Features

- **File Comparison**:
  - Detect added, removed, and modified translation keys
  - Support for CSV, LANG (plain & XML), and TXT files
  - Ignore case/whitespace options
  - Multiple comparison modes

- **Git Integration**:
  - Compare files from specific commits/branches
  - Support for working tree changes
  - Repository browser

- **Smart CSV Handling**:
  - Automatic delimiter detection
  - Custom column mapping
  - Header row detection
  - Real-time preview

- **User Interface**:
  - Tabbed interface for different settings
  - Modern theme support
  - Drag-and-drop file loading
  - Progress indicators
  - Exportable results

- **Advanced Features**:
  - Translation memory suggestions
  - Machine translation integration
  - Dark/Light theme toggle
  - Session history

Development
Technologies Used
Python 3.8
Tkinter (GUI)
GitPython (Git integration)
colorama (CLI colors)
csv/xml modules (file parsing)

- **Contributing**
  -Fork the repository

  -Create a feature branch (git checkout -b feature/your-feature)

  -Commit changes (git commit -m 'Add some feature')

  -Push to branch (git push origin feature/your-feature)

  -Open a Pull Request

**Please follow these guidelines:**

- Report bugs using GitHub Issues

- Suggest features via Discussions

- Follow PEP8 coding standards

- Include tests for new features

**License**
MIT License

Copyright (c) 2023 Alp Yalay

Permission is hereby granted...
