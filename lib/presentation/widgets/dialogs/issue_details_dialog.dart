import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
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
    ToastService.showSuccess(
      context, 
      'Copied to clipboard',
      duration: const Duration(seconds: 1),
    );
  }

  void _copyAll(BuildContext context) {
    final text = items.map(_formatIssue).join('\n\n');
    Clipboard.setData(ClipboardData(text: text));
    ToastService.showSuccess(context, 'All items copied');
  }

  String _formatIssue(QualityIssue issue) {
    if (issue.type == QualityIssueType.duplicateValue &&
        issue.relatedKeys != null &&
        issue.relatedKeys!.isNotEmpty) {
      final keys = issue.relatedKeys!.join(', ');
      final buffer = StringBuffer()
        ..writeln('Value: ${issue.targetValue}')
        ..writeln('Found in ${issue.relatedKeys!.length} keys:')
        ..writeln(keys)
        ..writeln('Note: Same translation is used for different keys.');
      return buffer.toString().trim();
    }

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
    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    );
    final monoStyle = theme.textTheme.bodySmall?.copyWith(
      fontFamily: 'RobotoMono',
      color: theme.colorScheme.onSurface,
    );
    final bodyStyle = theme.textTheme.bodyMedium;

    Widget content;

    if (issue.type == QualityIssueType.duplicateValue) {
      content = _buildDuplicateContent(context, labelStyle, monoStyle);
    } else if (issue.type == QualityIssueType.lengthOutlier) {
      content = _buildLengthOutlierContent(context, labelStyle, bodyStyle);
    } else {
      content = _buildStandardContent(context, labelStyle, monoStyle, bodyStyle);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildIssueIcon(context),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _issueTitle(issue.type),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _ReviewBadge(),
              const SizedBox(width: 8),
              IconButton(
                onPressed: onCopy,
                icon: const Icon(Icons.copy_rounded, size: 16),
                tooltip: 'Copy details',
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const Divider(height: 24),
          content,
          if (issue.type != QualityIssueType.duplicateValue) ...[
            const SizedBox(height: 16),
            _LabeledField(
              label: 'NOTE',
              value: _noteForIssue(issue.type),
              labelStyle: labelStyle,
              valueStyle: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDuplicateContent(
    BuildContext context,
    TextStyle? labelStyle,
    TextStyle? monoStyle,
  ) {
    final theme = Theme.of(context);
    final relatedKeys = issue.relatedKeys ?? [issue.key];
    // Show top 20 keys max to keep UI sane
    final displayKeys = relatedKeys.take(20).toList();
    final remaining = relatedKeys.length - displayKeys.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabeledField(
          label: 'REPEATED TRANSLATION',
          value: issue.targetValue ?? '',
          labelStyle: labelStyle,
          valueStyle: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'USED IN ${relatedKeys.length} KEYS',
          style: labelStyle,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            ...displayKeys.map((k) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    k,
                    style: monoStyle?.copyWith(fontSize: 11),
                  ),
                )),
            if (remaining > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '+$remaining more',
                  style: monoStyle?.copyWith(
                    fontSize: 11,
                    color: theme.colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLengthOutlierContent(
    BuildContext context,
    TextStyle? labelStyle,
    TextStyle? bodyStyle,
  ) {
    final sourceLen = issue.sourceValue?.length ?? 0;
    final targetLen = issue.targetValue?.length ?? 0;
    final maxLen = (sourceLen > targetLen ? sourceLen : targetLen).toDouble();
    // avoid divide by zero
    final safeMax = maxLen == 0 ? 1.0 : maxLen;

    // Calculate severity for color
    // Rules: > 40% diff = Critical (Red), > 30% = Warning (Orange)
    // Microcopy (<=2 words): > 100% diff (2x) = Critical
    
    Color barColor = Theme.of(context).colorScheme.primary;
    
    if (issue.sourceValue != null && sourceLen > 0) {
      final diffPercent = ((targetLen - sourceLen).abs() / sourceLen) * 100;
      final wordCount = issue.sourceValue!.split(RegExp(r'\s+')).length;
      
      if (wordCount <= 2) {
        // Microcopy rule
        if (targetLen > sourceLen * 2) {
           barColor = Theme.of(context).colorScheme.error; // Critical > 2x
        } else if (diffPercent > 40) {
           barColor = Colors.orange;
        }
      } else {
        // Standard rule
        if (diffPercent > 40) {
          barColor = Theme.of(context).colorScheme.error;
        } else if (diffPercent > 30) {
          barColor = Colors.orange;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _LengthBar(
                label: 'SOURCE',
                text: issue.sourceValue,
                length: sourceLen,
                fraction: sourceLen / safeMax,
                color: Theme.of(context).colorScheme.outline,
                labelStyle: labelStyle,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _LengthBar(
                label: 'TRANSLATION',
                text: issue.targetValue,
                length: targetLen,
                fraction: targetLen / safeMax,
                color: barColor,
                labelStyle: labelStyle,
                isHighlight: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: barColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: barColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: barColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  issue.description,
                  style: bodyStyle?.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStandardContent(
    BuildContext context,
    TextStyle? labelStyle,
    TextStyle? monoStyle,
    TextStyle? bodyStyle,
  ) {
    final sourceText = _displayValue(
      issue.sourceValue,
      _sourceFallback(issue.type),
    );
    final targetText = _displayValue(
      issue.targetValue,
      _targetFallback(issue.type),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabeledField(
          label: 'KEY',
          value: issue.key,
          labelStyle: labelStyle,
          valueStyle: monoStyle,
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _LabeledField(
                label: 'SOURCE TEXT',
                value: sourceText,
                labelStyle: labelStyle,
                valueStyle: bodyStyle,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _LabeledField(
                label: 'TRANSLATION',
                value: targetText,
                labelStyle: labelStyle,
                valueStyle: bodyStyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _LabeledField(
          label: 'ERROR DETAILS',
          value: issue.description,
          labelStyle: labelStyle,
          valueStyle: bodyStyle?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ],
    );
  }

  Widget _buildIssueIcon(BuildContext context) {
    IconData icon;
    Color color;

    switch (issue.type) {
      case QualityIssueType.duplicateValue:
        icon = Icons.copy_all_rounded;
        color = Colors.orange;
        break;
      case QualityIssueType.lengthOutlier:
        icon = Icons.straighten_rounded;
        color = Colors.purple;
        break;
      case QualityIssueType.placeholderMismatch:
        icon = Icons.data_object_rounded;
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }

  String _issueTitle(QualityIssueType type) {
    switch (type) {
      case QualityIssueType.duplicateValue:
        return 'Duplicate Values';
      case QualityIssueType.lengthOutlier:
        return 'Length Mismatch';
      case QualityIssueType.placeholderMismatch:
        return 'Broken Placeholders';
    }
  }
}

class _ReviewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 12,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 4),
          Text(
            'Review',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _LengthBar extends StatelessWidget {
  const _LengthBar({
    required this.label,
    required this.text,
    required this.length,
    required this.fraction,
    required this.color,
    required this.labelStyle,
    this.isHighlight = false,
  });

  final String label;
  final String? text;
  final int length;
  final double fraction;
  final Color color;
  final TextStyle? labelStyle;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final safeText = text ?? '';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: labelStyle),
            Text(
              '$length chars',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isHighlight ? color : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            FractionallySizedBox(
              widthFactor: fraction.clamp(0.01, 1.0),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          safeText,
          style: theme.textTheme.bodySmall?.copyWith(
            fontFamily: 'RobotoMono',
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
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
