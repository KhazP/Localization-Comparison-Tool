import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_pair.freezed.dart';

/// Links a source file with its matching target file.
@Freezed(equal: false)
class FilePair with _$FilePair {
  const FilePair._();

  /// Creates a file pair.
  const factory FilePair({
    required File sourceFile,
    required File targetFile,
  }) = _FilePair;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilePair &&
        other.sourceFile.path == sourceFile.path &&
        other.targetFile.path == targetFile.path;
  }

  @override
  int get hashCode => Object.hash(
        sourceFile.path,
        targetFile.path,
      );
}
