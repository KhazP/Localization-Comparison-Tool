/// Represents the change type for a localization entry.
enum StringComparisonStatus { added, removed, modified, identical }

/// Describes how a single key changed between two files.
class ComparisonStatusDetail {
  /// Creates a status detail for a single key.
  ComparisonStatusDetail(this.status, {this.similarity}) {
    if (status != StringComparisonStatus.modified && similarity != null) {
      throw ArgumentError(
        'Similarity score should only be provided for modified status.',
      );
    }
  }

  /// The change category for the key.
  final StringComparisonStatus status;

  /// Similarity score from 0.0 to 1.0 when the key is modified.
  final double? similarity;

  /// Creates an added status detail.
  factory ComparisonStatusDetail.added() =>
      ComparisonStatusDetail(StringComparisonStatus.added);

  /// Creates a removed status detail.
  factory ComparisonStatusDetail.removed() =>
      ComparisonStatusDetail(StringComparisonStatus.removed);

  /// Creates an identical status detail.
  factory ComparisonStatusDetail.identical() =>
      ComparisonStatusDetail(StringComparisonStatus.identical);

  /// Creates a modified status detail with a similarity score.
  factory ComparisonStatusDetail.modified(double similarityScore) {
    if (similarityScore < 0.0 || similarityScore > 1.0) {
      throw ArgumentError('Similarity score must be between 0.0 and 1.0.');
    }
    return ComparisonStatusDetail(
      StringComparisonStatus.modified,
      similarity: similarityScore,
    );
  }

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
    final similarity = similarityValue is num
        ? similarityValue.toDouble()
        : null;
    return ComparisonStatusDetail(status, similarity: similarity);
  }
}
