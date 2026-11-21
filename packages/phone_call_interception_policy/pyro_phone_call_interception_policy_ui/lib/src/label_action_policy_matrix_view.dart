import 'package:material_ui/material_ui.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'l10n/generated/app_localizations.dart';

/// 标签与拦截处置动作矩阵视图组件 (LabelActionPolicyMatrixView)
/// 100% 封装于微包内部，提供自闭环的策略列表、快速添加 Chip、动作选择下拉框及添加弹窗
class LabelActionPolicyMatrixView extends StatelessWidget {
  final Map<String, InterceptAction> labelActionMap;
  final List<String> availableLabels;
  final List<String> quickAddLabels;
  final void Function(String label, InterceptAction action) onActionChanged;
  final void Function(String label) onActionRemoved;
  final String Function(String label)? labelTranslator;
  final String Function(InterceptAction action)? actionTranslator;
  final String? title;
  final String? subtitle;

  const LabelActionPolicyMatrixView({
    super.key,
    required this.labelActionMap,
    this.availableLabels = const [],
    this.quickAddLabels = const [],
    required this.onActionChanged,
    required this.onActionRemoved,
    this.labelTranslator,
    this.actionTranslator,
    this.title,
    this.subtitle,
  });

  String _translateLabel(String label) {
    return labelTranslator?.call(label) ?? label;
  }

  String _translateAction(BuildContext context, InterceptAction action) {
    if (actionTranslator != null) {
      return actionTranslator!(action);
    }
    final l10n = AppLocalizations.of(context);
    if (action == InterceptAction.allow) {
      return l10n.actionAllow;
    } else if (action == InterceptAction.answerThenHangup) {
      return l10n.actionAnswerThenHangup;
    } else if (action == InterceptAction.silenceNoAnswer) {
      return l10n.actionSilence;
    }
    return l10n.actionEndCall;
  }

  IconData _getActionIcon(InterceptAction action) {
    if (action == InterceptAction.allow) {
      return Icons.check_circle_outline_rounded;
    } else if (action == InterceptAction.answerThenHangup) {
      return Icons.phone_paused_rounded;
    } else if (action == InterceptAction.silenceNoAnswer) {
      return Icons.volume_off_rounded;
    }
    return Icons.call_end_rounded;
  }

  Color _getActionColor(BuildContext context, InterceptAction action) {
    final theme = Theme.of(context);
    if (action == InterceptAction.allow) {
      return Colors.green;
    } else if (action == InterceptAction.answerThenHangup) {
      return theme.colorScheme.primary;
    } else if (action == InterceptAction.silenceNoAnswer) {
      return Colors.amber;
    }
    return theme.colorScheme.error;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tune_rounded, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? l10n.labelPolicyTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(l10n.addLabelRuleTitle),
                  style: FilledButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => _showAddLabelDialog(context),
                ),
              ],
            ),
            if (quickAddLabels.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: quickAddLabels
                    .where((label) => !labelActionMap.containsKey(label))
                    .map((label) => ActionChip(
                          avatar: Icon(
                            Icons.add_circle_outline_rounded,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          label: Text(_translateLabel(label), style: const TextStyle(fontSize: 12)),
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          side: BorderSide(color: theme.colorScheme.outlineVariant),
                          onPressed: () {
                            onActionChanged(label, InterceptAction.endCall);
                          },
                        ))
                    .toList(),
              ),
            ],
            const SizedBox(height: 12),
            if (labelActionMap.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
                ),
                child: Center(
                  child: Text(
                    l10n.noConfiguredLabels,
                    style: TextStyle(
                      fontSize: 13,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: labelActionMap.length,
                separatorBuilder: (context, index) => Divider(
                  height: 16,
                  color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
                itemBuilder: (context, index) {
                  final entry = labelActionMap.entries.elementAt(index);
                  final label = entry.key;
                  final currentAction = entry.value;

                  return Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle_outline_rounded,
                          size: 20,
                          color: theme.colorScheme.error,
                        ),
                        tooltip: l10n.deleteRuleTooltip,
                        onPressed: () => onActionRemoved(label),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _translateLabel(label),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: theme.colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (label != _translateLabel(label))
                              Text(
                                label,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: currentAction.isAllow
                                ? Colors.green.withValues(alpha: 0.5)
                                : theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<InterceptAction>(
                            value: currentAction,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: theme.colorScheme.primary,
                            ),
                            onChanged: (InterceptAction? newAction) {
                              if (newAction != null) {
                                onActionChanged(label, newAction);
                              }
                            },
                            items: InterceptAction.values.map((action) {
                              return DropdownMenuItem<InterceptAction>(
                                value: action,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getActionIcon(action),
                                      size: 16,
                                      color: _getActionColor(context, action),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      _translateAction(context, action),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showAddLabelDialog(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    String selectedLabel = availableLabels.isNotEmpty ? availableLabels.first : '';
    InterceptAction chosenAction = InterceptAction.endCall;
    final textController = TextEditingController(text: selectedLabel);

    showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (innerCtx, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                l10n.addLabelRuleTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (availableLabels.isNotEmpty) ...[
                      Text(
                        l10n.selectExistingLabel,
                        style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colorScheme.outlineVariant),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: availableLabels.contains(selectedLabel) ? selectedLabel : null,
                            isExpanded: true,
                            hint: Text(l10n.pleaseSelectLabel, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurfaceVariant)),
                            onChanged: (val) {
                              if (val != null) {
                                setDialogState(() {
                                  selectedLabel = val;
                                  textController.text = val;
                                });
                              }
                            },
                            items: availableLabels.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(_translateLabel(item), style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    TextField(
                      controller: textController,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: l10n.customLabelName,
                        hintText: l10n.customLabelHint,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (val) {
                        selectedLabel = val;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.selectActionPrompt,
                      style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.colorScheme.outlineVariant),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<InterceptAction>(
                          value: chosenAction,
                          isExpanded: true,
                          onChanged: (val) {
                            if (val != null) {
                              setDialogState(() {
                                chosenAction = val;
                              });
                            }
                          },
                          items: InterceptAction.values.map((action) {
                            return DropdownMenuItem<InterceptAction>(
                              value: action,
                              child: Row(
                                children: [
                                  Icon(_getActionIcon(action), size: 16, color: _getActionColor(context, action)),
                                  const SizedBox(width: 8),
                                  Text(_translateAction(context, action), style: TextStyle(color: theme.colorScheme.onSurface)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: Text(l10n.cancel, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                ),
                FilledButton(
                  onPressed: () {
                    final trimmed = textController.text.trim();
                    if (trimmed.isNotEmpty) {
                      onActionChanged(trimmed, chosenAction);
                    }
                    Navigator.of(dialogCtx).pop();
                  },
                  child: Text(l10n.save),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
