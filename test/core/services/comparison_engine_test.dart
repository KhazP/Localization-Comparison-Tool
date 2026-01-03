import 'package:flutter_test/flutter_test.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/core/services/diff_calculator.dart';
// AppSettings is not directly used by the engine's _calculateDiff for tests,
// but we pass the boolean flags and list directly.

void main() {
  group('DiffCalculator Tests', () {
    // The logic is now in a public, static method `DiffCalculator.calculateDiff`,
    // so we can call it directly in our tests without any workarounds.

    // The `performDiff` helper function is no longer needed, as we can use
    // the actual implementation.

    group('Ignore Case Tests', () {
      test(
          'should treat different cased values as identical when ignoreCase is true',
          () {
        final data1 = {'key1': 'Value'};
        final data2 = {'key1': 'value'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.identical);
      });

      test(
          'should treat different cased values as modified when ignoreCase is false',
          () {
        final data1 = {'key1': 'Value'};
        final data2 = {'key1': 'value'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.modified);
      });

      test(
          'should treat different cased keys as distinct (keys are case-sensitive)',
          () {
        // Key casing is always sensitive, ignoreCase applies to values.
        final data1 = {'Key1': 'Value'};
        final data2 = {'key1': 'Value'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['Key1']?.status, StringComparisonStatus.removed);
        expect(result['key1']?.status, StringComparisonStatus.added);
      });

      test(
          'should handle mixed case common strings from sample files correctly with ignoreCase true',
          () {
        final data1 = {'welcome': 'Welcome to our company.'};
        final data2 = {'welcome': 'welcome to our company.'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['welcome']?.status, StringComparisonStatus.identical);
      });
      test(
          'should handle user example: skills.type.dash as identical when ignoreCase is true',
          () {
        final data1 = {'skills.type.dash': 'Dash'};
        final data2 = {'skills.type.dash': 'dash'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['skills.type.dash']?.status,
            StringComparisonStatus.identical);
      });

      test(
          'should handle user example: skills.type.dash as modified when ignoreCase is false',
          () {
        final data1 = {'skills.type.dash': 'Dash'};
        final data2 = {'skills.type.dash': 'dash'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['skills.type.dash']?.status,
            StringComparisonStatus.modified);
      });
    });

    group('Bug Fix Tests', () {
      test('should correctly identify a removed key', () {
        final data1 = {'key1': 'Value1', 'key_to_remove': 'Value2'};
        final data2 = {'key1': 'Value1'};
        final result = DiffCalculator.calculateDiff(
          data1: data1,
          data2: data2,
          ignoreCase: false,
          ignorePatterns: [],
          ignoreWhitespace: false,
          comparisonMode: 'Key-based',
          similarityThreshold: 0.85,
        );
        expect(result['key_to_remove']?.status, StringComparisonStatus.removed);
      });
    });

    group('Ignore Whitespace Tests', () {
      test(
          'should treat values with different leading/trailing spaces as identical when ignoreWhitespace is true',
          () {
        final data1 = {'key1': '  value  '};
        final data2 = {'key1': 'value'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.identical);
      });

      test(
          'should treat values with different leading/trailing spaces as modified when ignoreWhitespace is false',
          () {
        final data1 = {'key1': '  value  '};
        final data2 = {'key1': 'value'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.modified);
      });

      test(
          'should treat values with different internal spacing as identical when ignoreWhitespace is true',
          () {
        final data1 = {'key1': 'value  with   spaces'};
        final data2 = {'key1': 'value with spaces'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.identical);
      });

      test(
          'should treat values with different internal spacing as modified when ignoreWhitespace is false',
          () {
        final data1 = {'key1': 'value  with   spaces'};
        final data2 = {'key1': 'value with spaces'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.modified);
      });

      test(
          'should handle mixed leading/trailing and internal spaces correctly when ignoreWhitespace is true',
          () {
        final data1 = {'key1': '  value  with   extra   spaces  '};
        final data2 = {'key1': 'value with extra spaces'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.identical);
      });

      test(
          'should treat empty string and string with only spaces as identical when ignoreWhitespace is true',
          () {
        final data1 = {'key1': '   '};
        final data2 = {'key1': ''};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.identical);
      });

      test(
          'should treat empty string and string with only spaces as modified when ignoreWhitespace is false',
          () {
        final data1 = {'key1': '   '};
        final data2 = {'key1': ''};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.modified);
      });
    });

    group('Ignore Patterns Tests', () {
      test('should ignore keys matching a simple prefix pattern', () {
        final data1 = {'_temp_key1': 'value1', 'user_key1': 'value2'};
        final data2 = {'_temp_key1': 'value1_modified', 'user_key2': 'value3'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [r'^_temp_'],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result.containsKey('_temp_key1'), isFalse);
        expect(result['user_key1']?.status, StringComparisonStatus.removed);
        expect(result['user_key2']?.status, StringComparisonStatus.added);
      });

      test('should not ignore keys if no patterns match', () {
        final data1 = {'_temp_key1': 'value1', 'user_key1': 'value2'};
        final data2 = {'_temp_key1': 'value1_modified', 'user_key2': 'value3'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [r'^_permanent_'],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result.containsKey('_temp_key1'), isTrue);
        expect(result['_temp_key1']?.status, StringComparisonStatus.modified);
        expect(result['user_key1']?.status, StringComparisonStatus.removed);
        expect(result['user_key2']?.status, StringComparisonStatus.added);
      });

      test('should ignore keys matching any of multiple patterns', () {
        final data1 = {
          'debug_data': 'debug',
          'temp_user': 'temp',
          'final_config': 'config'
        };
        final data2 = {'final_config': 'config_v2'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [r'^debug_', r'^temp_'],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result.containsKey('debug_data'), isFalse);
        expect(result.containsKey('temp_user'), isFalse);
        expect(result['final_config']?.status, StringComparisonStatus.modified);
      });

      test('should handle empty ignorePatterns list (no keys ignored)', () {
        final data1 = {'_temp_key1': 'value1'};
        final data2 = {'_temp_key1': 'value2'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result['_temp_key1']?.status, StringComparisonStatus.modified);
      });

      test('should correctly process non-ignored keys when some are ignored',
          () {
        final data1 = {
          'ignore_this_abc': 'val1',
          'keep_this_1': 'val2',
          'also_ignore_xyz': 'val3'
        };
        final data2 = {'keep_this_1': 'val2_mod', 'keep_this_2': 'val4'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [r'^ignore_this_', r'_xyz$'],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result.containsKey('ignore_this_abc'), isFalse);
        expect(result.containsKey('also_ignore_xyz'), isFalse);
        expect(result['keep_this_1']?.status, StringComparisonStatus.modified);
        expect(result['keep_this_2']?.status, StringComparisonStatus.added);
      });

      test(
          'should ignore keys even if their values would otherwise be identical or different',
          () {
        final data1 = {'ignore_me': 'same_value', 'another_to_ignore': 'val_A'};
        final data2 = {'ignore_me': 'same_value', 'another_to_ignore': 'val_B'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [r'^ignore_me', r'^another_to_ignore'],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result.containsKey('ignore_me'), isFalse);
        expect(result.containsKey('another_to_ignore'), isFalse);
        expect(result.isEmpty, isTrue);
      });
    });

    group('Combined Settings Tests', () {
      test(
          'ignoreCase true, ignoreWhitespace true: should make values identical',
          () {
        final data1 = {'key1': '  Hello World  '};
        final data2 = {'key1': 'hello world'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.identical);
      });

      test(
          'ignoreCase false, ignoreWhitespace true: should make values modified due to case',
          () {
        final data1 = {'key1': '  Hello World  '};
        final data2 = {'key1': 'hello world'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: false,
            ignorePatterns: [],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        // Whitespace is ignored, so 'Hello World' vs 'hello world' -> modified
        expect(result['key1']?.status, StringComparisonStatus.modified);
      });

      test(
          'ignoreCase true, ignoreWhitespace false: should make values modified due to whitespace',
          () {
        final data1 = {'key1': '  Hello World  '};
        final data2 = {
          'key1': 'hello world'
        }; // Note: target also has different case
        // Case is ignored, so '  hello world  ' (from data1 after lowercasing) vs 'hello world' (from data2 after lowercasing)
        // These are different due to whitespace.
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [],
            ignoreWhitespace: false,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result['key1']?.status, StringComparisonStatus.modified);
      });

      test(
          'ignorePatterns takes precedence: key is ignored even if other settings would apply',
          () {
        final data1 = {'_temp_data': '  Value  '};
        final data2 = {'_temp_data': 'value'};
        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [r'^_temp_'],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);
        expect(result.containsKey('_temp_data'), isFalse);
        expect(result.isEmpty, isTrue);
      });

      test('all settings active: complex scenario', () {
        final data1 = {
          '_temp_ignored': 'any value',
          'key_whitespace': '  Test Value  ',
          'key_case': 'Another VAL',
          'key_both': '  MIXED Case  ',
          'key_identical_after_ops': '  identical string  '
        };
        final data2 = {
          '_temp_ignored': 'other value',
          'key_whitespace':
              'Test Value', // Modified (only by whitespace if ignoreCase=false)
          'key_case':
              'another val', // Modified (only by case if ignoreWhitespace=false)
          'key_both': 'mixed case', // Identical after both ops
          'key_identical_after_ops':
              'identical string' // Identical after both ops
        };

        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [r'^_temp_'],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result.containsKey('_temp_ignored'), isFalse,
            reason: 'Pattern should exclude _temp_ignored');

        // 'key_whitespace': data1 '  Test Value  ' -> 'Test Value', data2 'Test Value' -> 'Test Value'
        // If ignoreCase=true: 'test value' vs 'test value' -> identical
        expect(
            result['key_whitespace']?.status, StringComparisonStatus.identical,
            reason: 'key_whitespace should be identical');

        // 'key_case': data1 'Another VAL' -> 'another val', data2 'another val' -> 'another val'
        // If ignoreWhitespace=true (no effect here as no extra spaces): 'another val' vs 'another val' -> identical
        expect(result['key_case']?.status, StringComparisonStatus.identical,
            reason: 'key_case should be identical');

        // 'key_both': data1 '  MIXED Case  ' -> 'MIXED Case' -> 'mixed case'
        //             data2 'mixed case' -> 'mixed case' -> 'mixed case'
        expect(result['key_both']?.status, StringComparisonStatus.identical,
            reason: 'key_both should be identical');

        // 'key_identical_after_ops': data1 '  identical string  ' -> 'identical string' -> 'identical string'
        //                           data2 'identical string' -> 'identical string' -> 'identical string'
        expect(result['key_identical_after_ops']?.status,
            StringComparisonStatus.identical,
            reason: 'key_identical_after_ops should be identical');
      });

      test(
          'ignorePatterns with others: pattern excludes, others processed normally',
          () {
        final data1 = {
          'config_A': '  Alpha ', // Becomes 'alpha'
          '_metadata_info': 'secret',
          'data_payload_X': '  Bravo  ' // Becomes 'bravo'
        };
        final data2 = {
          'config_A': 'alpha', // Identical after ops
          '_metadata_info': 'public',
          'data_payload_X': 'Charlie' // Modified after ops (bravo vs charlie)
        };

        final result = DiffCalculator.calculateDiff(
            data1: data1,
            data2: data2,
            ignoreCase: true,
            ignorePatterns: [r'^_metadata_'],
            ignoreWhitespace: true,
            comparisonMode: 'Key-based',
            similarityThreshold: 0.85);

        expect(result.containsKey('_metadata_info'), isFalse);
        expect(result['config_A']?.status, StringComparisonStatus.identical);
        expect(
            result['data_payload_X']?.status, StringComparisonStatus.modified);
      });
    });
  });
}
