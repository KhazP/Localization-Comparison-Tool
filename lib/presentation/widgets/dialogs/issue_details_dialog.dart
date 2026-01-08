import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

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
                          context.t.issueDetails.showingIssues(
                              count: visibleItems.length,
                              total: _filteredItems.length),
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
                  hintText: context.t.issueDetails.searchPlaceholder,
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
                          ? context.t.issueDetails.noDetails
                          : context.t.issueDetails.noMatches,
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
                              child: Text(context.t.issueDetails.showMore),
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
                    label: Text(context.t.issueDetails
                        .copyItems(count: _filteredItems.length)),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(context.t.issueDetails.close),
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
    Clipboard.setData(ClipboardData(text: _formatIssue(context, issue)));
    ToastService.showSuccess(
      context,
      context.t.issueDetails.copied,
      duration: const Duration(seconds: 1),
    );
  }

  void _copyAll(BuildContext context) {
    if (_filteredItems.isEmpty) return;
    final text = _filteredItems
        .map((issue) => _formatIssue(context, issue))
        .join('\n\n');
    Clipboard.setData(ClipboardData(text: text));
    ToastService.showSuccess(context,
        context.t.issueDetails.copiedCount(count: _filteredItems.length));
  }

  String _formatIssue(BuildContext context, QualityIssue issue) {
    if (issue.type == QualityIssueType.duplicateValue &&
        issue.relatedKeys != null &&
        issue.relatedKeys!.isNotEmpty) {
      final keys = issue.relatedKeys!.join(', ');
      final buffer = StringBuffer()
        ..writeln('${context.t.fileComparison.value}: ${issue.targetValue}')
        ..writeln(context.t.issueDetails.duplicateValue.affectedKeys(
            count: issue.relatedKeys!.length)) // TODO: Check if message fits
        ..writeln(keys)
        ..writeln(
            '${context.t.issueDetails.standard.note}: ${context.t.issueDetails.notes.duplicateValue}');
      return buffer.toString().trim();
    }

    final sourceText = _displayValue(
      issue.sourceValue,
      _sourceFallback(context, issue.type),
    );
    final targetText = _displayValue(
      issue.targetValue,
      _targetFallback(context, issue.type),
    );
    final buffer = StringBuffer()
      ..writeln('${context.t.diff.key}: ${issue.key}')
      ..writeln('${context.t.issueDetails.standard.sourceText}: $sourceText')
      ..writeln('${context.t.issueDetails.standard.translation}: $targetText')
      ..writeln(
          '${context.t.issueDetails.standard.errorDetails}: ${issue.description}')
      ..writeln(
          '${context.t.issueDetails.standard.note}: ${_noteForIssue(context, issue.type)}');
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
                  _issueTitle(context, issue.type),
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
                tooltip: context.t.common.copyText,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const Divider(height: 24),
          content,
          if (issue.type != QualityIssueType.duplicateValue) ...[
            const SizedBox(height: 16),
            _LabeledField(
              label: context.t.issueDetails.standard.note,
              value: _noteForIssue(context, issue.type),
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
          label: context.t.issueDetails.duplicateValue.label,
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
                    context.t.issueDetails.duplicateValue.warning,
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
              context.t.issueDetails.duplicateValue
                  .affectedKeys(count: relatedKeys.length),
              style: labelStyle,
            ),
            if (!hasContextMismatch && relatedSources.isNotEmpty)
              Text(
                context.t.issueDetails.duplicateValue.identicalSources,
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
                      context.t.issueDetails.duplicateValue
                          .moreKeys(count: remaining),
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
                label: context.t.issueDetails.lengthOutlier.source,
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
                label: context.t.issueDetails.lengthOutlier.translation,
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
      _sourceFallback(context, issue.type),
    );
    final targetText = _displayValue(
      issue.targetValue,
      _targetFallback(context, issue.type),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LabeledField(
          label: context.t.issueDetails.standard.key,
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
                label: context.t.issueDetails.standard.sourceText,
                value: sourceText,
                labelStyle: labelStyle,
                valueStyle: bodyStyle,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _LabeledField(
                label: context.t.issueDetails.standard.translation,
                value: targetText,
                labelStyle: labelStyle,
                valueStyle: bodyStyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _LabeledField(
          label: context.t.issueDetails.standard.errorDetails,
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

  String _issueTitle(BuildContext context, QualityIssueType type) {
    switch (type) {
      case QualityIssueType.duplicateValue:
        return context.t.issueDetails.types.duplicateValue;
      case QualityIssueType.lengthOutlier:
        return context.t.issueDetails.types.lengthOutlier;
      case QualityIssueType.placeholderMismatch:
        return context.t.issueDetails.types.placeholderMismatch;
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
            context.t.issueDetails.review,
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
              context.t.issueDetails.lengthOutlier.chars(count: length),
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

String _sourceFallback(BuildContext context, QualityIssueType type) {
  if (type == QualityIssueType.duplicateValue) {
    return context.t.issueDetails.fallbacks.multipleSources;
  }
  return context.t.issueDetails.fallbacks.sourceNotAvailable;
}

String _targetFallback(BuildContext context, QualityIssueType type) {
  if (type == QualityIssueType.duplicateValue) {
    return context.t.issueDetails.fallbacks.sharedTranslationNotAvailable;
  }
  return context.t.issueDetails.fallbacks.translationNotAvailable;
}

String _noteForIssue(BuildContext context, QualityIssueType type) {
  switch (type) {
    case QualityIssueType.placeholderMismatch:
      return context.t.issueDetails.notes.placeholderMismatch;
    case QualityIssueType.lengthOutlier:
      return context.t.issueDetails.notes.lengthOutlier;
    case QualityIssueType.duplicateValue:
      return context.t.issueDetails.notes.duplicateValue;
  }
}
