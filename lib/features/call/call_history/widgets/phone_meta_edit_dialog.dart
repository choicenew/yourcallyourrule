// lib/features/call/call_history/widgets/phone_meta_edit_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/provider/providers/call_log_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/label_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/common/widgets/public_select_label.dart';
import 'package:yourcallyourrule/features/labels/providers/label_phone_entry_to_remote_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 电话元数据编辑对话框
/// 用于统一编辑一个电话号码关联的 Name 和 LabelId
class PhoneMetaEditDialog extends ConsumerStatefulWidget {
  final CallLog log;

  const PhoneMetaEditDialog({super.key, required this.log});

  static Future<bool> show(BuildContext context, {required CallLog log}) async {
    final bool? dataChanged = await showDialog<bool>(
      context: context,
      builder: (_) => PhoneMetaEditDialog(log: log),
    );
    return dataChanged ?? false;
  }

  @override
  ConsumerState<PhoneMetaEditDialog> createState() => _PhoneMetaEditDialogState();
}

class _PhoneMetaEditDialogState extends ConsumerState<PhoneMetaEditDialog> {
  late TextEditingController _nameController;
  String? _selectedLabelId;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.log.name);
    _selectedLabelId = widget.log.labelIds?.firstOrNull;
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// 核心保存逻辑 - 严格分离 CallLog 和 LabelPhoneEntry 的保存
  Future<void> _saveChanges() async {
    setState(() => _isSaving = true);

    try {
      final newName = _nameController.text.trim();
      final newLabelIds = _selectedLabelId != null ? [_selectedLabelId!] : <String>[];
      final callLogService = ref.read(callLogServiceProvider);
      
      // 步骤 A: 独立地保存“事实档案” (LabelPhoneEntry)
      final entryToProcess = await _createOrUpdateLabelPhoneEntry(newName, _selectedLabelId);

      // 步骤 B: 独立地、无条件地保存当前这一条“历史事件快照” (CallLog)
      await callLogService.updateLog(widget.log.copyWith(
        name: newName.isEmpty ? null : newName,
        labelIds: newLabelIds,
      ));

      // 步骤 C: 在后台，批量更新数据库中所有使用该号码的 CallLog 记录
      await callLogService.updateNameAndLabelsByPhoneNumber(
        widget.log.phoneNumber, // 使用原始号码进行匹配
        newName.isEmpty ? null : newName,
        newLabelIds,
      );

      // 步骤 D: (可选) 同步
      if (entryToProcess != null) {
        final syncService = ref.read(labelPhoneEntryToRemoteProvider);
        await syncService.sync(entryToProcess);
      }
      
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ));
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  /// 私有辅助方法，封装了创建或更新 LabelPhoneEntry 的逻辑
  /// 它的唯一职责就是确保数据库中存在一条正确的记录，并返回它
  /// **此方法严格使用 E.164 号码**
  Future<LabelPhoneEntry?> _createOrUpdateLabelPhoneEntry(String newName, String? newLabelId) async {
    final labelService = ref.read(labelServiceProvider);
    
    // 1. 将 CallLog 中的原始号码转换为 E.164 格式
    final parsedResult = await PhoneUtils.parsePhoneNumber(widget.log.phoneNumber);
    final e164NumberString = parsedResult['e164Number'];

    if (e164NumberString == null || e164NumberString.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.numberInvalidFormat)));
      }
      return null;
    }
      
    final e164PhoneNumber = PhoneNumber.fromString(e164NumberString);
      
    // 2. 使用 E.164 号码在数据库中查找
    LabelPhoneEntry? existingEntry = await labelService.getLabelByPhoneNumber(e164PhoneNumber);
    LabelPhoneEntry entryToProcess;

    if (existingEntry != null) {
      // 3a. 如果存在，则更新
      entryToProcess = existingEntry.copyWith(
        name: newName.isEmpty ? null : newName, 
        labelId: newLabelId ?? '',
      );
      await labelService.updateLabel(entryToProcess);
    } else {
      // 3b. 如果不存在，则创建
      entryToProcess = LabelPhoneEntry(
        id: const Uuid().v4(),
        phoneNumber: e164PhoneNumber,
        labelId: newLabelId ?? '',
        name: newName.isEmpty ? null : newName,
      );
      await labelService.addLabel(entryToProcess);
    }
    debugPrint('LabelPhoneEntry: ${entryToProcess.toMap()}');
    return entryToProcess;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.editRule),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.name,
                hintText: AppLocalizations.of(context)!.enterName,
              ),
            ),
            const SizedBox(height: 24),
            Text(AppLocalizations.of(context)!.selectLabel, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            PublicSelectLabel(
              initialLabelId: _selectedLabelId,
              onLabelIdChanged: (newLabelId) {
                setState(() {
                  _selectedLabelId = newLabelId;
                });
              },
            ),
            const SizedBox(height: 16),
            GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
          ],
        ),
      ),
      actions: [
        if (!_isSaving)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancelButton),
          ),
        ElevatedButton(
          onPressed: _isSaving ? null : _saveChanges,
          child: _isSaving
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}