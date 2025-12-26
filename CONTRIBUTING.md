# Contributing to Localization Comparison Tool

Thank you for your interest in contributing! We welcome contributions from the community to help make this tool better for everyone.

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: Version 3.19 or higher ([Install Guide](https://docs.flutter.dev/get-started/install))
- **Dart SDK**: Included with Flutter
- **Git**: Version control system

### Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/Localization-Comparison-Tool.git
   cd Localization-Comparison-Tool
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Code**
   This project uses code generation (Hive, JSON Serialization).
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**
   ```bash
   flutter run -d windows
   ```

---

## 📁 Project Structure

```text
lib/
├── business_logic/     # State management (BLoC pattern)
│   ├── blocs/         # All BLoC implementations
│   └── events/        # BLoC events and states
├── core/              # Core utilities, constants, and DI
│   ├── constants/     # App colors, themes, strings
│   ├── services/      # Business logic services (Diffing, Parsing)
│   └── di/            # Dependency Injection (GetIt)
├── data/              # Data layer
│   ├── models/        # Data models (Hive, JSON)
│   └── parsers/       # File parsing logic
└── presentation/      # UI layer
    ├── themes/        # App themes and styles
    └── views/         # Application screens/pages
```

---

## 🔧 Development Guidelines

### Code Style
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines.
- Use **PascalCase** for classes, **camelCase** for variables/functions.
- Run the linter before committing: `flutter analyze`.

### State Management (BLoC)
- **Events**: Should be simple, descriptive, and separate files/classes where appropriate.
- **States**: Should be immutable.
- **Logic**: Keep business logic in BLoCs or Services, not in the UI widgets.

### Commits
- Use descriptive commit messages (e.g., `feat: Add XLIFF parsing support` or `fix: Resolve layout issue on high DPI`).
- Keep commits focused on a single logical change.

---

## 📝 Pull Request Process

1. **Create a Branch**: `git checkout -b feature/amazing-feature`
2. **Implement Changes**: Write clean, tested code.
3. **Verify**:
    - Run `flutter test`.
    - Run `flutter analyze` to check for lint errors.
    - Format code with `dart format .`.
4. **Push**: `git push origin feature/amazing-feature`
5. **Open PR**: Create a Pull Request against the `main` branch.
    - Fill out the PR template.
    - Attach screenshots for UI changes.

---

## 🧪 Testing

Run standard tests:
```bash
flutter test
```

---

## 📄 License & Conduct

- By contributing, you agree that your contributions will be licensed under the **GPLv3 License**.
- Please respect our [Code of Conduct](CODE_OF_CONDUCT.md).
