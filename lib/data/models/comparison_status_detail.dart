enum StringComparisonStatus { added, removed, modified, identical }

class ComparisonStatusDetail {
  final StringComparisonStatus status;
  final double? similarity; // Score from 0.0 to 1.0, only for 'modified' status

  ComparisonStatusDetail(this.status, {this.similarity}) {
    if (status != StringComparisonStatus.modified && similarity != null) {
      throw ArgumentError('Similarity score should only be provided for modified status.');
    }
    // For modified status, similarity score is expected to be calculated by the engine.
    // If it's somehow null here for modified, it indicates an issue in the engine.
    // We could enforce it with an assertion or error if desired, for example:
    // if (status == StringComparisonStatus.modified && similarity == null) {
    //   throw ArgumentError('Similarity score must be provided for modified status when creating this detail.');
    // }
  }

  // Optional: Add factory constructors for convenience
  factory ComparisonStatusDetail.added() => ComparisonStatusDetail(StringComparisonStatus.added);
  factory ComparisonStatusDetail.removed() => ComparisonStatusDetail(StringComparisonStatus.removed);
  factory ComparisonStatusDetail.identical() => ComparisonStatusDetail(StringComparisonStatus.identical);
  factory ComparisonStatusDetail.modified(double similarityScore) {
    if (similarityScore < 0.0 || similarityScore > 1.0) {
        throw ArgumentError('Similarity score must be between 0.0 and 1.0.');
    }
    return ComparisonStatusDetail(StringComparisonStatus.modified, similarity: similarityScore);
  }
} 