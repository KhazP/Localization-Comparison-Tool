import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/comparison_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/progress_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_event.dart';
import 'package:localizer_app_main/business_logic/blocs/file_watcher_bloc/file_watcher_state.dart';
import 'package:localizer_app_main/core/services/comparison_engine.dart'; // For ComparisonResult
import 'package:localizer_app_main/core/utils/file_explorer_utils.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart'; // Import new model
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/presentation/views/advanced_diff/advanced_diff_view.dart';
// import 'package:localizer_app_main/presentation/views/ai_translation_settings_view.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/theme_bloc.dart';
import 'package:localizer_app_main/core/services/backup_service.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:localizer_app_main/core/services/problem_detector.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:flutter/services.dart';
import 'package:localizer_app_main/core/services/platform_taskbar_service.dart';
import 'package:localizer_app_main/core/input/app_intents.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/app_command_service.dart';
import 'package:localizer_app_main/core/utils/drag_drop_utils.dart';
import 'package:localizer_app_main/core/services/onboarding_tutorial_service.dart';
import 'package:localizer_app_main/presentation/widgets/diff/diff_list_item.dart';
import 'package:localizer_app_main/core/services/export_service.dart';
import 'package:localizer_app_main/presentation/widgets/file_picker_drop_zone.dart';
import 'package:path/path.dart' as path;

// Enum for filter status in Basic View

enum BasicDiffFilter { all, added, removed, modified, problems }

class FileComparisonView extends StatefulWidget {
  final Function(int)? onNavigateToTab;
  final ComparisonSession? initialSession;

  const FileComparisonView({
    super.key,
    this.onNavigateToTab,
    this.initialSession,
  });

  @override
  State<FileComparisonView> createState() => _FileComparisonViewState();
}

class _FileComparisonViewState extends State<FileComparisonView> {
  // ... existing fields ...
  final ExportService _exportService = const ExportService();
  final PlatformTaskbarService _taskbar = PlatformTaskbarService();
  StreamSubscription<AppCommand>? _appCommandSubscription;

  /// Returns the current project ID if one is loaded, or null.
  String? get _currentProjectId {
    final projectState = context.read<ProjectBloc>().state;
    return projectState.status == ProjectStatus.loaded
        ? projectState.currentProject?.id
        : null;
  }

  void _navigateToAiSettings() {
    // Navigate to Settings tab (index 5)
    if (widget.onNavigateToTab != null) {
      widget.onNavigateToTab!(5);
    } else {
      // Fallback if callback not provided
      ToastService.showInfo(
          context, context.t.fileComparison.aiSettingsNotAvailable);
    }
  }

  void _handleAppCommand(AppCommand command) {
    switch (command.type) {
      case AppCommandType.openFiles:
        _openFilesFromCommand();
        break;
      case AppCommandType.exportResults:
        _exportFromCommand();
        break;
      case AppCommandType.openFolder:
        break;
      case AppCommandType.restartTutorial:
        _restartTutorialForDebug();
        break;
    }
  }

  Future<void> _openFilesFromCommand() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (!mounted || result == null || result.files.isEmpty) {
      return;
    }

    final picked = result.files.where((file) => file.path != null).toList();
    if (picked.isEmpty) {
      return;
    }

    final hasUnsupported =
        picked.map((file) => file.path!).any((path) => !_isValidFileType(path));
    if (hasUnsupported) {
      ToastService.showError(
        context,
        context.t.fileComparison.someFilesUnsupported,
        recoverySuggestion: context.t.fileComparison.pickSupportedFiles,
      );
      return;
    }

    if (_isBilingualMode) {
      setState(() {
        _bilingualFile = File(picked.first.path!);
        _file1 = null;
        _file2 = null;
      });
    } else {
      if (picked.length < 2) {
        ToastService.showWarning(
          context,
          context.t.fileComparison.pickTwoFiles,
        );
        return;
      }
      setState(() {
        _file1 = File(picked[0].path!);
        _file2 = File(picked[1].path!);
        _bilingualFile = null;
      });
    }

    _updateFileWatcher();

