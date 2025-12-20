# Contributing to Localizer App

Thank you for your interest in contributing to Localizer App! This document provides guidelines and instructions for contributing.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0+)
- Dart SDK (included with Flutter)
- Git
- Windows, macOS, or Linux

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/LocalizerAppMain.git
   cd LocalizerAppMain
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run -d windows  # or macos/linux
   ```

## 📁 Project Structure

```
lib/
├── business_logic/     # BLoC state management
│   └── blocs/         # All BLoC implementations
├── core/              # Core utilities and constants
│   ├── constants/     # App colors, spacing, etc.
│   ├── di/            # Dependency injection (get_it)
│   └── services/      # Business services
├── data/              # Data layer
│   ├── models/        # Data models
│   ├── parsers/       # File format parsers
│   └── repositories/  # Data repositories
└── presentation/      # UI layer
    ├── themes/        # App themes
    ├── views/         # Screen widgets
    └── widgets/       # Reusable components
```

## 🔧 Development Guidelines

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and small

### BLoC Pattern

- Events should be simple and descriptive
- States should be immutable
- Avoid BLoC-to-BLoC direct dependencies
- Pass dependencies via events or use service locator

### Commits

- Use clear, descriptive commit messages
- Reference issue numbers when applicable
- Keep commits focused on single changes

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📝 Pull Request Process

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests and ensure they pass
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## 📄 License

By contributing, you agree that your contributions will be licensed under the project's license.
