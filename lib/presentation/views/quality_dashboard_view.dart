import 'dart:developer' as developer;

import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/project_bloc/project_state.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/di/service_locator.dart';
import 'package:localizer_app_main/core/services/ai_usage_service.dart';
import 'package:localizer_app_main/core/services/quality_metrics_service.dart';
import 'package:localizer_app_main/data/models/ai_usage_summary.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/common/common_widgets.dart';
import 'package:localizer_app_main/presentation/widgets/dialogs/issue_details_dialog.dart';
import 'package:localizer_app_main/core/services/quality_report_exporter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:localizer_app_main/core/services/toast_service.dart';
import 'package:open_file_plus/open_file_plus.dart';

enum DashboardChartMode { words, coverage, burnUp }

class QualityDashboardView extends StatefulWidget {
  const QualityDashboardView({super.key});

  @override
  State<QualityDashboardView> createState() => _QualityDashboardViewState();
}

class _QualityDashboardViewState extends State<QualityDashboardView>
    with SingleTickerProviderStateMixin {
  final QualityMetricsService _metricsService = QualityMetricsService();
  final AiUsageService _aiUsageService = sl<AiUsageService>();
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  Future<QualityDashboardData>? _dashboardFuture;
  Future<AiUsageSummary>? _aiUsageFuture;
  List<ComparisonSession> _history = [];
  DashboardChartMode _chartMode = DashboardChartMode.words;
  bool _showOnlyCurrentProject = true;
  final _exporter = QualityReportExporter();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
    context.read<HistoryBloc>().add(LoadHistory());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _refreshDashboard({bool reloadHistory = false}) {
    if (reloadHistory) {
      context.read<HistoryBloc>().add(LoadHistory());
      return;
    }

    final settingsState = context.read<SettingsBloc>().state;
    if (settingsState.status != SettingsStatus.loaded) {
      return;
    }

    final projectState = context.read<ProjectBloc>().state;
    String? currentProjectId;
    if (projectState.status == ProjectStatus.loaded) {
      currentProjectId = projectState.currentProject?.id;
    }

    // Filter history based on project toggle
    final filteredHistory =
        (_showOnlyCurrentProject && currentProjectId != null)
            ? _history.where((s) => s.projectId == currentProjectId).toList()
            : _history;

    setState(() {
      _dashboardFuture = _metricsService.buildDashboardData(
        history: filteredHistory,
        settings: settingsState.appSettings,
      );
      _aiUsageFuture = _aiUsageService.getSummary();
    });
  }

  Future<void> _exportReport() async {
    QualityDashboardData? data;
    try {
      data = await _dashboardFuture;
    } catch (e, s) {
      developer.log(
        'Failed to build dashboard data for export.',
        name: 'QualityDashboardView',
        error: e,
        stackTrace: s,
      );
      if (mounted) {
        ToastService.showError(
          context,
          'Could not build the report. Please try again.',
        );
      }
      return;
    }
    if (data == null) {
      if (mounted) {
        ToastService.showInfo(context, 'No data to export');
      }
      return;
    }

    final bytes = _exporter.toExcelBytes(data);
    if (bytes.isEmpty) {
      if (mounted) {
        ToastService.showError(context, 'Export failed');
      }
      return;
    }

    final timestamp = DateFormat('yyyyMMdd_HHmm').format(DateTime.now());
    final fileName = 'quality_report_$timestamp.xlsx';

    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Quality Report',
      fileName: fileName,
      allowedExtensions: ['xlsx'],
      type: FileType.custom,
    );

    if (result != null) {
      var path = result;
      if (!path.toLowerCase().endsWith('.xlsx')) {
        path = '$path.xlsx';
      }
      final file = File(path);
      await file.writeAsBytes(bytes, flush: true);
      if (mounted) {
        ToastService.showSuccessWithAction(
          context,
          'Report saved',
          actionLabel: 'Open',
          onAction: () => OpenFile.open(file.path),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final settingsState = context.watch<SettingsBloc>().state;
    final isAmoled = settingsState.status == SettingsStatus.loaded &&
        settingsState.appSettings.appThemeMode.toLowerCase() == 'amoled' &&
        isDark;

    final cardColor = isAmoled
        ? AppThemeV2.amoledCard
        : (isDark ? AppThemeV2.darkCard : AppThemeV2.lightCard);
    final borderColor = isAmoled
        ? AppThemeV2.amoledBorder
        : (isDark ? AppThemeV2.darkBorder : AppThemeV2.lightBorder);

    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryLoaded) {
          _history = state.history;
          _refreshDashboard();
        }
      },
      builder: (context, state) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _DashboardHeader(
                  onRefresh: () => _refreshDashboard(reloadHistory: true),
                  onExport: _exportReport,
                  isProjectLoaded: context.watch<ProjectBloc>().state.status ==
                      ProjectStatus.loaded,
                  showProjectFilter: _showOnlyCurrentProject,
                  onToggleProjectFilter: () {
                    setState(() {
                      _showOnlyCurrentProject = !_showOnlyCurrentProject;
                      _refreshDashboard();
                    });
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _buildBody(
                    state: state,
                    cardColor: cardColor,
                    borderColor: borderColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody({
    required HistoryState state,
    required Color cardColor,
    required Color borderColor,
  }) {
    if (state is HistoryLoading && _dashboardFuture == null) {
      return const LoadingIndicator(message: 'Loading dashboard...');
    }

    if (state is HistoryError) {
      return ErrorDisplay(
        message: 'We could not load your history. Try again.',
        onRetry: () => _refreshDashboard(reloadHistory: true),
      );
    }

    if (_history.isEmpty) {
      return EmptyStateDisplay(
        icon: Icons.insights_outlined,
        message: 'Run a comparison to see your dashboard.',
        action: OutlinedButton.icon(
          onPressed: () => _refreshDashboard(reloadHistory: true),
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh'),
        ),
      );
    }

    if (_dashboardFuture == null) {
      return const LoadingIndicator(message: 'Building insights...');
    }

    return FutureBuilder<QualityDashboardData>(
      future: _dashboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingIndicator(message: 'Crunching the numbers...');
        }
        if (snapshot.hasError) {
          return ErrorDisplay(
            message: 'We could not build the dashboard. Try again.',
            onRetry: () => _refreshDashboard(reloadHistory: true),
          );
        }

        final data = snapshot.data;
        if (data == null || data.languages.isEmpty) {
          return EmptyStateDisplay(
            icon: Icons.insights_outlined,
            message: 'No usable data was found yet.',
            action: OutlinedButton.icon(
              onPressed: () => _refreshDashboard(reloadHistory: true),
              icon: const Icon(LucideIcons.refreshCcw),
              label: const Text('Refresh'),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SummaryRow(data: data),
              if (_aiUsageFuture != null) ...[
                const SizedBox(height: 20),
                FutureBuilder<AiUsageSummary>(
                  future: _aiUsageFuture,
                  builder: (context, usageSnapshot) {
                    final summary = usageSnapshot.data;
                    if (summary == null || !summary.hasUsage) {
                      return const SizedBox.shrink();
                    }
                    return _AiUsageSection(
                      summary: summary,
                      cardColor: cardColor,
                      borderColor: borderColor,
                    );
                  },
                ),
              ],
              const SizedBox(height: 20),
              _CoverageSection(
                data: data,
                cardColor: cardColor,
                borderColor: borderColor,
              ),
              const SizedBox(height: 20),
              _MainChartSection(
                data: data,
                mode: _chartMode,
                cardColor: cardColor,
                borderColor: borderColor,
                onModeChanged: (newMode) {
                  setState(() {
                    _chartMode = newMode;
                  });
                },
              ),
              const SizedBox(height: 20),
              _ActivityTrendSection(
                data: data,
                cardColor: cardColor,
                borderColor: borderColor,
              ),
              const SizedBox(height: 20),
              _IssuesSection(
                data: data,
                cardColor: cardColor,
                borderColor: borderColor,
              ),
              if (data.warnings.isNotEmpty) ...[
                const SizedBox(height: 16),
                _WarningsBanner(
                  warnings: data.warnings,
                  cardColor: cardColor,
                  borderColor: borderColor,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({
    required this.onRefresh,
    required this.onExport,
    required this.isProjectLoaded,
    required this.showProjectFilter,
    required this.onToggleProjectFilter,
  });

  final VoidCallback onRefresh;
  final VoidCallback onExport;
  final bool isProjectLoaded;
  final bool showProjectFilter;
  final VoidCallback onToggleProjectFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          LucideIcons.barChart3,
          size: 28,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Quality Dashboard',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Tooltip(
          message: 'Refresh',
          child: IconButton(
            onPressed: onRefresh,
            icon: const Icon(LucideIcons.refreshCcw),
          ),
        ),
        if (isProjectLoaded) ...[
          const SizedBox(width: 8),
          Tooltip(
            message: showProjectFilter
                ? 'Showing: Current Project'
                : 'Showing: All History',
            child: IconButton(
              onPressed: onToggleProjectFilter,
              icon: Icon(
                showProjectFilter ? LucideIcons.filter : LucideIcons.filterX,
                color: showProjectFilter
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: onExport,
          icon: const Icon(LucideIcons.download, size: 18),
          label: const Text('Export'),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.data});

  final QualityDashboardData data;

  @override
  Widget build(BuildContext context) {
    final avgCoverage = data.averageCoveragePercent;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 780;
        final cards = [
          _SummaryCard(
            title: 'Languages',
            value: data.totalLanguages.toString(),
            icon: LucideIcons.languages,
          ),
          _SummaryCard(
            title: 'Average coverage',
            value: '${avgCoverage.toStringAsFixed(1)}%',
            icon: LucideIcons.percent,
          ),
          _SummaryCard(
            title: 'Potential issues',
            value: data.totalIssues.toString(),
            icon: LucideIcons.alertTriangle,
          ),
        ];

        if (isCompact) {
          return Column(
            children: cards
                .map((card) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: card,
                    ))
                .toList(),
          );
        }

        return Row(
          children: List.generate(cards.length, (index) {
            final card = cards[index];
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == cards.length - 1 ? 0 : 12.0,
                ),
                child: card,
              ),
            );
          }),
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiUsageSection extends StatelessWidget {
  const _AiUsageSection({
    required this.summary,
    required this.cardColor,
    required this.borderColor,
  });

  final AiUsageSummary summary;
  final Color cardColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    if (!summary.hasUsage) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI usage',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: summary.providers
                .map((provider) => _AiUsageCard(summary: provider))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _AiUsageCard extends StatelessWidget {
  const _AiUsageCard({required this.summary});

  final AiUsageProviderSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.6),
    );
    final valueStyle = theme.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );

    final lastUsed = summary.lastUsedAt;
    final lastUsedLabel = lastUsed != null
        ? DateFormat('MMM d, yyyy h:mm a').format(lastUsed)
        : null;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 220,
        maxWidth: 320,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary.providerName,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildUsageRow(
              label: 'Requests',
              value: summary.requestCount.toString(),
              labelStyle: labelStyle,
              valueStyle: valueStyle,
            ),
            _buildUsageRow(
              label: 'Total tokens',
              value: summary.totalTokens.toString(),
              labelStyle: labelStyle,
              valueStyle: valueStyle,
            ),
            _buildUsageRow(
              label: 'Prompt tokens',
              value: summary.promptTokens.toString(),
              labelStyle: labelStyle,
              valueStyle: valueStyle,
            ),
            _buildUsageRow(
              label: 'Completion tokens',
              value: summary.completionTokens.toString(),
              labelStyle: labelStyle,
              valueStyle: valueStyle,
            ),
            if (summary.lastModel != null &&
                summary.lastModel!.trim().isNotEmpty)
              _buildUsageRow(
                label: 'Last model',
                value: summary.lastModel!,
                labelStyle: labelStyle,
                valueStyle: valueStyle,
              ),
            if (lastUsedLabel != null)
              _buildUsageRow(
                label: 'Last used',
                value: lastUsedLabel,
                labelStyle: labelStyle,
                valueStyle: valueStyle,
              ),
            if (summary.lastLatencyMs != null)
              _buildUsageRow(
                label: 'Last time',
                value: '${summary.lastLatencyMs} ms',
                labelStyle: labelStyle,
                valueStyle: valueStyle,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageRow({
    required String label,
    required String value,
    TextStyle? labelStyle,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: labelStyle)),
          const SizedBox(width: 8),
          Flexible(child: Text(value, style: valueStyle)),
        ],
      ),
    );
  }
}

class _CoverageSection extends StatelessWidget {
  const _CoverageSection({
    required this.data,
    required this.cardColor,
    required this.borderColor,
  });

  final QualityDashboardData data;
  final Color cardColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Translation coverage',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...data.languages.map((report) {
            final coverage = report.coverage;
            final percent = coverage.coveragePercent;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          report.languageLabel,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${percent.toStringAsFixed(1)}%',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: percent / 100,
                      minHeight: 8,
                      backgroundColor:
                          theme.colorScheme.primary.withOpacity(0.12),
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${coverage.translatedKeyCount} of '
                    '${coverage.sourceKeyCount} entries translated',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _MainChartSection extends StatelessWidget {
  const _MainChartSection({
    required this.data,
    required this.mode,
    required this.cardColor,
    required this.borderColor,
    required this.onModeChanged,
  });

  final QualityDashboardData data;
  final DashboardChartMode mode;
  final Color cardColor;
  final Color borderColor;
  final ValueChanged<DashboardChartMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    // If we are in burnUp mode, we don't use WordTrend points for the chart,
    // but the summary row logic is currently tied to WordTrend points.
    // For simplicity, we hide the summary row for BurnUp for now,
    // or we could show a summary of Total Keys?
    // Let's hide it for BurnUp to prevent confusion until we build a specific summary.
    // UPDATE: We now show summary for all modes.
    const showSummary = true;
    final theme = Theme.of(context);

    // Calculate title based on mode
    String title;
    switch (mode) {
      case DashboardChartMode.words:
        title = 'Words added over time';
        break;
      case DashboardChartMode.coverage:
        title = 'Translation Coverage';
        break;
      case DashboardChartMode.burnUp:
        title = 'Completion vs Scope';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (mode == DashboardChartMode.burnUp)
                Text(
                  'Scope vs Progress',
                  style: theme.textTheme.bodySmall,
                )
              else
                Text(
                  mode == DashboardChartMode.coverage
                      ? 'Coverage %'
                      : 'Words Added',
                  style: theme.textTheme.bodySmall,
                ),
              const Spacer(),
              SegmentedButton<DashboardChartMode>(
                segments: const [
                  ButtonSegment(
                    value: DashboardChartMode.words,
                    label: Text('Words'),
                    icon: Icon(LucideIcons.type),
                  ),
                  ButtonSegment(
                    value: DashboardChartMode.coverage,
                    label: Text('Coverage'),
                    icon: Icon(LucideIcons.percent),
                  ),
                  ButtonSegment(
                    value: DashboardChartMode.burnUp,
                    label: Text('Scope'),
                    icon: Icon(LucideIcons.trendingUp),
                  ),
                ],
                selected: {mode},
                onSelectionChanged: (newSelection) =>
                    onModeChanged(newSelection.first),
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (showSummary)
            _TrendSummaryRow(
              mode: mode,
              wordPoints: data.wordTrend,
              burnUpPoints: data.burnUpTrend,
            ),
          if (showSummary) const SizedBox(height: 16),
          Container(
            height: 280,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: theme.dividerColor.withOpacity(0.4),
              ),
            ),
            child: mode == DashboardChartMode.burnUp
                ? _BurnUpChart(points: data.burnUpTrend)
                : _WordTrendChart(
                    points: data.wordTrend,
                    showCoverage: mode == DashboardChartMode.coverage,
                  ),
          ),
        ],
      ),
    );
  }
}

class _TrendSummaryRow extends StatelessWidget {
  const _TrendSummaryRow({
    required this.mode,
    this.wordPoints,
    this.burnUpPoints,
  });

  final DashboardChartMode mode;
  final List<WordTrendPoint>? wordPoints;
  final List<BurnUpPoint>? burnUpPoints;

  @override
  Widget build(BuildContext context) {
    if (mode == DashboardChartMode.burnUp) {
      if (burnUpPoints == null || burnUpPoints!.isEmpty) {
        return const SizedBox.shrink();
      }
    } else {
      if (wordPoints == null || wordPoints!.isEmpty) {
        return const SizedBox.shrink();
      }
    }

    final theme = Theme.of(context);

    // Extract values based on mode
    double latestValue = 0;
    double earliestValue = 0;
    DateTime earliestDate = DateTime.now();
    DateTime latestDate = DateTime.now();
    int count = 0;

    if (mode == DashboardChartMode.burnUp) {
      final points = burnUpPoints!;
      latestValue = points.last.totalKeys.toDouble();
      earliestValue = points.first.totalKeys.toDouble();
      earliestDate = points.first.timestamp;
      latestDate = points.last.timestamp;
      count = points.length;
    } else {
      final points = wordPoints!;
      final isCoverage = mode == DashboardChartMode.coverage;
      latestValue = isCoverage
          ? points.last.coveragePercent
          : points.last.words.toDouble();
      earliestValue = isCoverage
          ? points.first.coveragePercent
          : points.first.words.toDouble();
      earliestDate = points.first.timestamp;
      latestDate = points.last.timestamp;
      count = points.length;
    }

    final delta = latestValue - earliestValue;

    // Format labels
    String latestLabel;
    String deltaLabel;
    IconData icon;

    switch (mode) {
      case DashboardChartMode.coverage:
        latestLabel = '${latestValue.toStringAsFixed(1)}%';
        deltaLabel = _formatSignedPercent(delta);
        icon = LucideIcons.percent;
        break;
      case DashboardChartMode.words:
        latestLabel = _formatCompactNumber(latestValue);
        deltaLabel = _formatSignedCount(delta);
        icon = LucideIcons.type;
        break;
      case DashboardChartMode.burnUp:
        latestLabel = _formatCompactNumber(latestValue);
        deltaLabel = _formatSignedCount(delta);
        icon = LucideIcons.infinity; // or distinct icon for Scope
        break;
    }

    final dateRange = count > 1
        ? '${DateFormat('MMM d').format(earliestDate)}'
            ' – ${DateFormat('MMM d').format(latestDate)}'
        : DateFormat('MMM d').format(latestDate);

    final deltaColor =
        delta >= 0 ? theme.colorScheme.primary : theme.colorScheme.error;

    // For Coverage, negative delta is bad (red).
    // For Word/Scope, positive delta (growth) might be neutral or green,
    // but usually "change" is colored by direction.
    // Let's keep logic simple: Up = Primary (Greenish), Down = Error (Red).

    // Special labels
    String mainLabel;
    String changeLabel;

    switch (mode) {
      case DashboardChartMode.words:
        mainLabel = 'Latest';
        changeLabel = 'Added';
        break;
      case DashboardChartMode.coverage:
        mainLabel = 'Latest';
        changeLabel = 'Change';
        break;
      case DashboardChartMode.burnUp:
        mainLabel = 'Total Scope';
        changeLabel = 'Scope Growth';
        break;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 520;
        final chips = [
          _TrendStatChip(
            label: mainLabel,
            value: latestLabel,
            icon: icon,
          ),
          _TrendStatChip(
            label: changeLabel,
            value: deltaLabel,
            valueColor: deltaColor,
            icon:
                delta >= 0 ? LucideIcons.trendingUp : LucideIcons.trendingDown,
          ),
          _TrendStatChip(
            label: 'Range',
            value: dateRange,
            icon: LucideIcons.calendar,
          ),
        ];

        if (isCompact) {
          return Column(
            children: chips
                .map((chip) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: chip,
                    ))
                .toList(),
          );
        }

        return Row(
          children: List.generate(chips.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == chips.length - 1 ? 0 : 12,
                ),
                child: chips[index],
              ),
            );
          }),
        );
      },
    );
  }
}

