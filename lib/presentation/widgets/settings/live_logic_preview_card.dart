import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

class LiveLogicPreviewCard extends StatefulWidget {
  final AppSettings settings;
  final bool isDark;
  final bool isAmoled;

  const LiveLogicPreviewCard({
    super.key,
    required this.settings,
    required this.isDark,
    required this.isAmoled,
  });

  @override
  State<LiveLogicPreviewCard> createState() => _LiveLogicPreviewCardState();
}

enum MatchStatus { identical, similar, ignored, different }

class _LiveLogicPreviewCardState extends State<LiveLogicPreviewCard> {
  final TextEditingController _controllerA =
      TextEditingController(text: 'Example Key');
  final TextEditingController _controllerB =
      TextEditingController(text: 'example key');

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        SettingsThemeHelper(isDark: widget.isDark, isAmoled: widget.isAmoled);
    final result = _calculateResult();

    return SettingsCardContainer(
      title: context.t.settings.comparison.previewMatch.title,
      isDark: widget.isDark,
      isAmoled: widget.isAmoled,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.settings.comparison.previewMatch.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: theme.textMutedColor,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildInput(
                        context,
                        context.t.settings.comparison.previewMatch.stringA,
                        _controllerA,
                        theme),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildInput(
                        context,
                        context.t.settings.comparison.previewMatch.stringB,
                        _controllerB,
                        theme),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildResultCard(context, result, theme),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInput(
    BuildContext context,
    String label,
    TextEditingController controller,
    SettingsThemeHelper theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: theme.textSecondaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: (_) => setState(() {}),
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            isDense: true,
            hintText: context.t.settings.comparison.previewMatch.enterText,
            hintStyle: TextStyle(color: theme.textMutedColor),
            filled: true,
            fillColor: theme.surfaceColor.withValues(alpha: 0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: theme.borderColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultCard(
    BuildContext context,
    _MatchResult result,
    SettingsThemeHelper theme,
  ) {
    final statusColor = _getStatusColor(result.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getStatusIcon(result.status),
              color: statusColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.statusLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  result.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: theme.textSecondaryColor,
                      ),
                ),
              ],
            ),
          ),
          if (result.similarity >= 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${(result.similarity * 100).toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                ),
                Text(
                  context.t.settings.comparison.previewMatch.similarity,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: theme.textMutedColor,
                      ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  _MatchResult _calculateResult() {
    final rawA = _controllerA.text;
    final rawB = _controllerB.text;

    // 1. Check Ignore Patterns (Treating inputs as Keys for this check)
    final ignorePatterns = widget.settings.ignorePatterns;
    if (_matchesPattern(rawA, ignorePatterns) ||
        _matchesPattern(rawB, ignorePatterns)) {
      return _MatchResult(
        status: MatchStatus.ignored,
        statusLabel: context.t.settings.comparison.previewMatch.ignored,
        description:
            context.t.settings.comparison.previewMatch.ignoredDescription,
        similarity: -1,
      );
    }

    // 2. Normalize (Values logic)
    var valA = rawA;
    var valB = rawB;

    if (widget.settings.ignoreWhitespace) {
      valA = valA.trim().replaceAll(RegExp(r'\s+'), ' ');
      valB = valB.trim().replaceAll(RegExp(r'\s+'), ' ');
    }

    if (widget.settings.ignoreCase) {
      valA = valA.toLowerCase();
      valB = valB.toLowerCase();
    }

    // 3. Compare
    if (valA == valB) {
      return _MatchResult(
        status: MatchStatus.identical,
        statusLabel: context.t.settings.comparison.previewMatch.identical,
        description:
            context.t.settings.comparison.previewMatch.identicalDescription,
        similarity: 1.0,
      );
    }

    if (valA.isEmpty || valB.isEmpty) {
      return _MatchResult(
        status: MatchStatus.different,
        statusLabel: context.t.settings.comparison.previewMatch.different,
        description:
            context.t.settings.comparison.previewMatch.differentDescription,
        similarity: 0.0,
      );
    }

    final similarity = valA.similarityTo(valB);
    final threshold = widget.settings.similarityThreshold;

    if (similarity >= threshold) {
      return _MatchResult(
        status: MatchStatus.similar,
        statusLabel: context.t.settings.comparison.previewMatch.similarModified,
        description: context.t.settings.comparison.previewMatch
            .similarModifiedDescription(threshold: (threshold * 100).round()),
        similarity: similarity,
      );
    } else {
      return _MatchResult(
        status: MatchStatus.different,
        statusLabel: context.t.settings.comparison.previewMatch.newDifferent,
        description: context.t.settings.comparison.previewMatch
            .newDifferentDescription(threshold: (threshold * 100).round()),
        similarity: similarity,
      );
    }
  }

  bool _matchesPattern(String input, List<String> patterns) {
    for (final pattern in patterns) {
      try {
        if (RegExp(pattern).hasMatch(input)) return true;
      } catch (_) {
        // Ignore invalid patterns
      }
    }
    return false;
  }

  Color _getStatusColor(MatchStatus status) {
    switch (status) {
      case MatchStatus.identical:
        return AppThemeV2.success;
      case MatchStatus.similar:
        return AppThemeV2.warning; // Orange/Yellow
      case MatchStatus.ignored:
        return Colors.grey;
      case MatchStatus.different:
        return AppThemeV2.error; // Or a distinct color for "Diff"
    }
  }

  IconData _getStatusIcon(MatchStatus status) {
    switch (status) {
      case MatchStatus.identical:
        return Icons.check_circle_rounded;
      case MatchStatus.similar:
        return Icons.change_circle_rounded;
      case MatchStatus.ignored:
        return Icons.visibility_off_rounded;
      case MatchStatus.different:
        return Icons.cancel_rounded;
    }
  }
}

class _MatchResult {
  final MatchStatus status;
  final String statusLabel;
  final String description;
  final double similarity;

  _MatchResult({
    required this.status,
    required this.statusLabel,
    required this.description,
    required this.similarity,
  });
}
