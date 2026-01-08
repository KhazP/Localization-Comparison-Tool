import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';

class StatusSection extends StatelessWidget {
  const StatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, child) {
        final stats = controller.stats;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _StatusBadge(
              label: context.t.advancedDiff.sidebar.statusSection
                  .total(count: stats['total'] ?? 0),
              color: Colors.blueGrey.withValues(alpha: 0.2),
              textColor: Colors.blueGrey,
            ),
            _StatusBadge(
              label: context.t.advancedDiff.sidebar.statusSection
                  .extra(count: stats['added'] ?? 0),
              color: Colors.green.withValues(alpha: 0.2),
              textColor: Colors.green,
            ),
            _StatusBadge(
              label: context.t.advancedDiff.sidebar.statusSection
                  .missing(count: stats['removed'] ?? 0),
              color: Colors.red.withValues(alpha: 0.2),
              textColor: Colors.red,
            ),
            _StatusBadge(
              label: context.t.advancedDiff.sidebar.statusSection
                  .changed(count: stats['modified'] ?? 0),
              color: Colors.amber.withValues(alpha: 0.2),
              textColor: Colors.amber[800]!,
            ),
          ],
        );
      },
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _StatusBadge({
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: textColor, width: 3),
        ),
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor.withValues(alpha: 0.8),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
