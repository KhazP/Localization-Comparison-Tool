# Contributing to Localization Comparison Tool

Thanks for helping improve this project.

This guide covers how to set up locally, how to submit changes, and what quality bar is expected before a pull request is opened.

## Prerequisites

- Flutter SDK 3.19+
- Dart SDK (bundled with Flutter)
- Git

## Local Setup

```bash
git clone https://github.com/YOUR_USERNAME/Localization-Comparison-Tool.git
cd Localization-Comparison-Tool
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d windows
```

## Branch and Commit Workflow

1. Create a feature branch from main.
2. Keep commits focused and descriptive.
3. Prefer small pull requests that are easier to review.

Recommended commit style:

- feat: add csv export option
- fix: prevent crash on missing key
- docs: update setup instructions

## Code Quality Expectations

Before opening a pull request, run:

```bash
dart format .
flutter analyze
flutter test
```

If your change affects generated code, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Pull Request Checklist

- Explain what changed and why.
- Link related issues.
- Add screenshots for UI changes.
- Confirm tests and analysis pass locally.
- Update documentation when behavior changes.

## Testing Guidance

- Add or update tests for every user-facing behavior change.
- Prefer deterministic tests (avoid timing assumptions).
- Keep business logic in testable layers.

## Security

Do not disclose security issues publicly.

Report vulnerabilities via [.github/SECURITY.md](.github/SECURITY.md).

## Code of Conduct

All participation is covered by [.github/CODE_OF_CONDUCT.md](.github/CODE_OF_CONDUCT.md).

## License

By contributing, you agree your contribution is licensed under the same license as this repository: Mozilla Public License 2.0.