class _TrendStatChip extends StatelessWidget {
  const _TrendStatChip({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedValueColor = valueColor ?? theme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: resolvedValueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WordTrendChart extends StatelessWidget {
  const _WordTrendChart({
    required this.points,
    required this.showCoverage,
  });

  final List<WordTrendPoint> points;
  final bool showCoverage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spots = <FlSpot>[];
    for (var index = 0; index < points.length; index++) {
      final val = showCoverage
          ? points[index].coveragePercent
          : points[index].words.toDouble();
      spots.add(FlSpot(index.toDouble(), val));
    }

    final maxY = points
        .map((point) =>
            showCoverage ? point.coveragePercent : point.words.toDouble())
        .fold<double>(0.0, (max, value) => value > max ? value : max);

    final adjustedMaxY = showCoverage ? 100.0 : (maxY == 0 ? 10.0 : maxY * 1.2);
    final dateFormat = DateFormat('MMM d');
    final tooltipDateFormat = DateFormat('MMM d, yyyy');
    final interval =
        points.length <= 4 ? 1.0 : (points.length / 4).ceilToDouble();
    final lineColor = theme.colorScheme.primary;
    final areaGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        lineColor.withOpacity(0.35),
        lineColor.withOpacity(0.02),
      ],
    );
    final tooltipStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface,
      fontWeight: FontWeight.w600,
    );
    final lastIndex = points.isNotEmpty ? points.length - 1 : 0;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (points.length - 1).toDouble(),
        minY: 0,
        maxY: adjustedMaxY,
        clipData:
            const FlClipData.all(), // Ensure lines don't bleed out of grid area
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          verticalInterval: interval,
          horizontalInterval: adjustedMaxY / 4,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.dividerColor.withOpacity(0.3),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: theme.dividerColor.withOpacity(0.15),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              // Only show first and last labels to avoid repetition when many points are on same day
              interval:
                  points.length > 1 ? (points.length - 1).toDouble() : 1.0,
              reservedSize: 40, // Increased to prevent label cutoff
              getTitlesWidget: (value, meta) {
                final index = value.round();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                // Only show first and last point labels
                if (index != 0 && index != points.length - 1) {
                  return const SizedBox.shrink();
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 6,
                  child: Text(
                    dateFormat.format(points[index].timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize:
                  54, // Increased from 44 to fit large numbers like 2.3M
              interval: adjustedMaxY / 4,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 6,
                  child: Text(
                    showCoverage
                        ? '${value.toInt()}%'
                        : _formatCompactNumber(value),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 10,
            tooltipPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            tooltipBorder: BorderSide(color: theme.dividerColor),
            getTooltipColor: (_) => theme.cardColor,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final index = spot.x.round();
                if (index < 0 || index >= points.length) {
                  return null;
                }
                final point = points[index];
                final dateLabel = tooltipDateFormat.format(point.timestamp);
                final valueLabel = showCoverage
                    ? '${point.coveragePercent.toStringAsFixed(1)}%'
                    : '${_formatCompactNumber(point.words)} words';
                return LineTooltipItem(
                  '$dateLabel\n$valueLabel',
                  tooltipStyle ??
                      const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                );
              }).toList();
            },
          ),
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: lineColor.withOpacity(0.4),
                  strokeWidth: 1,
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, bar, index) {
                    return FlDotCirclePainter(
                      radius: 5,
                      color: lineColor,
                      strokeWidth: 2,
                      strokeColor: theme.colorScheme.surface,
                    );
                  },
                ),
              );
            }).toList();
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.35,
            barWidth: 3.5,
            color: lineColor,
            dotData: FlDotData(
              show: points.length <= 12,
              checkToShowDot: (spot, barData) {
                if (points.length <= 12) {
                  return true;
                }
                return spot.x.round() == lastIndex;
              },
              getDotPainter: (spot, percent, bar, index) {
                final isLast = spot.x.round() == lastIndex;
                return FlDotCirclePainter(
                  radius: isLast ? 4.5 : 2.5,
                  color: lineColor,
                  strokeWidth: isLast ? 2 : 0,
                  strokeColor: theme.colorScheme.surface,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: areaGradient,
            ),
          ),
        ],
      ),
    );
  }
}

