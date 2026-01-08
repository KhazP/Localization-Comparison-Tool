import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:localizer_app_main/business_logic/blocs/settings_bloc/'
    'settings_bloc.dart';
import 'package:localizer_app_main/data/models/comparison_status_detail.dart';
import 'package:localizer_app_main/i18n/strings.g.dart';
import 'package:localizer_app_main/presentation/widgets/common/'
    'diff_highlighter.dart';
import 'package:localizer_app_main/core/services/toast_service.dart';

class DiffRowItem extends StatefulWidget {
  final int index;
  final String keyName;
  final ComparisonStatusDetail detail;
  final String oldValue;
  final String newValue;
  final bool isReviewed;
  final bool useInlineEditing;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onRevert;
  final VoidCallback? onAddToTM;
  final VoidCallback? onMarkReviewed;
  final ValueChanged<String>? onInlineSave;
  final VoidCallback? onAiTranslate;
  final VoidCallback? onAiSuggest;
  final VoidCallback? onAiRephrase;

  const DiffRowItem({
    super.key,
    required this.index,
    required this.keyName,
    required this.detail,
    required this.oldValue,
    required this.newValue,
    this.isReviewed = false,
    this.useInlineEditing = false,
    this.onEdit,
    this.onDelete,
    this.onRevert,
    this.onAddToTM,
    this.onMarkReviewed,
    this.onInlineSave,
    this.onAiTranslate,
    this.onAiSuggest,
    this.onAiRephrase,
  });

  @override
  State<DiffRowItem> createState() => _DiffRowItemState();
}

