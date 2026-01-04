import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

/// Service for managing the onboarding tutorial using tutorial_coach_mark.
///
/// Phase 1 targets (source, target, compare) use async callbacks so that the
/// tutorial only advances after the user completes the action (e.g., picks a
/// file). Phase 2 targets advance on tap (default behavior).
class OnboardingTutorialService {
  late TutorialCoachMark _tutorialCoachMark;
  TutorialCoachMarkController? _controller;

  final VoidCallback? onFinish;
  final VoidCallback? onSkip;
  final VoidCallback? onLoadSampleData;

  /// Async callbacks for Phase 1 steps.
  /// Return `true` to advance to next step, `false` to stay on current step.
  Future<bool> Function()? _onSourcePicked;
  Future<bool> Function()? _onTargetPicked;

  /// Compare callback (sync). We finish Phase 1 immediately after triggering;
  /// Phase 2 is shown by the view on `ComparisonSuccess`.
  VoidCallback? _onCompareTapped;

  OnboardingTutorialService({
    this.onFinish,
    this.onSkip,
    this.onLoadSampleData,
  });

  /// Shows Phase 1: Data Input (Source, Target, Compare).
  ///
  /// [onSourcePicked] / [onTargetPicked] should open the file picker and return
  /// `true` if a valid file was selected, or `false` if canceled/invalid. The
  /// tutorial advances only on `true`.
  ///
  /// [onCompareTapped] triggers the comparison; the tutorial finishes (Phase 1
  /// ends) immediately and Phase 2 is shown by the view upon success.
  void showDataInputTutorial(
    BuildContext context, {
    required GlobalKey keySourceFilePicker,
    required GlobalKey keyTargetFilePicker,
    required GlobalKey keyCompareButton,
    Future<bool> Function()? onSourcePicked,
    Future<bool> Function()? onTargetPicked,
    VoidCallback? onCompareTapped,
  }) {
    _onSourcePicked = onSourcePicked;
    _onTargetPicked = onTargetPicked;
    _onCompareTapped = onCompareTapped;

    _show(
      context,
      targets: [
        _buildTarget(
          identify: 'source_file',
          keyTarget: keySourceFilePicker,
          icon: LucideIcons.upload,
          title: '1. Import Source File',
          description:
              'Use the button below to browse for a file, or drag & drop onto the highlighted area.',
          align: ContentAlign.bottom,
          context: context,
          // Disable target tap to prevent auto-advance; use buttons instead.
          enableTargetTap: false,
          enableOverlayTap: false,
          actionButton: _buildSourceFileActions(context),
        ),
        _buildTarget(
          identify: 'target_file',
          keyTarget: keyTargetFilePicker,
          icon: LucideIcons.fileInput,
          title: '2. Import Target File',
          description:
              'Use the button below to browse for a file, or drag & drop onto the highlighted area.',
          align: ContentAlign.bottom,
          context: context,
          enableTargetTap: false,
          enableOverlayTap: false,
          actionButton: _buildTargetFileActions(context),
        ),
        _buildTarget(
          identify: 'compare_button',
          keyTarget: keyCompareButton,
          icon: LucideIcons.arrowRightLeft,
          title: '3. Compare Files',
          description:
              'Tap the button below to run the comparison and see the results.',
          align: ContentAlign.bottom,
          context: context,
          enableTargetTap: false,
          enableOverlayTap: false,
          actionButton: _buildCompareActions(context),
          hintText: 'Next: filters, search, advanced view, and export.',
        ),
      ],
    );
  }

