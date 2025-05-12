import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/list_service.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

/// 电话号码标签服务类
/// 负责将电话号码与标签ID关联，处理号码标记的业务逻辑
class LabelPhoneService extends ListService {
  final RuleRepository _ruleRepository;
  final PredefinedLabelService _predefinedLabelService;
  final Uuid _uuid = Uuid();
  
  /// 构造函数
  LabelPhoneService(this._ruleRepository, this._predefinedLabelService) : super(_ruleRepository);

  /// 标记电话号码
  Future<LabelPhoneEntry> markPhone(PhoneNumber phoneNumber, String labelId, {
    String? name,
    String? avatar,
    String? icon,
    RulePriority priority = LabelPhoneEntry.defaultPriority,
    RuleAction action = LabelPhoneEntry.defaultAction,
    bool isEnabled = true,
  }) async {
    // 检查标签ID是否存在
    final label = await _predefinedLabelService.getLabelById(labelId);
    if (label == null) {
      throw Exception('标签ID不存在: $labelId');
    }
    
    // 创建标签条目
    final entry = LabelPhoneEntry(
      id: _uuid.v4(),
      name: name ?? '',
      phoneNumber: phoneNumber,
      labelId: labelId,   // 只存储标签ID引用
      avatar: avatar ?? label.avatar,  // 可以使用自定义头像或标签默认头像
      icon: icon ?? label.icon,        // 可以使用自定义图标或标签默认图标
      priority: priority,
      action: action,
      isEnabled: isEnabled,
    );
    
    await _ruleRepository.save(entry);
    return entry;
  }

  /// 更新电话号码标记
  Future<void> updatePhoneMark(LabelPhoneEntry entry) async {
    await _ruleRepository.update(entry);
  }

  /// 删除电话号码标记
  Future<void> removePhoneMark(String entryId) async {
    final entry = await _ruleRepository.getById(entryId);
    if (entry != null) {
      await _ruleRepository.delete(entry);
    }
  }

  /// 获取所有电话号码标记
  Future<List<LabelPhoneEntry>> getAllPhoneMarks() async {
    final rules = await _ruleRepository.getAll();
    return rules.whereType<LabelPhoneEntry>().toList();
  }

  /// 根据电话号码获取标记
  Future<LabelPhoneEntry?> getLabelByPhoneNumber(PhoneNumber phoneNumber) async {
    final marks = await getAllPhoneMarks();
    try {
      return marks.firstWhere(
        (mark) => mark.phoneNumber == phoneNumber,
      );
    } catch (e) {
      return null;
    }
  }

  /// 根据标签ID获取所有标记
  Future<List<LabelPhoneEntry>> getMarksByLabelId(String labelId) async {
    final marks = await getAllPhoneMarks();
    return marks.where((mark) => mark.labelId == labelId).toList();
  }

  /// 检查电话号码是否已标记
  Future<bool> isPhoneMarked(PhoneNumber phoneNumber) async {
    final mark = await getLabelByPhoneNumber(phoneNumber);
    return mark != null;
  }
  
  /// 获取标记的视图模型（包含标签详细信息）
  Future<LabelViewModel> getMarkViewModel(LabelPhoneEntry entry) async {
    final label = await _predefinedLabelService.getLabelById(entry.labelId);
    return LabelViewModel(
      rule: entry,
      label: label,
      getLabelId: (rule) => rule.labelId,
    );
  }
  
  /// 批量获取标记的视图模型
  Future<List<LabelViewModel>> getMarkViewModels(List<LabelPhoneEntry> entries) async {
    // 提取所有使用的标签ID
    final labelIds = entries.map((e) => e.labelId).toSet().toList();
    
    // 批量加载所有相关的标签
    final labelsMap = <String, PredefinedLabel>{};
    for (final id in labelIds) {
      final label = await _predefinedLabelService.getLabelById(id);
      if (label != null) {
        labelsMap[id] = label;
      }
    }
    
    // 创建视图模型
    return entries.map((entry) {
      return LabelViewModel(
        rule: entry,
        label: labelsMap[entry.labelId],
        getLabelId: (rule) => rule.labelId,
      );
    }).toList();
  }
}

/// 标签视图模型
/// 提供通用的视图模型用于UI显示
class LabelViewModel<T> {
  /// 规则对象
  final T rule;
  
  /// 预定义标签
  final PredefinedLabel? label;
  
  /// 获取规则中labelId的函数
  final String Function(T) getLabelId;

  /// 构造函数
  LabelViewModel({
    required this.rule,
    this.label,
    required this.getLabelId,
  });

  /// 获取标签文本
  String get labelText => label?.text ?? 'Unknown Label';

  /// 获取标签ID
  String get labelId => getLabelId(rule);

  /// 获取标签头像
  String? get labelAvatar => label?.avatar;

  /// 获取标签图标
  String? get labelIcon => label?.icon;
}