/// Aggregated usage information for AI providers.
class AiUsageSummary {
  /// Creates an AI usage summary.
  const AiUsageSummary({
    required this.providers,
    this.history = const [],
  });

  /// Provider summaries.
  final List<AiUsageProviderSummary> providers;

  /// Full usage history (individual requests).
  final List<AiUsageHistoryEntry> history;

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

  /// Returns history entries filtered by date range and optional provider.
  List<AiUsageHistoryEntry> historyInRange({
    required DateTime from,
    required DateTime to,
    String? providerName,
  }) {
    return history.where((entry) {
      final inRange =
          !entry.timestamp.isBefore(from) && !entry.timestamp.isAfter(to);
      final matchesProvider =
          providerName == null || entry.providerName == providerName;
      return inRange && matchesProvider;
    }).toList();
  }
}

/// A single usage event record.
class AiUsageHistoryEntry {
  const AiUsageHistoryEntry({
    required this.timestamp,
    required this.providerName,
    this.promptTokens = 0,
    this.completionTokens = 0,
    this.totalTokens = 0,
    this.characters = 0,
    this.latencyMs,
    this.model,
  });

  final DateTime timestamp;
  final String providerName;
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;
  final int characters;
  final int? latencyMs;
  final String? model;

  /// Estimated cost for this single request.
  double? get estimatedCostUsd {
    switch (providerName) {
      case 'Google Translate':
        return characters > 0 ? characters / 1000000 * 20.0 : null;
      case 'DeepL':
        return characters > 0 ? characters / 1000000 * 25.0 : null;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'providerName': providerName,
        'promptTokens': promptTokens,
        'completionTokens': completionTokens,
        'totalTokens': totalTokens,
        'characters': characters,
        if (latencyMs != null) 'latencyMs': latencyMs,
        if (model != null) 'model': model,
      };

  factory AiUsageHistoryEntry.fromJson(Map<String, dynamic> json) {
    return AiUsageHistoryEntry(
      timestamp: DateTime.parse(json['timestamp'] as String),
      providerName: json['providerName'] as String,
      promptTokens: json['promptTokens'] as int? ?? 0,
      completionTokens: json['completionTokens'] as int? ?? 0,
      totalTokens: json['totalTokens'] as int? ?? 0,
      characters: json['characters'] as int? ?? 0,
      latencyMs: json['latencyMs'] as int?,
      model: json['model'] as String?,
    );
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
    this.totalCharacters = 0,
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

  /// Total characters translated (for character-based APIs like Google/DeepL).
  final int totalCharacters;

  /// Most recent model name seen.
  final String? lastModel;

  /// Timestamp of the most recent request.
  final DateTime? lastUsedAt;

  /// Most recent latency in milliseconds.
  final int? lastLatencyMs;

  /// Whether this provider uses character-based pricing.
  bool get isCharacterBased =>
      providerName == 'Google Translate' || providerName == 'DeepL';

  /// Estimated cost in USD based on provider pricing.
  ///
  /// Pricing:
  /// - Google Translate: $20 per 1M characters
  /// - DeepL: $25 per 1M characters
  /// - Token-based providers: returns null (pricing varies by model)
  double? get estimatedCostUsd {
    if (totalCharacters <= 0) return null;

    switch (providerName) {
      case 'Google Translate':
        return totalCharacters / 1000000 * 20.0;
      case 'DeepL':
        return totalCharacters / 1000000 * 25.0;
      default:
        return null;
    }
  }
}
