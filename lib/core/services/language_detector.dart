/// Helper utilities for detecting and labeling languages.
class LanguageDetector {
  static const Map<String, String> _languageNameMap = {
    'english': 'en',
    'turkish': 'tr',
    'german': 'de',
    'french': 'fr',
    'spanish': 'es',
    'italian': 'it',
    'portuguese': 'pt',
    'brazilian': 'pt-br',
    'russian': 'ru',
    'japanese': 'ja',
    'korean': 'ko',
    'chinese': 'zh',
    'arabic': 'ar',
    'polish': 'pl',
    'dutch': 'nl',
    'swedish': 'sv',
    'norwegian': 'no',
    'danish': 'da',
    'finnish': 'fi',
  };

  static final Map<String, String> _codeToName =
      _languageNameMap.map((key, value) => MapEntry(value, key));

  /// Returns a best-effort language code from a file path.
  static String detectFromPath(String filePath) {
    final normalized = filePath.replaceAll('\\', '/').toLowerCase();
    final segments = normalized.split('/');
    final fileName = segments.isNotEmpty ? segments.last : normalized;
    final baseName =
        fileName.contains('.') ? fileName.split('.').first : fileName;

    final direct = _matchLocale(baseName);
    if (direct != null) {
      return direct;
    }

    final namedDirect = _matchLanguageName(baseName);
    if (namedDirect != null) {
      return namedDirect;
    }

    final tokensMatch = _matchLocaleInTokens(baseName);
    if (tokensMatch != null) {
      return tokensMatch;
    }

    final namedTokens = _matchLanguageNameInTokens(baseName);
    if (namedTokens != null) {
      return namedTokens;
    }

    for (final segment in segments.reversed) {
      final segmentMatch = _matchLocale(segment);
      if (segmentMatch != null) {
        return segmentMatch;
      }
      final namedSegment = _matchLanguageName(segment);
      if (namedSegment != null) {
        return namedSegment;
      }
      final segmentTokens = _matchLocaleInTokens(segment);
      if (segmentTokens != null) {
        return segmentTokens;
      }
      final namedSegmentTokens = _matchLanguageNameInTokens(segment);
      if (namedSegmentTokens != null) {
        return namedSegmentTokens;
      }
    }
    return 'und';
  }

  /// Returns a friendly label for a language code.
  static String displayName(String code) {
    final normalized = code.trim().toLowerCase();
    if (normalized.isEmpty || normalized == 'und') {
      return 'Unknown';
    }

    final exactName = _codeToName[normalized];
    if (exactName != null) {
      return '${_titleCase(exactName)} ($normalized)';
    }

    final baseCode = normalized.split('-').first;
    final baseName = _codeToName[baseCode];
    if (baseName != null) {
      return '${_titleCase(baseName)} ($normalized)';
    }

    return normalized;
  }

  static String? _matchLanguageName(String value) {
    final normalized = value.replaceAll(RegExp(r'[^a-z]'), '');
    if (normalized.isEmpty) {
      return null;
    }
    return _languageNameMap[normalized];
  }

  static String? _matchLanguageNameInTokens(String value) {
    final tokens = value
        .split(RegExp(r'[^a-z]+'))
        .where((token) => token.isNotEmpty)
        .toList();
    for (final token in tokens) {
      final match = _languageNameMap[token];
      if (match != null) {
        return match;
      }
    }
    return null;
  }

  static String? _matchLocale(String value) {
    final match = RegExp(r'^([a-z]{2})(?:[-_]?([a-z]{2}))?$').firstMatch(value);
    if (match == null) {
      return null;
    }
    final language = match.group(1);
    final region = match.group(2);
    if (language == null || language.isEmpty) {
      return null;
    }
    if (region == null || region.isEmpty) {
      return language;
    }
    return '$language-$region';
  }

  static String? _matchLocaleInTokens(String value) {
    final tokens = value
        .split(RegExp(r'[^a-z]+'))
        .where((token) => token.isNotEmpty)
        .toList();
    for (var index = 0; index < tokens.length; index++) {
      final token = tokens[index];
      if (token.length != 2) {
        continue;
      }
      if (index + 1 < tokens.length && tokens[index + 1].length == 2) {
        return '${tokens[index]}-${tokens[index + 1]}';
      }
      return token;
    }
    return null;
  }

  static String _titleCase(String value) {
    if (value.isEmpty) {
      return value;
    }
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
}
