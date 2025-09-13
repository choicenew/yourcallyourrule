import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/utils/call_history_action_handler.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_dialog.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/rule_action_dialog.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class _CallTypeInfo {
  final IconData icon;
  final Color color;
  final String text;

  _CallTypeInfo({required this.icon, required this.color, required this.text});
}

/// 最终、完整功能合并版的通话记录卡片
class CallLogCard extends ConsumerWidget {
  final CallLog log;
  final bool isSelected;
  final VoidCallback? onMultiSelectTap;
  final CallHistoryActionHandler? actionHandler;

  const CallLogCard({
    super.key, 
    required this.log, 
    this.isSelected = false,
    this.onMultiSelectTap,
    this.actionHandler,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final callTypeInfo = _getCallTypeInfo(context, log.callType);
    final timeFormat = DateFormat('HH:mm');
    final timeString = timeFormat.format(DateTime.fromMillisecondsSinceEpoch(log.timestamp.millisecondsSinceEpoch));
    
    final handler = this.actionHandler ?? CallHistoryActionHandler(context: context, ref: ref, log: log);
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        side: isSelected ? BorderSide(color: Theme.of(context).primaryColor, width: 2) : BorderSide.none,
        borderRadius: BorderRadius.circular(12)
      ),
      child: InkWell(
        onTap: onMultiSelectTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0), // 减小下边距
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 顶部：头像和联系人信息
              _buildCardHeader(context, ref, callTypeInfo),
              // 中部：操作栏
              _buildCardActions(context, handler),
              // 【UI调整】底部：合并了通话状态、时间和标签的信息区
              _buildFooterInfo(context, ref, timeString, callTypeInfo),
            ],
          ),
        ),
      ),
    );
  }

  // --- 头部信息：头像、联系人姓名和号码 ---
  Widget _buildCardHeader(BuildContext context, WidgetRef ref, _CallTypeInfo callTypeInfo) {
    // ... (此部分代码无变化)
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              FutureBuilder<String?>(
                future: _getAvatarPath(ref, log.phoneNumber),
                builder: (context, snapshot) {
                  final avatarPath = snapshot.data;
                  final imageProvider = avatarPath != null ? AvatarUtils.getAvatarImage(avatarPath, null) : null;
                  
                  return CircleAvatar(
                    radius: 24,
                    backgroundImage: imageProvider,
                    backgroundColor: Colors.grey[200],
                    child: imageProvider == null 
                        ? Icon(Icons.person, size: 28, color: Colors.grey[400]) 
                        : null,
                  );
                },
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: callTypeInfo.color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(callTypeInfo.icon, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      log.name ?? log.phoneNumber,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (log.name == null)
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: InkWell(
                        onTap: () => _showNameEditDialog(context, ref),
                        borderRadius: BorderRadius.circular(16),
                        child: Icon(Icons.edit, size: 16, color: Colors.grey[600]),
                      ),
                    ),
                ],
              ),
              if (log.name != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    log.phoneNumber,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// 操作区: 图标按钮行
  Widget _buildCardActions(BuildContext context, CallHistoryActionHandler handler) {
    // 【UI调整】使用SizedBox控制高度，使其更紧凑
    return SizedBox(
      height: 40, // 控制操作栏的高度
      child: Padding(
        padding: const EdgeInsets.only(left: 56.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.info_outline, size: 20),
              color: Colors.grey,
              onPressed: () {},
              tooltip: AppLocalizations.of(context)!.viewDetails,
            ),
            IconButton(
              icon: const Icon(Icons.label_outline, size: 20),
              color: Colors.grey,
              onPressed: () => _showLabelSelectionDialog(context),
              tooltip: AppLocalizations.of(context)!.addLabel,
            ),
            IconButton(
              icon: Icon(log.callType == 'blocked' ? Icons.block : Icons.phone, size: 20),
              color: Colors.grey,
              onPressed: handler.handleCallAction,
              tooltip: log.callType == 'blocked' ? AppLocalizations.of(context)!.unblock : AppLocalizations.of(context)!.call,
            ),
            IconButton(
              icon: const Icon(Icons.rule, size: 20),
              color: Colors.grey,
              onPressed: () => _showRuleActionDialog(context),
              tooltip: AppLocalizations.of(context)!.addRule,
            ),
          ],
        ),
      ),
    );
  }
  
  /// 【UI调整】新的底部信息区：整合了通话状态、时间、SIM卡和标签
  Widget _buildFooterInfo(BuildContext context, WidgetRef ref, String timeString, _CallTypeInfo callTypeInfo) {
    final simInfo = '${log.simDisplayName ?? ''} ${log.carrierName ?? ''}'.trim();
    final hasSimInfo = simInfo.isNotEmpty;
    bool hasLabels = log.labelIds != null && log.labelIds!.isNotEmpty;

    // 分隔符
    Widget buildSeparator() => const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text('•', style: TextStyle(fontSize: 12, color: Colors.grey)),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 64.0), // 左侧对齐姓名下方
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 第一行：通话状态、时间、SIM卡信息
          Row(
            children: [
              Text(
                callTypeInfo.text,
                style: TextStyle(fontSize: 13, color: callTypeInfo.color, fontWeight: FontWeight.bold),
              ),
              buildSeparator(),
              Text(timeString, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              if (hasSimInfo) ...[
                buildSeparator(),
                Flexible(
                  child: Text(
                    simInfo,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
          // 第二行：标签信息 (如果存在)
          if (hasLabels)
            FutureBuilder<String?>(  
              future: _getLabelText(context, ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0), // 与上一行保持一个小的间距
                    child: Text(
                      snapshot.data!,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }
                return const SizedBox.shrink(); // 如果没有标签文本，则不显示任何内容
              },
            ),
        ],
      ),
    );
  }

  // --- 所有辅助方法 --- (无变化)

  _CallTypeInfo _getCallTypeInfo(BuildContext context, String callType) {
    switch (callType) {
      case 'incoming': return _CallTypeInfo(icon: Icons.phone, color: Colors.green, text: AppLocalizations.of(context)!.callTypeAnswered);
      case 'outgoing': return _CallTypeInfo(icon: Icons.call_made, color: Colors.blue, text: AppLocalizations.of(context)!.callTypeOutgoing);
      case 'missed': return _CallTypeInfo(icon: Icons.phone_missed, color: Colors.orange, text: AppLocalizations.of(context)!.callTypeMissed);
      case 'blocked': return _CallTypeInfo(icon: Icons.block, color: Colors.red, text: AppLocalizations.of(context)!.callTypeBlocked);
      default: return _CallTypeInfo(icon: Icons.phone, color: Colors.grey, text: AppLocalizations.of(context)!.callTypeUnknown);
    }
  }

  Future<String?> _getAvatarPath(WidgetRef ref, String phoneNumber) async {
    return await ref.read(callLogServiceProvider).getAvatarForNumber(phoneNumber);
  }
  
  Future<String?> _getLabelText(BuildContext context, WidgetRef ref) async {
    return await LabelTextUtils.getLabelTextFromCallLog(context, ref, log);
  }

  void _showLabelSelectionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => Consumer(
        builder: (context, ref, _) => LabelDialog(
          log: log,
          onLabelUpdated: () => ref.read(callLogServiceProvider).refresh(),
        ),
      ),
    );
  }

  void _showRuleActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RuleActionDialog(log: log),
    );
  }
  
  void _showNameEditDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addName),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: AppLocalizations.of(context)!.enterName),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                final callLogService = ref.read(callLogServiceProvider);
                callLogService.updateLog(log.copyWith(name: newName));
                Navigator.pop(dialogContext);
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }
}