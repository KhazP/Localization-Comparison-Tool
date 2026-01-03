# AI rules for Flutter

You are an expert in Flutter and Dart development. Your goal is to build
beautiful, performant, and maintainable applications following modern best
practices. You have expert experience with application writing, testing, and
running Flutter applications for various platforms, including desktop, web, and
mobile platforms.

## Project Communication Overrides (Read First)
* **User Profile:** The project owner is non-technical in coding, but knows
  basic web terms. Use plain language and avoid jargon or code references in
  user-facing messages.
* **Questions:** Never ask technical questions. Make technical decisions
  independently. Ask only about user-facing tradeoffs.
* **Updates:** Keep updates short: what was built, what it does, and how to
  test it. The user typically runs the app on Windows to test.
* **Reference Docs:** Follow `CLAUDE.md` and `GEMINI.md` for user-facing rules
  and `TECHNICAL.md` for technical decisions.

## Interaction Guidelines
* **User Persona:** Assume the user prefers plain language and does not read or
  write code.
* **Explanations:** Explain technical ideas only when needed, in plain language
  without jargon. If a technical term is unavoidable, translate it immediately.
* **Clarification:** If a request is ambiguous, ask only about user-facing
  behavior, visuals, or workflow. Do not ask technical questions.
* **No placeholders:** Do not leave stubbed or placeholder implementations
  (e.g., TODOs, empty functions, mock returns, placeholder UI text). Implement
  real behavior; if blocked, explain what is missing in plain language and
  propose a user-facing alternative.
* **Dependencies:** When suggesting new dependencies from `pub.dev`, explain
  their benefits.
* **Formatting:** Use the `dart_format` tool to ensure consistent code
  formatting.
* **Fixes:** Use the `dart_fix` tool to automatically fix many common errors,
  and to help code conform to configured analysis options.
* **Linting:** Use the Dart linter with a recommended set of rules to catch
  common issues. Use the `analyze_files` tool to run the linter.

## Project Structure
* **Standard Structure:** Assumes a standard Flutter project structure with
  `lib/main.dart` as the primary application entry point.
* **Clean Architecture:** The project generally follows a clean architecture pattern:
    * `lib/presentation`: Widgets, views, themes, and bloc/cubit implementations.
    * `lib/business_logic`: Blocs often reside here or in presentation depending on scope.
    * `lib/domain`: Business logic entities and repository interfaces (if strictly separated).
    * `lib/data`: Models, repository implementations, data sources, and services.
    * `lib/core`: Shared utilities, dependency injection, and constants.

## Flutter style guide
* **SOLID Principles:** Apply SOLID principles throughout the codebase.
* **Concise and Declarative:** Write concise, modern, technical Dart code.
  Prefer functional and declarative patterns.
* **Composition over Inheritance:** Favor composition for building complex
  widgets and logic.
* **Immutability:** Prefer immutable data structures. Widgets (especially
  `StatelessWidget`) should be immutable.
* **State Management:** Separate ephemeral state and app state. Use a state
  management solution for app state to handle the separation of concerns.
* **Widgets are for UI:** Everything in Flutter's UI is a widget. Compose
  complex UIs from smaller, reusable widgets.

## Package Management
* **Pub Tool:** To manage packages, use the `pub` tool, if available.
* **External Packages:** If a new feature requires an external package, use the
  `pub_dev_search` tool, if it is available. Otherwise, identify the most
  suitable and stable package from pub.dev.

## Code Quality
* **Code structure:** Adhere to maintainable code structure and separation of
  concerns (e.g., UI logic separate from business logic).
* **Naming conventions:** Avoid abbreviations and use meaningful, consistent,
  descriptive names for variables, functions, and classes.
* **Conciseness:** Write code that is as short as it can be while remaining
  clear.
* **Simplicity:** Write straightforward code. Code that is clever or
  obscure is difficult to maintain.
* **Error Handling:** Anticipate and handle potential errors. Don't let your
  code fail silently. Use `Talker` for logging exceptions.
* **Styling:**
    * Line length: Lines should be 80 characters or fewer.
    * Use `PascalCase` for classes, `camelCase` for
      members/variables/functions/enums, and `snake_case` for files.
* **Functions:**
    * Functions short and with a single purpose (strive for less than 20 lines).
* **Testing:** Write code with testing in mind.
* **Logging:** Use the `talker_flutter` package for comprehensive logging and debugging.

## Dart Best Practices
* **Effective Dart:** Follow the official Effective Dart guidelines.
* **Class Organization:** Define related classes within the same library file.
  For large libraries, export smaller, private libraries from a single top-level
  library.
* **Library Organization:** Group related libraries in the same folder.
* **API Documentation:** Add documentation comments to all public APIs,
  including classes, constructors, methods, and top-level functions.
* **Comments:** Write clear comments for complex or non-obvious code. Avoid
  over-commenting.
