import 'package:flutter/material.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';

class ComparisonResultDialog extends StatelessWidget {
  final ComparisonResult result;

  const ComparisonResultDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // Collect all entries and sort them by key for better readability
    final entries = result.diff.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return AlertDialog(
      title: const Text('Comparison Details'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Key')),
                      DataColumn(label: Text('Source')),
                      DataColumn(label: Text('Target')),
                      DataColumn(label: Text('Status')),
                    ],
                    rows: entries.map((entry) {
                      final key = entry.key;
                      final detail = entry.value;
                      final sourceValue = result.file1Data[key] ?? '';
                      final targetValue = result.file2Data[key] ?? '';

                      return DataRow(cells: [
                        DataCell(_buildSyntaxHighlightedKey(context, key)),
                        DataCell(Text(sourceValue)),
                        DataCell(Text(targetValue)),
                        DataCell(_buildStatusCell(context, detail)),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
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

  Widget _buildSyntaxHighlightedKey(BuildContext context, String key) {
    final parts = key.split('.');
    if (parts.length < 2) {
      return Text(key, style: const TextStyle(fontWeight: FontWeight.bold));
    }

    final path = parts.sublist(0, parts.length - 1).join('.') + '.';
    final item = parts.last;

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: path,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          TextSpan(
            text: item,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCell(BuildContext context, ComparisonStatusDetail detail) {
    Color color;
    String text;

    switch (detail.status) {
      case StringComparisonStatus.added:
        color = Colors.green;
        text = 'Added';
        break;
      case StringComparisonStatus.removed:
        color = Colors.red;
        text = 'Removed';
        break;
      case StringComparisonStatus.modified:
        color = Colors.orange;
        text = 'Modified';
        break;
      case StringComparisonStatus.identical:
        color = Colors.grey;
        text = 'Identical';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
