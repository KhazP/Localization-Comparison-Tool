import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/core/utils/key_utils.dart';

void main() {
  group('KeyUtils', () {
    group('toCamelCase', () {
      test('converts snake_case to camelCase', () {
        expect(KeyUtils.toCamelCase('hello_world'), 'helloWorld');
      });

      test('converts PascalCase to camelCase', () {
        expect(KeyUtils.toCamelCase('HelloWorld'), 'helloWorld');
      });

      test('converts Title Case to camelCase', () {
        expect(KeyUtils.toCamelCase('Hello World'), 'helloWorld');
      });
    });

    group('toSnakeCase', () {
      test('converts camelCase to snake_case', () {
        expect(KeyUtils.toSnakeCase('helloWorld'), 'hello_world');
      });

      test('converts PascalCase to snake_case', () {
        expect(KeyUtils.toSnakeCase('HelloWorld'), 'hello_world');
      });

      test('converts Title Case to snake_case', () {
        expect(KeyUtils.toSnakeCase('Hello World'), 'hello_world');
      });
    });

    group('toPascalCase', () {
      test('converts snake_case to PascalCase', () {
        expect(KeyUtils.toPascalCase('hello_world'), 'HelloWorld');
      });

      test('converts camelCase to PascalCase', () {
        expect(KeyUtils.toPascalCase('helloWorld'), 'HelloWorld');
      });
    });

    group('toTitleCase', () {
      test('converts snake_case to Title Case', () {
        expect(KeyUtils.toTitleCase('hello_world'), 'Hello World');
      });

      test('converts camelCase to Title Case', () {
        expect(KeyUtils.toTitleCase('helloWorld'), 'Hello World');
      });
    });

    group('toConstantCase', () {
      test('converts camelCase to CONSTANT_CASE', () {
        expect(KeyUtils.toConstantCase('helloWorld'), 'HELLO_WORLD');
      });

      test('converts snake_case to CONSTANT_CASE', () {
        expect(KeyUtils.toConstantCase('hello_world'), 'HELLO_WORLD');
      });
    });

    group('toParamCase', () {
      test('converts camelCase to param-case', () {
        expect(KeyUtils.toParamCase('helloWorld'), 'hello-world');
      });

      test('converts snake_case to param-case', () {
        expect(KeyUtils.toParamCase('hello_world'), 'hello-world');
      });
    });

    group('convertToFormat', () {
      test('converts using KeyCaseFormat enum', () {
        expect(
          KeyUtils.convertToFormat('hello_world', KeyCaseFormat.camelCase),
          'helloWorld',
        );
        expect(
          KeyUtils.convertToFormat('helloWorld', KeyCaseFormat.snakeCase),
          'hello_world',
        );
        expect(
          KeyUtils.convertToFormat('hello_world', KeyCaseFormat.constantCase),
          'HELLO_WORLD',
        );
      });
    });

    group('batchConvert', () {
      test('converts multiple keys at once', () {
        final keys = ['hello_world', 'foo_bar', 'test_key'];
        final result = KeyUtils.batchConvert(keys, KeyCaseFormat.camelCase);
        expect(result, ['helloWorld', 'fooBar', 'testKey']);
      });
    });

    group('detectFormat', () {
      test('detects snake_case', () {
        expect(KeyUtils.detectFormat('hello_world'), KeyCaseFormat.snakeCase);
      });

      test('detects CONSTANT_CASE', () {
        expect(
            KeyUtils.detectFormat('HELLO_WORLD'), KeyCaseFormat.constantCase);
      });

      test('detects param-case', () {
        expect(KeyUtils.detectFormat('hello-world'), KeyCaseFormat.paramCase);
      });

      test('detects camelCase', () {
        expect(KeyUtils.detectFormat('helloWorld'), KeyCaseFormat.camelCase);
      });

      test('detects PascalCase', () {
        expect(KeyUtils.detectFormat('HelloWorld'), KeyCaseFormat.pascalCase);
      });
    });
  });

  group('KeyCaseFormatExtension', () {
    test('displayName returns readable format name', () {
      expect(KeyCaseFormat.camelCase.displayName, 'camelCase');
      expect(KeyCaseFormat.snakeCase.displayName, 'snake_case');
      expect(KeyCaseFormat.constantCase.displayName, 'CONSTANT_CASE');
    });

    test('example returns example key in format', () {
      expect(KeyCaseFormat.camelCase.example, 'helloWorld');
      expect(KeyCaseFormat.snakeCase.example, 'hello_world');
      expect(KeyCaseFormat.constantCase.example, 'HELLO_WORLD');
    });
  });
}
