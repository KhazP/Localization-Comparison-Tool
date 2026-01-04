import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/secure_storage_service.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';

/// A widget that displays storage contents for debugging.
class StorageInspectorSection extends StatefulWidget {
  final bool isDark;
  final bool isAmoled;

  const StorageInspectorSection({
    super.key,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  State<StorageInspectorSection> createState() =>
      _StorageInspectorSectionState();
}

class _StorageInspectorSectionState extends State<StorageInspectorSection> {
  Map<String, String> _hiveData = {};
  Map<String, String> _secureStorageData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    // Load Hive data
    try {
      final box = Hive.box<AppSettings>('app_settings_box');
      final settings = box.get('current_settings');
      if (settings != null) {
        _hiveData = {
          'appLanguage': settings.appLanguage,
          'appThemeMode': settings.appThemeMode,
          'showDeveloperOptions': settings.showDeveloperOptions.toString(),
          'enableAiTranslation': settings.enableAiTranslation.toString(),
          'defaultSourceFormat': settings.defaultSourceFormat,
          'defaultTargetFormat': settings.defaultTargetFormat,
          'ignoreCase': settings.ignoreCase.toString(),
          'ignoreWhitespace': settings.ignoreWhitespace.toString(),
          'comparisonMode': settings.comparisonMode,
          'similarityThreshold': settings.similarityThreshold.toString(),
        };
      }
    } catch (e) {
      _hiveData = {'error': e.toString()};
    }

    // Load Secure Storage data (masked)
    try {
      final secureStorage = sl<SecureStorageService>();
      final googleKey = await secureStorage.getGoogleApiKey();
      final deeplKey = await secureStorage.getDeepLApiKey();
      final geminiKey = await secureStorage.getGeminiApiKey();
      final openaiKey = await secureStorage.getOpenAiApiKey();
      final lastProject = await secureStorage.getLastProject();

      _secureStorageData = {
        'google_translate_api_key': _maskValue(googleKey),
        'deepl_api_key': _maskValue(deeplKey),
        'gemini_api_key': _maskValue(geminiKey),
        'openai_api_key': _maskValue(openaiKey),
        'last_project_path': lastProject ?? '(not set)',
      };
    } catch (e) {
      _secureStorageData = {'error': e.toString()};
    }

    setState(() => _isLoading = false);
  }

  String _maskValue(String? value) {
    if (value == null || value.isEmpty) return '(not set)';
    if (value.length <= 8) return '***';
    return '${value.substring(0, 4)}...${value.substring(value.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionTile(
      leading: Icon(LucideIcons.database, color: colorScheme.primary),
      title: const Text('Storage Inspector'),
      subtitle: const Text('View Hive & Secure Storage contents'),
      children: [
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          )
        else ...[
          _buildSubsection('Hive (AppSettings)', _hiveData),
          _buildSubsection('Secure Storage (Masked)', _secureStorageData),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              icon: const Icon(LucideIcons.refreshCw),
              label: const Text('Refresh'),
              onPressed: _loadData,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSubsection(String title, Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isDark
                  ? AppThemeV2.darkTextSecondary
                  : AppThemeV2.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          ...data.entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      entry.key,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            color: widget.isDark
                                ? AppThemeV2.darkTextSecondary
                                : AppThemeV2.lightTextSecondary,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
