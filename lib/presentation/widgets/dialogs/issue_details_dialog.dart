import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';

/// Shows detailed quality issues in a dialog.
class IssueDetailsDialog extends StatelessWidget {
  const IssueDetailsDialog({
    super.key,
    required this.title,
    required this.description,
    required this.items,
  });

  final String title;
  final String description;
  final List<QualityIssue> items;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(
                    alpha: 0.7,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (items.isEmpty)
                const Center(child: Text('No details available.'))
              else
                Flexible(
                  child: ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _IssueCard(
                        issue: item,
                        onCopy: () => _copyIssue(context, item),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _copyAll(context),
                    child: const Text('Copy All'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyIssue(BuildContext context, QualityIssue issue) {
    Clipboard.setData(ClipboardData(text: _formatIssue(issue)));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _copyAll(BuildContext context) {
    final text = items.map(_formatIssue).join('\n\n');
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All items copied')),
    );
  }

  String _formatIssue(QualityIssue issue) {
    final sourceText = _displayValue(
      issue.sourceValue,
      _sourceFallback(issue.type),
    );
    final targetText = _displayValue(
      issue.targetValue,
      _targetFallback(issue.type),
    );
    final buffer = StringBuffer()
      ..writeln('Key: ${issue.key}')
      ..writeln('Source: $sourceText')
      ..writeln('Translation: $targetText')
      ..writeln('Specific Error: ${issue.description}')
      ..writeln('User Review Required: Yes')
      ..writeln('Note: ${_noteForIssue(issue.type)}');
    return buffer.toString().trim();
  }
}

class _IssueCard extends StatelessWidget {
  const _IssueCard({
    required this.issue,
    required this.onCopy,
  });

  final QualityIssue issue;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      fontWeight: FontWeight.w600,
    );
    final monoStyle = theme.textTheme.bodyMedium?.copyWith(
      fontFamily: 'RobotoMono',
      fontSize: 13,
    );
    final bodyStyle = theme.textTheme.bodyMedium;

    final sourceText = _displayValue(
      issue.sourceValue,
      _sourceFallback(issue.type),
    );
    final targetText = _displayValue(
      issue.targetValue,
      _targetFallback(issue.type),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _LabeledField(
                  label: 'Key',
                  value: issue.key,
                  labelStyle: labelStyle,
                  valueStyle: monoStyle,
                ),
              ),
              IconButton(
                onPressed: onCopy,
                icon: const Icon(Icons.copy, size: 18),
                tooltip: 'Copy',
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 520) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: 'Source Text',
                        value: sourceText,
                        labelStyle: labelStyle,
                        valueStyle: monoStyle ?? bodyStyle,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _LabeledField(
                        label: 'Translation',
                        value: targetText,
                        labelStyle: labelStyle,
                        valueStyle: monoStyle ?? bodyStyle,
                      ),
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LabeledField(
                    label: 'Source Text',
                    value: sourceText,
                    labelStyle: labelStyle,
                    valueStyle: monoStyle ?? bodyStyle,
                  ),
                  const SizedBox(height: 8),
                  _LabeledField(
                    label: 'Translation',
                    value: targetText,
                    labelStyle: labelStyle,
                    valueStyle: monoStyle ?? bodyStyle,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          _LabeledField(
            label: 'Specific Error',
            value: issue.description,
            labelStyle: labelStyle,
            valueStyle: bodyStyle,
          ),
          const SizedBox(height: 8),
          _LabeledField(
            label: 'User Review Required',
            value: 'Yes',
            labelStyle: labelStyle,
            valueStyle: bodyStyle,
          ),
          const SizedBox(height: 8),
          _LabeledField(
            label: 'Note',
            value: _noteForIssue(issue.type),
            labelStyle: labelStyle,
            valueStyle: bodyStyle,
          ),
        ],
      ),
    );
  }

}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 4),
        Text(value, style: valueStyle),
      ],
    );
  }
}

String _displayValue(String? value, String fallback) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return fallback;
  }
  return trimmed;
}

String _sourceFallback(QualityIssueType type) {
  if (type == QualityIssueType.duplicateValue) {
    return 'Multiple source texts';
  }
  return 'Source text not available';
}

String _targetFallback(QualityIssueType type) {
  if (type == QualityIssueType.duplicateValue) {
    return 'Shared translation not available';
  }
  return 'Translation not available';
}

String _noteForIssue(QualityIssueType type) {
  switch (type) {
    case QualityIssueType.placeholderMismatch:
      return 'Markers like {name} should match the source.';
    case QualityIssueType.lengthOutlier:
      return 'Big length changes can affect how text fits on screen.';
    case QualityIssueType.duplicateValue:
      return 'Same translation is used for different keys.';
  }
}
