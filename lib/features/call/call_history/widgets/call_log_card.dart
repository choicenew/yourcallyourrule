import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/label_dialog.dart';
import 'package:yourcallyourrule/features/labels/utils/label_text_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallLogCard extends ConsumerWidget {
  final CallLog log;

  const CallLogCard({super.key, required this.log});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 根据通话类型设置不同的图标和颜色
    IconData callIcon;
    Color iconColor;
    String callTypeText;
    
    switch (log.callType) {
      case 'incoming':
        callIcon = Icons.call_received;
        iconColor = Colors.green;
        callTypeText = AppLocalizations.of(context)!.callTypeAnswered;
        break;
      case 'outgoing':
        callIcon = Icons.call_made;
        iconColor = Colors.blue;
        callTypeText = AppLocalizations.of(context)!.callTypeOutgoing;
        break;
      case 'missed':
        callIcon = Icons.call_missed;
        iconColor = Colors.red;
        callTypeText = AppLocalizations.of(context)!.callTypeMissed;
        break;
      default:
        callIcon = Icons.call;
        iconColor = Colors.grey;
        callTypeText = AppLocalizations.of(context)!.callTypeUnknown;
    }
    
    // 格式化通话时间
    final callTime = log.timestamp;
    final formattedDate = '${callTime.year}-${callTime.month.toString().padLeft(2, '0')}-${callTime.day.toString().padLeft(2, '0')} ${callTime.hour.toString().padLeft(2, '0')}:${callTime.minute.toString().padLeft(2, '0')}';
    
    // 获取CallLogService实例
    final callLogService = ref.read(callLogServiceProvider);
    
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // 使用FutureBuilder同时获取标签文本和头像路径
                FutureBuilder<List<dynamic>>(
                  future: Future.wait([
                    _getLabelText(context, ref, log),
                    _getAvatarPath(context, ref, log.phoneNumber, null),
                  ]),
                  builder: (context, snapshot) {
                    // 加载中显示占位符
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha:0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))),
                      );
                    }
                    
                    // 获取结果
                    final labelText = snapshot.data?[0] as String?;
                    final avatarPath = snapshot.data?[1] as String?;
                    
                    // 使用AvatarUtils获取头像图片
                    final imageProvider = AvatarUtils.getAvatarImage(avatarPath, labelText);
                    
                    if (imageProvider != null) {
                      // 有头像图片
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      // 使用默认图标
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha:0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(callIcon, color: iconColor),
                      );
                    }
                  },
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    log.name ?? log.phoneNumber,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // 如果没有名称，显示编辑按钮
                                if (log.name == null)
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 16),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => _showNameEditDialog(context, log, ref),
                                    tooltip: AppLocalizations.of(context)?.addName,
                                  ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: iconColor.withValues(alpha:0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              callTypeText,
                              style: TextStyle(fontSize: 12, color: iconColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        log.phoneNumber, // 始终显示电话号码作为次要信息
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.label_outline),
                      onPressed: () => _showLabelDialog(context, log),
                      tooltip: AppLocalizations.of(context)!.addLabel,
                    ),
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.green),
                      onPressed: () {
                        // 回拨电话
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(AppLocalizations.of(context)!.callbackTo(log.phoneNumber))),
                        );
                      },
                      tooltip: AppLocalizations.of(context)!.callback,
                    ),
                  ],
                ),
              ],
            ),
            // 使用标签服务获取标签信息
            if (log.labelIds != null && log.labelIds!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 64.0),
                child: Text(
                  log.labelIds!.map((labelId) async {
                    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
                    final label = await predefinedLabelService.getLabelById(labelId);
                    return label?.text ?? labelId;
                  }).join(', '),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 获取标签文本
  Future<String?> _getLabelText(BuildContext context, WidgetRef ref, CallLog log) async {
    if (log.labelIds == null || log.labelIds!.isEmpty) {
      return null;
    }
    
    return await LabelTextUtils.getLabelTextFromCallLog(context, ref, log);
  }
  
  /// 获取头像路径
  Future<String?> _getAvatarPath(BuildContext context, WidgetRef ref, String phoneNumber, String? labelText) async {
    final callLogService = ref.read(callLogServiceProvider);
    // 使用CallLogService的getAvatarForNumber方法获取头像路径
    return await callLogService.getAvatarForNumber(phoneNumber);
  }
  
  /// 显示标签对话框
  void _showLabelDialog(BuildContext context, CallLog log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => LabelDialog(log: log),
    );
  }
  
  /// 显示名称编辑对话框
  void _showNameEditDialog(BuildContext context, CallLog log, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final callLogService = ref.read(callLogServiceProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addName ),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)?.enterName,
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                // 创建带有名称的新CallLog
                final updatedLog = log.copyWith(name: nameController.text);
                // 更新通话记录
                callLogService.updateLog(updatedLog);
                Navigator.pop(context);
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }
}