    final ready = _isBilingualMode
        ? _bilingualFile != null
        : _file1 != null && _file2 != null;
    if (ready) {
      _startComparison();
    }
  }

  Future<void> _exportFromCommand() async {
    if (!mounted) return;
    if (_latestComparisonResult == null) {
      ToastService.showInfo(
          context, context.t.fileComparison.noResultsToExport);
      return;
    }
    await _exportResult();
  }

  File? _file1;
  File? _file2;
  File? _bilingualFile;
  bool _isBilingualMode = false;
  // Store the latest comparison results for the analytics bar
  ComparisonResult? _latestComparisonResult;
  BasicDiffFilter _currentFilter = BasicDiffFilter.all;

  // Search/filter state
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  bool _isRegexEnabled = false;
  bool _isFuzzyEnabled = false;

  // Pagination
  int _currentPage = 0;
  int _itemsPerPage = 100;
  // -1 represents "All"
  final List<int> _availablePageSizes = [100, 250, 500, 1000, 10000, -1];

  // Flag to ensure we only auto-load the last project once
  bool _hasAutoLoadedLastProject = false;
  // Flag to show loading state while we determine if we should auto-load
  bool _isCheckingAutoLoad = true;

  // Tutorial GlobalKeys
  final GlobalKey _keySourceFilePicker = GlobalKey();
  final GlobalKey _keyTargetFilePicker = GlobalKey();
  final GlobalKey _keyCompareButton = GlobalKey();
  final GlobalKey _keyFilterChips = GlobalKey();
  final GlobalKey _keySearchBar = GlobalKey();
  final GlobalKey _keyAdvancedButton = GlobalKey();
  final GlobalKey _keyExportButton = GlobalKey();
  bool _tutorialShown = false;
  bool _analysisTutorialShown = false;

  @override
  void initState() {
    super.initState();
    _appCommandSubscription =
        sl<AppCommandService>().stream.listen(_handleAppCommand);
    assert(() {
      debugPrint(
          '[DEV] To restart the onboarding tutorial, run sl<AppCommandService>().emit(const AppCommand(AppCommandType.restartTutorial)); in the Debug Console.');
      return true;
    }());
    // Check if we have an active comparison from the Wizard or preserved state
    final comparisonState = context.read<ComparisonBloc>().state;
    if (comparisonState is ComparisonSuccess) {
      _file1 = comparisonState.file1;
      _file2 = comparisonState.file2;
      _latestComparisonResult = comparisonState.result;
      _isBilingualMode =
          comparisonState.file1.path == comparisonState.file2.path;
      if (_isBilingualMode) {
        _bilingualFile = comparisonState.file1;
      }
      // Prevent auto-loading last project since we have an active comparison
      _hasAutoLoadedLastProject = true;
      _isCheckingAutoLoad = false;

      // If we came from Wizard, we might need to trigger Phase 2 tutorial manually
      // because the listener won't fire for the initial state.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Check onboarding step to decide if we show Phase 2
        final settings = context.read<SettingsBloc>().state.appSettings;
        if (settings.onboardingStep >= 3 && !settings.isOnboardingCompleted) {
          _showTutorialPhase2();
        }
      });
    }

    // Check if we should auto-load the last project on startup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryAutoLoadLastProject();
    });

    // Initialize tutorial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTutorial();
    });
  }

  void _initTutorial({bool forceRestart = false}) {
    final settingsState = context.read<SettingsBloc>().state;

    // If settings are not loaded yet, do nothing. Listener will trigger this later.
    if (settingsState.status != SettingsStatus.loaded) {
      return;
    }

    final settings = settingsState.appSettings;

    // Don't show if already completed (unless forcing restart).
    if (!forceRestart && settings.isOnboardingCompleted) {
      return;
    }

    // Determine which phase to resume based on persisted step.
    // Steps 0-2 = Phase 1 (file input), Steps 3+ = Phase 2 (analysis).
    final step = settings.onboardingStep;

    // If step >= 3, user already completed Phase 1; don't re-show Phase 1.
    // Phase 2 is triggered by ComparisonSuccess, so nothing to do here.
    if (!forceRestart && step >= 3) {
      // Mark that we've "shown" Phase 1 so we don't re-init on rebuild.
      _tutorialShown = true;
      return;
    }

    // Prevent duplicate show if already displayed this session.
    if (!forceRestart && _tutorialShown) {
      return;
    }

    if (forceRestart) {
      _analysisTutorialShown = false;
    }

    setState(() => _tutorialShown = true);

    // Small delay to ensure UI is ready.
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      OnboardingTutorialService(
        onLoadSampleData: _loadSampleData,
      ).showDataInputTutorial(
        context,
        keySourceFilePicker: _keySourceFilePicker,
        keyTargetFilePicker: _keyTargetFilePicker,
        keyCompareButton: _keyCompareButton,
        onSourcePicked: () => _pickFileForTutorial(1),
        onTargetPicked: () => _pickFileForTutorial(2),
        onCompareTapped: _startComparison,
      );
    });
  }

  /// Picks a file for the tutorial and returns `true` if a valid file was
  /// selected, `false` otherwise. The tutorial advances only on `true`.
  Future<bool> _pickFileForTutorial(int fileNumber) async {
    final result = await FilePicker.platform.pickFiles();
    if (!mounted) return false;

    if (result == null || result.files.isEmpty) {
      // User cancelled.
      return false;
    }

    final path = result.files.single.path;
    if (path == null || !_isValidFileType(path)) {
      ToastService.showError(
        context,
        context.t.fileComparison.unsupportedFileType,
        recoverySuggestion:
            context.t.fileComparison.unsupportedFileTypeSuggestion,
      );
      return false;
    }

    setState(() {
      if (fileNumber == 1) {
        _file1 = File(path);
      } else if (fileNumber == 2) {
        _file2 = File(path);
      } else {
        _bilingualFile = File(path);
      }
    });

    _updateFileWatcher();
    return true;
  }

  void _restartTutorialForDebug() {
    if (!mounted) return;

    final settings = context.read<SettingsBloc>().state.appSettings;
    final isDev = kDebugMode || settings.showDeveloperOptions;

    if (!isDev) {
      ToastService.showInfo(
        context,
        context.t.fileComparison.restartTutorialDevOnly,
      );
      return;
    }

    context.read<SettingsBloc>()
      ..add(const UpdateIsOnboardingCompleted(false))
      ..add(const UpdateOnboardingStep(0));

    setState(() {
      _tutorialShown = false;
      _analysisTutorialShown = false;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initTutorial(forceRestart: true);
    });

    debugPrint('[DEV] Onboarding tutorial restart requested.');
  }

  void _showTutorialPhase2() {
    final settings = context.read<SettingsBloc>().state.appSettings;
    if (_analysisTutorialShown || settings.isOnboardingCompleted) {
      return;
    }

    _analysisTutorialShown = true;

    // Mark that we've entered Phase 2 (step 3+), so hot reload won't restart
    // Phase 1.
    if (settings.onboardingStep < 3) {
      context.read<SettingsBloc>().add(const UpdateOnboardingStep(3));
    }

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;

      OnboardingTutorialService(
        onFinish: () {
          context
              .read<SettingsBloc>()
              .add(const UpdateIsOnboardingCompleted(true));
        },
        onSkip: () {
          context
              .read<SettingsBloc>()
              .add(const UpdateIsOnboardingCompleted(true));
        },
      ).showAnalysisTutorial(
        context,
        keyFilterChips: _keyFilterChips,
        keySearchBar: _keySearchBar,
        keyAdvancedButton: _keyAdvancedButton,
        keyExportButton: _keyExportButton,
      );
    });
  }

  void _tryAutoLoadLastProject() {
    if (_hasAutoLoadedLastProject) return;

    final settingsState = context.read<SettingsBloc>().state;
    final historyState = context.read<HistoryBloc>().state;

    // If settings or history aren't ready (and history isn't error), wait
    if (settingsState.status != SettingsStatus.loaded) {
      return;
    }

    // If feature disabled, stop checking
    if (!settingsState.appSettings.openLastProjectOnStartup) {
      if (mounted) setState(() => _isCheckingAutoLoad = false);
      return;
    }

    // Feature is enabled. Check history.
    if (historyState is HistoryLoading) return; // Wait for history

    if (historyState is HistoryLoaded) {
      if (historyState.history.isNotEmpty) {
        _hasAutoLoadedLastProject = true;
        _loadRecentComparison(historyState.history.first);
        // Keeps _isCheckingAutoLoad = true until comparison starts/succeeds
      } else {
        // History empty, stop checking
        if (mounted) setState(() => _isCheckingAutoLoad = false);
      }
    } else if (historyState is HistoryError) {
      // Error loading history, stop checking
      if (mounted) setState(() => _isCheckingAutoLoad = false);
    }
  }

  @override
  void dispose() {
    _appCommandSubscription?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  bool _detectProblem(String source, String? target) {
    if (ProblemDetector.hasEmptyTarget(target)) {
      return true;
    }
    if (ProblemDetector.hasPlaceholderMismatch(source, target)) {
      return true;
    }
    if (ProblemDetector.hasSuspiciousLength(source, target)) {
      return true;
    }
    return false;
  }

  Future<void> _loadSampleData() async {
    try {
      final tempDir = Directory.systemTemp.createTempSync('localizer_sample_');

      // Load sample files from assets
      final sourceContent =
          await rootBundle.loadString('assets/sample_data/english/en.json');
      final targetContent =
          await rootBundle.loadString('assets/sample_data/turkish/tr.json');

      final sourceFile = File(path.join(tempDir.path, 'en.json'));
      final targetFile = File(path.join(tempDir.path, 'tr.json'));

      await sourceFile.writeAsString(sourceContent);
      await targetFile.writeAsString(targetContent);

      if (!mounted) return;

      setState(() {
        _file1 = sourceFile;
        _file2 = targetFile;
        _bilingualFile = null;
        _isBilingualMode = false;
      });

      _updateFileWatcher();

      // Update Step to 1 (Compare)
      context.read<SettingsBloc>().add(const UpdateOnboardingStep(1));

      ToastService.showSuccess(
          context, context.t.fileComparison.sampleDataLoaded);

      // Auto start comparison
      _startComparison();
    } catch (e) {
      if (!mounted) return;
      ToastService.showError(
          context, context.t.fileComparison.loadSampleDataError(error: e));
    }
  }

  Future<void> _pickFile(int fileNumber) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        if (fileNumber == 1) {
          _file1 = File(result.files.single.path!);
        } else if (fileNumber == 2) {
          _file2 = File(result.files.single.path!);
        } else {
          _bilingualFile = File(result.files.single.path!);
        }
      });

      // Update file watcher when files change
      _updateFileWatcher();
    }
  }

  void _toggleFileWatching(bool enabled) {
    context.read<SettingsBloc>().add(UpdateAutoReloadOnChange(enabled));
  }

  void _toggleComparisonMode() {
    setState(() {
      _isBilingualMode = !_isBilingualMode;
    });
    _updateFileWatcher();
  }

  void _startComparison() {
    if (_isBilingualMode) {
      _startBilingualComparison();
      return;
    }
    if (_file1 != null && _file2 != null) {
      setState(() {
        _currentFilter = BasicDiffFilter.all; // Reset filter on new comparison
      });
      final settingsState = context.read<SettingsBloc>().state;
      if (settingsState.status == SettingsStatus.loaded) {
        context.read<ComparisonBloc>().add(CompareFilesRequested(
              file1: _file1!,
              file2: _file2!,
              settings: settingsState.appSettings,
              projectId: _currentProjectId,
            ));
      }
      _updateFileWatcher();

      // Update Onboarding: Step 0 (Import) → Step 1 (Run Comparison)
      if (context.read<SettingsBloc>().state.appSettings.onboardingStep == 0) {
        context.read<SettingsBloc>().add(const UpdateOnboardingStep(1));
      }
    } else {
      ToastService.showWarning(context, context.t.fileComparison.pickTwoFiles);
    }
  }

  void _startBilingualComparison() {
    if (_bilingualFile != null) {
      setState(() {
        _currentFilter = BasicDiffFilter.all; // Reset filter on new comparison
      });
      final settingsState = context.read<SettingsBloc>().state;
      if (settingsState.status == SettingsStatus.loaded) {
        context.read<ComparisonBloc>().add(
              CompareBilingualFileRequested(
                file: _bilingualFile!,
                settings: settingsState.appSettings,
                projectId: _currentProjectId,
              ),
            );
      }
      _updateFileWatcher();

      // Update Onboarding Step to 1 (Compare) if current step is 0
      if (context.read<SettingsBloc>().state.appSettings.onboardingStep == 0) {
        context.read<SettingsBloc>().add(const UpdateOnboardingStep(1));
      }
    } else {
      ToastService.showWarning(
          context, context.t.fileComparison.pickBilingualFile);
    }
  }

  void _updateFileWatcher() {
    final settingsState = context.read<SettingsBloc>().state;
    final isAutoReloadEnabled = settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.autoReloadOnChange;

    if (!isAutoReloadEnabled) {
      context.read<FileWatcherBloc>().add(StopWatchingFiles());
      return;
    }

    if (_isBilingualMode && _bilingualFile != null) {
      context.read<FileWatcherBloc>().add(
            StartWatchingFiles(
              _bilingualFile!.path,
              _bilingualFile!.path,
            ),
          );
      return;
    }

    if (!_isBilingualMode && _file1 != null && _file2 != null) {
      context.read<FileWatcherBloc>().add(
            StartWatchingFiles(_file1!.path, _file2!.path),
          );
    } else {
      context.read<FileWatcherBloc>().add(StopWatchingFiles());
    }
  }

  void _onFileDropped(String filePath, int fileNumber) {
    final file = File(filePath);

    // Validate file extension
    if (_isValidFileType(file.path)) {
      setState(() {
        if (fileNumber == 1) {
          _file1 = file;
        } else if (fileNumber == 2) {
          _file2 = file;
        } else {
          _bilingualFile = file;
        }
      });

      // Update file watcher when files change
      _updateFileWatcher();

      // Show success message
      final fileName = file.path.split(Platform.pathSeparator).last;
      final selectionLabel = fileNumber == 1
          ? context.t.fileComparison.sourceFile
          : fileNumber == 2
              ? context.t.fileComparison.targetFile
              : context.t.fileComparison.bilingualFile;
      ToastService.showSuccess(
          context,
          context.t.fileComparison
              .fileSelected(label: selectionLabel, fileName: fileName));

      // Update Onboarding Step to 1 (Compare) if current step is 0, since a file is selected
      if (context.read<SettingsBloc>().state.appSettings.onboardingStep == 0) {
        context.read<SettingsBloc>().add(const UpdateOnboardingStep(1));
      }
    } else {
      // Show error for invalid file type
      ToastService.showError(
        context,
        context.t.fileComparison.invalidFileType,
        recoverySuggestion:
            context.t.fileComparison.unsupportedFileTypeSuggestion,
      );
    }
  }

  bool _isValidFileType(String filePath) {
    return DragDropUtils.isValidFilePath(filePath);
  }

  void _navigateToAdvancedView() {
    if (_latestComparisonResult != null && _file1 != null && _file2 != null) {
      // Advance onboarding: Step 2/3/4 → Step 5 (Advanced View)
      final currentStep =
          context.read<SettingsBloc>().state.appSettings.onboardingStep;
      if (currentStep >= 2 && currentStep < 5) {
        context.read<SettingsBloc>().add(const UpdateOnboardingStep(5));
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdvancedDiffView(
            comparisonResult: _latestComparisonResult!,
            sourceFile: _file1!,
            targetFile: _file2!,
          ),
        ),
      );
    } else {
      ToastService.showInfo(
          context, context.t.fileComparison.performComparisonFirstEditor);
    }
  }

  Widget _buildAnimatedProgressOverlay(
      BuildContext context, ProgressLoading state) {
    final progress = state.percentage / 100.0;

    // Build ETA text
    String timeEstimate = '';
    final eta = state.estimatedTimeRemaining;
    if (eta != null && eta.inSeconds > 0) {
      if (eta.inSeconds < 60) {
        timeEstimate =
            context.t.fileComparison.remaining(time: '${eta.inSeconds}s');
      } else {
        final minutes = (eta.inSeconds / 60).ceil();
        timeEstimate = context.t.fileComparison.remaining(time: '$minutes min');
      }
    }

    // Build bytes progress text
    final bytesText = state.formattedBytesProgress;

    return Center(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context)
                .colorScheme
                .outlineVariant
                .withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.t.fileComparison.processing,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '${state.percentage}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 12,
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.7),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    state.stage,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (bytesText != null)
                  Text(
                    bytesText,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
              ],
            ),
            if (timeEstimate.isNotEmpty) ...[
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  timeEstimate,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine if Amoled mode is active
    final settingsState = context.watch<SettingsBloc>().state;
    final themeState = context.watch<ThemeBloc>().state;
    final bool isAmoled = settingsState.status == SettingsStatus.loaded &&
        Theme.of(context).brightness == Brightness.dark &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyF, control: true): () {
          _searchFocusNode.requestFocus();
        },
      },
      child: Focus(
        autofocus: true,
        child: Actions(
          actions: {
            FocusSearchIntent: CallbackAction<FocusSearchIntent>(
              onInvoke: (intent) {
                _searchFocusNode.requestFocus();
                return null;
              },
            ),
            SaveIntent: CallbackAction<SaveIntent>(
              onInvoke: (intent) {
                if (_latestComparisonResult != null) {
                  _exportResult();
                } else {
                  ToastService.showInfo(
                      context, context.t.fileComparison.performComparisonFirst);
                }
                return null;
              },
            ),
            ExportIntent: CallbackAction<ExportIntent>(
              onInvoke: (intent) {
                if (_latestComparisonResult != null) {
                  _exportResult();
                } else {
                  ToastService.showInfo(
                      context, context.t.fileComparison.performComparisonFirst);
                }
                return null;
              },
            ),
            OpenFileIntent: CallbackAction<OpenFileIntent>(
              onInvoke: (intent) {
                _pickFile(1); // Default to source file
                return null;
              },
            ),
          },
          child: Stack(
            children: [
              MultiBlocListener(
                listeners: [
                  // Auto-load last project on startup if setting is enabled
                  BlocListener<HistoryBloc, HistoryState>(
                    listenWhen: (previous, current) =>
                        !_hasAutoLoadedLastProject && current is HistoryLoaded,
                    listener: (context, historyState) {
                      _tryAutoLoadLastProject();
                    },
                  ),
                  // Also try auto-load when settings first load (in case history loaded first)
                  BlocListener<SettingsBloc, SettingsState>(
                    listenWhen: (previous, current) =>
                        !_hasAutoLoadedLastProject &&
                        previous.status != SettingsStatus.loaded &&
                        current.status == SettingsStatus.loaded,
                    listener: (context, state) {
                      _tryAutoLoadLastProject();
                    },
                  ),
                  BlocListener<SettingsBloc, SettingsState>(
                    listenWhen: (previous, current) =>
                        previous.status != SettingsStatus.loaded &&
                        current.status == SettingsStatus.loaded,
                    listener: (context, state) {
                      _initTutorial();
                    },
                  ),
                  BlocListener<SettingsBloc, SettingsState>(
                    listenWhen: (previous, current) =>
                        previous.status == SettingsStatus.loaded &&
                        current.status == SettingsStatus.loaded &&
                        previous.appSettings.autoReloadOnChange !=
                            current.appSettings.autoReloadOnChange,
                    listener: (context, state) {
                      _updateFileWatcher();
                    },
                  ),
                  BlocListener<FileWatcherBloc, FileWatcherState>(
                    listener: (context, state) {
                      if (state is FileChangedDetected) {
                        // Show a toast notification about file change
                        ToastService.showInfo(
                            context,
                            context.t.fileComparison.fileChanged(
                                fileName: state.changedFilePath
                                    .split(Platform.pathSeparator)
                                    .last));

                        // Trigger automatic recomparison
                        final settingsStateForReload =
                            context.read<SettingsBloc>().state;
                        if (settingsStateForReload.status ==
                            SettingsStatus.loaded) {
                          if (_isBilingualMode) {
                            context.read<ComparisonBloc>().add(
                                  CompareBilingualFileRequested(
                                    file: File(state.file1Path),
                                    settings:
                                        settingsStateForReload.appSettings,
                                    projectId: _currentProjectId,
                                  ),
                                );
                          } else {
                            context.read<ComparisonBloc>().add(
                                  CompareFilesRequested(
                                    file1: File(state.file1Path),
                                    file2: File(state.file2Path),
                                    settings:
                                        settingsStateForReload.appSettings,
                                    projectId: _currentProjectId,
                                  ),
                                );
                          }
                        }
                      }
                    },
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // File Selection Section
                      Card(
                        color: isAmoled
                            ? Colors.black
                            : Theme.of(context).cardColor,
                        elevation: isAmoled ? 0.3 : 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: isAmoled
                                ? Colors.grey[850]!
                                : Theme.of(context)
                                    .dividerColor
                                    .withValues(alpha: 0.5),
                          ),
                        ),
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              if (_isBilingualMode)
                                Row(
                                  children: [
                                    FilePickerDropZone(
                                      title: context
                                          .t.fileComparison.bilingualFile,
                                      file: _bilingualFile,
                                      onPressed: () => _pickFile(3),
                                      onFilePicked: (path) =>
                                          _onFileDropped(path, 3),
                                      isAmoled: isAmoled,
                                      shortcutHint: 'Ctrl+O',
                                    ),
                                  ],
                                )
                              else
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      key: _keySourceFilePicker,
                                      child: FilePickerDropZone(
                                        title:
                                            context.t.fileComparison.sourceFile,
                                        file: _file1,
                                        onPressed: () => _pickFile(1),
                                        onFilePicked: (path) =>
                                            _onFileDropped(path, 1),
                                        isAmoled: isAmoled,
                                        shortcutHint: 'Ctrl+O',
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      key: _keyTargetFilePicker,
                                      child: FilePickerDropZone(
                                        title:
                                            context.t.fileComparison.targetFile,
                                        file: _file2,
                                        onPressed: () => _pickFile(2),
                                        onFilePicked: (path) =>
                                            _onFileDropped(path, 2),
                                        isAmoled: isAmoled,
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    key: _keyCompareButton,
                                    child: ElevatedButton.icon(
                                      icon: const Icon(
                                          LucideIcons.arrowRightLeft,
                                          size: 18),
                                      label: Text(_isBilingualMode
                                          ? context.t.fileComparison.compareFile
                                          : context
                                              .t.fileComparison.compareFiles),
                                      onPressed: _isBilingualMode
                                          ? (_bilingualFile != null
                                              ? _startComparison
                                              : null)
                                          : (_file1 != null && _file2 != null
                                              ? _startComparison
                                              : null),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  OutlinedButton.icon(
                                    icon: const Icon(LucideIcons.languages,
                                        size: 18),
                                    label: Text(_isBilingualMode
                                        ? context.t.fileComparison.twoFilesMode
                                        : context
                                            .t.fileComparison.bilingualMode),
                                    onPressed: _toggleComparisonMode,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Analytics and Actions Bar - Modified Layout
                      _buildAnalyticsAndActionsBar(settingsState, themeState),
                      const SizedBox(height: 16.0), // Reduced bottom margin
                      BlocBuilder<ProgressBloc, ProgressState>(
                        builder: (context, state) {
                          if (state is ProgressLoading) {
                            return _buildAnimatedProgressOverlay(
                                context, state);
                          }
                          if (state is ProgressFailure) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(LucideIcons.alertCircle,
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                        'Error during processing: ${state.error}',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error)),
                                  ],
                                ));
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      Expanded(
                        child: BlocConsumer<ComparisonBloc, ComparisonState>(
                          listener: (context, state) {
                            // When comparison state changes, we are definitely no longer checking auto load
                            if (state is ComparisonLoading ||
                                state is ComparisonSuccess ||
                                state is ComparisonFailure) {
                              if (_isCheckingAutoLoad) {
                                setState(() => _isCheckingAutoLoad = false);
                              }
                            }

                            if (state is ComparisonLargeFileWarning) {
                              context
                                  .read<ProgressBloc>()
                                  .add(ComparisonCompleted());
                              _showLargeFileWarningDialog(context, state);
                            }

                            if (state is ComparisonSuccess) {
                              _showTutorialPhase2();
                              context
                                  .read<ProgressBloc>()
                                  .add(ComparisonCompleted());

                              // Advance onboarding: Step 1 (Run Comparison) → Step 2 (Review Missing)
                              if (context
                                      .read<SettingsBloc>()
                                      .state
                                      .appSettings
                                      .onboardingStep ==
                                  1) {
                                context
                                    .read<SettingsBloc>()
                                    .add(const UpdateOnboardingStep(2));
                              }

                              // Update file references in the UI
                              final isBilingualResult =
                                  state.file1.path == state.file2.path;
                              setState(() {
                                _isBilingualMode = isBilingualResult;
                                _file1 = state.file1;
                                _file2 = state.file2;
                                if (isBilingualResult) {
                                  _bilingualFile = state.file1;
                                }
                                _latestComparisonResult = state.result;
                                _currentPage = 0; // Reset pagination
                              });
                              _updateFileWatcher();

                              // Announce result for screen readers
                              final changeCount = state.result.diff.values
                                  .where((d) =>
                                      d.status !=
                                      StringComparisonStatus.identical)
                                  .length;
                              SemanticsService.announce(
                                'Comparison complete. Found $changeCount changes.',
                                TextDirection.ltr,
                              );

                              // History recording is now handled by ComparisonBloc
                            } else if (state is ComparisonFailure) {
                              context
                                  .read<ProgressBloc>()
                                  .add(ComparisonError(state.error));
                              // Optionally, clear _file1, _file2, _latestComparisonResult if a history load failed?
                              // Or just show the error via ProgressBloc/Snackbar
                              ToastService.showError(
                                  context,
                                  context.t.fileComparison
                                      .comparisonFailed(error: state.error));
                            }
                          },
                          builder: (context, state) {
                            final theme = Theme.of(context);

                            Widget content;
                            if (_isCheckingAutoLoad) {
                              content = const Center(
                                  key: ValueKey('checking'),
                                  child: CircularProgressIndicator());
                            } else if (state is ComparisonLoading) {
                              content = Center(
                                  key: const ValueKey('loading'),
                                  child: Text(context
                                      .t.fileComparison.comparisonInProgress));
                            } else if (state is ComparisonSuccess) {
                              var diffEntries =
                                  state.result.diff.entries.toList();

                              // Apply filter

                              if (_currentFilter != BasicDiffFilter.all) {
                                diffEntries = diffEntries.where((entry) {
                                  switch (_currentFilter) {
                                    case BasicDiffFilter.added:
                                      return entry.value.status ==
                                          StringComparisonStatus.added;
                                    case BasicDiffFilter.removed:
                                      return entry.value.status ==
                                          StringComparisonStatus.removed;
                                    case BasicDiffFilter.modified:
                                      return entry.value.status ==
                                          StringComparisonStatus.modified;
                                    case BasicDiffFilter.problems:
                                      final key = entry.key;
                                      final value1 =
                                          state.result.file1Data[key] ?? '';
                                      final value2 =
                                          state.result.file2Data[key];
                                      return _detectProblem(value1, value2);
                                    default:
                                      return true;
                                  }
                                }).toList();
                              }

                              // Hide identical entries if setting is disabled and we are in 'All' filter
                              final showIdentical = settingsState
                                  .appSettings.showIdenticalEntries;
                              int hiddenIdenticalCount = 0;
                              if (!showIdentical &&
                                  _currentFilter == BasicDiffFilter.all) {
                                final identicals = diffEntries
                                    .where((entry) =>
                                        entry.value.status ==
                                        StringComparisonStatus.identical)
                                    .toList();
                                hiddenIdenticalCount = identicals.length;
                                if (hiddenIdenticalCount > 0) {
                                  diffEntries = diffEntries
                                      .where((entry) =>
                                          entry.value.status !=
                                          StringComparisonStatus.identical)
                                      .toList();
                                }
                              }

                              // Apply text search filter
                              final int totalBeforeSearch = diffEntries.length;
                              if (_searchQuery.isNotEmpty) {
                                final query = _isRegexEnabled
                                    ? _searchQuery
                                    : _searchQuery.toLowerCase();
                                diffEntries = diffEntries.where((entry) {
                                  final key = entry
                                      .key; // Keys are case-sensitive usually, but let's be generous
                                  final value1 =
                                      (state.result.file1Data[entry.key] ?? '');
                                  final value2 =
                                      (state.result.file2Data[entry.key] ?? '');

                                  // Regex Search
                                  if (_isRegexEnabled) {
                                    try {
                                      final regex =
                                          RegExp(query, caseSensitive: false);
                                      return regex.hasMatch(key) ||
                                          regex.hasMatch(value1) ||
                                          regex.hasMatch(value2);
                                    } catch (e) {
                                      return false; // Invalid regex
                                    }
                                  }

                                  // Fuzzy Search
                                  if (_isFuzzyEnabled) {
                                    // Check key normally
                                    if (key.toLowerCase().contains(query))
                                      return true;

                                    if (value1.toLowerCase().contains(query) ||
                                        value2.toLowerCase().contains(query))
                                      return true;

                                    // If not found by contains, try similarity
                                    if (value1.similarityTo(query) > 0.4 ||
                                        value2.similarityTo(query) > 0.4)
                                      return true;

                                    return false;
                                  }

                                  // Standard Search
                                  return key.toLowerCase().contains(query) ||
                                      value1.toLowerCase().contains(query) ||
                                      value2.toLowerCase().contains(query);
                                }).toList();
                              }

                              if (diffEntries.isEmpty) {
                                if (_searchQuery.isNotEmpty) {
                                  content = Center(
                                    key: const ValueKey('empty_search'),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(LucideIcons.searchX,
                                            size: 48,
                                            color: theme.colorScheme.onSurface
                                                .withAlpha(100)),
                                        const SizedBox(height: 12),
                                        Text(
                                          context.t.fileComparison
                                              .noMatches(query: _searchQuery),
                                          style: TextStyle(
                                              color: theme.colorScheme.onSurface
                                                  .withAlpha(150)),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          context.t.fileComparison
                                              .showingEntries(
                                                  count: 0,
                                                  total: totalBeforeSearch),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: theme.colorScheme.onSurface
                                                  .withAlpha(100)),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (_searchQuery.isEmpty &&
                                    !state.result.diff.values.any((e) =>
                                        e.status !=
                                        StringComparisonStatus.identical)) {
                                  content = Center(
                                      key: const ValueKey('identical'),
                                      child: Text(context
                                          .t.fileComparison.filesIdentical));
                                } else if (diffEntries.isEmpty &&
                                    hiddenIdenticalCount > 0) {
                                  // If we hid everything (e.g. only identicals existed and we hid them)
                                  content = Column(
                                    key: const ValueKey('hidden_identical'),
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          context.t.fileComparison
                                              .hiddenIdentical(
                                                  count: hiddenIdenticalCount),
                                          style: TextStyle(
                                              color: theme.colorScheme.onSurface
                                                  .withAlpha(150))),
                                      const SizedBox(height: 8),
                                      TextButton(
                                        onPressed: () {
                                          context.read<SettingsBloc>().add(
                                              const UpdateShowIdenticalEntries(
                                                  true));
                                        },
                                        child: Text(context
                                            .t.fileComparison.showIdentical),
                                      )
                                    ],
                                  );
                                } else {
                                  content = Center(
                                      key: const ValueKey('no_diff'),
                                      child: Text(
                                          context.t.fileComparison.noDiff));
                                }
                              } else {
                                content = Column(
                                  key: const ValueKey('results'),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Hidden entries summary
                                    if (hiddenIdenticalCount > 0)
                                      Container(
                                        width: double.infinity,
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: theme.dividerColor
                                                  .withValues(alpha: 0.2)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(LucideIcons.eyeOff,
                                                size: 16,
                                                color: theme.colorScheme
                                                    .onSurfaceVariant),
                                            const SizedBox(width: 8),
                                            Text(
                                              context.t.fileComparison
                                                  .hiddenIdentical(
                                                      count:
                                                          hiddenIdenticalCount),
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                fontStyle: FontStyle.italic,
                                                color: theme.colorScheme
                                                    .onSurfaceVariant,
                                              ),
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                minimumSize: const Size(60, 24),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                              ),
                                              onPressed: () {
                                                context.read<SettingsBloc>().add(
                                                    const UpdateShowIdenticalEntries(
                                                        true));
                                              },
                                              child: Text(context
                                                  .t.fileComparison.show),
                                            ),
                                          ],
                                        ),
                                      ),

                                    // Result count header when search is active
                                    if (_searchQuery.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 8),
                                        child: Text(
                                          context.t.fileComparison
                                              .showingEntries(
                                                  count: diffEntries.length,
                                                  total: totalBeforeSearch),
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: theme.colorScheme.onSurface
                                                .withAlpha(150),
                                          ),
                                        ),
                                      ),
                                    Expanded(
                                      child: Builder(builder: (context) {
                                        final filteredCount =
                                            diffEntries.length;

                                        // Handle "All" selection (-1)
                                        final effectiveItemsPerPage =
                                            _itemsPerPage == -1
                                                ? math.max(1, filteredCount)
                                                : _itemsPerPage;

                                        final startIndex = _currentPage *
                                            effectiveItemsPerPage;
                                        final endIndex = math.min(
                                            startIndex + effectiveItemsPerPage,
                                            filteredCount);
                                        final visibleEntries =
                                            (startIndex < filteredCount)
                                                ? diffEntries.sublist(
                                                    startIndex, endIndex)
                                                : <MapEntry<String,
                                                    ComparisonStatusDetail>>[];

                                        return Column(
                                          children: [
                                            Expanded(
                                              child: Scrollbar(
                                                controller: _scrollController,
                                                thumbVisibility: true,
                                                child: ListView.builder(
                                                  controller: _scrollController,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  itemCount:
                                                      visibleEntries.length,
                                                  addAutomaticKeepAlives: false,
                                                  addRepaintBoundaries: false,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final entry =
                                                        visibleEntries[index];
                                                    final globalIndex =
                                                        startIndex + index;
                                                    final key = entry.key;
                                                    final statusDetail =
                                                        entry.value;
                                                    final status =
                                                        statusDetail.status;
                                                    final value1 = state
                                                        .result.file1Data[key];
                                                    final value2 = state
                                                        .result.file2Data[key];

                                                    final lineNumber =
                                                        (globalIndex + 1)
                                                            .toString()
                                                            .padLeft(3, '0');

                                                    final lineSettingsState =
                                                        context
                                                            .watch<
                                                                SettingsBloc>()
                                                            .state;
                                                    String lineFontFamily =
                                                        'Consolas, Monaco, monospace';
                                                    double lineFontSize = 12.0;
                                                    if (lineSettingsState
                                                            .status ==
                                                        SettingsStatus.loaded) {
                                                      try {
                                                        final ff =
                                                            lineSettingsState
                                                                .appSettings
                                                                .diffFontFamily;
                                                        if (ff.isNotEmpty &&
                                                            ff !=
                                                                'System Default')
                                                          lineFontFamily = ff;
                                                        lineFontSize =
                                                            lineSettingsState
                                                                .appSettings
                                                                .diffFontSize;
                                                      } catch (_) {}
                                                    }

                                                    return RepaintBoundary(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: 48,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    8, 4, 8, 4),
                                                            child: Text(
                                                              lineNumber,
                                                              style: TextStyle(
                                                                color: theme
                                                                    .colorScheme
                                                                    .outline,
                                                                fontFamily:
                                                                    lineFontFamily,
                                                                fontSize:
                                                                    lineFontSize,
                                                                height: 1.4,
                                                              ),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: DiffListItem(
                                                              diffKey: key,
                                                              status: status,
                                                              value1: value1,
                                                              value2: value2,
                                                              isAmoled:
                                                                  isAmoled,
                                                              settingsState:
                                                                  settingsState,
                                                              themeState:
                                                                  themeState,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: theme.cardColor,
                                                border: Border(
                                                    top: BorderSide(
                                                        color: theme
                                                            .dividerColor)),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      '${context.t.fileComparison.show}: ',
                                                      style: theme
                                                          .textTheme.bodySmall),
                                                  DropdownButton<int>(
                                                    value: _itemsPerPage,
                                                    underline: const SizedBox(),
                                                    style: theme
                                                        .textTheme.bodySmall,
                                                    items: _availablePageSizes
                                                        .map((e) {
                                                      final text = e == -1
                                                          ? context
                                                              .t
                                                              .fileComparison
                                                              .showAll
                                                          : '$e';
                                                      return DropdownMenuItem(
                                                          value: e,
                                                          child: Text(text));
                                                    }).toList(),
                                                    onChanged: (v) {
                                                      if (v != null &&
                                                          v != _itemsPerPage) {
                                                        setState(() {
                                                          _itemsPerPage = v;
                                                          _currentPage = 0;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                      '${startIndex + 1}-$endIndex of $filteredCount',
                                                      style: theme
                                                          .textTheme.bodySmall),
                                                  const SizedBox(width: 8),
                                                  IconButton(
                                                    icon: const Icon(LucideIcons
                                                        .chevronsLeft),
                                                    tooltip: 'First page',
                                                    splashRadius: 20,
                                                    onPressed: _currentPage > 0
                                                        ? () {
                                                            setState(() =>
                                                                _currentPage =
                                                                    0);
                                                            _scrollController
                                                                .jumpTo(0);
                                                          }
                                                        : null,
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(LucideIcons
                                                        .chevronLeft),
                                                    tooltip: 'Previous page',
                                                    splashRadius: 20,
                                                    onPressed: _currentPage > 0
                                                        ? () {
                                                            setState(() =>
                                                                _currentPage--);
                                                            _scrollController
                                                                .jumpTo(0);
                                                          }
                                                        : null,
                                                  ),
                                                  Text(
                                                      ' ${_currentPage + 1} / ${(filteredCount / effectiveItemsPerPage).ceil()} ',
                                                      style: theme
                                                          .textTheme.bodySmall),
                                                  IconButton(
                                                    icon: const Icon(LucideIcons
                                                        .chevronRight),
                                                    tooltip: 'Next page',
                                                    splashRadius: 20,
                                                    onPressed:
                                                        endIndex < filteredCount
                                                            ? () {
                                                                setState(() =>
                                                                    _currentPage++);
                                                                _scrollController
                                                                    .jumpTo(0);
                                                              }
                                                            : null,
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(LucideIcons
                                                        .chevronsRight),
                                                    tooltip: 'Last page',
                                                    splashRadius: 20,
                                                    onPressed:
                                                        endIndex < filteredCount
                                                            ? () {
                                                                final lastPage =
                                                                    (filteredCount /
                                                                                effectiveItemsPerPage)
                                                                            .ceil() -
                                                                        1;
                                                                setState(() =>
                                                                    _currentPage =
                                                                        lastPage);
                                                                _scrollController
                                                                    .jumpTo(0);
                                                              }
                                                            : null,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ],
                                );
                              }
                            } else if (state is ComparisonFailure) {
                              content = Center(
                                  key: const ValueKey('failure'),
                                  child: Text(
                                      context.t.fileComparison
                                          .comparisonFailed(error: state.error),
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error)));
                            } else {
                              content = _buildEmptyState(context, isAmoled);
                            }

                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              switchInCurve: Curves.easeOutCubic,
                              switchOutCurve: Curves.easeInCubic,
                              child: content,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // UserOnboardingChecklist removed
            ],
          ),
        ),
      ),
    );
  }

  FileFormat _exportFileFormat(String format) {
    switch (format) {
      case 'Excel':
        return Formats.xlsx;
      case 'JSON':
        return Formats.json;
      default:
        return Formats.csv;
    }
  }

  Future<DragItem?> _buildExportDragItem(
    DragItemRequest request,
  ) async {
    if (_latestComparisonResult == null) {
      return null;
    }

    final settings = context.read<SettingsBloc>().state.appSettings;
    final format = settings.defaultExportFormat;
    final fileName = _exportService.exportFileName(format);

    final item = DragItem(
      localData: {
        'type': 'comparison_export',
        'format': format,
      },
      suggestedName: fileName,
    );

    if (!item.virtualFileSupported && format != 'JSON' && format != 'CSV') {
      return null;
    }

    final bytes =
        await _exportService.buildExportBytes(_latestComparisonResult!, format);

    if (item.virtualFileSupported) {
      item.addVirtualFile(
        format: _exportFileFormat(format),
        provider: (sinkProvider, progress) {
          final sink = sinkProvider(fileSize: bytes.length);
          sink.add(bytes);
          sink.close();
        },
      );
    } else {
      item.add(Formats.plainText(utf8.decode(bytes)));
    }

    return item;
  }

  Future<void> _exportResult() async {
    if (_latestComparisonResult == null) return;

    // Mark onboarding as completed if at export step (step 7)
    if (context.read<SettingsBloc>().state.appSettings.onboardingStep == 7) {
      context.read<SettingsBloc>().add(const UpdateIsOnboardingCompleted(true));
    }

    final settings = context.read<SettingsBloc>().state.appSettings;
    final format = settings.defaultExportFormat;

    if (format == 'Excel') {
      await _exportToExcel();
    } else if (format == 'JSON') {
      await _exportToJson();
    } else {
      await _exportToCsv();
    }
  }

  Future<void> _exportToExcel() async {
    final fileBytes = _exportService.buildExcelBytes(_latestComparisonResult!);

    // Save
    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Excel Report',
      fileName: 'comparison_report.xlsx',
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (outputPath != null) {
      try {
        _taskbar.setIndeterminate();

        final settings = context.read<SettingsBloc>().state.appSettings;
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        if (fileBytes.isNotEmpty) {
          File(outputPath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(fileBytes);

          if (mounted) {
            if (settings.openFolderAfterExport) {
              // SECURITY: Use validated file explorer utility
              FileExplorerUtils.openDirectory(File(outputPath).parent.path);
            }

            ToastService.showSuccessWithAction(
              context,
              context.t.fileComparison.saved(format: 'Excel'),
              actionLabel: context.t.common.open,
              onAction: () => OpenFile.open(outputPath),
            );
          }
        } else if (mounted) {
          ToastService.showError(
              context, context.t.fileComparison.saveError(format: 'Excel'));
        }

        _taskbar.clearProgress();
      } catch (e) {
        _taskbar.setError();

        if (mounted) {
          ToastService.showError(
              context,
              context.t.fileComparison
                  .saveErrorDetailed(format: 'Excel', error: e));
        }
      }
    }
  }

  Future<void> _exportToJson() async {
    final jsonString = _exportService.buildJsonString(_latestComparisonResult!);

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: context.t.fileComparison.exportReport(format: 'JSON'),
      fileName: 'comparison_report.json',
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (outputPath != null) {
      try {
        _taskbar.setIndeterminate();

        final settings = context.read<SettingsBloc>().state.appSettings;
        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        await File(outputPath).writeAsString(jsonString);
        if (mounted) {
          if (settings.openFolderAfterExport) {
            // SECURITY: Use validated file explorer utility
            FileExplorerUtils.openDirectory(File(outputPath).parent.path);
          }
          ToastService.showSuccessWithAction(
            context,
            context.t.fileComparison.saved(format: 'JSON'),
            actionLabel: context.t.common.open,
            onAction: () => OpenFile.open(outputPath),
          );
        }

        _taskbar.clearProgress();
      } catch (e) {
        _taskbar.setError();

        if (mounted) {
          ToastService.showError(
              context,
              context.t.fileComparison
                  .saveErrorDetailed(format: 'JSON', error: e));
        }
      }
    }
  }

  Future<void> _exportToCsv() async {
    final settings = context.read<SettingsBloc>().state.appSettings;
    final csvString = _exportService.buildCsvString(
      _latestComparisonResult!,
      includeUtf8Bom: settings.includeUtf8Bom,
    );

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: context.t.fileComparison.exportReport(format: 'CSV'),
      fileName: 'comparison_report.csv',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (outputPath != null) {
      try {
        _taskbar.setIndeterminate();

        await BackupService().createBackupIfNeeded(
          targetPath: outputPath,
          settings: settings,
        );
        await File(outputPath).writeAsString(csvString);
        if (mounted) {
          if (settings.openFolderAfterExport) {
            // SECURITY: Use validated file explorer utility
            FileExplorerUtils.openDirectory(File(outputPath).parent.path);
          }
          ToastService.showSuccessWithAction(
            context,
            context.t.fileComparison.saved(format: 'CSV'),
            actionLabel: context.t.common.open,
            onAction: () => OpenFile.open(outputPath),
          );
        }

        _taskbar.clearProgress();
      } catch (e) {
        _taskbar.setError();

        if (mounted) {
          ToastService.showError(
              context,
              context.t.fileComparison
                  .saveErrorDetailed(format: 'CSV', error: e));
        }
      }
    }
  }

  Widget _buildAnalyticsAndActionsBar(
      SettingsState settingsState, AppThemeState themeState) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final bool isAmoled = isDarkMode &&
        settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled';

    int totalKeys = 0;
    int addedCount = 0;
    int removedCount = 0;
    int modifiedCount = 0;

    if (_latestComparisonResult != null) {
      final allKeys = Set<String>.from(_latestComparisonResult!.file1Data.keys);
      allKeys.addAll(_latestComparisonResult!.file2Data.keys);
      totalKeys = allKeys.length;
      _latestComparisonResult!.diff.forEach((key, statusDetail) {
        switch (statusDetail.status) {
          case StringComparisonStatus.added:
            addedCount++;
            break;
          case StringComparisonStatus.removed:
            removedCount++;
            break;
          case StringComparisonStatus.modified:
            modifiedCount++;
            break;
          default:
            break;
        }
      });
    }

    final Color cardBg =
        isAmoled ? Colors.black : (theme.cardTheme.color ?? theme.cardColor);
    final Color borderColor = isAmoled ? Colors.grey[850]! : theme.dividerColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // Stats Section
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildStatsChart(
                      addedCount, removedCount, modifiedCount, themeState),
                  const SizedBox(width: 16),
                  _buildCompactStat(context.t.fileComparison.total, totalKeys,
                      theme.colorScheme.onSurface.withAlpha(180)),
                  const SizedBox(width: 16),
                  _buildCompactStat(
                      '+${addedCount}', null, themeState.diffAddedColor),
                  const SizedBox(width: 12),
                  _buildCompactStat(
                      '-${removedCount}', null, themeState.diffRemovedColor),
                  const SizedBox(width: 12),
                  _buildCompactStat(
                      '~${modifiedCount}', null, themeState.diffModifiedColor),
                  // File watcher removed (moved to settings)
                ],
              ),
            ),
          ),

          // Search Field
          Container(
            key: _keySearchBar,
            width: 320,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withAlpha(100),
                ),
                prefixIcon: Icon(
                  LucideIcons.search,
                  size: 18,
                  color: theme.colorScheme.onSurface.withAlpha(120),
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          LucideIcons.x,
                          size: 16,
                          color: theme.colorScheme.onSurface.withAlpha(120),
                        ),
                        tooltip: 'Clear search',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: theme.colorScheme.primary, width: 1.5),
                ),
                filled: true,
                fillColor: isAmoled
                    ? Colors.grey[900]
                    : (isDarkMode ? const Color(0xFF252530) : Colors.grey[50]),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // Search Toggles
          _buildSearchToggle(
              'Regex',
              '.*',
              _isRegexEnabled,
              (val) => setState(() {
                    _isRegexEnabled = val;
                    if (val) _isFuzzyEnabled = false;
                  }),
              theme),
          const SizedBox(width: 4),
          _buildSearchToggle(
              'Fuzzy',
              '~',
              _isFuzzyEnabled,
              (val) => setState(() {
                    _isFuzzyEnabled = val;
                    if (val) _isRegexEnabled = false;
                  }),
              theme),
          const SizedBox(width: 8),

          // Filter Toggle Buttons (icon-only to prevent overflow)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              key: _keyFilterChips,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFilterChip(
                  BasicDiffFilter.added,
                  context.t.diff.extra,
                  themeState.diffAddedColor,
                  context.t.diff.extra,
                ),
                const SizedBox(width: 4),
                _buildFilterChip(
                  BasicDiffFilter.removed,
                  context.t.diff.missing,
                  themeState.diffRemovedColor,
                  context.t.diff.missing,
                ),
                const SizedBox(width: 4),
                _buildFilterChip(
                  BasicDiffFilter.modified,
                  context.t.diff.modified,
                  themeState.diffModifiedColor,
                  context.t.diff.modified,
                ),
                const SizedBox(width: 4),
                _buildFilterChip(
                  BasicDiffFilter.problems,
                  context.t.quality.issues,
                  Colors.orange,
                  context.t.quality.issues,
                ),
                const SizedBox(width: 8),
                // Toggle Identical Logic
                IconButton(
                  icon: Icon(
                    settingsState.appSettings.showIdenticalEntries
                        ? LucideIcons.eye
                        : LucideIcons.eyeOff,
                    color: settingsState.appSettings.showIdenticalEntries
                        ? theme.colorScheme.onSurface.withAlpha(180)
                        : theme.colorScheme.onSurface.withAlpha(100),
                    size: 20,
                  ),
                  tooltip: settingsState.appSettings.showIdenticalEntries
                      ? context.t.fileComparison.hideIdentical
                      : context.t.fileComparison.showIdentical,
                  onPressed: () {
                    context.read<SettingsBloc>().add(UpdateShowIdenticalEntries(
                        !settingsState.appSettings.showIdenticalEntries));
                  },
                ),
                // Show All reset
                IconButton(
                  icon: const Icon(LucideIcons.filterX, size: 20),
                  tooltip: context.t.fileComparison.showAll,
                  onPressed: _currentFilter != BasicDiffFilter.all
                      ? () =>
                          setState(() => _currentFilter = BasicDiffFilter.all)
                      : null,
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 28,
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: borderColor,
          ),

          // Action Buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildExportActionButton(
                key: _keyExportButton,
                icon: LucideIcons.download,
                label: context.t.common.export,
                onPressed: _exportResult,
                color: theme.colorScheme.onSurface,
                tooltip: context.t.common.export,
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: context.t.common.edit,
                child: FilledButton.icon(
                  key: _keyAdvancedButton,
                  icon: const Icon(LucideIcons.maximize, size: 16),
                  label: Text(context.t.common.edit),
                  onPressed: _navigateToAdvancedView,
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              // AI button moved to Advanced view
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchToggle(String tooltip, String label, bool value,
      Function(bool) onChanged, ThemeData theme) {
    // Determine active color
    final isActive = value;
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.colorScheme.onSurface.withValues(alpha: 0.5);

    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        checked: value,
        label: label,
        child: InkWell(
          onTap: () => onChanged(!value),
          borderRadius: BorderRadius.circular(4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
                color: isActive
                    ? activeColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isActive ? activeColor : Colors.transparent,
                )),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsChart(
      int added, int removed, int modified, AppThemeState themeState) {
    final total = added + removed + modified;
    if (total == 0) return const SizedBox.shrink();

    return Tooltip(
      message:
          '${context.t.dialogs.diffViewer.added}: $added\n${context.t.dialogs.diffViewer.removed}: $removed\n${context.t.dialogs.diffViewer.modified}: $modified',
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 12,
      ),
      child: SizedBox(
        width: 40,
        height: 40,
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: added.toDouble(),
                color: themeState.diffAddedColor,
                radius: 6,
                showTitle: false,
              ),
              PieChartSectionData(
                value: removed.toDouble(),
                color: themeState.diffRemovedColor,
                radius: 6,
                showTitle: false,
              ),
              PieChartSectionData(
                value: modified.toDouble(),
                color: themeState.diffModifiedColor,
                radius: 6,
                showTitle: false,
              ),
            ],
            sectionsSpace: 2,
            centerSpaceRadius: 10,
            startDegreeOffset: 270,
          ),
        ),
      ),
    );
  }

  Widget _buildCompactStat(String label, int? value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value != null ? '$label: $value' : label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    BasicDiffFilter filter,
    String label,
    Color color,
    String tooltip,
  ) {
    final bool isActive = _currentFilter == filter;
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: FilterChip(
        label: Text(label),
        selected: isActive,
        onSelected: (bool value) {
          if (value) {
            setState(() => _currentFilter = filter);
          } else {
            setState(() => _currentFilter = BasicDiffFilter.all);
          }
        },
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: TextStyle(
          fontSize: 12,
          color: isActive ? color : theme.colorScheme.onSurface.withAlpha(180),
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: Colors.transparent,
        selectedColor: color.withValues(alpha: 0.15),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
      ),
    );
  }

  Widget _buildCompactActionButton({
    Key? key,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
    String? tooltip,
  }) {
    final button = TextButton.icon(
      key: key,
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip, child: button);
    }
    return button;
  }

  Widget _buildExportActionButton({
    Key? key,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
    String? tooltip,
  }) {
    final button = _buildCompactActionButton(
      key: key,
      icon: icon,
      label: label,
      onPressed: onPressed,
      color: color,
      tooltip: tooltip,
    );

    if (_latestComparisonResult == null) {
      return button;
    }

    return DragItemWidget(
      allowedOperations: () => [DropOperation.copy],
      dragItemProvider: _buildExportDragItem,
      child: DraggableWidget(
        child: button,
      ),
    );
  }

  Widget _buildFileWatcherStatus(
      SettingsState settingsState, bool isAmoled, bool isDarkMode) {
    final isAutoReloadEnabled = settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.autoReloadOnChange;

    return BlocBuilder<FileWatcherBloc, FileWatcherState>(
      builder: (context, watcherState) {
        final isWatching =
            watcherState is FileWatcherActive && watcherState.isEnabled;

        return Tooltip(
          message: context.t.fileComparison.watchingTooltip(
              status: isWatching
                  ? context.t.common.enabled
                  : context.t.common.disabled),
          waitDuration: const Duration(milliseconds: 500),
          child: InputChip(
            avatar: isWatching
                ? const _PulsingIndicator()
                : Icon(
                    LucideIcons.eyeOff,
                    size: 16,
                    color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                  ),
            label: Text(
              isWatching
                  ? context.t.fileComparison.watching
                  : context.t.fileComparison.watchOff,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isWatching ? FontWeight.bold : FontWeight.normal,
                color: isWatching
                    ? (isDarkMode ? Colors.green[400] : Colors.green[800])
                    : (isDarkMode ? Colors.grey[400] : Colors.grey[700]),
              ),
            ),
            selected: isAutoReloadEnabled,
            showCheckmark: false,
            onSelected: (value) => _toggleFileWatching(value),
            backgroundColor: Colors.transparent,
            selectedColor: isDarkMode
                ? Colors.green.withValues(alpha: 0.15)
                : Colors.green.withValues(alpha: 0.1),
            side: BorderSide(
              color: isWatching
                  ? (isDarkMode ? Colors.green[700]! : Colors.green[600]!)
                  : (isDarkMode ? Colors.grey[800]! : Colors.grey[300]!),
            ),
            padding: const EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, bool isAmoled) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final textSecondary = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Animated Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: const _AnimatedEmptyStateIcon(),
              ),
              const SizedBox(height: 24),
              // Headline
              Text(
                context.t.fileComparison.readyToCompare,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              // Description
              Text(
                context.t.fileComparison.readyToCompareDesc,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Supported formats with tooltips
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: _buildFormatBadges(theme),
              ),
              const SizedBox(height: 32),
              // Recent Comparisons Section
              BlocBuilder<HistoryBloc, HistoryState>(
                builder: (context, historyState) {
                  if (historyState is HistoryLoaded &&
                      historyState.history.isNotEmpty) {
                    final recentItems = historyState.history.take(5).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                            color: theme.dividerColor.withValues(alpha: 0.5)),
                        const SizedBox(height: 12),
                        Text(
                          context.t.fileComparison.recentComparisons,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...recentItems.map((session) =>
                            _buildRecentComparisonItem(
                                context, session, theme, textSecondary)),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentComparisonItem(BuildContext context,
      ComparisonSession session, ThemeData theme, Color textSecondary) {
    final sourceName = session.file1Path.split(Platform.pathSeparator).last;
    final targetName = session.file2Path.split(Platform.pathSeparator).last;
    final isBilingualSession = session.file1Path == session.file2Path;
    final title = isBilingualSession
        ? context.t.fileComparison.bilingualFileLabel(name: sourceName)
        : context.t.fileComparison
            .comparisonLabel(source: sourceName, target: targetName);

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(LucideIcons.clock,
          color: theme.colorScheme.primary.withValues(alpha: 0.7)),
      title: Text(
        title,
        style:
            theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _timeAgo(session.timestamp),
        style: theme.textTheme.bodySmall?.copyWith(color: textSecondary),
      ),
      onTap: () => _loadRecentComparison(session),
    );
  }

  void _loadRecentComparison(ComparisonSession session) {
    // Handle non-file comparison types
    if (session.type == ComparisonType.git) {
      ToastService.showInfo(
          context, 'Git comparisons should be opened from the Repository tab.');
      return;
    }
    if (session.type == ComparisonType.directory) {
      ToastService.showInfo(context,
          'Directory comparisons should be opened from the Directory tab.');
      return;
    }

    final file1 = File(session.file1Path);
    final file2 = File(session.file2Path);
    final isBilingualSession = session.file1Path == session.file2Path;

    final shouldCheckBoth = !isBilingualSession;
    if (!file1.existsSync() || (shouldCheckBoth && !file2.existsSync())) {
      ToastService.showError(context, context.t.fileComparison.fileNotExist);
      return;
    }

    setState(() {
      _isBilingualMode = isBilingualSession;
      if (isBilingualSession) {
        _bilingualFile = file1;
      } else {
        _file1 = file1;
        _file2 = file2;
      }
    });
    _startComparison();
  }

  String _timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return context.t.history.timeAgo.justNow;
    } else if (difference.inMinutes < 60) {
      return context.t.history.timeAgo.minutesAgo(count: difference.inMinutes);
    } else if (difference.inHours < 24) {
      return context.t.history.timeAgo.hoursAgo(count: difference.inHours);
    } else if (difference.inDays < 7) {
      return context.t.history.timeAgo.daysAgo(count: difference.inDays);
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  List<Widget> _buildFormatBadges(ThemeData theme) {
    const formatDescriptions = {
      '.lang': 'Key-value language files',
      '.json': 'JSON localization files (i18next, Flutter, etc.)',
      '.xml': 'Android XML strings',
      '.xliff': 'XLIFF translation interchange format',
      '.properties': 'Java .properties files',
      '.yaml': 'YAML localization files (Rails, Flutter)',
    };

    return formatDescriptions.entries.map((entry) {
      return Tooltip(
        message: entry.value,
        preferBelow: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.help,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Text(
              entry.key,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
                fontFamily: 'Consolas, Monaco, monospace',
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Future<void> _showLargeFileWarningDialog(
      BuildContext context, ComparisonLargeFileWarning state) async {
    bool dontShowAgain = false;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(context.t.fileComparison.largeFileTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.fileComparison
                        .largeFileContent(count: state.count),
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    value: dontShowAgain,
                    onChanged: (value) {
                      setState(() {
                        dontShowAgain = value ?? false;
                      });
                    },
                    title: Text(
                      context.t.fileComparison.dontShowAgain,
                      style: const TextStyle(fontSize: 14),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(context.t.common.cancel),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();

                    // If "Don't show again" is checked, suppress the warning for this file
                    if (dontShowAgain) {
                      context.read<ComparisonBloc>().add(
                            SuppressLargeFileWarning(state.file1.path),
                          );
                    }

                    context.read<ComparisonBloc>().add(ProceedWithComparison(
                        state.result, state.file1, state.file2,
                        wasLoadedFromHistory: state.wasLoadedFromHistory));
                  },
                  child: Text(context.t.fileComparison.proceed),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _PulsingIndicator extends StatefulWidget {
  const _PulsingIndicator();

  @override
  State<_PulsingIndicator> createState() => _PulsingIndicatorState();
}

class _PulsingIndicatorState extends State<_PulsingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FadeTransition(
      opacity: _animation,
      child: Icon(
        LucideIcons.eye,
        size: 16,
        color: isDark ? Colors.green[400] : Colors.green[700],
      ),
    );
  }
}

class _AnimatedEmptyStateIcon extends StatefulWidget {
  const _AnimatedEmptyStateIcon();

  @override
  State<_AnimatedEmptyStateIcon> createState() =>
      _AnimatedEmptyStateIconState();
}

class _AnimatedEmptyStateIconState extends State<_AnimatedEmptyStateIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _floatAnimation;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    // Smooth floating up and down
    _floatAnimation = Tween<double>(begin: 0, end: -12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // Pulsing background glow
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // Very subtle rotation for more "life"
    _rotateAnimation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing background glow
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(
                            alpha: 0.2 * (2 - _pulseAnimation.value)),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
              // Floating and rotating icon
              Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Transform.rotate(
                  angle: _rotateAnimation.value,
                  child: Icon(
                    LucideIcons.arrowRightLeft,
                    size: 48,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
