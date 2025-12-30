import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localizer_app_main/business_logic/blocs/history_bloc.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/settings_bloc.dart';
import 'package:localizer_app_main/core/services/quality_metrics_service.dart';
import 'package:localizer_app_main/data/models/comparison_history.dart';
import 'package:localizer_app_main/data/models/quality_metrics.dart';
import 'package:localizer_app_main/presentation/themes/app_theme_v2.dart';
import 'package:localizer_app_main/presentation/widgets/common/common_widgets.dart';
import 'package:localizer_app_main/presentation/widgets/dialogs/issue_details_dialog.dart';
import 'package:localizer_app_main/core/services/quality_report_exporter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class QualityDashboardView extends StatefulWidget {
  const QualityDashboardView({super.key});

  @override
  State<QualityDashboardView> createState() => _QualityDashboardViewState();
}

class _QualityDashboardViewState extends State<QualityDashboardView>
    with SingleTickerProviderStateMixin {
  final QualityMetricsService _metricsService = QualityMetricsService();
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  Future<QualityDashboardData>? _dashboardFuture;
  List<ComparisonSession> _history = [];
  bool _showCoverageChart = false;
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

    setState(() {
      _dashboardFuture = _metricsService.buildDashboardData(
        history: _history,
        settings: settingsState.appSettings,
      );
    });
  }

  Future<void> _exportReport() async {
    final data = await _dashboardFuture;
    if (data == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data to export')),
        );
      }
      return;
    }

    final bytes = _exporter.toExcelBytes(data);
    if (bytes.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export failed')),
        );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report saved to ${file.path}')),
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
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SummaryRow(data: data),
              const SizedBox(height: 20),
              _CoverageSection(
                data: data,
                cardColor: cardColor,
                borderColor: borderColor,
              ),
              const SizedBox(height: 20),
              _WordTrendSection(
                data: data,
                cardColor: cardColor,
                borderColor: borderColor,
                showCoverage: _showCoverageChart,
                onToggleMetric: () => setState(() {
                  _showCoverageChart = !_showCoverageChart;
                }),
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
  });

  final VoidCallback onRefresh;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.insights_rounded,
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
            icon: const Icon(Icons.refresh_rounded),
          ),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: onExport,
          icon: const Icon(Icons.download_rounded, size: 18),
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
            icon: Icons.language_rounded,
          ),
          _SummaryCard(
            title: 'Average coverage',
            value: '${avgCoverage.toStringAsFixed(1)}%',
            icon: Icons.check_circle_rounded,
          ),
          _SummaryCard(
            title: 'Potential issues',
            value: data.totalIssues.toString(),
            icon: Icons.warning_amber_rounded,
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
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
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
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                          theme.colorScheme.primary.withValues(alpha: 0.12),
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${coverage.translatedKeyCount} of '
                    '${coverage.sourceKeyCount} entries translated',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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

class _WordTrendSection extends StatelessWidget {
  const _WordTrendSection({
    required this.data,
    required this.cardColor,
    required this.borderColor,
    required this.showCoverage,
    required this.onToggleMetric,
  });

  final QualityDashboardData data;
  final Color cardColor;
  final Color borderColor;
  final bool showCoverage;
  final VoidCallback onToggleMetric;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final points = data.wordTrend;

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
            'Words added over time',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          if (points.isEmpty)
            Text(
              'Run new comparisons to start this chart.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            )
          else ...[
            Row(
              children: [
                Text(
                  showCoverage ? 'Coverage %' : 'Words Added',
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      label: Text('Words'),
                      icon: Icon(Icons.text_fields),
                    ),
                    ButtonSegment(
                      value: true,
                      label: Text('Coverage'),
                      icon: Icon(Icons.percent),
                    ),
                  ],
                  selected: {showCoverage},
                  onSelectionChanged: (_) => onToggleMetric(),
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _TrendSummaryRow(
              points: points,
              showCoverage: showCoverage,
            ),
            const SizedBox(height: 16),
            Container(
              height: 280,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.4),
                ),
              ),
              child: _WordTrendChart(
                points: points,
                showCoverage: showCoverage,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TrendSummaryRow extends StatelessWidget {
  const _TrendSummaryRow({
    required this.points,
    required this.showCoverage,
  });

  final List<WordTrendPoint> points;
  final bool showCoverage;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final latest = points.last;
    final earliest = points.first;
    final latestValue = showCoverage
        ? latest.coveragePercent
        : latest.words.toDouble();
    final earliestValue = showCoverage
        ? earliest.coveragePercent
        : earliest.words.toDouble();
    final delta = latestValue - earliestValue;
    final deltaLabel = showCoverage
        ? _formatSignedPercent(delta)
        : _formatSignedCount(delta);
    final latestLabel = showCoverage
        ? '${latestValue.toStringAsFixed(1)}%'
        : _formatCompactNumber(latestValue);
    final dateRange = points.length > 1
        ? '${DateFormat('MMM d').format(earliest.timestamp)}'
            ' – ${DateFormat('MMM d').format(latest.timestamp)}'
        : DateFormat('MMM d').format(latest.timestamp);

    final deltaColor = delta >= 0
        ? theme.colorScheme.primary
        : theme.colorScheme.error;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 520;
        final chips = [
          _TrendStatChip(
            label: 'Latest',
            value: latestLabel,
            icon: showCoverage
                ? Icons.percent_rounded
                : Icons.text_fields_rounded,
          ),
          _TrendStatChip(
            label: 'Change',
            value: deltaLabel,
            valueColor: deltaColor,
            icon: delta >= 0
                ? Icons.trending_up_rounded
                : Icons.trending_down_rounded,
          ),
          _TrendStatChip(
            label: 'Range',
            value: dateRange,
            icon: Icons.calendar_today_rounded,
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
          color: theme.dividerColor.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
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
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
        lineColor.withValues(alpha: 0.35),
        lineColor.withValues(alpha: 0.02),
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
        clipData: const FlClipData.all(), // Ensure lines don't bleed out of grid area
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          verticalInterval: interval,
          horizontalInterval: adjustedMaxY / 4,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.dividerColor.withValues(alpha: 0.3),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: theme.dividerColor.withValues(alpha: 0.15),
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
              interval: points.length > 1 ? (points.length - 1).toDouble() : 1.0,
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
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 54, // Increased from 44 to fit large numbers like 2.3M
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
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                final dateLabel =
                    tooltipDateFormat.format(point.timestamp);
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
                  color: lineColor.withValues(alpha: 0.4),
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
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
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                            color: theme.dividerColor.withValues(alpha: 0.5),
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
            Icons.info_outline,
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
    return '${(absValue / 1000000).toStringAsFixed(1)}M';
  }
  if (absValue >= 1000) {
    return '${(absValue / 1000).toStringAsFixed(1)}k';
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