* **Trailing Comments:** Don't add trailing comments.
* **Async/Await:** Ensure proper use of `async`/`await` for asynchronous
  operations with robust error handling.
    * Use `Future`s, `async`, and `await` for asynchronous operations.
    * Use `Stream`s for sequences of asynchronous events.
* **Null Safety:** Write code that is soundly null-safe. Leverage Dart's null
  safety features. Avoid `!` unless the value is guaranteed to be non-null.
* **Pattern Matching:** Use pattern matching features where they simplify the
  code.
* **Records:** Use records to return multiple types in situations where defining
  an entire class is cumbersome.
* **Switch Statements:** Prefer using exhaustive `switch` statements or
  expressions, which don't require `break` statements.

## Flutter Best Practices
* **Immutability:** Widgets (especially `StatelessWidget`) are immutable; when
  the UI needs to change, Flutter rebuilds the widget tree.
* **Composition:** Prefer composing smaller widgets over extending existing
  ones. Use this to avoid deep widget nesting.
* **Private Widgets:** Use small, private `Widget` classes instead of private
  helper methods that return a `Widget`.
* **Build Methods:** Break down large `build()` methods into smaller, reusable
  private Widget classes.
* **List Performance:** Use `ListView.builder` or `SliverList` for long lists to
  create lazy-loaded lists for performance.
* **Isolates:** Use `compute()` or `Isolate.spawn` to run expensive calculations in a separate
  isolate to avoid blocking the UI thread, such as massive file parsing.
* **Const Constructors:** Use `const` constructors for widgets and in `build()`
  methods whenever possible to reduce rebuilds.

## Current Tech Stack & Patterns

### State Management
* **Flutter Bloc:** The project uses `flutter_bloc` as the primary state management solution.
* **Equatable:** Use `equatable` for Bloc Events and States to ensure efficient comparisons.
* **Service Locator:** Use `get_it` for dependency injection (accessed via `sl<Type>()`).
* **RepositoryProvider:** Use `MultiRepositoryProvider` in `app.dart` to provide repositories to the widget tree.

### Networking
* **Dio:** Use `dio` for all HTTP requests. Do typically interacts via a `DioClient` wrapper or injected instance.
* **Logging:** `talker_dio_logger` is used to log network traffic.

### Persistence
* **Hive:** Used for local storage (user preferences, session history, warning suppressions).
* **Secure Storage:** `flutter_secure_storage` is used for sensitive data like API keys.

### UI & UX
* **Icons:** Use `lucide_icons` as the standard icon set.
* **Window Management:**
    * `bitsdojo_window` is used for custom title bars on desktop.
    * `window_manager` is used for window positioning and resizing.
* **Drag and Drop:** Use `super_drag_and_drop` for advanced file dragging capabilities.
* **Toast Notifications:** Use `toastification` with glassmorphism style for user feedback.
* **Data Grids:** Use `pluto_grid` for complex tables (like the advanced diff view).
* **Syntax Highlighting:** Use `code_text_field` and `highlight` for code views.
* **Fonts:** `google_fonts` (Inter, Roboto, etc.) are used.

### Testing
* **Mocktail:** Use `mocktail` for mocking in unit tests.
* **Bloc Test:** Use `bloc_test` for testing Blocs.

### Code Generation
* **Build Runner:** Run `dart run build_runner build --delete-conflicting-outputs` after changing files with code generation.
* **JSON Serialization:** Use `json_serializable` for models.
* **Hive Generator:** Used for Hive TypeAdapters.

## Application Architecture
* **Main Entry Point:** `lib/main.dart` initializes Hive, Service Locator, Window Manager, and runs the app.
* **App Widget:** `lib/presentation/app.dart` sets up providers (Blocs, Repositories) and method channels.
* **Home View:** `lib/presentation/views/home_view.dart` provides the main navigation shell (Navigation Rail + IndexedStack).

## Visual Design & Theming
* **Theme System:** `AppThemeV2` handles theme generation.
* **Modes:** Supports Light, Dark, AMOLED, and System modes. Use `ThemeBloc` to switch.
* **Windows Visuals:** Supports Mica effect and Acrylic transparency where available.

### Contrast Ratios
* **WCAG Guidelines:** Aim to meet the Web Content Accessibility Guidelines
  (WCAG) 2.1 standards.
* **Minimum Contrast:**
    * **Normal Text:** A contrast ratio of at least **4.5:1**.
    * **Large Text:** (18pt or 14pt bold) A contrast ratio of at least **3:1**.

## Documentation
* **`dartdoc`:** Write `dartdoc`-style comments for all public APIs.
* **Comment wisely:** Use comments to explain why the code is written a certain
  way, not what the code does. The code itself should be self-explanatory.

## Accessibility (A11Y)
Implement accessibility features to empower all users, assuming a wide variety
of users with different physical abilities, mental abilities, age groups,
education levels, and learning styles.
