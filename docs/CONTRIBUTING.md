# Contributing to Localization Comparison Tool

Thank you for considering contributing to the Localization Comparison Tool! This document provides guidelines and instructions to help you get started as a developer.

## Development Environment Setup

### Prerequisites
- Python 3.7+
- pip (Python package installer)
- Git

### Setting Up Your Development Environment

1. **Clone the repository**
   ```bash
   git clone https://github.com/KhazP/Localization-Comparison-Tool.git
   cd Localization-Comparison-Tool
   ```

2. **Create a virtual environment**
   ```bash
   python -m venv venv
   ```

3. **Activate the virtual environment**
   - On Windows:
     ```bash
     venv\Scripts\activate.bat
     ```
   - On macOS/Linux:
     ```bash
     source venv/bin/activate
     ```

4. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

5. **Install development dependencies** (if applicable)
   ```bash
   pip install -r requirements-dev.txt
   ```

## Project Structure

```
Directory structure:
└── khazp-localizerappmain/
    ├── LICENSE                  # License information
    ├── requirements.txt         # List of project dependencies
    ├── setup.py                 # Installation and packaging script
    ├── start_localizer.bat      # Batch file to launch the application on Windows
    ├── GUI/                     # Graphical User Interface components
    │   ├── flet_gui.py          # Main entry point for the GUI application
    │   ├── logic.py             # Shared GUI logic functions
    │   └── syntax_highlighter.py# Support for syntax highlighting in the UI
    ├── MixedParser/             # Package for mixed file format parsing
    │   ├── __init__.py          # Package initializer
    │   └── mixed_parser.py      # Implementation of mixed file parsing logic
    ├── assets/                  # Static assets (images, icons)
    │   └── logo/                # Logos and other image assets
    ├── cli/                     # Command Line Interface tools
    │   ├── __init__.py          # CLI package initializer
    │   └── compare_files.py     # Script to compare localization files via CLI
    ├── components/              # Reusable UI components
    │   ├── __init__.py          # Package initializer for components
    │   ├── file_input.py        # Component for file input handling
    │   ├── history_dialog.py    # Component for displaying comparison history
    │   ├── onboarding.py        # Component for onboarding/tutorial features
    │   ├── results_view.py      # Component for showing comparison results
    │   ├── settings_dialog.py   # Component for managing application settings
    │   └── stats_panel.py       # Component for displaying statistics
    ├── config/                  # Configuration files and logs
    │   ├── config.json          # Main configuration file
    │   └── history.json         # File storing comparison history
    ├── core/                    # Core application logic and constants
    │   ├── config.py            # Logic for configuration management
    │   ├── constants.py         # Definition of constant values
    │   ├── errors.py            # Custom error definitions used across the project
    │   └── themes.py            # Definitions of UI themes
    ├── docs/                    # Documentation files
    │   ├── README.md            # Project overview and instructions
    │   ├── CODE_OF_CONDUCT.md   # Contributor code of conduct
    │   ├── CONTRIBUTING.md      # Guidelines on how to contribute
    │   ├── FUNDING.yml          # Funding information and sponsorship setup
    │   ├── SECURITY.md          # Security policy and reporting guidelines
    │   └── code_documentation_style_guide.md   # Guidelines for code documentation standards
    ├── models/                  # Data models representing business objects
    │   └── comparison_result.py # Data model for comparison results
    ├── parsers/                 # Individual file format parsers
    │   ├── __init__.py          # Package initializer for parsers
    │   ├── android_xml_parser.py# Parser for Android XML files
    │   ├── angular_json_parser.py# Parser for Angular JSON files
    │   ├── base_parser.py       # Base class for file parsers
    │   ├── csv_parser.py        # Parser for CSV files
    │   ├── json_parser.py       # Parser for JSON files
    │   ├── lang_parser.py       # Parser for .lang files
    │   ├── properties_parser.py # Parser for .properties files
    │   ├── resx_parser.py       # Parser for RESX files
    │   ├── xliff_parser.py      # Parser for XLIFF files
    │   ├── xml_parser.py        # Parser for XML files
    │   └── yaml_parser.py       # Parser for YAML files
    ├── runtime_hooks/           # Scripts that run at runtime
    │   └── remove_env_var.py    # Script to remove sensitive environment variables
    ├── tests/                   # Automated test suite
    │   ├── __init__.py          # Test package initializer
    │   ├── conftest.py          # Pytest fixtures and configuration
    │   ├── mock_services.py     # Mocks for testing external services
    │   ├── snapshot_helpers.py  # Helpers for snapshot testing of UI components
    │   ├── test_hello_world.py  # Sample test for basic functionality
    │   ├── test_integration.py  # Integration tests for end-to-end scenarios
    │   ├── test_parsers.py      # Tests for file parser functionality
    │   ├── test_snapshots.py    # Snapshot tests to validate UI output
    │   ├── test_ui.py           # Tests for UI component behavior
    │   └── snapshots/           # Directory for stored snapshot files
    │       ├── file_input_component.json   # Snapshot for file input component
    │       ├── results_view_empty.json       # Snapshot for empty results view
    │       ├── results_view_error.json       # Snapshot for error state in results view
    │       └── stats_panel_component.json    # Snapshot for stats panel component
    ├── utils/                   # Utility services and helper modules
    │   ├── __init__.py          # Package initializer for utils
    │   ├── file_cache_service.py# Service for caching file contents
    │   ├── file_processing_service.py# Service to process and compare files
    │   ├── history_manager.py   # Handles history management for comparisons
    │   └── logger_service.py    # Provides a configured logger for the application
    └── .github/                 # GitHub-specific configuration files
        ├── ISSUE_TEMPLATE/      # Templates for reporting bugs or requesting features
        │   ├── bug_report.md    # Template for bug reports
        │   └── feature_request.md# Template for feature requests
        └── workflows/           # Continuous Integration/Deployment workflow definitions
            ├── pylint.yml       # Pylint configuration for code analysis
            ├── python-app.yml   # GitHub Actions workflow for Python applications
            └── tests.yml        # GitHub Actions workflow for running tests
```

## Coding Standards

### Python Style Guide

- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) style guidelines
- Use meaningful variable and function names
- Include type hints for function parameters and return values
- Add docstrings to all functions, classes, and modules (see our [Code Documentation Style Guide](docs/code_documentation_style_guide.md))

### Git Workflow

1. Create a new branch for your feature or bugfix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit them with descriptive messages:
   ```bash
   git commit -m "Add feature: description of the feature"
   ```

3. Push your branch and create a pull request:
   ```bash
   git push origin feature/your-feature-name
   ```

## Testing

Run tests to ensure your changes don't break existing functionality:

```bash
python -m pytest tests/
```

For more detailed test output:

```bash
python -m pytest tests/ -v
```

## Submitting Changes

1. Push your branch to GitHub
2. Create a Pull Request from your branch
3. Describe what your changes do and why they should be included
4. Reference any related issues

## Questions?

If you have any questions or need help, please open an issue on the GitHub repository.