class _DiffRowItemState extends State<DiffRowItem> {
  bool _isHoveringSource = false;
  bool _isInlineEditing = false;
  late TextEditingController _editController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.newValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(DiffRowItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.newValue != widget.newValue && !_isInlineEditing) {
      _editController.text = widget.newValue;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _editController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _isInlineEditing) {
      _saveInlineEdit();
    }
  }

  void _startInlineEdit() {
    setState(() {
      _isInlineEditing = true;
      _editController.text = widget.newValue;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _editController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _editController.text.length,
      );
    });
  }

  void _saveInlineEdit() {
    if (_isInlineEditing) {
      final newText = _editController.text;
      setState(() => _isInlineEditing = false);
      if (newText != widget.newValue) {
        widget.onInlineSave?.call(newText);
      }
    }
  }

  void _handleTargetTap() {
    if (widget.useInlineEditing) {
      _startInlineEdit();
    } else {
      widget.onEdit?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDimmed = widget.isReviewed;
    final isCloud = _isCloudTranslation(
      context.watch<SettingsBloc>().state.appSettings.translationStrategy,
    );
    final translateLabel = isCloud
        ? context.t.advancedDiff.table.translateWithCloud
        : context.t.advancedDiff.table.translateWithAi;
    final rephraseLabel = isCloud
        ? context.t.advancedDiff.table.rephrase
        : context.t.advancedDiff.table.rephraseWithAi;

    return Material(
      type: MaterialType.transparency,
      child: Opacity(
        opacity: isDimmed ? 0.5 : 1.0,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isDimmed
                ? Theme.of(context).disabledColor.withValues(alpha: 0.05)
                : null,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: Row(
            children: [
              // Index
              SizedBox(
                width: 48,
                child: Center(
                  child: Text(
                    '${widget.index + 1}',
                    style: TextStyle(
                        color: Theme.of(context).disabledColor, fontSize: 12),
                  ),
                ),
              ),
              // Status Badge
              SizedBox(
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _buildStatusBadge(context),
                ),
              ),
              // Key
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.keyName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Vertical Divider
              VerticalDivider(
                  width: 1,
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.5)),
              // Old Value (Source) - with copy on hover
              Expanded(
                flex: 3,
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHoveringSource = true),
                  onExit: (_) => setState(() => _isHoveringSource = false),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        child: DiffHighlighter.buildDiffText(
                          widget.oldValue,
                          widget.newValue,
                          isSource: true,
                          baseStyle: const TextStyle(
                              fontSize: 13, fontFamily: 'RobotoMono'),
                          maxLines: 2,
                        ),
                      ),
                      if (_isHoveringSource && widget.oldValue.isNotEmpty)
                        Positioned(
                          right: 4,
                          child: IconButton(
                            icon: const Icon(Icons.copy, size: 16),
                            tooltip: context.t.advancedDiff.diffRow.copySource,
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.oldValue));
                              ToastService.showSuccess(
                                  context, context.t.common.copied);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .cardColor
                                  .withValues(alpha: 0.9),
                              padding: const EdgeInsets.all(4),
                              minimumSize: const Size(28, 28),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                  width: 1,
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.5)),
              // New Value (Target) - single-click to edit
              Expanded(
                flex: 3,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _handleTargetTap,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.centerLeft,
                    color: widget.detail.status == StringComparisonStatus.added
                        ? Colors.green.withValues(alpha: 0.05)
                        : null,
                    child: _isInlineEditing
                        ? _buildInlineEditor(context)
                        : DiffHighlighter.buildDiffText(
                            widget.oldValue,
                            widget.newValue,
                            isSource: false,
                            baseStyle: const TextStyle(
                                fontSize: 13, fontFamily: 'RobotoMono'),
                            maxLines: 2,
                          ),
                  ),
                ),
              ),
              // Actions PopupMenu
              SizedBox(
                width: 40,
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 18),
                  tooltip: context.t.advancedDiff.diffRow.actions,
                  itemBuilder: (context) => [
                    // AI Actions
                    if (widget.onAiTranslate != null)
                      PopupMenuItem(
                        value: 'aiTranslate',
                        child: Row(
                          children: [
                            Icon(LucideIcons.sparkles,
                                size: 18, color: Colors.purple),
                            const SizedBox(width: 8),
                            Text(translateLabel),
                          ],
                        ),
                      ),
                    if (widget.onAiRephrase != null)
                      PopupMenuItem(
                        value: 'aiRephrase',
                        child: Row(
                          children: [
                            Icon(LucideIcons.wand2,
                                size: 18, color: Colors.orange),
                            const SizedBox(width: 8),
                            Text(rephraseLabel),
                          ],
                        ),
                      ),
                    if (widget.onAiSuggest != null)
                      PopupMenuItem(
                        value: 'aiSuggest',
                        child: Row(
                          children: [
                            Icon(LucideIcons.lightbulb,
                                size: 18, color: Colors.amber),
                            const SizedBox(width: 8),
                            Text(context
                                .t.advancedDiff.table.suggestTranslation),
                          ],
                        ),
                      ),
                    if (widget.onAiTranslate != null ||
                        widget.onAiRephrase != null ||
                        widget.onAiSuggest != null)
                      const PopupMenuDivider(),
                    PopupMenuItem(
                      value: 'addToTM',
                      child: Row(
                        children: [
                          Icon(Icons.psychology, size: 18),
                          SizedBox(width: 8),
                          Text(context.t.advancedDiff.table.addToTm),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'markReviewed',
                      child: Row(
                        children: [
                          Icon(
                              widget.isReviewed
                                  ? Icons.visibility_off
                                  : Icons.check_circle_outline,
                              size: 18),
                          const SizedBox(width: 8),
                          Text(widget.isReviewed
                              ? context.t.advancedDiff.table.unmarkReviewed
                              : context.t.advancedDiff.table.markReviewed),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'revert',
                      child: Row(
                        children: [
                          Icon(Icons.undo, size: 18),
                          SizedBox(width: 8),
                          Text(context.t.advancedDiff.table.revertToSource),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline,
                              size: 18, color: Colors.red),
                          SizedBox(width: 8),
                          Text(context.t.advancedDiff.table.deleteEntry,
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case 'aiTranslate':
                        widget.onAiTranslate?.call();
                        break;
                      case 'aiSuggest':
                        widget.onAiSuggest?.call();
                        break;
                      case 'aiRephrase':
                        widget.onAiRephrase?.call();
                        break;
                      case 'addToTM':
                        widget.onAddToTM?.call();
                        break;
                      case 'markReviewed':
                        widget.onMarkReviewed?.call();
                        break;
                      case 'revert':
                        widget.onRevert?.call();
                        break;
                      case 'delete':
                        widget.onDelete?.call();
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInlineEditor(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.enter &&
              !HardwareKeyboard.instance.isShiftPressed) {
            _saveInlineEdit();
          } else if (event.logicalKey == LogicalKeyboardKey.escape) {
            setState(() => _isInlineEditing = false);
          }
        }
      },
      child: TextField(
        controller: _editController,
        focusNode: _focusNode,
        maxLines: 2,
        minLines: 1,
        style: const TextStyle(fontSize: 13, fontFamily: 'RobotoMono'),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
        ),
        onSubmitted: (_) => _saveInlineEdit(),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color barColor;
    String label;

    switch (widget.detail.status) {
      case StringComparisonStatus.added:
        barColor = Colors.green;
        label = context.t.advancedDiff.status.added;
        break;
      case StringComparisonStatus.removed:
        barColor = Colors.red;
        label = context.t.advancedDiff.status.missing;
        break;
      case StringComparisonStatus.modified:
        barColor = Colors.amber[700]!;
        int percent = ((1.0 - (widget.detail.similarity ?? 0)) * 100).toInt();
        label = context.t.advancedDiff.status.changed(percent: percent);
        break;
      default:
        barColor = Colors.grey[400]!;
        label = context.t.advancedDiff.status.same;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 3,
          height: 22,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.color
                    ?.withValues(alpha: 0.7) ??
                Colors.grey[600],
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  bool _isCloudTranslation(String value) {
    return value.toLowerCase().contains('cloud');
  }
}
