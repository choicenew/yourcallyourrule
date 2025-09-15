// lib/features/call/call_history/widgets/call_log_dialogs.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/providers/label_phone_entry_to_remote_provider.dart';
import 'package:yourcallyourrule/features/labels/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/features/call/call_history/widgets/rule_action_dialog.dart'; // 引入正确的Dialog

/// 一个专门处理通话记录相关弹窗的类
/// 将弹窗逻辑从 CallLogCard 中分离出来
class CallLogDialogs {
  final BuildContext context;
  final WidgetRef ref;
  final CallLog log;
  final Map<String, String> labelIdToTextMap;
  final String? region;

  CallLogDialogs({
    required this.context,
    required this.ref,
    required this.log,
    required this.labelIdToTextMap,
    this.region,
  });
  
  /// 显示标签选择弹窗
  /// 返回 true 如果数据被修改, 否则返回 false.
  Future<bool> showLabelSelectionDialog() async {
    String? selectedLabelId = log.labelIds?.firstOrNull;
    bool isSaving = false;
    bool dataChanged = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(this.context)!.selectLabel),
              content: PublicSelectLabel(
                initialLabelId: selectedLabelId,
                onLabelIdChanged: (newLabelId) {
                  setDialogState(() { selectedLabelId = newLabelId; });
                },
              ),
              actions: [
                if (!isSaving)
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: Text(AppLocalizations.of(this.context)!.cancelButton),
                  ),
                ElevatedButton(
                  onPressed: isSaving ? null : () async {
                    setDialogState(() { isSaving = true; });
                    
                    final newLabelId = selectedLabelId;
                    if (newLabelId == null || newLabelId == log.labelIds?.firstOrNull) {
                       Navigator.pop(dialogContext);
                       return;
                    }

                    final parsedResult = await PhoneUtils.parsePhoneNumber(log.phoneNumber);
                    final e164NumberString = parsedResult['e164Number'];

                    if (e164NumberString == null || e164NumberString.isEmpty) {
                      if (this.context.mounted) {
                        ScaffoldMessenger.of(this.context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(this.context)!.numberInvalidFormat)));
                      }
                      setDialogState(() { isSaving = false; });
                      return;
                    }
                    
                    final standardizedPhoneNumber = PhoneNumber.fromString(e164NumberString);
                    final callLogService = ref.read(callLogServiceProvider);
                    final labelService = ref.read(labelServiceProvider);

                    final updatedLog = log.copyWith(labelIds: [newLabelId]);

 debugPrint('updateLog: ${updatedLog.toMap()}'); 

                    await callLogService.updateLog(updatedLog);
                     
                    LabelPhoneEntry? existingEntry = await labelService.getLabelByPhoneNumber(standardizedPhoneNumber);
                    LabelPhoneEntry entryToProcess;

                    if (existingEntry != null) {
                      entryToProcess = existingEntry.copyWith(labelId: newLabelId);
                      await labelService.updateLabel(entryToProcess);

                    } else {
                      entryToProcess = LabelPhoneEntry(
                        id: const Uuid().v4(),
                        phoneNumber: standardizedPhoneNumber,
                        labelId: newLabelId,
                        name: log.name,
                      );
                      await labelService.addLabel(entryToProcess);
                    }
                    
                    final syncService = ref.read(labelPhoneEntryToRemoteProvider);
                    await syncService.sync(entryToProcess);
                    
                    dataChanged = true;
                    if (dialogContext.mounted) Navigator.pop(dialogContext);
                  },
                  child: isSaving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Text(AppLocalizations.of(this.context)!.save),
                ),
              ],
            );
          }
        );
      },
    );
    return dataChanged;
  }

  /// 显示名称编辑弹窗
  /// 返回 true 如果数据被修改, 否则返回 false.
  Future<bool> showNameEditDialog() async {
    final nameController = TextEditingController(text: log.name);
    bool dataChanged = false;
    await showDialog(
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
            onPressed: () async {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty && newName != log.name) {
                await ref.read(callLogServiceProvider).updateLog(log.copyWith(name: newName));
                dataChanged = true;
              }
              Navigator.pop(dialogContext);
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
    return dataChanged;
  }

  /// 显示规则操作弹窗 (核心业务)
  /// 这个操作是独立的，不直接影响通话记录列表，所以不需要返回 bool
  Future<void> showRuleActionDialog() async {
    await showDialog(
      context: context,
      builder: (context) => RuleActionDialog(log: log),
    );
  }

  /// 显示详情弹窗
  void showCallDetailsDialog() {
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formattedTime = dateFormat.format(log.timestamp);
    final primaryLabelId = log.labelIds?.firstOrNull;
    final rawLabelText = primaryLabelId != null ? labelIdToTextMap[primaryLabelId] : null;
    final translatedLabelText = rawLabelText != null ? LabelTranslationUtils.translateLabelText(context, rawLabelText) : '-';
    final callTypeInfo = _getCallTypeInfo(context, log.callType);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.callDetails),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailItem(AppLocalizations.of(context)!.name, log.name ?? '-'),
              _buildDetailItem(AppLocalizations.of(context)!.phoneNumber, log.phoneNumber),
              _buildDetailItem(AppLocalizations.of(context)!.region, region ?? '-'),
              _buildDetailItem(AppLocalizations.of(context)!.callType, callTypeInfo.text),
              _buildDetailItem(AppLocalizations.of(context)!.callTime, formattedTime),
              if (log.simDisplayName.isNotEmpty)
                _buildDetailItem(AppLocalizations.of(context)!.simCard(log.simSlotIndex), log.simDisplayName),
              if (log.carrierName.isNotEmpty)
                _buildDetailItem(AppLocalizations.of(context)!.carrier, log.carrierName),
              _buildDetailItem(AppLocalizations.of(context)!.labels, translatedLabelText),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.closeButton),
          ),
        ],
      ),
    );
  }

  // Helper methods for dialogs
  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  _CallTypeInfo _getCallTypeInfo(BuildContext context, String callType) {
    final localizations = AppLocalizations.of(context)!;
    switch (callType) {
      case 'incoming': return _CallTypeInfo(icon: Icons.phone, color: Colors.green, text: localizations.callTypeAnswered);
      case 'outgoing': return _CallTypeInfo(icon: Icons.call_made, color: Colors.blue, text: localizations.callTypeOutgoing);
      case 'missed': return _CallTypeInfo(icon: Icons.phone_missed, color: Colors.orange, text: localizations.callTypeMissed);
      case 'blocked': return _CallTypeInfo(icon: Icons.block, color: Colors.red, text: localizations.callTypeBlocked);
      default: return _CallTypeInfo(icon: Icons.phone, color: Colors.grey, text: localizations.callTypeUnknown);
    }
  }
}

// Private helper class used by the dialog
class _CallTypeInfo {
  final IconData icon;
  final Color color;
  final String text;
  _CallTypeInfo({required this.icon, required this.color, required this.text});
}