import 'package:recase/recase.dart';

/// Utility class for transforming localization key formats.
///
/// Provides conversions between common naming conventions used in
/// localization files: camelCase, snake_case, PascalCase, Title Case, etc.
class KeyUtils {
  KeyUtils._();

  /// Converts a key to camelCase.
  /// Example: "hello_world" -> "helloWorld"
  static String toCamelCase(String key) => ReCase(key).camelCase;

  /// Converts a key to snake_case.
  /// Example: "helloWorld" -> "hello_world"
  static String toSnakeCase(String key) => ReCase(key).snakeCase;

  /// Converts a key to PascalCase.
  /// Example: "hello_world" -> "HelloWorld"
  static String toPascalCase(String key) => ReCase(key).pascalCase;

  /// Converts a key to Title Case.
  /// Example: "hello_world" -> "Hello World"
  static String toTitleCase(String key) => ReCase(key).titleCase;

  /// Converts a key to CONSTANT_CASE (screaming snake case).
  /// Example: "helloWorld" -> "HELLO_WORLD"
  static String toConstantCase(String key) => ReCase(key).constantCase;

  /// Converts a key to dot.case.
  /// Example: "helloWorld" -> "hello.world"
  static String toDotCase(String key) => ReCase(key).dotCase;

  /// Converts a key to param-case (kebab-case).
  /// Example: "helloWorld" -> "hello-world"
  static String toParamCase(String key) => ReCase(key).paramCase;

  /// Converts a key to path/case.
  /// Example: "helloWorld" -> "hello/world"
  static String toPathCase(String key) => ReCase(key).pathCase;

  /// Converts a key to Sentence case.
  /// Example: "helloWorld" -> "Hello world"
  static String toSentenceCase(String key) => ReCase(key).sentenceCase;

  /// Converts a key to Header-Case.
  /// Example: "helloWorld" -> "Hello-World"
  static String toHeaderCase(String key) => ReCase(key).headerCase;

  /// Batch converts a list of keys to a specified case.
  static List<String> batchConvert(
    List<String> keys,
    KeyCaseFormat format,
  ) {
    return keys.map((key) => convertToFormat(key, format)).toList();
  }

  /// Converts a key to the specified format.
  static String convertToFormat(String key, KeyCaseFormat format) {
    switch (format) {
      case KeyCaseFormat.camelCase:
        return toCamelCase(key);
      case KeyCaseFormat.snakeCase:
        return toSnakeCase(key);
      case KeyCaseFormat.pascalCase:
        return toPascalCase(key);
      case KeyCaseFormat.titleCase:
        return toTitleCase(key);
      case KeyCaseFormat.constantCase:
        return toConstantCase(key);
      case KeyCaseFormat.dotCase:
        return toDotCase(key);
      case KeyCaseFormat.paramCase:
        return toParamCase(key);
      case KeyCaseFormat.pathCase:
        return toPathCase(key);
      case KeyCaseFormat.sentenceCase:
        return toSentenceCase(key);
      case KeyCaseFormat.headerCase:
        return toHeaderCase(key);
    }
  }

  /// Detects the most likely case format of a key.
  static KeyCaseFormat? detectFormat(String key) {
    if (key.contains('_') && key == key.toUpperCase()) {
      return KeyCaseFormat.constantCase;
    }
    if (key.contains('_')) {
      return KeyCaseFormat.snakeCase;
    }
    if (key.contains('-')) {
      return KeyCaseFormat.paramCase;
    }
    if (key.contains('.')) {
      return KeyCaseFormat.dotCase;
    }
    if (key.contains('/')) {
      return KeyCaseFormat.pathCase;
    }
    if (key.contains(' ')) {
      if (key[0] == key[0].toUpperCase()) {
        return KeyCaseFormat.titleCase;
      }
      return KeyCaseFormat.sentenceCase;
    }
    if (key.isNotEmpty && key[0] == key[0].toUpperCase()) {
      return KeyCaseFormat.pascalCase;
    }
    if (key.isNotEmpty && key[0] == key[0].toLowerCase()) {
      return KeyCaseFormat.camelCase;
    }
    return null;
  }
}

/// Enumeration of supported key case formats.
enum KeyCaseFormat {
  camelCase,
  snakeCase,
  pascalCase,
  titleCase,
  constantCase,
  dotCase,
  paramCase,
  pathCase,
  sentenceCase,
  headerCase,
}

/// Extension to provide display names for KeyCaseFormat.
extension KeyCaseFormatExtension on KeyCaseFormat {
  String get displayName {
    switch (this) {
      case KeyCaseFormat.camelCase:
        return 'camelCase';
      case KeyCaseFormat.snakeCase:
        return 'snake_case';
      case KeyCaseFormat.pascalCase:
        return 'PascalCase';
      case KeyCaseFormat.titleCase:
        return 'Title Case';
      case KeyCaseFormat.constantCase:
        return 'CONSTANT_CASE';
      case KeyCaseFormat.dotCase:
        return 'dot.case';
      case KeyCaseFormat.paramCase:
        return 'param-case';
      case KeyCaseFormat.pathCase:
        return 'path/case';
      case KeyCaseFormat.sentenceCase:
        return 'Sentence case';
      case KeyCaseFormat.headerCase:
        return 'Header-Case';
    }
  }

  String get example {
    switch (this) {
      case KeyCaseFormat.camelCase:
        return 'helloWorld';
      case KeyCaseFormat.snakeCase:
        return 'hello_world';
      case KeyCaseFormat.pascalCase:
        return 'HelloWorld';
      case KeyCaseFormat.titleCase:
        return 'Hello World';
      case KeyCaseFormat.constantCase:
        return 'HELLO_WORLD';
      case KeyCaseFormat.dotCase:
        return 'hello.world';
      case KeyCaseFormat.paramCase:
        return 'hello-world';
      case KeyCaseFormat.pathCase:
        return 'hello/world';
      case KeyCaseFormat.sentenceCase:
        return 'Hello world';
      case KeyCaseFormat.headerCase:
        return 'Hello-World';
    }
  }
}
