import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/'
    'advanced_diff_controller.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/data/services/translation_service.dart';
import 'package:localizer_app_main/presentation/utils/ai_error_mapper.dart';
import 'package:localizer_app_main/presentation/widgets/dialogs/'
    'ai_suggestion_dialog.dart';
import 'package:localizer_app_main/presentation/views/settings_view.dart';

enum _AiBulkAction {
  reviewEach,
  translateAll,
}

/// Common language codes for localization.
const _commonLanguages = <String, String>{
  'en': 'English',
  'tr': 'Turkish',
  'de': 'German',
  'fr': 'French',
  'es': 'Spanish',
  'it': 'Italian',
  'pt': 'Portuguese',
  'ru': 'Russian',
  'zh': 'Chinese',
  'ja': 'Japanese',
  'ko': 'Korean',
  'ar': 'Arabic',
  'hi': 'Hindi',
  'nl': 'Dutch',
  'pl': 'Polish',
  'sv': 'Swedish',
  'da': 'Danish',
  'no': 'Norwegian',
  'fi': 'Finnish',
  'cs': 'Czech',
  'el': 'Greek',
  'he': 'Hebrew',
  'th': 'Thai',
  'vi': 'Vietnamese',
  'id': 'Indonesian',
  'ms': 'Malay',
  'uk': 'Ukrainian',
  'ro': 'Romanian',
  'hu': 'Hungarian',
  'bg': 'Bulgarian',
  'hr': 'Croatian',
  'sk': 'Slovak',
  'sl': 'Slovenian',
  'et': 'Estonian',
  'lv': 'Latvian',
  'lt': 'Lithuanian',
};

/// AI Translation sidebar section for the Advanced Diff view.
///
/// Provides:
/// - Source/target language selectors
/// - Translate All Missing button with progress
class AiSection extends StatelessWidget {
  const AiSection({super.key, required this.isCloudTranslation});