class _IssuesSection extends StatelessWidget {
  const _IssuesSection({
    required this.data,
    required this.cardColor,
    required this.borderColor,
  });

  final QualityDashboardData data;
  final Color cardColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final placeholderCount = data.languages.fold<int>(
      0,
      (sum, report) => sum + report.issues.placeholderMismatchCount,
    );
    final lengthCount = data.languages.fold<int>(
      0,
      (sum, report) => sum + report.issues.lengthOutlierCount,
    );
    final duplicateCount = data.languages.fold<int>(
      0,
      (sum, report) => sum + report.issues.duplicateValueCount,
    );

    final placeholderIssues = _collectIssues(
      data.languages,
      (report) => report.issues.placeholderMismatchIssues,
    );
    final lengthIssues = _collectIssues(
      data.languages,
      (report) => report.issues.lengthOutlierIssues,
    );
    final duplicateIssues = _collectIssues(
      data.languages,
      (report) => report.issues.duplicateValueIssues,
    );

    final placeholderSamples = _collectSamples(
      data.languages,
      (report) => report.issues.placeholderMismatchIssues,
    );
    final lengthSamples = _collectSamples(
      data.languages,
      (report) => report.issues.lengthOutlierIssues,
    );
    final duplicateSamples = _collectSamples(
      data.languages,
      (report) => report.issues.duplicateValueIssues,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Potential issues',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (data.totalIssues == 0)
            Text(
              'No issues found in the latest comparisons.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            )
          else ...[
            _IssueRow(
              title: 'Placeholder mismatches',
              description: 'Markers like {name} do not match.',
              count: placeholderCount,
              samples: placeholderSamples,
              onTap: () => showDialog(
                context: context,
                builder: (context) => IssueDetailsDialog(
                  title: 'Placeholder Mismatches',
                  description: 'These translations have different '
                      'placeholders ({name}) than the source.',
                  items: placeholderIssues,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _IssueRow(
              title: 'Very short or long translations',
              description: 'Length looks unusual compared to the source.',
              count: lengthCount,
              samples: lengthSamples,
              onTap: () => showDialog(
                context: context,
                builder: (context) => IssueDetailsDialog(
                  title: 'Length Outliers',
                  description: 'These translations are significantly shorter '
                      'or longer than the source.',
                  items: lengthIssues,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _IssueRow(
              title: 'Duplicate values',
              description: 'The same translation is used many times.',
              count: duplicateCount,
              samples: duplicateSamples,
              onTap: () => showDialog(
                context: context,
                builder: (context) => IssueDetailsDialog(
                  title: 'Duplicate Values',
                  description: 'These translations appear multiple times.',
                  items: duplicateIssues,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<QualityIssue> _collectIssues(
    List<LanguageQualityReport> reports,
    List<QualityIssue> Function(LanguageQualityReport) picker,
  ) {
    final issues = <QualityIssue>[];
    for (final report in reports) {
      issues.addAll(picker(report));
    }
    return issues;
  }

  List<String> _collectSamples(
    List<LanguageQualityReport> reports,
    List<QualityIssue> Function(LanguageQualityReport) picker, {
    int limit = 3,
  }) {
    final samples = <String>[];
    for (final report in reports) {
      for (final issue in picker(report)) {
        if (samples.length >= limit) {
          return samples;
        }
        samples.add(_formatSample(report.languageLabel, issue));
      }
    }
    return samples;
  }

  String _formatSample(String languageLabel, QualityIssue issue) {
    var description = issue.description.trim();
    if (issue.type == QualityIssueType.duplicateValue) {
      final value = issue.targetValue?.trim();
      if (value != null && value.isNotEmpty) {
        description = 'Duplicate: "$value"';
      }
    }
    if (description.isEmpty) {
      return '$languageLabel: ${issue.key}';
    }
    return '$languageLabel: ${issue.key} — $description';
  }
}

class _IssueRow extends StatelessWidget {
  const _IssueRow({
    required this.title,
    required this.description,
    required this.count,
    required this.samples,
    this.onTap,
  });

  final String title;
  final String description;
  final int count;
  final List<String> samples;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    count.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            if (samples.isNotEmpty) ...[
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: samples
                    .map(
                      (sample) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.dividerColor.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          sample,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _WarningsBanner extends StatelessWidget {
  const _WarningsBanner({
    required this.warnings,
    required this.cardColor,
    required this.borderColor,
  });

  final List<String> warnings;
  final Color cardColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.info,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: warnings
                  .map(
                    (warning) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        warning,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatCompactNumber(num value) {
  final absValue = value.abs();
  if (absValue >= 1000000) {
    String s = (absValue / 1000000).toStringAsFixed(1);
    if (s.endsWith('.0')) s = s.substring(0, s.length - 2);
    return '${s}M';
  }
  if (absValue >= 1000) {
    String s = (absValue / 1000).toStringAsFixed(1);
    if (s.endsWith('.0')) s = s.substring(0, s.length - 2);
    return '${s}k';
  }
  return absValue.toStringAsFixed(0);
}

String _formatSignedCount(double value) {
  final sign = value >= 0 ? '+' : '-';
  return '$sign${_formatCompactNumber(value)}';
}

String _formatSignedPercent(double value) {
  final sign = value >= 0 ? '+' : '-';
  return '$sign${value.abs().toStringAsFixed(1)}%';
}

class _ActivityTrendSection extends StatelessWidget {
  const _ActivityTrendSection({
    required this.data,
    required this.cardColor,
    required this.borderColor,
  });

  final QualityDashboardData data;
  final Color cardColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    if (data.activityTrend.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Translation Activity',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Keys added, modified, and removed over time',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 320,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TrendLegendItem(
                    color: const Color(0xFF4ADE80), // Accent green
                    label: 'Added',
                  ),
                  const SizedBox(width: 16),
                  _TrendLegendItem(
                    color: Colors.amber,
                    label: 'Modified',
                  ),
                  const SizedBox(width: 16),
                  _TrendLegendItem(
                    color: Colors.redAccent,
                    label: 'Removed',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _ActivityTrendChart(points: data.activityTrend),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrendLegendItem extends StatelessWidget {
  const _TrendLegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _ActivityTrendChart extends StatelessWidget {
  const _ActivityTrendChart({required this.points});

  final List<ActivityTrendPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d');

    // Calculate max Y for scaling
    double maxY = 0;
    for (final point in points) {
      // For stacked chart, max Y is the sum of positive bars (added + modified)
      // Removed is typically shown below or just stacked.
      // Let's stack them all positively for "Total Activity Volume"
      // OR stack Added/Modified up and Removed down?
      // A simple positive stack is usually easier to read for "Activity Volume".
      final total = point.added + point.modified + point.removed;
      if (total > maxY) maxY = total.toDouble();
    }

    final adjustedMaxY = maxY == 0 ? 10.0 : maxY * 1.2;
    final interval = adjustedMaxY / 4;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: adjustedMaxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.all(8),
            getTooltipColor: (_) => theme.cardColor,
            tooltipBorder: BorderSide(color: theme.dividerColor),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final point = points[group.x.toInt()];
              String label;
              String value;
              switch (rodIndex) {
                case 0:
                  label = 'Added';
                  value = point.added.toString();
                  break;
                case 1:
                  label = 'Modified';
                  value = point.modified.toString();
                  break;
                case 2:
                  label = 'Removed';
                  value = point.removed.toString();
                  break;
                default:
                  return null;
              }
              return BarTooltipItem(
                '$label: $value',
                theme.textTheme.bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                // Only show first and last labels for clean look
                if (points.length > 5 &&
                    index != 0 &&
                    index != points.length - 1) {
                  return const SizedBox.shrink();
                }

                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    dateFormat.format(points[index].timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: interval, // Match grid interval to prevent overcrowding
              reservedSize:
                  42, // Slightly increased for 6-char strings like "100.5k"
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox.shrink();
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    _formatCompactNumber(value),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.dividerColor.withValues(alpha: 0.1),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: points.asMap().entries.map((entry) {
          final index = entry.key;
          final point = entry.value;

          return BarChartGroupData(
            x: index,
            barRods: [
              // We want a stacked bar. fl_chart BarRodStackItem doesn't exist directly in simple API?
              // Actually BarChartGroupData has 'groupVertically' but usually we just use fromY/toY in BarRodStackItem?
              // Or just BarChartGroupData with multiple rods if we want grouped.
              // Stacked is supported by BarChartGroupData(barRods: [BarChartRodData(rodStackItems: ...)])

              BarChartRodData(
                toY: (point.added + point.modified + point.removed).toDouble(),
                width: 16,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
                color: Colors.transparent, // Only stack items have color
                rodStackItems: [
                  BarChartRodStackItem(
                    0,
                    point.added.toDouble(),
                    const Color(0xFF4ADE80),
                  ),
                  BarChartRodStackItem(
                    point.added.toDouble(),
                    (point.added + point.modified).toDouble(),
                    Colors.amber,
                  ),
                  BarChartRodStackItem(
                    (point.added + point.modified).toDouble(),
                    (point.added + point.modified + point.removed).toDouble(),
                    Colors.redAccent,
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _BurnUpChart extends StatelessWidget {
  const _BurnUpChart({required this.points});

  final List<BurnUpPoint> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM d');

    // Calculate max Y
    double maxY = 0;
    for (final point in points) {
      if (point.totalKeys > maxY) maxY = point.totalKeys.toDouble();
    }

    final adjustedMaxY = maxY == 0 ? 10.0 : maxY * 1.2;
    final interval = adjustedMaxY / 4;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (points.length - 1).toDouble(),
        minY: 0,
        maxY: adjustedMaxY,
        clipData: const FlClipData.all(),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval,
          getDrawingHorizontalLine: (value) => FlLine(
            color: theme.dividerColor.withValues(alpha: 0.1),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= points.length) {
                  return const SizedBox.shrink();
                }
                if (points.length > 5 &&
                    index != 0 &&
                    index != points.length - 1) {
                  return const SizedBox.shrink();
                }

                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    dateFormat.format(points[index].timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: interval,
              reservedSize: 42,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox.shrink();
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    _formatCompactNumber(value),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipColor: (_) => theme.cardColor,
              tooltipBorder: BorderSide(color: theme.dividerColor),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final index = spot.x.round();
                  if (index < 0 || index >= points.length) return null;
                  final point = points[index];

                  final isTarget = spot.barIndex == 0;
                  final label = isTarget ? 'Total' : 'Translated';
                  final color =
                      isTarget ? Colors.blueAccent : const Color(0xFF4ADE80);

                  return LineTooltipItem(
                    '$label: ${isTarget ? point.totalKeys : point.translatedKeys}',
                    theme.textTheme.bodySmall!
                        .copyWith(color: color, fontWeight: FontWeight.bold),
                  );
                }).toList();
              }),
        ),
        lineBarsData: [
          // Total Keys (Scope)
          LineChartBarData(
            spots: points.asMap().entries.map((e) {
              return FlSpot(e.key.toDouble(), e.value.totalKeys.toDouble());
            }).toList(),
            isCurved: true,
            color: Colors.blueAccent,
            barWidth: 3,
            dotData: const FlDotData(show: false),
          ),
          // Translated Keys (Progress)
          LineChartBarData(
            spots: points.asMap().entries.map((e) {
              return FlSpot(
                  e.key.toDouble(), e.value.translatedKeys.toDouble());
            }).toList(),
            isCurved: true,
            color: const Color(0xFF4ADE80),
            barWidth: 3,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF4ADE80).withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    );
  }
}
