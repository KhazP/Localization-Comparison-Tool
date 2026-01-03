import 'package:hive_flutter/hive_flutter.dart';
import 'package:localizer_app_main/data/models/ai_usage_summary.dart';

/// Stores aggregated usage stats for AI providers.
class AiUsageService {
  static const String _boxName = 'ai_usage_box';
  static const String _summaryKey = 'summary';
  static const String _historyKey = 'history';
  static const int _maxHistoryEntries =
      10000; // Limit to prevent unbounded growth

  /// Records a single AI request for the specified provider.
  Future<void> recordUsage({
    required String providerName,
    int promptTokens = 0,
    int completionTokens = 0,
    int totalTokens = 0,
    int characters = 0,
    String? model,
    int? latencyMs,
    DateTime? usedAt,
  }) async {
    final box = await _openBox();
    final timestamp = usedAt ?? DateTime.now();

    // Update aggregated summary
    final summary = _readMap(box.get(_summaryKey));
    final providers = _readMap(summary['providers']);
    final providerStats = _readMap(providers[providerName]);

    final resolvedTotal =
        totalTokens > 0 ? totalTokens : promptTokens + completionTokens;

    final updated = <String, dynamic>{
      'requestCount': (providerStats['requestCount'] as int? ?? 0) + 1,
      'promptTokens':
          (providerStats['promptTokens'] as int? ?? 0) + promptTokens,
      'completionTokens':
          (providerStats['completionTokens'] as int? ?? 0) + completionTokens,
      'totalTokens':
          (providerStats['totalTokens'] as int? ?? 0) + resolvedTotal,
      'totalCharacters':
          (providerStats['totalCharacters'] as int? ?? 0) + characters,
      'lastUsedAt': timestamp.toIso8601String(),
    };

    if (model != null && model.isNotEmpty) {
      updated['lastModel'] = model;
    } else if (providerStats['lastModel'] != null) {
      updated['lastModel'] = providerStats['lastModel'];
    }

    if (latencyMs != null) {
      updated['lastLatencyMs'] = latencyMs;
    } else if (providerStats['lastLatencyMs'] != null) {
      updated['lastLatencyMs'] = providerStats['lastLatencyMs'];
    }

    providers[providerName] = updated;
    summary['providers'] = providers;
    await box.put(_summaryKey, summary);

    // Store individual history entry
    final historyEntry = AiUsageHistoryEntry(
      timestamp: timestamp,
      providerName: providerName,
      promptTokens: promptTokens,
      completionTokens: completionTokens,
      totalTokens: resolvedTotal,
      characters: characters,
      latencyMs: latencyMs,
      model: model,
    );

    final historyList = _readHistoryList(box.get(_historyKey));
    historyList.add(historyEntry.toJson());

    // Trim if too large (keep most recent)
    if (historyList.length > _maxHistoryEntries) {
      historyList.removeRange(0, historyList.length - _maxHistoryEntries);
    }

    await box.put(_historyKey, historyList);
  }

  /// Returns aggregated AI usage totals with optional history.
  Future<AiUsageSummary> getSummary({bool includeHistory = false}) async {
    final box = await _openBox();
    final summary = _readMap(box.get(_summaryKey));
    final providers = _readMap(summary['providers']);

    final providerSummaries = providers.entries
        .map((entry) => _parseProvider(entry.key, entry.value))
        .whereType<AiUsageProviderSummary>()
        .toList()
      ..sort((a, b) => a.providerName.compareTo(b.providerName));

    List<AiUsageHistoryEntry> history = [];
    if (includeHistory) {
      final historyList = _readHistoryList(box.get(_historyKey));
      history = historyList
          .map((json) =>
              AiUsageHistoryEntry.fromJson(Map<String, dynamic>.from(json)))
          .toList()
        ..sort(
            (a, b) => b.timestamp.compareTo(a.timestamp)); // Most recent first
    }

    return AiUsageSummary(providers: providerSummaries, history: history);
  }

  /// Returns usage history filtered by date range.
  Future<List<AiUsageHistoryEntry>> getHistory({
    DateTime? from,
    DateTime? to,
    String? providerName,
  }) async {
    final box = await _openBox();
    final historyList = _readHistoryList(box.get(_historyKey));

    var entries = historyList
        .map((json) =>
            AiUsageHistoryEntry.fromJson(Map<String, dynamic>.from(json)))
        .toList();

    if (from != null) {
      entries = entries.where((e) => !e.timestamp.isBefore(from)).toList();
    }
    if (to != null) {
      entries = entries.where((e) => !e.timestamp.isAfter(to)).toList();
    }
    if (providerName != null) {
      entries = entries.where((e) => e.providerName == providerName).toList();
    }

    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries;
  }

  Future<Box<dynamic>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      try {
        await Hive.openBox<dynamic>(_boxName);
      } catch (_) {
        await Hive.deleteBoxFromDisk(_boxName);
        await Hive.openBox<dynamic>(_boxName);
      }
    }
    return Hive.box<dynamic>(_boxName);
  }

  Map<String, dynamic> _readMap(dynamic value) {
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return <String, dynamic>{};
  }

  List<dynamic> _readHistoryList(dynamic value) {
    if (value is List) {
      return List<dynamic>.from(value);
    }
    return <dynamic>[];
  }

  AiUsageProviderSummary? _parseProvider(
    String providerName,
    dynamic value,
  ) {
    if (value is! Map) return null;
    final data = Map<String, dynamic>.from(value);

    final lastUsedRaw = data['lastUsedAt'] as String?;
    final lastUsed =
        lastUsedRaw != null ? DateTime.tryParse(lastUsedRaw) : null;

    return AiUsageProviderSummary(
      providerName: providerName,
      requestCount: data['requestCount'] as int? ?? 0,
      promptTokens: data['promptTokens'] as int? ?? 0,
      completionTokens: data['completionTokens'] as int? ?? 0,
      totalTokens: data['totalTokens'] as int? ?? 0,
      totalCharacters: data['totalCharacters'] as int? ?? 0,
      lastModel: data['lastModel'] as String?,
      lastUsedAt: lastUsed,
      lastLatencyMs: data['lastLatencyMs'] as int?,
    );
  }
}
