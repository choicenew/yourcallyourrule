// lib/features/call/call_history/utils/call_history_action_handler.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/call/local_call_type.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/features/rules/providers/allowed_blocked_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 一个专门处理通话记录相关操作的工具类 (Handler)
class CallHistoryActionHandler {
  final BuildContext context;
  final WidgetRef ref;
  final CallLog log;
  final VoidCallback onRefresh;

  CallHistoryActionHandler({
    required this.context,
    required this.ref,
    required this.log,
    required this.onRefresh,
  });

  /// 主入口方法：根据通话记录类型，处理电话或拦截操作
  void handleCallAction() {
    if (log.callType == LocalCallType.blocked) {
      _showUnblockConfirmDialog();
    } else {
      _showCallActionDialog();
    }
  }

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

  Future<void> _makePhoneCall() async {
    final Uri telUri = Uri(scheme: 'tel', path: log.phoneNumber);
    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
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
  
  Future<void> _blockNumber() async {
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
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.unblockNumberFailed}: $e'),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      onRefresh(); // Refresh the list to show the new 'blocked' status
    }
  }

  void _showUnblockConfirmDialog() {
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
                onRefresh(); // Always refresh to reflect the unblocked status
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