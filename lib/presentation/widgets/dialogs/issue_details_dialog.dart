import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';

/// Shows detailed quality issues in a dialog.
/// Shows detailed quality issues in a dialog.
class IssueDetailsDialog extends StatefulWidget {
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
  State<IssueDetailsDialog> createState() => _IssueDetailsDialogState();
}

class _IssueDetailsDialogState extends State<IssueDetailsDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<QualityIssue> _filteredItems = [];
  int _displayLimit = 20;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredItems = widget.items.where((issue) {
          return issue.key.toLowerCase().contains(lowerQuery) ||
              (issue.sourceValue?.toLowerCase().contains(lowerQuery) ??
                  false) ||
              (issue.targetValue?.toLowerCase().contains(lowerQuery) ??
                  false) ||
              issue.description.toLowerCase().contains(lowerQuery);
        }).toList();
      }
      _displayLimit = 20; // Reset limit on search
    });
  }

  void _showMore() {
    setState(() {
      _displayLimit += 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleItems = _filteredItems.take(_displayLimit).toList();
    final hasMore = _displayLimit < _filteredItems.length;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Showing ${visibleItems.length} of ${_filteredItems.length} issues',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search by key, text, or error...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),
              if (visibleItems.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      _searchController.text.isEmpty
                          ? 'No details available.'
                          : 'No matches found.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: visibleItems.length + (hasMore ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      if (index == visibleItems.length) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: _showMore,
                              child: const Text('Show More'),
                            ),
                          ),
                        );
                      }
                      final item = visibleItems[index];
                      return _IssueCard(
                        issue: item,
                        onCopy: () => _copyIssue(context, item),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _copyAll(context),
                    icon: const Icon(Icons.copy_all),
                    label: Text('Copy ${_filteredItems.length} Items'),
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
    if (_filteredItems.isEmpty) return;
    final text = _filteredItems.map(_formatIssue).join('\n\n');
    Clipboard.setData(ClipboardData(text: text));
    ToastService.showSuccess(context, 'Copied ${_filteredItems.length} items');
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
      content =
          _buildStandardContent(context, labelStyle, monoStyle, bodyStyle);
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
    final relatedSources = issue.relatedSources ?? {};

    // Check if distinct source texts exist
    final distinctSources = relatedSources.values.toSet();
    final hasContextMismatch = distinctSources.length > 1;

    // Show top 10 keys
    final displayKeys = relatedKeys.take(10).toList();
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
        if (hasContextMismatch)
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    size: 16, color: Colors.orange),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Different source texts use this same translation. Check context.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'AFFECTED KEYS (${relatedKeys.length})',
              style: labelStyle,
            ),
            if (!hasContextMismatch && relatedSources.isNotEmpty)
              Text(
                'Identical Sources',
                style: labelStyle?.copyWith(color: theme.colorScheme.primary),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              ...displayKeys.map((k) {
                final source = relatedSources[k];
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: theme.dividerColor.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        k,
                        style: monoStyle?.copyWith(
                            fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      if (source != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          '"$source"',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                );
              }),
              if (remaining > 0)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  child: Center(
                    child: Text(
                      '+$remaining more keys',
                      style: monoStyle?.copyWith(
                        fontSize: 11,
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
            ],
          ),
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
          valueStyle:
              bodyStyle?.copyWith(color: Theme.of(context).colorScheme.error),
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
