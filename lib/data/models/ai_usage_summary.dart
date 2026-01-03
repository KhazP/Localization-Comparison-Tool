/// Aggregated usage information for AI providers.
class AiUsageSummary {
  /// Creates an AI usage summary.
  const AiUsageSummary({required this.providers});

  /// Provider summaries.
  final List<AiUsageProviderSummary> providers;

  /// Whether any provider has recorded usage.
  bool get hasUsage {
    return providers.any((provider) => provider.requestCount > 0);
  }

  /// Returns the summary for a specific provider name.
  AiUsageProviderSummary? providerByName(String name) {
    for (final provider in providers) {
      if (provider.providerName == name) {
        return provider;
      }
    }
    return null;
  }
}

/// Usage stats for a single AI provider.
class AiUsageProviderSummary {
  /// Creates a provider usage summary.
  const AiUsageProviderSummary({
    required this.providerName,
    required this.requestCount,
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    this.lastModel,
    this.lastUsedAt,
    this.lastLatencyMs,
  });

  /// Provider display name.
  final String providerName;

  /// Total number of requests recorded.
  final int requestCount;

  /// Total prompt tokens used.
  final int promptTokens;

  /// Total completion tokens used.
  final int completionTokens;

  /// Total tokens used.
  final int totalTokens;

  /// Most recent model name seen.
  final String? lastModel;

  /// Timestamp of the most recent request.
  final DateTime? lastUsedAt;

  /// Most recent latency in milliseconds.
  final int? lastLatencyMs;
}
