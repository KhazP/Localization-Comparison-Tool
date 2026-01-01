import 'dart:io';

/// Statistics about translation files in a project folder.
class ProjectStats {
  /// Number of translation files found.
  final int translationFileCount;
  
  /// Detected language codes (from file names/paths).
  final Set<String> detectedLanguages;
  
  const ProjectStats({
    required this.translationFileCount,
    required this.detectedLanguages,
  });
  
  const ProjectStats.empty()
      : translationFileCount = 0,
        detectedLanguages = const {};
  
  /// Formatted string for UI display, e.g., "12 translation files, 3 languages"
  String get displayString {
    if (translationFileCount == 0) return 'Empty project';
    
    final fileLabel = translationFileCount == 1 
        ? '1 translation file' 
        : '$translationFileCount translation files';
    
    if (detectedLanguages.isEmpty) return fileLabel;
    
    final langLabel = detectedLanguages.length == 1
        ? '1 language'
        : '${detectedLanguages.length} languages';
    
    return '$fileLabel, $langLabel';
  }
}

/// Service for scanning project folders and calculating statistics.
class ProjectStatsService {
  /// File extensions recognized as translation files.
  static const _translationExtensions = {
    '.json',
    '.arb',
    '.xml',
    '.strings',
    '.xliff',
    '.xlf',
    '.po',
    '.pot',
    '.resx',
    '.yaml',
    '.yml',
  };
  
  /// Common language code patterns in file names.
  static final _languagePatterns = [
    // ISO 639-1 codes: en, fr, de, es, etc.
    RegExp(r'[._-]([a-z]{2})(?:[._-]|$)', caseSensitive: false),
    // ISO 639-1 with region: en-US, fr-CA, zh-CN
    RegExp(r'[._-]([a-z]{2}[_-][A-Z]{2})(?:[._-]|$)', caseSensitive: false),
    // Common locale folder names
    RegExp(r'[\\/](en|fr|de|es|it|pt|ru|zh|ja|ko|ar|hi|nl|pl|sv|da|fi|no|tr)[\\/]', caseSensitive: false),
    // values-xx Android resource folders
    RegExp(r'values-([a-z]{2}(?:-[a-zA-Z]{2,4})?)[\\/]', caseSensitive: false),
  ];
  
  /// Cache of project stats to avoid re-scanning.
  final Map<String, ProjectStats> _cache = {};
  
  /// Scans a project folder and returns statistics.
  /// Results are cached.
  Future<ProjectStats> getStats(String projectPath) async {
    // Check cache first
    if (_cache.containsKey(projectPath)) {
      return _cache[projectPath]!;
    }
    
    try {
      final dir = Directory(projectPath);
      if (!await dir.exists()) {
        return const ProjectStats.empty();
      }
      
      int fileCount = 0;
      final languages = <String>{};
      
      await for (final entity in dir.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          final path = entity.path.toLowerCase();
          final fileName = path.split(Platform.pathSeparator).last;
          
          // Check if it's a translation file
          final isTranslationFile = _translationExtensions.any(
            (ext) => fileName.endsWith(ext),
          );
          
          if (isTranslationFile) {
            fileCount++;
            
            // Try to extract language code
            for (final pattern in _languagePatterns) {
              final match = pattern.firstMatch(entity.path);
              if (match != null) {
                final lang = match.group(1)?.toLowerCase();
                if (lang != null && lang.length >= 2) {
                  // Normalize: en_US -> en-US
                  languages.add(lang.replaceAll('_', '-'));
                  break;
                }
              }
            }
          }
        }
      }
      
      final stats = ProjectStats(
        translationFileCount: fileCount,
        detectedLanguages: languages,
      );
      
      // Cache the result
      _cache[projectPath] = stats;
      
      return stats;
    } catch (e) {
      // Return empty stats on error (folder might not exist, permission issues, etc.)
      return const ProjectStats.empty();
    }
  }
  
  /// Clears the cache for a specific project path.
  void invalidateCache(String projectPath) {
    _cache.remove(projectPath);
  }
  
  /// Clears all cached stats.
  void clearCache() {
    _cache.clear();
  }
}
