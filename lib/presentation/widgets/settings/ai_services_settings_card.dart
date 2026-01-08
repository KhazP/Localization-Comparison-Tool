import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/data/services/api_key_validation_service.dart';
import 'package:localizer_app_main/data/services/translation_memory_service.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/presentation/widgets/settings/setting_override_indicator.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/services/dialog_service.dart';
import 'dart:developer' as developer;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:localizer_app_main/presentation/widgets/settings/global_translation_memory_card.dart';

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
  late final Map<ApiProvider, TextEditingController> _apiKeyControllers;
  late final Map<ApiProvider, FocusNode> _apiKeyFocusNodes;

  @override
  void initState() {
    super.initState();
    _apiKeyControllers = {
      ApiProvider.gemini:
          TextEditingController(text: widget.settings.geminiApiKey),
      ApiProvider.openAi:
          TextEditingController(text: widget.settings.openaiApiKey),
      ApiProvider.googleTranslate:
          TextEditingController(text: widget.settings.googleTranslateApiKey),
      ApiProvider.deepl:
          TextEditingController(text: widget.settings.deeplApiKey),
    };
    _apiKeyFocusNodes = {
      ApiProvider.gemini: FocusNode(),
      ApiProvider.openAi: FocusNode(),
      ApiProvider.googleTranslate: FocusNode(),
      ApiProvider.deepl: FocusNode(),
    };
  }

  @override
  void didUpdateWidget(covariant AiServicesSettingsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncApiKeyController(
      ApiProvider.gemini,
      widget.settings.geminiApiKey,
    );
    _syncApiKeyController(
      ApiProvider.openAi,
      widget.settings.openaiApiKey,
    );
    _syncApiKeyController(
      ApiProvider.googleTranslate,
      widget.settings.googleTranslateApiKey,
    );
    _syncApiKeyController(
      ApiProvider.deepl,
      widget.settings.deeplApiKey,
    );
  }

  @override
  void dispose() {
    for (final controller in _apiKeyControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _apiKeyFocusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _syncApiKeyController(ApiProvider provider, String value) {
    final controller = _apiKeyControllers[provider];
    final focusNode = _apiKeyFocusNodes[provider];
    if (controller == null || focusNode == null) return;
    if (focusNode.hasFocus) return;
    if (controller.text != value) {
      controller.text = value;
    }
  }

  // TM logic moved to GlobalTranslationMemoryCard

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SettingsCardContainer(
          title: context.t.settings.ai.translationStrategy,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
          children: [
            SettingsRow(
              label: context.t.settings.ai.strategy,
              description: context.t.settings.ai.strategyDescription,
              control: SettingsDropdown<String>(
                value: widget.settings.translationStrategy,
                items: const ['Generative AI (LLM)', 'Cloud Translation'],
                onChanged: (val) {
                  if (val != null) bloc.add(UpdateTranslationStrategy(val));
                },
                isDark: widget.isDark,
                isAmoled: widget.isAmoled,
                itemLabelBuilder: (val) {
                  if (val == 'Generative AI (LLM)') {
                    return context.t.settings.ai.strategyLLM;
                  }
                  if (val == 'Cloud Translation') {
                    return context.t.settings.ai.strategyCloud;
                  }
                  return val;
                },
              ),
              isDark: widget.isDark,
              isAmoled: widget.isAmoled,
            ),
            SettingsRow(
              label: context.t.settings.ai.enableAiTranslation,
              description: context.t.settings.ai.enableAiTranslationDescription,
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
            title: context.t.settings.ai.llmProvider,
            isDark: widget.isDark,
            isAmoled: widget.isAmoled,
            trailing: _buildSectionResetButton(context, bloc),
            children: [
              _buildOverridableSettingsRow(
                context: context,
                bloc: bloc,
                label: context.t.settings.ai.service,
                description: context.t.settings.ai.serviceDescription,
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
                  itemLabelBuilder: (val) {
                    if (val == 'Google Gemini')
                      return context.t.settings.ai.providerGemini;
                    if (val == 'OpenAI')
                      return context.t.settings.ai.providerOpenAI;
                    return val;
                  },
                ),
              ),
              if (widget.settings.aiTranslationService == 'Google Gemini')
                _buildApiKeyField(
                  context,
                  context.t.settings.ai.geminiApiKey,
                  ApiProvider.gemini,
                  _apiKeyControllers[ApiProvider.gemini]!,
                  _apiKeyFocusNodes[ApiProvider.gemini]!,
                  (val) => bloc.add(UpdateGeminiApiKey(val)),
                ),
              if (widget.settings.aiTranslationService == 'OpenAI')
                _buildApiKeyField(
                  context,
                  context.t.settings.ai.openAiApiKey,
                  ApiProvider.openAi,
                  _apiKeyControllers[ApiProvider.openAi]!,
                  _apiKeyFocusNodes[ApiProvider.openAi]!,
                  (val) => bloc.add(UpdateOpenAiApiKey(val)),
                ),
              _buildOverridableSettingsRow(
                context: context,
                bloc: bloc,
                label: context.t.settings.ai.model,
                description: context.t.settings.ai.modelDescription,
                settingKey: 'defaultAiModel',
                showDivider: false,
                control: SettingsDropdown<String>(
                  value: widget.state.isProjectScope
                      ? widget.state.getEffectiveDefaultAiModel()
                      : widget.settings.defaultAiModel,
                  items: widget.state.availableModels[
                          widget.settings.aiTranslationService ==
                                  'Google Gemini'
                              ? ApiProvider.gemini
                              : ApiProvider.openAi] ??
                      (widget.settings.aiTranslationService == 'Google Gemini'
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
            title: context.t.settings.ai.advancedParameters,
            isDark: widget.isDark,
            isAmoled: widget.isAmoled,
            children: [
              ListTile(
                title: Text(context.t.settings.ai.parameters),
                subtitle: Text(context.t.settings.ai.parametersDescription),
                trailing: IconButton(
                  icon: Icon(_showAdvancedParameters
                      ? LucideIcons.chevronUp
                      : LucideIcons.chevronDown),
                  onPressed: () => setState(
                      () => _showAdvancedParameters = !_showAdvancedParameters),
                ),
              ),
              if (_showAdvancedParameters) ...[
                SettingsRow(
                  label: context.t.settings.ai.temperature,
                  description: context.t.settings.ai.temperatureDescription,
                  control: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.settings.aiTemperature.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Slider(
                          value: widget.settings.aiTemperature,
                          min: 0.0,
                          max: 2.0,
                          divisions: 20,
                          onChanged: (val) =>
                              bloc.add(UpdateAiTemperature(val)),
                        ),
                      ),
                    ],
                  ),
                  isDark: widget.isDark,
                  isAmoled: widget.isAmoled,
                ),
                SettingsRow(
                  label: context.t.settings.ai.maxTokens,
                  description: context.t.settings.ai.maxTokensDescription,
                  control: SizedBox(
                    width: 150,
                    child: SettingsDropdown<int>(
                      value: widget.settings.maxTokens,
                      items: const [512, 1024, 2048, 4096, 8192, 16384, 32768],
                      onChanged: (val) {
                        if (val != null) bloc.add(UpdateMaxTokens(val));
                      },
                      isDark: widget.isDark,
                      isAmoled: widget.isAmoled,
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
                                context.t.settings.ai.systemContext,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(width: 8),
                              SettingOverrideIndicator(
                                isOverridden: widget.state
                                    .isOverridden('systemTranslationContext'),
                                onReset: widget.state.isOverridden(
                                        'systemTranslationContext')
                                    ? () => bloc.add(const ResetSettingToGlobal(
                                        'systemTranslationContext'))
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
                              ? widget.state
                                  .getEffectiveSystemTranslationContext()
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
                          labelText: widget.state.isProjectScope
                              ? null
                              : context.t.settings.ai.systemContext,
                          hintText: context.t.settings.ai.systemContextHint,
                          helperText: context.t.settings.ai.systemContextHelper,
                          helperMaxLines: 2,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SettingsRow(
                        label: context.t.settings.ai.contextStrings,
                        description:
                            context.t.settings.ai.contextStringsDescription,
                        control: Switch(
                          value: widget.settings.includeContextStrings,
                          onChanged: (val) =>
                              bloc.add(UpdateIncludeContextStrings(val)),
                        ),
                        isDark: widget.isDark,
                        isAmoled: widget.isAmoled,
                        showDivider: false,
                      ),
                      if (widget.settings.includeContextStrings)
                        SettingsRow(
                          label: context.t.settings.ai.contextCount,
                          description:
                              context.t.settings.ai.contextCountDescription,
                          control: SettingsDropdown<int>(
                            value: widget.settings.contextStringsCount,
                            items: const [1, 2, 3, 5, 10],
                            onChanged: (val) {
                              if (val != null)
                                bloc.add(UpdateContextStringsCount(val));
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
            title: context.t.settings.ai.cloudServices,
            isDark: widget.isDark,
            isAmoled: widget.isAmoled,
            children: [
              _buildApiKeyField(
                context,
                context.t.settings.ai.googleTranslateApiKey,
                ApiProvider.googleTranslate,
                _apiKeyControllers[ApiProvider.googleTranslate]!,
                _apiKeyFocusNodes[ApiProvider.googleTranslate]!,
                (val) => bloc.add(UpdateGoogleTranslateApiKey(val)),
              ),
              _buildApiKeyField(
                context,
                context.t.settings.ai.deeplApiKey,
                ApiProvider.deepl,
                _apiKeyControllers[ApiProvider.deepl]!,
                _apiKeyFocusNodes[ApiProvider.deepl]!,
                (val) => bloc.add(UpdateDeeplApiKey(val)),
                showDivider: false,
              ),
            ],
          ),
        ],
        GlobalTranslationMemoryCard(
          settings: widget.settings,
          translationMemoryService: widget.translationMemoryService,
          translationMemoryStatsFuture: widget.translationMemoryStatsFuture,
          onRefreshStats: widget.onRefreshStats,
          isDark: widget.isDark,
          isAmoled: widget.isAmoled,
        ),
      ],
    );
  }

  Widget _buildApiKeyField(
    BuildContext context,
    String label,
    ApiProvider provider,
    TextEditingController controller,
    FocusNode focusNode,
    ValueChanged<String> onChanged, {
    bool showDivider = true,
  }) {
    final testResult =
        widget.state.apiKeyTests[provider] ?? ApiKeyTestResult.idle;
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
                    Text(label,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onChanged: onChanged,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: context.t.settings.ai.apiKeyPlaceholder,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
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
                    onPressed: isTesting
                        ? null
                        : () {
                            final value = controller.text;
                            context.read<SettingsBloc>().add(
                                TestApiKey(provider: provider, apiKey: value));
                          },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: isTesting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white))
                        : Text(context.t.settings.ai.test),
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
                  testResult.status == ApiKeyTestStatus.success
                      ? LucideIcons.checkCircle
                      : LucideIcons.alertCircle,
                  size: 16,
                  color: testResult.status == ApiKeyTestStatus.success
                      ? Colors.green
                      : Colors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    testResult.message +
                        (testResult.usage != null
                            ? ' (${testResult.usage})'
                            : ''),
                    style: TextStyle(
                      fontSize: 12,
                      color: testResult.status == ApiKeyTestStatus.success
                          ? Colors.green
                          : Colors.red,
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
            color: widget.isAmoled
                ? AppThemeV2.amoledBorder
                : (widget.isDark
                    ? AppThemeV2.darkBorder
                    : AppThemeV2.lightBorder),
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
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppThemeV2.darkTextMuted)),
        const SizedBox(height: 4),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
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
      message: context.t.settings.ai.resetToGlobal,
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
