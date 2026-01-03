import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/languages/json.dart';
import 'package:highlight/languages/xml.dart';
import 'package:highlight/languages/yaml.dart';
import 'package:highlight/languages/ini.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/talker_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/presentation/utils/ai_error_mapper.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/'
    'advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/widgets/dialogs/'
    'ai_suggestion_dialog.dart';

class DetailEditDialog extends StatefulWidget {
  final String keyName;
  final String sourceValue;
  final String targetValue;
  final String? fileExtension;
  final Function(String) onSave;

  const DetailEditDialog({
    super.key,
    required this.keyName,
    required this.sourceValue,
    required this.targetValue,
    required this.onSave,
    this.fileExtension,
  });

  @override
  State<DetailEditDialog> createState() => _DetailEditDialogState();
}

class _DetailEditDialogState extends State<DetailEditDialog> {
  late CodeController _sourceController;
  late CodeController _targetController;
  late Map<String, TextStyle> _theme;
  bool _isAiLoading = false;

  @override
  void initState() {
    super.initState();
    // Will be updated in didChangeDependencies, but keep a safe default here.
    _theme = _getTheme();

    final language = _getLanguageMode();

    _sourceController = CodeController(
      text: widget.sourceValue,
      language: language,
    );

    _targetController = CodeController(
      text: widget.targetValue,
      language: language,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update theme based on brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    _theme = isDark ? atomOneDarkTheme : atomOneLightTheme;
    // We shouldn't update controller theme dynamically without recreating.
    // CodeField takes a theme separately? No, CodeField takes a theme map.
    // Wait, CodeField uses styles from theme if not provided?
    // In code_text_field 2.x/3.x:
    // CodeField(controller: controller, textStyle: ..., padding: ...)
    // Actually CodeTheme wraps CodeField usually?
    // Let's check constructor of CodeField.
    // It has `style` or similar.
    // The theme is usually passed to CodeTheme widget that wraps CodeField,
    // or CodeField allows passing a theme map.
    // Actually, common usage:
    // CodeTheme(
    //   data: CodeThemeData(styles: themeMap),
    //   child: CodeField(controller: controller),
    // )
    // OR
    // CodeField has no internal theme logic, it relies on RichText.
    // But syntax highlighting needs styles.
    // Provide styles to CodeField?
    // "CodeField(controller: controller)" uses simple styles.
    // "CodeTheme" is the way.
  }

  @override
  void dispose() {
    _sourceController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  Future<void> _handleAiTranslate() async {
    if (_isAiLoading) return;
    if (widget.sourceValue.trim().isEmpty) {
      ToastService.showInfo(context, 'No source text to translate.');
      return;
    }

    setState(() => _isAiLoading = true);

    try {
      final controller = context.read<AdvancedDiffController>();
      final suggestion = await controller.suggestTranslation(widget.keyName);
      if (!mounted) return;

      final decision = await AiSuggestionDialog.showForTranslation(
        context,
        keyName: widget.keyName,
        suggestion: suggestion,
      );

      if (!mounted || decision == null) return;
      if (decision.action == AiSuggestionAction.accept &&
          decision.text != null) {
        _targetController.text = decision.text!;
        ToastService.showSuccess(context, 'AI suggestion added.');
      }
    } catch (e, stackTrace) {
      sl<TalkerService>().handle(
        e,
        stackTrace,
        'AI dialog translate failed for "${widget.keyName}"',
      );
      if (mounted) {
        ToastService.showError(context, aiUserMessageForError(e));
      }
    } finally {
      if (mounted) {
        setState(() => _isAiLoading = false);
      }
    }
  }

  dynamic _getLanguageMode() {
    final ext = widget.fileExtension?.toLowerCase() ?? '';
    if (ext.endsWith('json') || ext.endsWith('arb')) return json;
    if (ext.endsWith('xml') || ext.endsWith('resx')) return xml;
    if (ext.endsWith('yaml') || ext.endsWith('yml')) return yaml;
    if (ext.endsWith('properties') || ext.endsWith('ini')) return ini;
    return null; // Plain text
  }

  Map<String, TextStyle> _getTheme() {
    // Default fallback
    return atomOneLightTheme;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final codeTheme = isDark ? atomOneDarkTheme : atomOneLightTheme;

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.edit, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Edit: ${widget.keyName}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 700,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Source (Read-only)
            Row(
              children: [
                Text(
                  'SOURCE (Original)',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.disabledColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _getKeyLanguageName(),
                  style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic, color: theme.disabledColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.dividerColor),
                  borderRadius: BorderRadius.circular(8),
                  color: isDark
                      ? const Color(0xFF1E1E1E)
                      : const Color(0xFFFAFAFA),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CodeTheme(
                    data: CodeThemeData(styles: codeTheme),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CodeField(
                        controller: _sourceController,
                        readOnly: true,
                        textStyle: const TextStyle(
                            fontFamily: 'RobotoMono', fontSize: 13),
                        lineNumberStyle: const LineNumberStyle(
                          width: 48,
                          margin: 8,
                        ),
                        wrap: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Target (Editable)
            Text(
              'TARGET (Translation)',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 180,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8),
                  color: isDark
                      ? const Color(0xFF1E1E1E)
                      : const Color(0xFFFAFAFA),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CodeTheme(
                    data: CodeThemeData(styles: codeTheme),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: CodeField(
                        controller: _targetController,
                        textStyle: const TextStyle(
                            fontFamily: 'RobotoMono', fontSize: 13),
                        lineNumberStyle: const LineNumberStyle(
                          width: 48,
                          margin: 8,
                        ),
                        wrap: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        OutlinedButton.icon(
          onPressed: _isAiLoading ? null : _handleAiTranslate,
          icon: const Icon(LucideIcons.sparkles, size: 16),
          label: Text(
            _isAiLoading ? 'Translating...' : 'Translate with AI',
          ),
        ),
        FilledButton.icon(
          onPressed: () {
            widget.onSave(_targetController.text);
            Navigator.of(context).pop();
            ToastService.showSuccess(context, 'Saved & Added to TM');
          },
          icon: const Icon(Icons.save),
          label: const Text('Save Changes'),
        ),
      ],
    );
  }

  String _getKeyLanguageName() {
    final ext = widget.fileExtension?.toLowerCase() ?? '';
    if (ext.endsWith('json') || ext.endsWith('arb')) return 'JSON';
    if (ext.endsWith('xml') || ext.endsWith('resx')) return 'XML';
    if (ext.endsWith('yaml') || ext.endsWith('yml')) return 'YAML';
    if (ext.endsWith('properties') || ext.endsWith('ini')) return 'PROPERTIES';
    return 'PLAIN TEXT';
  }
}
