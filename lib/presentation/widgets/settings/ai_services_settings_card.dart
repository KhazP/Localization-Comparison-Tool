import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/presentation/widgets/settings/setting_override_indicator.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'dart:developer' as developer;
import 'package:lucide_icons/lucide_icons.dart';

class AiServicesSettingsCard extends StatefulWidget {
  final AppSettings settings;
  final SettingsState state;
  final TranslationMemoryService? translationMemoryService;
  final Future<TranslationMemoryStats>? translationMemoryStatsFuture;
  final VoidCallback onRefreshStats;
  final bool isDark;
  final bool isAmoled;

  const AiServicesSettingsCard({
    super.key,
    required this.settings,
    required this.state,
    this.translationMemoryService,
    this.translationMemoryStatsFuture,
    required this.onRefreshStats,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  State<AiServicesSettingsCard> createState() => _AiServicesSettingsCardState();
}

class _AiServicesSettingsCardState extends State<AiServicesSettingsCard> {
  bool _translationMemoryBusy = false;
  bool _showAdvancedParameters = false;

  String _formatMemorySize(int bytes) {
    if (bytes <= 0) return '0 KB';
    final kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    final mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }

  Future<void> _runTranslationMemoryAction(Future<void> Function() action) async {
    if (_translationMemoryBusy) return;
    setState(() => _translationMemoryBusy = true);
    try {
      await action();
    } finally {
      if (mounted) {
        setState(() => _translationMemoryBusy = false);
      }
    }
  }

  Future<void> _importTranslationMemory(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    await _runTranslationMemoryAction(() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['tmx', 'csv'],
      );
      if (result == null || result.files.single.path == null) return;
      final file = File(result.files.single.path!);
      final imported = await service.importFromFile(file);
      widget.onRefreshStats();
      if (!mounted) return;
      final message = imported > 0
          ? 'Imported $imported items into memory.'
          : 'No items were added.';
      ToastService.showInfo(context, message);
    });
  }

