import 'package:flutter/material.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/sidebar_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/status_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/translation_memory_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/filters_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/actions_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/similarity_section.dart';

class AdvancedDiffSidebar extends StatelessWidget {
  const AdvancedDiffSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  'Widgets',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                const Icon(Icons.chevron_left, size: 20),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                SidebarSection(title: 'Status', child: StatusSection()),
                SizedBox(height: 16),
                SidebarSection(
                    title: 'Translation Memory',
                    child: TranslationMemorySection()),
                SizedBox(height: 16),
                SidebarSection(title: 'Filters', child: FiltersSection()),
                SizedBox(height: 16),
                SidebarSection(title: 'Actions', child: ActionsSection()),
                SizedBox(height: 16),
                SidebarSection(title: 'Similarity', child: SimilaritySection()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
