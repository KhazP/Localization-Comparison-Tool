import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/data/models/ai_suggestion_result.dart';

/// The action a user takes when reviewing an AI suggestion.
enum AiSuggestionAction {
  /// Apply the suggestion.
  accept,

  /// Skip the suggestion.
  reject,

  /// Stop a bulk review flow.
  stop,
}

/// Result from an AI suggestion review dialog.
class AiSuggestionDecision {
  /// Creates an accepted decision with the chosen text.
  const AiSuggestionDecision.accept(this.text)
      : action = AiSuggestionAction.accept;

  /// Creates a rejected decision.
  const AiSuggestionDecision.reject()
      : action = AiSuggestionAction.reject,
        text = null;

  /// Creates a stop decision for bulk review flows.
  const AiSuggestionDecision.stop()
      : action = AiSuggestionAction.stop,
        text = null;

  /// The selected action.
  final AiSuggestionAction action;

  /// The accepted text, if any.
  final String? text;
}

/// Dialog for reviewing AI-generated suggestions before applying them.
///
/// Supports both translation suggestions and rephrase results.
class AiSuggestionDialog extends StatefulWidget {
  const AiSuggestionDialog({
    super.key,
    required this.keyName,
    required this.originalText,
    required this.suggestedText,
    this.providerName,
    this.confidence,
    this.alternatives,
    this.isRephrase = false,
    this.rejectLabel = 'Reject',
    this.showStopButton = false,
    this.stopLabel = 'Stop',
  });

  /// The localization key being edited.
  final String keyName;

  /// The original text (source for translation, current target for rephrase).
  final String originalText;

  /// The AI-suggested text.
  final String suggestedText;

  /// Name of the AI provider.
  final String? providerName;

  /// Confidence score (0.0 to 1.0).
  final double? confidence;

  /// Alternative suggestions.
  final List<String>? alternatives;

  /// Whether this is a rephrase (vs translation) dialog.
  final bool isRephrase;

  /// Label for the reject button.
  final String rejectLabel;

  /// Whether to show a stop button for bulk review.
  final bool showStopButton;

  /// Label for the stop button.
  final String stopLabel;

  /// Shows a dialog for a translation suggestion.
  static Future<AiSuggestionDecision?> showForTranslation(
    BuildContext context, {
    required String keyName,
    required TranslationSuggestion suggestion,
    String rejectLabel = 'Reject',
    bool showStopButton = false,
    String stopLabel = 'Stop',
  }) {
    return showDialog<AiSuggestionDecision>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AiSuggestionDialog(
        keyName: keyName,
        originalText: suggestion.originalText,
        suggestedText: suggestion.translatedText,
        providerName: suggestion.providerName,
        confidence: suggestion.confidence,
        alternatives: suggestion.alternatives,
        isRephrase: false,
        rejectLabel: rejectLabel,
        showStopButton: showStopButton,
        stopLabel: stopLabel,
      ),
    );
  }

  /// Shows a dialog for a rephrase result.
  static Future<AiSuggestionDecision?> showForRephrase(
    BuildContext context, {
    required String keyName,
    required RephraseResult result,
    String rejectLabel = 'Reject',
    bool showStopButton = false,
    String stopLabel = 'Stop',
  }) {
    return showDialog<AiSuggestionDecision>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AiSuggestionDialog(
        keyName: keyName,
        originalText: result.originalText,
        suggestedText: result.rephrasedText,
        providerName: result.providerName,
        alternatives: result.alternatives,
        isRephrase: true,
        rejectLabel: rejectLabel,
        showStopButton: showStopButton,
        stopLabel: stopLabel,
      ),
    );
  }

  @override
  State<AiSuggestionDialog> createState() => _AiSuggestionDialogState();
}

class _AiSuggestionDialogState extends State<AiSuggestionDialog> {
  late TextEditingController _editController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.suggestedText);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Reset to suggested if canceling edit
        _editController.text = widget.suggestedText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            widget.isRephrase ? LucideIcons.wand2 : LucideIcons.sparkles,
            color: widget.isRephrase ? Colors.orange : Colors.purple,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isRephrase ? 'AI Rephrase' : 'AI Translation',
                  style: theme.textTheme.titleLarge,
                ),
                Text(
                  widget.keyName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (widget.providerName != null)
            Chip(
              label: Text(widget.providerName!),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
            ),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Original text
            Text(
              'Original:',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.hintColor,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                widget.originalText,
                style: const TextStyle(fontFamily: 'RobotoMono', fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),

            // Suggestion
            Row(
              children: [
                Text(
                  'Suggestion:',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
                const Spacer(),
                if (widget.confidence != null)
                  Tooltip(
                    message: 'AI Confidence',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.gauge,
                          size: 14,
                          color: _getConfidenceColor(widget.confidence!),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${(widget.confidence! * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: _getConfidenceColor(widget.confidence!),
                          ),
                        ),
                      ],
                    ),
                  ),
                IconButton(
                  icon: Icon(
                    _isEditing ? LucideIcons.x : LucideIcons.pencil,
                    size: 16,
                  ),
                  tooltip: _isEditing ? 'Cancel edit' : 'Edit suggestion',
                  onPressed: _toggleEdit,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: _isEditing
                  ? TextField(
                      controller: _editController,
                      maxLines: null,
                      autofocus: true,
                      style: const TextStyle(
                          fontFamily: 'RobotoMono', fontSize: 13),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    )
                  : SelectableText(
                      widget.suggestedText,
                      style: const TextStyle(
                          fontFamily: 'RobotoMono', fontSize: 13),
                    ),
            ),

            // Alternatives
            if (widget.alternatives != null &&
                widget.alternatives!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Alternatives:',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 8),
              ...widget.alternatives!.map((alt) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () => setState(() {
                        _editController.text = alt;
                        _isEditing = true;
                      }),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          alt,
                          style: const TextStyle(
                              fontFamily: 'RobotoMono', fontSize: 12),
                        ),
                      ),
                    ),
                  )),
            ],
          ],
        ),
      ),
      actions: [
        if (widget.showStopButton)
          TextButton(
            onPressed: () => Navigator.of(context).pop(
              const AiSuggestionDecision.stop(),
            ),
            child: Text(widget.stopLabel),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(
            const AiSuggestionDecision.reject(),
          ),
          child: Text(widget.rejectLabel),
        ),
        FilledButton.icon(
          onPressed: () {
            final result =
                _isEditing ? _editController.text : widget.suggestedText;
            Navigator.of(context).pop(AiSuggestionDecision.accept(result));
          },
          icon: const Icon(LucideIcons.check, size: 16),
          label: const Text('Accept'),
        ),
      ],
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.5) return Colors.orange;
    return Colors.red;
  }
}