  final bool isCloudTranslation;

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, child) {
        final infoLabel = isCloudTranslation
            ? 'Uses cloud translation to translate empty target values '
                'from source.'
            : 'Uses AI to translate empty target values from source.';
        final settingsLabel =
            isCloudTranslation ? 'Translation Settings' : 'AI Settings';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Language Selectors
            LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 260;
                if (isNarrow) {
                  return Column(
                    children: [
                      _LanguageDropdown(
                        label: 'Source',
                        value: controller.sourceLang,
                        onChanged: controller.setSourceLang,
                      ),
                      const SizedBox(height: 8),
                      const Icon(LucideIcons.arrowDown, size: 16),
                      const SizedBox(height: 8),
                      _LanguageDropdown(
                        label: 'Target',
                        value: controller.targetLang,
                        onChanged: controller.setTargetLang,
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _LanguageDropdown(
                        label: 'Source',
                        value: controller.sourceLang,
                        onChanged: controller.setSourceLang,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(LucideIcons.arrowRight, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _LanguageDropdown(
                        label: 'Target',
                        value: controller.targetLang,
                        onChanged: controller.setTargetLang,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),

            // Progress indicator
            if (controller.isAiProcessing) ...[
              LinearProgressIndicator(value: controller.aiProgress),
              const SizedBox(height: 8),
              Text(
                'Translating... ${(controller.aiProgress * 100).toInt()}%',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],

            // Translate All Missing button
            ElevatedButton.icon(
              onPressed: controller.isAiProcessing
                  ? null
                  : () => _translateAllMissing(context, controller),
              icon: Icon(
                LucideIcons.sparkles,
                color: controller.isAiProcessing ? null : Colors.white,
                size: 18,
              ),
              label: Text(
                controller.isAiProcessing
                    ? 'Translating...'
                    : 'Translate All Missing',
                style: TextStyle(
                  color: controller.isAiProcessing ? null : Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[700],
                disabledBackgroundColor: Colors.purple[200],
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: () => _openAiSettings(context),
              icon: const Icon(LucideIcons.settings, size: 18),
              label: Text(settingsLabel),
            ),

            const SizedBox(height: 8),

            // Info text
            Text(
              infoLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  Future<void> _translateAllMissing(
    BuildContext context,
    AdvancedDiffController controller,
  ) async {
    final sourceLabel =
        _commonLanguages[controller.sourceLang] ?? controller.sourceLang;
    final targetLabel =
        _commonLanguages[controller.targetLang] ?? controller.targetLang;
    final action = await showDialog<_AiBulkAction>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(LucideIcons.sparkles, color: Colors.purple),
            SizedBox(width: 12),
            Text('Translate All Missing?'),
          ],
        ),
        content: Text(
          'This will use ${isCloudTranslation ? 'cloud translation' : 'AI'} '
          'to translate all entries with empty target values from '
          '$sourceLabel to $targetLabel.\n\n'
          'You can review each suggestion or apply all at once.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('Cancel'),
          ),
          OutlinedButton(
            onPressed: () =>
                Navigator.of(context).pop(_AiBulkAction.translateAll),
            child: const Text('Translate All'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(context).pop(_AiBulkAction.reviewEach),
            child: const Text('Review Each'),
          ),
        ],
      ),
    );

    if (action == null || !context.mounted) return;

    if (action == _AiBulkAction.reviewEach) {
      await _reviewMissingTranslations(context, controller);
      return;
    }

    try {
      final count = await controller.translateAllMissing();
      if (context.mounted) {
        ToastService.showSuccess(
          context,
          isCloudTranslation
              ? 'Translated $count entries with cloud translation.'
              : 'Translated $count entries with AI.',
        );
      }
    } catch (e, stackTrace) {
      sl<TalkerService>().handle(
        e,
        stackTrace,
        'AI translate all failed',
      );
      if (context.mounted) {
        ToastService.showError(
          context,
          aiUserMessageForError(e),
        );
      }
    }
  }

  Future<void> _reviewMissingTranslations(
    BuildContext context,
    AdvancedDiffController controller,
  ) async {
    final missingKeys = controller.getMissingKeys();
    if (missingKeys.isEmpty) {
      ToastService.showInfo(context, 'No missing entries to translate.');
      return;
    }

    controller.startAiProcessing();
    int appliedCount = 0;

    try {
      for (int i = 0; i < missingKeys.length; i++) {
        final key = missingKeys[i];

        try {
          final suggestion = await controller.suggestTranslation(key);
          if (!context.mounted) break;

          final decision = await AiSuggestionDialog.showForTranslation(
            context,
            keyName: key,
            suggestion: suggestion,
            titleOverride:
                isCloudTranslation ? 'Cloud Translation' : 'AI Translation',
            rejectLabel: 'Skip',
            showStopButton: true,
            stopLabel: 'Stop',
          );

          if (!context.mounted || decision == null) break;
          if (decision.action == AiSuggestionAction.stop) break;
          if (decision.action == AiSuggestionAction.accept &&
              decision.text != null) {
            controller.applyAiSuggestion(key, decision.text!);
            appliedCount++;
          }
        } catch (e, stackTrace) {
          sl<TalkerService>().handle(
            e,
            stackTrace,
            'AI review failed for "$key"',
          );
          if (context.mounted) {
            ToastService.showError(
              context,
              aiUserMessageForError(e),
            );
          }
          if (e is MissingApiKeyException) break;
        } finally {
          final progress = (i + 1) / missingKeys.length;
          controller.updateAiProgress(progress);
        }
      }
    } finally {
      controller.stopAiProcessing();
    }

    if (context.mounted && appliedCount > 0) {
      ToastService.showSuccess(
        context,
        isCloudTranslation
            ? 'Applied $appliedCount suggestions.'
            : 'Applied $appliedCount AI suggestions.',
      );
    }
  }

  Future<void> _openAiSettings(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SettingsView(
          initialCategory: SettingsCategory.aiServices,
          showBackButton: true,
        ),
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: _commonLanguages.containsKey(value) ? value : null,
          isExpanded: true,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          items: _commonLanguages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(
                entry.value,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ],
    );
  }
}
