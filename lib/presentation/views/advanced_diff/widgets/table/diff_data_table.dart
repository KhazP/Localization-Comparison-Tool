import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/table/diff_row_item.dart';

class DiffDataTable extends StatelessWidget {
  const DiffDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvancedDiffController>(
      builder: (context, controller, _) {
        final entries = controller.processedEntries;
        final totalCount = entries.length;

        // Pagination logic
        final startIndex = controller.currentPage * controller.itemsPerPage;
        // detailed slicing
        int endIndex = startIndex + controller.itemsPerPage;
        if (endIndex > totalCount) endIndex = totalCount;

        final visibleEntries = (startIndex < totalCount)
            ? entries.sublist(startIndex, endIndex)
            : [];

        return Column(
          children: [
            // Header
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                    bottom: BorderSide(color: Theme.of(context).dividerColor)),
              ),
              child: Row(
                children: [
                  const SizedBox(
                      width: 48,
                      child: Center(
                          child: Text('#',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)))),
                  Container(
                      width: 1,
                      height: 24,
                      color: Theme.of(context).dividerColor),
                  const SizedBox(
                      width: 80,
                      child: Center(
                          child: Text('STATUS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)))),
                  Container(
                      width: 1,
                      height: 24,
                      color: Theme.of(context).dividerColor),
                  const Expanded(
                      flex: 2,
                      child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text('STRING KEY',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)))),
                  Container(
                      width: 1,
                      height: 24,
                      color: Theme.of(context).dividerColor),
                  const Expanded(
                      flex: 3,
                      child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text('SOURCE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)))),
                  Container(
                      width: 1,
                      height: 24,
                      color: Theme.of(context).dividerColor),
                  const Expanded(
                      flex: 3,
                      child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text('TARGET (click to edit)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)))),
                  const SizedBox(width: 40), // Actions column spacer
                ],
              ),
            ),
            // List
            Expanded(
              child: visibleEntries.isEmpty
                  ? const Center(child: Text('No entries found'))
                  : ListView.builder(
                      itemCount: visibleEntries.length,
                      itemBuilder: (context, index) {
                        final entry = visibleEntries[index];
                        final globalIndex = startIndex + index;
                        final key = entry.key;

                        final oldVal = controller.getSourceValue(key);
                        final newVal = controller.getTargetValue(key);

                        return DiffRowItem(
                          index: globalIndex,
                          keyName: key,
                          detail: entry.value,
                          oldValue: oldVal,
                          newValue: newVal,
                          isReviewed: controller.reviewedKeys.contains(key),
                          useInlineEditing: controller.useInlineEditing,
                          onEdit: () {
                            _showEditDialog(
                                context, controller, key, oldVal, newVal);
                          },
                          onInlineSave: (newText) {
                            controller.updateEntry(key, newText);
                          },
                          onAddToTM: () {
                            controller.addToTM(key, oldVal, newVal);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Added to Translation Memory'),
                                  behavior: SnackBarBehavior.floating,
                                  width: 300),
                            );
                          },
                          onMarkReviewed: () {
                            controller.toggleReviewed(key);
                          },
                          onRevert: () {
                            controller.revertEntry(key);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Reverted to source value'),
                                  behavior: SnackBarBehavior.floating,
                                  width: 300),
                            );
                          },
                          onDelete: () {
                            controller.deleteEntry(key);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Deleted entry'),
                                  behavior: SnackBarBehavior.floating,
                                  width: 300),
                            );
                          },
                        );
                      },
                    ),
            ),
            // Pagination Footer
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border(
                    top: BorderSide(color: Theme.of(context).dividerColor)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text('Show: '),
                  DropdownButton<int>(
                    value: controller.itemsPerPage,
                    underline: const SizedBox(),
                    items: const [50, 100, 200, 500]
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text('$e')))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        controller.setItemsPerPage(v);
                      }
                    },
                  ),
                  const Spacer(),
                  Text('${startIndex + 1}-${endIndex} of $totalCount'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.first_page),
                    onPressed: controller.currentPage > 0
                        ? () {
                            controller.firstPage();
                          }
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: controller.currentPage > 0
                        ? () {
                            controller.previousPage();
                          }
                        : null,
                  ),
                  Text(
                      ' ${controller.currentPage + 1} / ${(totalCount / controller.itemsPerPage).ceil()} '),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: endIndex < totalCount
                        ? () {
                            controller.nextPage();
                          }
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.last_page),
                    onPressed: endIndex < totalCount
                        ? () {
                            controller.lastPage();
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog(
      BuildContext context,
      AdvancedDiffController controller,
      String key,
      String source,
      String target) async {
    final textController = TextEditingController(text: target);
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Translation: $key'),
          contentPadding: const EdgeInsets.all(24),
          content: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 600, maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Source (Original):',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SelectableText(
                    // Use SelectableText for copy-paste
                    source,
                    style:
                        const TextStyle(fontFamily: 'RobotoMono', fontSize: 13),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Target (Translation):',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 8),
                TextField(
                  controller: textController,
                  maxLines: 8,
                  minLines: 3,
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter translation...',
                    contentPadding: EdgeInsets.all(12),
                  ),
                  style:
                      const TextStyle(fontFamily: 'RobotoMono', fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () {
                controller.updateEntry(key, textController.text);
                controller.addToTM(key, source, textController.text);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Saved and Added to TM'),
                    behavior: SnackBarBehavior.floating,
                    width: 300,
                  ),
                );
              },
              icon: const Icon(Icons.psychology, size: 16),
              label: const Text('Save & Add to TM'),
            ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: () {
                controller.updateEntry(key, textController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
