import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_controller.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/sidebar_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/status_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/translation_memory_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/filters_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/actions_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/similarity_section.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/widgets/sidebar/ai_section.dart';

class AdvancedDiffSidebar extends StatelessWidget {
  final FocusNode? searchFocusNode;

  const AdvancedDiffSidebar({super.key, this.searchFocusNode});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsBloc>().state.appSettings;
    final controller = context.watch<AdvancedDiffController>();
    final isCloud = _isCloudStrategy(settings.translationStrategy);
    final aiTitle = isCloud ? 'Cloud Translation' : 'AI Translation';

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
          // Search Bar - positioned prominently below header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              focusNode: searchFocusNode,
              decoration: InputDecoration(
                hintText: 'Search keys & values... (Ctrl+F)',
                prefixIcon: const Icon(LucideIcons.search, size: 18),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Tooltip(
                      message: 'Fuzzy Search (typo-tolerant)',
                      child: IconButton(
                        icon: Text(
                          '~',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: controller.isFuzzyEnabled
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).hintColor,
                          ),
                        ),
                        onPressed: () =>
                            controller.toggleFuzzy(!controller.isFuzzyEnabled),
                      ),
                    ),
                    Tooltip(
                      message: 'Regex Search',
                      child: IconButton(
                        icon: Text(
                          '.*',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: controller.isRegexEnabled
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).hintColor,
                          ),
                        ),
                        onPressed: () =>
                            controller.toggleRegex(!controller.isRegexEnabled),
                      ),
                    ),
                  ],
                ),
              ),
              onChanged: (value) {
                controller.updateSearch(value);
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SidebarSection(
                  title: aiTitle,
                  child: AiSection(isCloudTranslation: isCloud),
                ),
                const SizedBox(height: 16),
                const SidebarSection(title: 'Status', child: StatusSection()),
                const SizedBox(height: 16),
                const SidebarSection(
                    title: 'Translation Memory',
                    child: TranslationMemorySection()),
                const SizedBox(height: 16),
                const SidebarSection(title: 'Filters', child: FiltersSection()),
                const SizedBox(height: 16),
                const SidebarSection(title: 'Actions', child: ActionsSection()),
                const SizedBox(height: 16),
                const SidebarSection(
                    title: 'Similarity', child: SimilaritySection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isCloudStrategy(String value) {
    return value.toLowerCase().contains('cloud');
  }
}
