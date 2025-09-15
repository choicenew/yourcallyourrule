import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/common/utils/phone_utils.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/remote/remote_number_entry.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_service.dart';

/// 标签电话条目到远程同步服务
/// 负责将 LabelPhoneEntry 同步到远程号码服务
class LabelPhoneEntryToRemote {
  final RemoteNumberService _remoteNumberService;
  final PredefinedLabelService _predefinedLabelService;

  LabelPhoneEntryToRemote(
    this._remoteNumberService,
    this._predefinedLabelService,
  );

  /// 处理单个标签数据并同步到远程号码服务
  Future<void> sync(LabelPhoneEntry labelPhoneEntry) async {
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
      
      await _syncInternal(formattedPhoneNumber, labelPhoneEntry);
    } catch (e) {
      // 如果电话号码格式化失败，使用原始号码
      await _syncInternal(phoneNumber, labelPhoneEntry);
    }
  }

  Future<void> _syncInternal(PhoneNumber phoneNumber, LabelPhoneEntry labelPhoneEntry) async {
    // 获取预定义标签信息
    final predefinedLabel = await _predefinedLabelService.getLabelById(labelPhoneEntry.labelId);
    final labelText = predefinedLabel?.text ?? '';
    
    // 检查远程号码服务中是否已存在该号码
    final existingEntry = await _remoteNumberService.getRemoteNumberByPhoneNumber(phoneNumber);
    
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
        id: const Uuid().v4(),
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
  
  /// 确定名称
  String _determineName(LabelPhoneEntry labelPhoneEntry, RemoteNumberEntry existingEntry) {
    if (labelPhoneEntry.name.isNotEmpty) {
      return labelPhoneEntry.name;
    }
    return existingEntry.name;
  }
}