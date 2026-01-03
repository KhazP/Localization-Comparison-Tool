import 'package:flutter/material.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

class ComparisonResultDialog extends StatelessWidget {
  final ComparisonResult result;

  const ComparisonResultDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final addedKeys = result.diff.entries
        .where((entry) => entry.value.status == StringComparisonStatus.added)
        .map((entry) => entry.key)
        .toList();

    final removedKeys = result.diff.entries
        .where((entry) => entry.value.status == StringComparisonStatus.removed)
        .map((entry) => entry.key)
        .toList();

    final modifiedKeys = result.diff.entries
        .where((entry) => entry.value.status == StringComparisonStatus.modified)
        .map((entry) => entry.key)
        .toList();

    return AlertDialog(
      title: const Text('Comparison Details'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildKeyList(context, 'Added Keys', addedKeys, Colors.green),
              _buildKeyList(context, 'Removed Keys', removedKeys, Colors.red),
              _buildKeyList(
                  context, 'Modified Keys', modifiedKeys, Colors.orange),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildKeyList(
      BuildContext context, String title, List<String> keys, Color color) {
    if (keys.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: color)),
          const Divider(),
          ...keys.map((key) => Text(key)).toList(),
        ],
      ),
    );
  }
}