  /// Builds action buttons for Source File step.
  Widget _buildSourceFileActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (onLoadSampleData != null) ...[
          ElevatedButton.icon(
            onPressed: () {
              _tutorialCoachMark.finish();
              onLoadSampleData?.call();
            },
            icon: const Icon(LucideIcons.downloadCloud, size: 16),
            label: const Text('Load Sample Data'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
        ],
        OutlinedButton.icon(
          onPressed: () async {
            await _onSourcePicked?.call();
          },
          icon: const Icon(LucideIcons.folderOpen, size: 16),
          label: const Text('Browse Source File'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => _controller?.next(),
          icon: const Icon(LucideIcons.arrowRight, size: 16),
          label: const Text('Next'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54),
          ),
        ),
      ],
    );
  }

  /// Builds action buttons for Target File step.
  Widget _buildTargetFileActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: () async {
            await _onTargetPicked?.call();
          },
          icon: const Icon(LucideIcons.folderOpen, size: 16),
          label: const Text('Browse Target File'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white70),
          ),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => _controller?.next(),
          icon: const Icon(LucideIcons.arrowRight, size: 16),
          label: const Text('Next'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54),
          ),
        ),
      ],
    );
  }

  /// Builds action buttons for Compare step.
  Widget _buildCompareActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            _onCompareTapped?.call();
            _tutorialCoachMark.finish();
          },
          icon: const Icon(LucideIcons.arrowRightLeft, size: 16),
          label: const Text('Compare Files'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  /// Shows Phase 2: Analysis (Filter, Search, Advanced, Export)
  void showAnalysisTutorial(
    BuildContext context, {
    required GlobalKey keyFilterChips,
    required GlobalKey keySearchBar,
    required GlobalKey keyAdvancedButton,
    required GlobalKey keyExportButton,
  }) {
    _show(
      context,
      targets: [
        _buildTarget(
          identify: 'filter_chips',
          keyTarget: keyFilterChips,
          icon: LucideIcons.filter,
          title: '4. Filter Results',
          description:
              'Use these filters to view Added, Removed, or Modified strings.',
          align: ContentAlign.bottom,
          radius: 8,
          context: context,
        ),
        _buildTarget(
          identify: 'search_bar',
          keyTarget: keySearchBar,
          icon: LucideIcons.search,
          title: '5. Search Results',
          description: 'Find specific keys or values using the search bar.',
          align: ContentAlign.bottom,
          radius: 8,
          context: context,
        ),
        _buildTarget(
          identify: 'advanced_button',
          keyTarget: keyAdvancedButton,
          icon: LucideIcons.maximize,
          title: '6. Advanced View',
          description:
              'Open the detailed diff view with editing, AI translation, and more.',
          align: ContentAlign.top,
          radius: 8,
          context: context,
        ),
        _buildTarget(
          identify: 'export_button',
          keyTarget: keyExportButton,
          icon: LucideIcons.download,
          title: '7. Export Results',
          description: 'Save your comparison as CSV, JSON, or Excel file.',
          align: ContentAlign.top,
          radius: 8,
          isLast: true,
          context: context,
        ),
      ],
    );
  }

  void _show(
    BuildContext context, {
    required List<TargetFocus> targets,
    Function(TargetFocus)? onClickTarget,
  }) {
    _tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      opacityShadow: 0.85,
      textSkip: 'SKIP TUTORIAL',
      textStyleSkip: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      paddingFocus: 10,
      focusAnimationDuration: const Duration(milliseconds: 400),
      pulseAnimationDuration: const Duration(milliseconds: 800),
      onFinish: onFinish,
      onSkip: () {
        onSkip?.call();
        return true;
      },
      onClickTarget: (target) {
        onClickTarget?.call(target);
      },
    );

    _tutorialCoachMark.show(context: context);
  }

  TargetFocus _buildTarget({
    required String identify,
    required GlobalKey keyTarget,
    required IconData icon,
    required String title,
    required String description,
    required ContentAlign align,
    required BuildContext context,
    double radius = 12,
    Widget? actionButton,
    String? hintText,
    bool isLast = false,
    bool enableOverlayTap = true,
    bool enableTargetTap = true,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return TargetFocus(
      identify: identify,
      keyTarget: keyTarget,
      shape: ShapeLightFocus.RRect,
      radius: radius,
      enableOverlayTab: enableOverlayTap,
      enableTargetTab: enableTargetTap,
      contents: [
        TargetContent(
          align: align,
          builder: (context, controller) {
            // Capture controller for programmatic advancement.
            _controller = controller;
            return _buildContent(
              context,
              icon: icon,
              title: title,
              description: description,
              primaryColor: primaryColor,
              actionButton: actionButton,
              hintText: hintText,
              isLast: isLast,
            );
          },
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color primaryColor,
    Widget? actionButton,
    String? hintText,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: primaryColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 15,
              height: 1.4,
            ),
          ),
          if (hintText != null) ...[
            const SizedBox(height: 8),
            Text(
              hintText,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          if (actionButton != null) ...[
            const SizedBox(height: 16),
            actionButton,
          ],
          if (isLast) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.green.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.partyPopper,
                      color: Colors.green[300], size: 20),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "You're all set! Tap anywhere to finish.",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
