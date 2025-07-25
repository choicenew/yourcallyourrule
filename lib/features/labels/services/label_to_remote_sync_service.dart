import 'dart:async';

import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/features/labels/services/label_service.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

/// 标签到远程号码同步服务类
/// 负责将标签电话条目同步到远程号码服务，并处理电话号码格式化为E164格式
/// 类似于PluginToRemoteSyncService，但专门用于标签数据
class LabelToRemoteSyncService {
  final RemoteNumberService _remoteNumberService;
  final LabelService _labelService;
  final PredefinedLabelService _predefinedLabelService;
  StreamSubscription<dynamic>? _dataSubscription;

  LabelToRemoteSyncService(
    this._remoteNumberService,
    this._labelService,
    this._predefinedLabelService,
  );

  /// 开始监听标签电话条目流并同步到远程号码服务
  void startSync(Stream<LabelPhoneEntry> labelPhoneEntryStream) {
    _dataSubscription?.cancel();
    
    _dataSubscription = labelPhoneEntryStream.listen(_handleLabelData);
  }

  /// 处理单个标签数据并同步到远程号码服务
  Future<void> syncSingleLabel(LabelPhoneEntry labelPhoneEntry) async {
    await _handleLabelData(labelPhoneEntry);
  }

  /// 处理标签数据并转换为远程号码条目
  Future<void> _handleLabelData(LabelPhoneEntry labelPhoneEntry) async {
    // 获取电话号码
    final phoneNumber = labelPhoneEntry.phoneNumber;
    
    // 尝试将电话号码转换为E164格式
    try {
      final phoneNumberMap = await PhoneUtils.parsePhoneNumberWithoutIso(
        phoneNumber.value,
        null,
      );
      
      // 获取E164格式的电话号码
      final e164Number = phoneNumberMap['e164'] ?? phoneNumber.value;
      final formattedPhoneNumber = PhoneNumber.fromString(e164Number);
      
      // 获取预定义标签信息
      final predefinedLabel = await _predefinedLabelService.getLabelById(labelPhoneEntry.labelId);
      final labelText = predefinedLabel?.text ?? '';
      
      // 检查远程号码服务中是否已存在该号码
      final existingEntry = await _remoteNumberService.getRemoteNumberByPhoneNumber(formattedPhoneNumber);
      
      if (existingEntry != null) {
        // 更新现有条目
        final updatedEntry = RemoteNumberEntry(
          id: existingEntry.id,
          phoneNumber: formattedPhoneNumber,
          name: _determineName(labelPhoneEntry, existingEntry),
          label: labelText,
          priority: existingEntry.priority,
          count: existingEntry.count,
          action: existingEntry.action,
          isEnabled: existingEntry.isEnabled,
        );
        await _remoteNumberService.updateRemoteNumber(updatedEntry);
      } else {
        // 创建新条目
        final newEntry = RemoteNumberEntry(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          phoneNumber: formattedPhoneNumber,
          name: labelPhoneEntry.name,
          label: labelText,
          priority: const RulePriority(0),
          count: 0,
          action: RuleAction.none,
          isEnabled: true,
        );
        await _remoteNumberService.addRemoteNumber(newEntry);
      }
    } catch (e) {
      // 如果电话号码格式化失败，使用原始号码
      final existingEntry = await _remoteNumberService.getRemoteNumberByPhoneNumber(phoneNumber);
      
      // 获取预定义标签信息
      final predefinedLabel = await _predefinedLabelService.getLabelById(labelPhoneEntry.labelId);
      final labelText = predefinedLabel?.text ?? '';
      
      if (existingEntry != null) {
        // 更新现有条目
        final updatedEntry = RemoteNumberEntry(
          id: existingEntry.id,
          phoneNumber: phoneNumber,
          name: _determineName(labelPhoneEntry, existingEntry),
          label: labelText,
          priority: existingEntry.priority,
          count: existingEntry.count,
          action: existingEntry.action,
          isEnabled: existingEntry.isEnabled,
        );
        await _remoteNumberService.updateRemoteNumber(updatedEntry);
      } else {
        // 创建新条目
        final newEntry = RemoteNumberEntry(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          phoneNumber: phoneNumber,
          name: labelPhoneEntry.name,
          label: labelText,
          priority: const RulePriority(0),
          count: 0,
          action: RuleAction.none,
          isEnabled: true,
        );
        await _remoteNumberService.addRemoteNumber(newEntry);
      }
    }
  }
  
  /// 确定名称
  String _determineName(LabelPhoneEntry labelPhoneEntry, RemoteNumberEntry existingEntry) {
    if (labelPhoneEntry.name.isNotEmpty) {
      return labelPhoneEntry.name;
    }
    return existingEntry.name;
  }

  /// 根据电话号码同步标签信息到远程号码
  Future<void> syncLabelByPhoneNumber(PhoneNumber phoneNumber) async {
    final labelPhoneEntry = await _labelService.getLabelByPhoneNumber(phoneNumber);
    if (labelPhoneEntry != null) {
      await _handleLabelData(labelPhoneEntry);
    }
  }

  /// 同步所有标签到远程号码
  Future<void> syncAllLabels() async {
    final labels = await _labelService.getAllLabels();
    for (final label in labels) {
      await _handleLabelData(label);
    }
  }

  /// 停止同步服务
  void dispose() {
    _dataSubscription?.cancel();
    _dataSubscription = null;
  }
}