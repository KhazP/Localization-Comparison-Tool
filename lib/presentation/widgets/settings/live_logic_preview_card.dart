import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/settings/settings_shared.dart';
import 'package:localizer_app_main/data/models/app_settings.dart';

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
      title: 'Preview Match',
      isDark: widget.isDark,
      isAmoled: widget.isAmoled,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Test how your current settings affect matching logic.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: theme.textMutedColor,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child:
                        _buildInput(context, 'String A', _controllerA, theme),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child:
                        _buildInput(context, 'String B', _controllerB, theme),
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
            hintText: 'Enter text...',
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
                  result.status,
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
                  'Similarity',
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
        status: 'Ignored',
        description: 'Input matches an ignore pattern.',
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
        status: 'Identical',
        description: 'Strings match exactly after normalization.',
        similarity: 1.0,
      );
    }

    if (valA.isEmpty || valB.isEmpty) {
      // If one is empty and other isn't (since we checked equality above), it's New/Removed
      // For this preview, let's just say "Different" or "New"
      return _MatchResult(
        status: 'Different',
        description: 'One value is empty.',
        similarity: 0.0,
      );
    }

    final similarity = valA.similarityTo(valB);
    final threshold = widget.settings.similarityThreshold;

    if (similarity >= threshold) {
      return _MatchResult(
        status: 'Similar / Modified',
        description:
            'Match score is above threshold (${(threshold * 100).round()}%).',
        similarity: similarity,
      );
    } else {
      return _MatchResult(
        status: 'New / Different',
        description:
            'Match score is below threshold (${(threshold * 100).round()}%).',
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Identical':
        return AppThemeV2.success;
      case 'Similar / Modified':
        return AppThemeV2.warning; // Orange/Yellow
      case 'Ignored':
        return Colors.grey;
      case 'New / Different':
        return AppThemeV2.error; // Or a distinct color for "Diff"
      default:
        return Theme.of(context).primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Identical':
        return Icons.check_circle_rounded;
      case 'Similar / Modified':
        return Icons.change_circle_rounded;
      case 'Ignored':
        return Icons.visibility_off_rounded;
      case 'New / Different':
        return Icons.cancel_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}

class _MatchResult {
  final String status;
  final String description;
  final double similarity;

  _MatchResult({
    required this.status,
    required this.description,
    required this.similarity,
  });
}
