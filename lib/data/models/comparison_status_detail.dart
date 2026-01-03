import 'package:freezed_annotation/freezed_annotation.dart';

part 'comparison_status_detail.freezed.dart';

/// Represents the change type for a localization entry.
enum StringComparisonStatus { added, removed, modified, identical }

/// Describes how a single key changed between two files.
@freezed
class ComparisonStatusDetail with _$ComparisonStatusDetail {
  const ComparisonStatusDetail._();

  /// Creates an added status detail.
  const factory ComparisonStatusDetail.added() = ComparisonStatusDetailAdded;

  /// Creates a removed status detail.
  const factory ComparisonStatusDetail.removed() =
      ComparisonStatusDetailRemoved;

  /// Creates an identical status detail.
  const factory ComparisonStatusDetail.identical() =
      ComparisonStatusDetailIdentical;

  /// Creates a modified status detail with a similarity score.
  @Assert(
    'similarity >= 0.0 && similarity <= 1.0',
    'Similarity score must be between 0.0 and 1.0.',
  )
  const factory ComparisonStatusDetail.modified(double similarity) =
      ComparisonStatusDetailModified;

  /// The change category for the key.
  StringComparisonStatus get status => when(
        added: () => StringComparisonStatus.added,
        removed: () => StringComparisonStatus.removed,
        identical: () => StringComparisonStatus.identical,
        modified: (_) => StringComparisonStatus.modified,
      );

  /// Similarity score from 0.0 to 1.0 when the key is modified.
  double? get similarity => maybeWhen(
        modified: (value) => value,
        orElse: () => null,
      );

  /// Converts the detail into a sendable map for background work.
  Map<String, Object?> toMap() {
    return <String, Object?>{
      'status': status.name,
      'similarity': similarity,
    };
  }

  /// Builds a detail from a map produced by [toMap].
  factory ComparisonStatusDetail.fromMap(Map<String, Object?> map) {
    final statusName = map['status'];
    if (statusName is! String) {
      throw ArgumentError('Missing or invalid status name.');
    }
    final status = StringComparisonStatus.values.firstWhere(
      (value) => value.name == statusName,
      orElse: () {
        throw ArgumentError('Unknown status name: $statusName');
      },
    );
    final similarityValue = map['similarity'];
    final similarity =
        similarityValue is num ? similarityValue.toDouble() : null;

    switch (status) {
      case StringComparisonStatus.added:
        if (similarity != null) {
          throw ArgumentError(
            'Similarity score should only be provided for modified status.',
          );
        }
        return const ComparisonStatusDetail.added();
      case StringComparisonStatus.removed:
        if (similarity != null) {
          throw ArgumentError(
            'Similarity score should only be provided for modified status.',
          );
        }
        return const ComparisonStatusDetail.removed();
      case StringComparisonStatus.identical:
        if (similarity != null) {
          throw ArgumentError(
            'Similarity score should only be provided for modified status.',
          );
        }
        return const ComparisonStatusDetail.identical();
      case StringComparisonStatus.modified:
        if (similarity == null) {
          throw ArgumentError(
            'Similarity score must be provided for modified status.',
          );
        }
        if (similarity < 0.0 || similarity > 1.0) {
          throw ArgumentError(
            'Similarity score must be between 0.0 and 1.0.',
          );
        }
        return ComparisonStatusDetail.modified(similarity);
    }
  }
}
