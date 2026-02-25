import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart' hide ComparisonResult;
import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/data/parsers/localization_parser.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockComparisonEngine mockEngine;
  late MockWarningSuppressionsRepository mockWarnings;
  late AppSettings settings;
  late File file1;
  late File file2;

  setUpAll(() {
    registerFallbackValue(File(''));
    registerFallbackValue(AppSettings.defaultSettings());
  });

  setUp(() {
    mockEngine = MockComparisonEngine();
    mockWarnings = MockWarningSuppressionsRepository();
    settings = AppSettings.defaultSettings();
    file1 = File('source.json');
    file2 = File('target.json');
  });

  ComparisonResult _makeResult({int diffCount = 5}) {
    final diff = <String, ComparisonStatusDetail>{};
    for (var i = 0; i < diffCount; i++) {
      diff['key_$i'] = const ComparisonStatusDetail.added();
    }
    return ComparisonResult({}, {}, IMap(diff));
  }

  group('ComparisonBloc', () {
    test('initial state is ComparisonInitial', () {
      final bloc = ComparisonBloc(comparisonEngine: mockEngine);
      expect(bloc.state, const ComparisonInitial());
      bloc.close();
    });

    blocTest<ComparisonBloc, ComparisonState>(
      'CompareFilesRequested emits loading then success',
      build: () {
        final result = _makeResult();
        when(() => mockEngine.compareFiles(
              any(),
              any(),
              any(),
              onProgress: any(named: 'onProgress'),
            )).thenAnswer((_) async => result);
        return ComparisonBloc(comparisonEngine: mockEngine);
      },
      act: (bloc) => bloc.add(CompareFilesRequested(
        file1: file1,
        file2: file2,
        settings: settings,
      )),
      expect: () => [
        isA<ComparisonLoading>(),
        isA<ComparisonSuccess>(),
      ],
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'CompareFilesRequested emits failure on exception',
      build: () {
        when(() => mockEngine.compareFiles(
              any(),
              any(),
              any(),
              onProgress: any(named: 'onProgress'),
            )).thenThrow(Exception('Parse error'));
        return ComparisonBloc(comparisonEngine: mockEngine);
      },
      act: (bloc) => bloc.add(CompareFilesRequested(
        file1: file1,
        file2: file2,
        settings: settings,
      )),
      expect: () => [
        isA<ComparisonLoading>(),
        isA<ComparisonFailure>(),
      ],
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'CompareBilingualFileRequested emits loading then success',
      build: () {
        final result = _makeResult();
        when(() => mockEngine.compareBilingualFile(
              any(),
              any(),
              onProgress: any(named: 'onProgress'),
            )).thenAnswer((_) async => result);
        return ComparisonBloc(comparisonEngine: mockEngine);
      },
      act: (bloc) => bloc.add(CompareBilingualFileRequested(
        file: file1,
        settings: settings,
      )),
      expect: () => [
        isA<ComparisonLoading>(),
        isA<ComparisonSuccess>(),
      ],
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'CompareBilingualFileRequested emits failure for invalid bilingual file',
      build: () {
        when(() => mockEngine.compareBilingualFile(
              any(),
              any(),
              onProgress: any(named: 'onProgress'),
            )).thenThrow(InvalidBilingualFileException('Not a bilingual file'));
        return ComparisonBloc(comparisonEngine: mockEngine);
      },
      act: (bloc) => bloc.add(CompareBilingualFileRequested(
        file: file1,
        settings: settings,
      )),
      expect: () => [
        isA<ComparisonLoading>(),
        isA<ComparisonFailure>()
            .having((s) => s.error, 'error', 'Not a bilingual file'),
      ],
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'CompareFilesFromHistoryRequested emits failure when files missing',
      build: () {
        return ComparisonBloc(comparisonEngine: mockEngine);
      },
      act: (bloc) => bloc.add(CompareFilesFromHistoryRequested(
        file1Path: '/nonexistent/path1.json',
        file2Path: '/nonexistent/path2.json',
        settings: settings,
      )),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        isA<ComparisonLoading>(),
        isA<ComparisonFailure>(),
      ],
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'large file warning emitted when diff exceeds 50000 entries',
      build: () {
        final result = _makeResult(diffCount: 50001);
        when(() => mockEngine.compareFiles(
              any(),
              any(),
              any(),
              onProgress: any(named: 'onProgress'),
            )).thenAnswer((_) async => result);
        when(() => mockWarnings.isLargeFileWarningSuppressed(any()))
            .thenReturn(false);
        return ComparisonBloc(
          comparisonEngine: mockEngine,
          warningSuppressionsRepository: mockWarnings,
        );
      },
      act: (bloc) => bloc.add(CompareFilesRequested(
        file1: file1,
        file2: file2,
        settings: settings,
      )),
      expect: () => [
        isA<ComparisonLoading>(),
        isA<ComparisonLargeFileWarning>(),
      ],
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'ProceedWithComparison emits success from warning state',
      build: () => ComparisonBloc(comparisonEngine: mockEngine),
      act: (bloc) {
        final result = _makeResult();
        bloc.add(ProceedWithComparison(result, file1, file2));
      },
      expect: () => [
        isA<ComparisonSuccess>(),
      ],
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'SuppressLargeFileWarning calls repository',
      build: () {
        when(() => mockWarnings.suppressLargeFileWarning(any()))
            .thenAnswer((_) async {});
        return ComparisonBloc(
          comparisonEngine: mockEngine,
          warningSuppressionsRepository: mockWarnings,
        );
      },
      act: (bloc) => bloc.add(SuppressLargeFileWarning('/path/to/file.json')),
      verify: (_) {
        verify(() =>
                mockWarnings.suppressLargeFileWarning('/path/to/file.json'))
            .called(1);
      },
    );

    blocTest<ComparisonBloc, ComparisonState>(
      'large file warning suppressed when repository says so',
      build: () {
        final result = _makeResult(diffCount: 50001);
        when(() => mockEngine.compareFiles(
              any(),
              any(),
              any(),
              onProgress: any(named: 'onProgress'),
            )).thenAnswer((_) async => result);
        when(() => mockWarnings.isLargeFileWarningSuppressed(any()))
            .thenReturn(true);
        return ComparisonBloc(
          comparisonEngine: mockEngine,
          warningSuppressionsRepository: mockWarnings,
        );
      },
      act: (bloc) => bloc.add(CompareFilesRequested(
        file1: file1,
        file2: file2,
        settings: settings,
      )),
      expect: () => [
        isA<ComparisonLoading>(),
        isA<ComparisonSuccess>(),
      ],
    );
  });
}
