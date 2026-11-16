import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_ads_hub/pyro_ads_hub.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/label_action_config_provider.dart';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class EndCallSettingsPage extends ConsumerWidget {
  const EndCallSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInterceptAction = ref.watch(interceptActionConfigProvider);
    final interceptActionNotifier = ref.read(interceptActionConfigProvider.notifier);
    final labelActionMap = ref.watch(labelActionConfigProvider);
    final labelActionNotifier = ref.read(labelActionConfigProvider.notifier);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isZh = Localizations.localeOf(context).languageCode.toLowerCase() == 'zh';
    final cardTitle = isZh ? '按标签自定义拦截处置' : 'Action by Caller Label';
    final cardSubtitle = isZh
        ? '为特定号码标签独立指定处置动作（放行通过、立即挂断、接通后挂断或静音）'
        : l10n.labelActionDescription;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.interceptionActionSettingsTitle,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: theme.colorScheme.onSurface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // 1. 全局默认拦截动作设置
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                        width: 1.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.error.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.call_end_rounded, color: theme.colorScheme.error, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              l10n.incomingCallInterceptAction,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.chooseDefaultInterceptAction,
                          style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.1),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<InterceptAction>(
                              value: selectedInterceptAction,
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down_rounded, color: theme.colorScheme.primary),
                              onChanged: (InterceptAction? newValue) {
                                if (newValue != null) {
                                  interceptActionNotifier.setInterceptAction(newValue);
                                }
                              },
                              items: <DropdownMenuItem<InterceptAction>>[
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.endCall,
                                  child: Text(l10n.endCallImmediately, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.answerThenHangup,
                                  child: Text(l10n.answerThenHangup, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                                DropdownMenuItem<InterceptAction>(
                                  value: InterceptAction.silenceNoAnswer,
                                  child: Text(l10n.silenceAndNoAnswer, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: theme.colorScheme.onSurface)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. 按标签自定义动作列表卡片 (左侧 Label，右侧 InterceptAction 选择器)
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                        width: 1.1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.label_rounded, color: theme.colorScheme.primary, size: 20),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  cardTitle,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline_rounded, color: theme.colorScheme.primary),
                              tooltip: isZh ? '添加标签规则' : '${l10n.addLabel} ${l10n.ruleAction}',
                              onPressed: () => _showAddLabelDialog(context, ref, l10n, theme, isZh),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cardSubtitle,
                          style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 14),

                        if (labelActionMap.isEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                              child: Text(
                                isZh ? '暂无自定义标签规则，点击右上角加号或下方快捷标签添加' : 'No custom label rules yet. Tap + or quick tags below to add',
                                style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildQuickAddChip(context, ref, 'Fraud Scam Likely', InterceptAction.endCall, theme),
                              _buildQuickAddChip(context, ref, 'Spam Likely', InterceptAction.endCall, theme),
                              _buildQuickAddChip(context, ref, 'Telemarketing', InterceptAction.silenceNoAnswer, theme),
                              _buildQuickAddChip(context, ref, 'Delivery', InterceptAction.allow, theme),
                              _buildQuickAddChip(context, ref, 'Takeaway', InterceptAction.allow, theme),
                            ],
                          ),
                        ] else ...[
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: labelActionMap.length,
                            separatorBuilder: (_, _) => Divider(height: 16, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
                            itemBuilder: (context, index) {
                              final entry = labelActionMap.entries.elementAt(index);
                              final labelKey = entry.key;
                              final currentAction = entry.value;

                              return Row(
                                children: [
                                  // 左侧：标签名称展示与删除按钮
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_outline_rounded, size: 20, color: theme.colorScheme.error),
                                    tooltip: l10n.deleteRule,
                                    onPressed: () => labelActionNotifier.removeActionForLabel(labelKey),
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          labelKey.translate(context),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: theme.colorScheme.onSurface,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (labelKey != labelKey.translate(context))
                                          Text(
                                            labelKey,
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

                                  // 右侧：选择拦截类型 (放行 / 挂断 / 接通后挂断 / 静音)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: currentAction.isAllow
                                            ? Colors.green.withValues(alpha: 0.5)
                                            : theme.colorScheme.outlineVariant,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<InterceptAction>(
                                        value: currentAction,
                                        icon: Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: theme.colorScheme.primary),
                                        onChanged: (InterceptAction? newAction) {
                                          if (newAction != null) {
                                            labelActionNotifier.setActionForLabel(labelKey, newAction);
                                          }
                                        },
                                        items: [
                                          DropdownMenuItem<InterceptAction>(
                                            value: InterceptAction.allow,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.check_circle_outline_rounded, size: 16, color: Colors.green),
                                                const SizedBox(width: 6),
                                                Text(l10n.actionAllow, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
                                              ],
                                            ),
                                          ),
                                          DropdownMenuItem<InterceptAction>(
                                            value: InterceptAction.endCall,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.call_end_rounded, size: 16, color: theme.colorScheme.error),
                                                const SizedBox(width: 6),
                                                Text(l10n.endCallImmediately, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                                              ],
                                            ),
                                          ),
                                          DropdownMenuItem<InterceptAction>(
                                            value: InterceptAction.answerThenHangup,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.phone_paused_rounded, size: 16, color: theme.colorScheme.primary),
                                                const SizedBox(width: 6),
                                                Text(l10n.answerThenHangup, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                                              ],
                                            ),
                                          ),
                                          DropdownMenuItem<InterceptAction>(
                                            value: InterceptAction.silenceNoAnswer,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.volume_off_rounded, size: 16, color: Colors.amber),
                                                const SizedBox(width: 6),
                                                Text(l10n.silenceAndNoAnswer, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const AdsInlineBanner(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAddChip(
    BuildContext context,
    WidgetRef ref,
    String labelKey,
    InterceptAction defaultAction,
    ThemeData theme,
  ) {
    return ActionChip(
      avatar: Icon(
        defaultAction.isAllow ? Icons.check_circle_outline_rounded : Icons.block_rounded,
        size: 16,
        color: defaultAction.isAllow ? Colors.green : theme.colorScheme.error,
      ),
      label: Text(labelKey.translate(context), style: const TextStyle(fontSize: 12)),
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      side: BorderSide(color: theme.colorScheme.outlineVariant),
      onPressed: () {
        ref.read(labelActionConfigProvider.notifier).setActionForLabel(labelKey, defaultAction);
      },
    );
  }

  void _showAddLabelDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    ThemeData theme,
    bool isZh,
  ) {
    String selectedLabel = 'Spam Likely';
    InterceptAction chosenAction = InterceptAction.endCall;
    final textController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                isZh ? '添加标签处置规则' : '${l10n.addLabel} ${l10n.interceptAction}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: theme.colorScheme.onSurface),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isZh ? '选择预设标签或输入自定义标签：' : 'Select predefined label or enter custom label:', style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant)),
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
                          value: predefinedLabels.any((m) => m['text'] == selectedLabel) ? selectedLabel : null,
                          isExpanded: true,
                          hint: Text(l10n.selectLabel, style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurfaceVariant)),
                          onChanged: (val) {
                            if (val != null) {
                              setDialogState(() {
                                selectedLabel = val;
                                textController.text = val;
                              });
                            }
                          },
                          items: predefinedLabels.map((m) {
                            final rawText = m['text'] as String;
                            return DropdownMenuItem<String>(
                              value: rawText,
                              child: Text(rawText.translate(context), style: TextStyle(fontSize: 14, color: theme.colorScheme.onSurface)),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: textController,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: isZh ? '自定义标签名称' : '${l10n.custom} ${l10n.label}',
                        hintText: isZh ? '例如: 骚扰电话、催收、外卖等' : 'e.g. Spam, Delivery, etc.',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (val) {
                        selectedLabel = val;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('${l10n.ruleAction}:', style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant)),
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
                          items: [
                            DropdownMenuItem(
                              value: InterceptAction.allow,
                              child: Text(l10n.actionAllow, style: TextStyle(color: theme.colorScheme.onSurface)),
                            ),
                            DropdownMenuItem(
                              value: InterceptAction.endCall,
                              child: Text(l10n.endCallImmediately, style: TextStyle(color: theme.colorScheme.onSurface)),
                            ),
                            DropdownMenuItem(
                              value: InterceptAction.answerThenHangup,
                              child: Text(l10n.answerThenHangup, style: TextStyle(color: theme.colorScheme.onSurface)),
                            ),
                            DropdownMenuItem(
                              value: InterceptAction.silenceNoAnswer,
                              child: Text(l10n.silenceAndNoAnswer, style: TextStyle(color: theme.colorScheme.onSurface)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: Text(l10n.cancelButton, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    final finalLabel = textController.text.trim().isNotEmpty
                        ? textController.text.trim()
                        : selectedLabel.trim();
                    if (finalLabel.isNotEmpty) {
                      ref.read(labelActionConfigProvider.notifier).setActionForLabel(finalLabel, chosenAction);
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