  Future<void> _exportTranslationMemoryTmx(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    await _runTranslationMemoryAction(() async {
      final stats = await service.getStats();
      if (stats.entryCount == 0) {
        if (mounted) ToastService.showWarning(context, 'Nothing to export yet.');
        return;
      }
      final outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Export TMX',
        fileName: 'translation_memory.tmx',
        type: FileType.custom,
        allowedExtensions: ['tmx'],
      );
      if (outputPath == null) return;
      await service.exportToTmx(File(outputPath));
      if (mounted) ToastService.showSuccess(context, 'TMX saved.');
    });
  }

  Future<void> _exportTranslationMemoryCsv(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    await _runTranslationMemoryAction(() async {
      final stats = await service.getStats();
      if (stats.entryCount == 0) {
        if (mounted) ToastService.showWarning(context, 'Nothing to export yet.');
        return;
      }
      final outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Export CSV',
        fileName: 'translation_memory.csv',
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );
      if (outputPath == null) return;
      await service.exportToCsv(File(outputPath));
      if (mounted) ToastService.showSuccess(context, 'CSV saved.');
    });
  }

  Future<void> _confirmClearTranslationMemory(BuildContext context) async {
    final service = widget.translationMemoryService;
    if (service == null) return;
    final confirm = await DialogService.showConfirmation(
      context: context,
      title: 'Clear translation memory?',
      content: 'This removes all saved translation pairs on this device. This action cannot be undone.',
      confirmText: 'Clear Memory',
      isDestructive: true,
      icon: LucideIcons.trash2,
    );

    if (confirm != true) return;

    await _runTranslationMemoryAction(() async {
      try {
        await service.clearMemory();
        widget.onRefreshStats();
        if (mounted) ToastService.showSuccess(context, 'Translation memory cleared.');
      } catch (e, s) {
        developer.log('Failed to clear translation memory.', name: 'translation_memory.clear', error: e, stackTrace: s);
        if (mounted) ToastService.showError(context, 'Could not clear memory.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SettingsCardContainer(
          title: 'Translation Strategy',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: 'Strategy',
              description: 'Select how you want to translate strings',
              control: SettingsDropdown<String>(
                value: widget.settings.translationStrategy,
                items: const ['Generative AI (LLM)', 'Cloud Translation'],
                onChanged: (val) {
                  if (val != null) bloc.add(UpdateTranslationStrategy(val));
                },
                isDark: widget.isDark,
                isAmoled: widget.isAmoled,
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            SettingsRow(
              label: 'Enable AI Translation',
              description: 'Allow the app to use AI for translation suggestions',
              control: Switch(
                value: widget.settings.enableAiTranslation,
                onChanged: (val) => bloc.add(UpdateEnableAiTranslation(val)),
                activeColor: colorScheme.primary,
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
              showDivider: false,
            ),
          ],
        ),

        if (widget.settings.translationStrategy == 'Generative AI (LLM)') ...[
          SettingsCardContainer(
            title: 'LLM Service Provider',
            isDark: widget.isDark,
            isAmoled: widget.isAmoled,
            trailing: _buildSectionResetButton(context, bloc),
            children: [
              _buildOverridableSettingsRow(
                context: context,
                bloc: bloc,
                label: 'Service',
                description: 'Provider for Generative AI',
                settingKey: 'aiTranslationService',
                control: SettingsDropdown<String>(
                  value: widget.state.isProjectScope
                      ? widget.state.getEffectiveAiTranslationService()
                      : widget.settings.aiTranslationService,
                  items: const ['Google Gemini', 'OpenAI'],
                  onChanged: (val) {
                    if (val != null) {
                      if (widget.state.isProjectScope) {
                        bloc.add(UpdateProjectOverridableSetting(
                          settingKey: 'aiTranslationService',
                          value: val,
                        ));
                      } else {
                        bloc.add(UpdateAiTranslationService(val));
                      }
                    }
                  },
                  isDark: widget.isDark,
                  isAmoled: widget.isAmoled,
                ),
              ),
              if (widget.settings.aiTranslationService == 'Google Gemini')
                _buildApiKeyField(
                  context,
                  'Gemini API Key',
                  widget.settings.geminiApiKey,
                  ApiProvider.gemini,
                  (val) => bloc.add(UpdateGeminiApiKey(val)),
                ),
              if (widget.settings.aiTranslationService == 'OpenAI')
                _buildApiKeyField(
                  context,
                  'OpenAI API Key',
                  widget.settings.openaiApiKey,
                  ApiProvider.openAi,
                  (val) => bloc.add(UpdateOpenAiApiKey(val)),
                ),
              _buildOverridableSettingsRow(
                context: context,
                bloc: bloc,
                label: 'Model',
                description: 'Select which model to use',
                settingKey: 'defaultAiModel',
                showDivider: false,
                control: SettingsDropdown<String>(
                  value: widget.state.isProjectScope
                      ? widget.state.getEffectiveDefaultAiModel()
                      : widget.settings.defaultAiModel,
                  items: widget.state.availableModels[widget.settings.aiTranslationService == 'Google Gemini' 
                      ? ApiProvider.gemini 
                      : ApiProvider.openAi] ?? (widget.settings.aiTranslationService == 'Google Gemini'
                          ? const ['gemini-1.5-flash', 'gemini-1.5-pro']
                          : const ['gpt-4o', 'gpt-4o-mini']),
                  onChanged: (val) {
                    if (val != null) {
                      if (widget.state.isProjectScope) {
                        bloc.add(UpdateProjectOverridableSetting(
                          settingKey: 'defaultAiModel',
                          value: val,
                        ));
                      } else {
                        bloc.add(UpdateDefaultAiModel(val));
                      }
                    }
                  },
                  isDark: widget.isDark,
                  isAmoled: widget.isAmoled,
                ),
              ),
            ],
          ),

          SettingsCardContainer(
            title: 'Advanced Parameters',
            isDark: widget.isDark,
            isAmoled: widget.isAmoled,
            children: [
              ListTile(
               title: const Text('Parameters'),
               subtitle: const Text('Temperature, Context, and more'),
               trailing: IconButton(
                 icon: Icon(_showAdvancedParameters ? LucideIcons.chevronUp : LucideIcons.chevronDown),
                 onPressed: () => setState(() => _showAdvancedParameters = !_showAdvancedParameters),
               ),
              ),
              if (_showAdvancedParameters) ...[
                SettingsRow(
                  label: 'Temperature',
                  description: 'Higher values make output more creative (${widget.settings.aiTemperature.toStringAsFixed(1)})',
                  control: SizedBox(
                    width: 200,
                    child: Slider(
                      value: widget.settings.aiTemperature,
                      min: 0.0,
                      max: 2.0,
                      divisions: 20,
                      onChanged: (val) => bloc.add(UpdateAiTemperature(val)),
                    ),
                  ),
                  isDark: widget.isDark,
                  isAmoled: widget.isAmoled,
                ),
                SettingsRow(
                  label: 'Max Tokens',
                  description: 'Limit context window length',
                  control: SizedBox(
                    width: 150,
                    child: SettingsDropdown<int>(
                      value: widget.settings.maxTokens,
                      items: const [512, 1024, 2048, 4096, 8192],
                      onChanged: (val) {
                        if (val != null) bloc.add(UpdateMaxTokens(val));
                      },
                    ),
                  ),
                  isDark: widget.isDark,
                  isAmoled: widget.isAmoled,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label with override indicator for System Context
                      if (widget.state.isProjectScope)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                'System Context / Instructions',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              SettingOverrideIndicator(
                                isOverridden: widget.state.isOverridden('systemTranslationContext'),
                                onReset: widget.state.isOverridden('systemTranslationContext')
                                    ? () => bloc.add(const ResetSettingToGlobal('systemTranslationContext'))
                                    : null,
                                compact: true,
                              ),
                            ],
                          ),
                        ),
                      TextField(
                        maxLines: 4,
                        controller: TextEditingController(
                          text: widget.state.isProjectScope
                              ? widget.state.getEffectiveSystemTranslationContext()
                              : widget.settings.systemTranslationContext,
                        ),
                        onChanged: (val) {
                          if (widget.state.isProjectScope) {
                            bloc.add(UpdateProjectOverridableSetting(
                              settingKey: 'systemTranslationContext',
                              value: val,
                            ));
                          } else {
                            bloc.add(UpdateSystemTranslationContext(val));
                          }
                        },
                        decoration: InputDecoration(
                          labelText: widget.state.isProjectScope ? null : 'System Context / Instructions',
                          hintText: 'You are a professional localizer. Maintain the tone and intent of the source string...',
                          helperText: 'Provide specific instructions to the AI about your project\'s style and terminology.',
                          helperMaxLines: 2,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SettingsRow(
                        label: 'Context Strings',
                        description: 'Include surrounding strings for better context',
                        control: Switch(
                          value: widget.settings.includeContextStrings,
                          onChanged: (val) => bloc.add(UpdateIncludeContextStrings(val)),
                        ),
                        isDark: widget.isDark,
                        isAmoled: widget.isAmoled,
                        showDivider: false,
                      ),
                      if (widget.settings.includeContextStrings)
                        SettingsRow(
                          label: 'Context Count',
                          description: 'Number of surrounding strings to include',
                          control: SettingsDropdown<int>(
                            value: widget.settings.contextStringsCount,
                            items: const [1, 2, 3, 5, 10],
                            onChanged: (val) {
                              if (val != null) bloc.add(UpdateContextStringsCount(val));
                            },
                            isDark: widget.isDark,
                            isAmoled: widget.isAmoled,
                          ),
                          isDark: widget.isDark,
                          isAmoled: widget.isAmoled,
                          showDivider: false,
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ] else ...[
          SettingsCardContainer(
            title: 'Cloud Translation Services',
            isDark: widget.isDark,
            isAmoled: widget.isAmoled,
            children: [
              _buildApiKeyField(
                context,
                'Google Translate API Key',
                widget.settings.googleTranslateApiKey,
                ApiProvider.googleTranslate,
                (val) => bloc.add(UpdateGoogleTranslateApiKey(val)),
              ),
              _buildApiKeyField(
                context,
                'DeepL API Key',
                widget.settings.deeplApiKey,
                ApiProvider.deepl,
                (val) => bloc.add(UpdateDeeplApiKey(val)),
                showDivider: false,
              ),
            ],
          ),
        ],

        SettingsCardContainer(
          title: 'Translation Memory',
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: 'Auto-learn',
              description: 'Save translations to local memory for future reuse',
              control: Switch(
                value: widget.settings.enableTranslationMemory,
                onChanged: (val) => bloc.add(UpdateEnableTranslationMemory(val)),
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            SettingsRow(
              label: 'Confidence Threshold',
              description: 'Minimum score to auto-apply (${(widget.settings.translationConfidenceThreshold * 100).toInt()}%)',
              control: SizedBox(
                width: 150,
                child: Slider(
                  value: widget.settings.translationConfidenceThreshold,
                  onChanged: (val) => bloc.add(UpdateTranslationConfidenceThreshold(val)),
                ),
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            FutureBuilder<TranslationMemoryStats>(
              future: widget.translationMemoryStatsFuture,
              builder: (context, snapshot) {
                final stats = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _buildStatItem('Entries', stats?.entryCount.toString() ?? '...', context),
                          const SizedBox(width: 24),
                          _buildStatItem('Size', stats != null ? 'Memory Size: ${_formatMemorySize(stats.storageBytes)}' : '...', context),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          FilledButton.icon(
                            onPressed: _translationMemoryBusy ? null : () => _importTranslationMemory(context),
                            icon: const Icon(LucideIcons.download, size: 18),
                            label: const Text('Import'),
                          ),
                          OutlinedButton.icon(
                            onPressed: _translationMemoryBusy ? null : () => _exportTranslationMemoryTmx(context),
                            icon: const Icon(LucideIcons.upload, size: 18),
                            label: const Text('Export TMX'),
                          ),
                          OutlinedButton.icon(
                            onPressed: _translationMemoryBusy ? null : () => _exportTranslationMemoryCsv(context),
                            icon: const Icon(LucideIcons.table, size: 18),
                            label: const Text('Export CSV'),
                          ),
                          OutlinedButton.icon(
                            onPressed: _translationMemoryBusy ? null : () => _confirmClearTranslationMemory(context),
                            icon: Icon(LucideIcons.trash2, size: 18, color: AppThemeV2.error),
                            label: Text('Clear Memory', style: TextStyle(color: AppThemeV2.error)),
                            style: OutlinedButton.styleFrom(side: BorderSide(color: AppThemeV2.error.withValues(alpha: 0.5))),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApiKeyField(
    BuildContext context,
    String label,
    String value,
    ApiProvider provider,
    ValueChanged<String> onChanged, {
    bool showDivider = true,
  }) {
    final testResult = widget.state.apiKeyTests[provider] ?? const ApiKeyTestResult.idle();
    final isTesting = testResult.status == ApiKeyTestStatus.testing;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: TextEditingController(text: value),
                      onChanged: onChanged,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter API Key',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 26),
                child: SizedBox(
                  height: 40,
                  child: FilledButton(
                    onPressed: isTesting ? null : () {
                      context.read<SettingsBloc>().add(TestApiKey(provider: provider, apiKey: value));
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: isTesting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Test'),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (testResult.status != ApiKeyTestStatus.idle)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                Icon(
                  testResult.status == ApiKeyTestStatus.success ? LucideIcons.checkCircle : LucideIcons.alertCircle,
                  size: 16,
                  color: testResult.status == ApiKeyTestStatus.success ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    testResult.message + (testResult.usage != null ? ' (${testResult.usage})' : ''),
                    style: TextStyle(
                      fontSize: 12,
                      color: testResult.status == ApiKeyTestStatus.success ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          const SizedBox(height: 12),
        if (showDivider)
          Divider(
            color: widget.isAmoled ? AppThemeV2.amoledBorder : (widget.isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppThemeV2.darkTextMuted)),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// Builds a settings row that shows an override indicator when in project scope.
  Widget _buildOverridableSettingsRow({
    required BuildContext context,
    required SettingsBloc bloc,
    required String label,
    required String description,
    required String settingKey,
    required Widget control,
    bool showDivider = true,
  }) {
    final isProjectScope = widget.state.isProjectScope;
    final isOverridden = widget.state.isOverridden(settingKey);

    return SettingsRow(
      label: label,
      description: description,
      control: control,
      isDark: widget.isDark,
      isAmoled: widget.isAmoled,
      showDivider: showDivider,
      trailing: isProjectScope
          ? SettingOverrideIndicator(
              isOverridden: isOverridden,
              onReset: isOverridden
                  ? () => bloc.add(ResetSettingToGlobal(settingKey))
                  : null,
              compact: true,
            )
          : null,
    );
  }

  /// Builds a reset button for the section that appears when in project scope
  /// and there are any overrides in the AI Services category.
  Widget? _buildSectionResetButton(BuildContext context, SettingsBloc bloc) {
    if (!widget.state.isProjectScope) return null;
    
    final hasAnyOverrides = widget.state.projectSettings?.hasOverrides ?? false;
    if (!hasAnyOverrides) return null;

    return Tooltip(
      message: 'Reset all AI settings to global defaults',
      child: IconButton(
        icon: Icon(
          LucideIcons.refreshCcw,
          size: 18,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        onPressed: () {
          bloc.add(const ResetCategoryToGlobal('aiServices'));
        },
      ),
    );
  }
}
