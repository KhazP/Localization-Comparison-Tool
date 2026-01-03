import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';

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
              label: '${stats['total']} total',
              color: Colors.blueGrey.withValues(alpha: 0.2),
              textColor: Colors.blueGrey,
            ),
            _StatusBadge(
              label: '${stats['added']} extra',
              color: Colors.green.withValues(alpha: 0.2),
              textColor: Colors.green,
            ),
            _StatusBadge(
              label: '${stats['removed']} missing',
              color: Colors.red.withValues(alpha: 0.2),
              textColor: Colors.red,
            ),
            _StatusBadge(
              label: '${stats['modified']} changed',
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
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
