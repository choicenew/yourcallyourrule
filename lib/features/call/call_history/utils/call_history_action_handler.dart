// lib/features/call/call_history/utils/call_history_action_handler.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 一个专门处理通话记录相关操作的工具类 (Handler)
/// 将复杂的业务逻辑从UI组件中分离出来，使代码更清晰、更易于维护。
class CallHistoryActionHandler {
  final BuildContext context;
  final WidgetRef ref;
  final CallLog log;

  CallHistoryActionHandler({
    required this.context,
    required this.ref,
    required this.log,
  });

  /// 主入口方法：根据通话记录类型，处理电话或拦截操作
  void handleCallAction() {
    if (log.callType == 'blocked') {
      // 如果是已拦截的通话，显示解除拦截的确认对话框
      _showUnblockConfirmDialog();
    } else {
      // 否则，显示一个包含“拨打”和“拦截”选项的对话框
      _showCallActionDialog();
    }
  }

  /// 显示包含“拨打”和“拦截”选项的底部菜单
  void _showCallActionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: Text(AppLocalizations.of(context)!.call),
              onTap: () {
                Navigator.pop(context);
                _makePhoneCall();
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.red),
              title: Text(AppLocalizations.of(context)!.blockNumber),
              onTap: () {
                Navigator.pop(context);
                _blockNumber();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 拨打电话功能
  Future<void> _makePhoneCall() async {
    final Uri telUri = Uri(scheme: 'tel', path: log.phoneNumber);
    try {
      // 检查设备是否可以处理此URL
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        // 如果无法启动，抛出错误
        throw 'Could not launch $telUri';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.callingNumberFailed}: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
  
  /// 拦截号码功能
  Future<void> _blockNumber() async {
    final callLogService = ref.read(callLogServiceProvider);
    final allowedBlockedService = ref.read(allowedBlockedServiceProvider);

    try {
      final entry = ListEntry(
        id: log.id,
        phoneNumber: PhoneNumber(log.phoneNumber),
        labelId: log.labelIds?.isNotEmpty == true ? log.labelIds!.first : '',
        name: log.name ?? log.phoneNumber,
      );
      
      await allowedBlockedService.addAllowedBlockedRule(entry, RuleAction.block);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.blockNumberSuccess),
          backgroundColor: Colors.green,
        ));
        // 操作成功后刷新通话记录列表
        await callLogService.refresh();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.blockNumberFailed}: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  /// 显示解除拦截确认对话框
  void _showUnblockConfirmDialog() {
    final callLogService = ref.read(callLogServiceProvider);
    final allowedBlockedService = ref.read(allowedBlockedServiceProvider);
        
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.unblockNumber),
        content: Text(AppLocalizations.of(context)!.unblockNumberConfirmation(log.phoneNumber)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                final blockedRules = await allowedBlockedService.getAllBlockedRules();
                final matchingRules = blockedRules.where(
                  (rule) => rule.phoneNumber.value == log.phoneNumber
                ).toList();
                
                // 删除所有匹配的拦截规则
                for (final rule in matchingRules) {
                  await allowedBlockedService.removeRule(rule.id);
                }
                
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.unblockNumberSuccess),
                    backgroundColor: Colors.green,
                  ));
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${AppLocalizations.of(context)!.unblockNumberFailed}: $e'),
                    backgroundColor: Colors.red,
                  ));
                }
              } finally {
                // 无论成功失败，都刷新列表以确保UI状态正确
                await callLogService.refresh();
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.green),
            child: Text(AppLocalizations.of(context)!.unblock),
          ),
        ],
      ),
    );
  }
}