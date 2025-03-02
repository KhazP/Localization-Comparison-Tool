## Introduction

First off, thank you for considering contributing to the Localization Comparison Tool! It's people like you that make this tool a great resource for the localization community.

Following these guidelines helps to communicate that you respect the time of the developers managing and developing this open source project. In return, they should reciprocate that respect in addressing your issue, assessing changes, and helping you finalize your pull requests.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [alpyalay@gmail.com](mailto:alpyalay@gmail.com).

## What can I contribute?

### Code Contributions

We welcome code contributions that improve the tool's functionality, fix bugs, or enhance the user experience.

#### Setting up your development environment

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/Localization-Comparison-Tool.git`
3. Create a virtual environment: `python -m venv venv`
4. Activate the environment:
   - Windows: `venv\Scripts\activate`
   - macOS/Linux: `source venv/bin/activate`
5. Install dependencies: `pip install -r requirements.txt`

#### Making changes

1. Create a new branch: `git checkout -b feature/your-feature-name`
2. Make your changes
3. Run tests: `pytest`
4. Format your code: `black . && isort .`
5. Commit your changes with a descriptive message
6. Push to your fork: `git push origin feature/your-feature-name`
7. Create a Pull Request

#### Pull Request Guidelines

- Follow the code style (Black, isort, flake8)
- Include tests for new functionality
- Update documentation for any changed functionality
- Keep PRs focused on a single change
- Link to relevant issues

### Documentation Contributions

Documentation is crucial for our users. Here's how to contribute:

1. Navigate to the docs directory
2. Edit or add markdown files
3. For significant changes, please open an issue first to discuss
4. Follow the same PR process as code contributions

#### Style Guide for Documentation

- Use clear, concise language
- Include screenshots for UI features
- Provide code examples where applicable
- Follow the structure of existing documentation

### Bug Reports and Feature Requests

- Use the GitHub issue tracker
- For bugs, include:
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Screenshots if applicable
  - Environment details (OS, Python version, etc.)
- For feature requests, explain the use case and benefits

## Security Issues

If you discover a security vulnerability, please do NOT open an issue. Instead, email [alpyalay@gmail.com](mailto:alpyalay@gmail.com) with details about the vulnerability.

## Development Workflow

### Branch Naming Convention

- `feature/` - For new features
- `bugfix/` - For bug fixes
- docs - For documentation changes
- `refactor/` - For code refactoring

### Commit Message Format

Follow the conventional commits specification:
- `feat:` - A new feature
- `fix:` - A bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code changes that neither fix bugs nor add features
- `test:` - Adding or updating tests
- `chore:` - Changes to the build process or auxiliary tools

## Code Review Process

The maintainers review Pull Requests on a regular basis. After feedback has been given, we expect responses within two weeks. After two weeks, we may close the pull request if it isn't showing any activity.

## Getting Help

Don't hesitate to open an issue or reach out to the maintainers if you have any questions about contributing.

Thanks again for your interest in improving the Localization Comparison Tool!