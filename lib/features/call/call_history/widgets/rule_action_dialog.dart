import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/rule_management_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/rules/services/allowed_blocked_service.dart';
import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 规则操作对话框组件
class RuleActionDialog extends ConsumerWidget {
  final CallLog log;

  const RuleActionDialog({super.key, required this.log});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.addToRules),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 允许/阻止规则选项
          ListTile(
            leading: const Icon(Icons.check_circle_outline, color: Colors.green),
            title: Text(AppLocalizations.of(context)!.addToAllowedRules),
            onTap: () {
              _addToAllowedBlockedRule(context, ref, log, RuleAction.allow);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.block, color: Colors.red),
            title: Text(AppLocalizations.of(context)!.addToBlockedRules),
            onTap: () {
              _addToAllowedBlockedRule(context, ref, log, RuleAction.block);
              Navigator.pop(context);
            },
          ),
          const Divider(),
          // 黑白名单选项
          ListTile(
            leading: const Icon(Icons.check_circle_outline, color: Colors.blue),
            title: Text(AppLocalizations.of(context)!.addToWhitelist),
            onTap: () {
              _addToWhiteBlackRule(context, ref, log, RuleAction.allow);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.block, color: Colors.orange),
            title: Text(AppLocalizations.of(context)!.addToBlacklist),
            onTap: () {
              _addToWhiteBlackRule(context, ref, log, RuleAction.block);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancelButton),
        ),
      ],
    );
  }

  // 添加到允许/阻止规则
  Future<void> _addToAllowedBlockedRule(BuildContext context, WidgetRef ref, CallLog log, RuleAction action) async {
    try {
      final service = ref.read(allowedBlockedServiceProvider);
      final labelId = log.labelIds?.isNotEmpty == true ? log.labelIds!.first : '';
      
      // 创建ListEntry对象
      final entry = ListEntry(
        id: log.id,
        phoneNumber: PhoneNumber(log.number),
        labelId: labelId,
        name: log.name ?? log.number, // 优先使用name字段，如果为空则使用号码
      );
      
      await service.addAllowedBlockedRule(entry, action);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(action.type == RuleActionType.allow
              ? (AppLocalizations.of(context)!.addedToAllowedRules)
              : (AppLocalizations.of(context)!.addedToBlockedRules)),
          backgroundColor: action.type == RuleActionType.allow ? Colors.green : Colors.red,
        ));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)?.addRuleFailed}: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  // 添加到黑白名单
  Future<void> _addToWhiteBlackRule(BuildContext context, WidgetRef ref, CallLog log, RuleAction action) async {
    try {
      final service = ref.read(ruleManagementServiceProvider);
      final labelId = log.labelIds?.isNotEmpty == true ? log.labelIds!.first : '';
      
      // 创建ListEntry对象
      final entry = ListEntry(
        id: log.id,
        phoneNumber: PhoneNumber(log.number),
        labelId: labelId,
        name: log.name ?? log.number, // 优先使用name字段，如果为空则使用号码
      );
      
      await service.addPhoneRule(entry, action);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(action.type == RuleActionType.allow
              ? (AppLocalizations.of(context)!.addedToWhitelist)
              : (AppLocalizations.of(context)!.addedToBlacklist)),
          backgroundColor: action.type == RuleActionType.allow ? Colors.blue : Colors.orange,
        ));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)?.addRuleFailed}: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }
}