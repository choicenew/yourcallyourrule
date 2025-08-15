// 远程号码实体类，用于表示远程号码数据

import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import '../rule/rule_base.dart';

/// 远程号码实体类，继承自RuleBase
class RemoteNumberEntry extends RuleBase {
  // 远程电话号码
  final PhoneNumber phoneNumber;
  
  // 标签文本内容
  final String label;
  
  // 计数（用于记录匹配次数）
  final int count;
  
  // 联系人名称（可选）

  // 联系人名称（可选）
  
  // 构造函数
  const RemoteNumberEntry({
    required super.id,
    super.name = '',
    required super.priority,
    required this.phoneNumber,
    required this.label,
    super.action = RuleAction.none,
    super.isEnabled = true,
    this.count = 0,
  });
  
  // 实现规则匹配方法
  @override
  bool matches(String input) {
    // 检查输入是否与远程号码匹配
    return isEnabled && phoneNumber.value == input;
  }
  
  // 重写toMap方法，添加远程号码特有的字段
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber.value,
      'label': label,
      'count': count,
      'name': name,
    });
    return map;
  }
  
  // 从Map创建实例的工厂构造函数
  factory RemoteNumberEntry.fromMap(Map<String, dynamic> map) {
    return RemoteNumberEntry(
      id: map['id'],
      name: map['name'] ?? '',
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      label: map['label'] ?? '',
      priority: RulePriority.fromInt(map['priority'] ?? 0),
      action: RuleAction.fromString(map['action'] ?? 'none'),
      isEnabled: map['isEnabled'] ?? true,
      count: map['count'] ?? 0,
    );
  }
  
  // 创建带有递增计数的新实例
  RemoteNumberEntry incrementCount() {
    return copyWith(count: count + 1);
  }
  
  // 添加copyWith方法用于创建新实例
  @override
  RemoteNumberEntry copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    bool? isEnabled,
    String? label,
    int? count,
  }) {
    return RemoteNumberEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      phoneNumber: phoneNumber,
      label: label ?? this.label,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      count: count ?? this.count,
    );
  }
  
  // 检查计数是否超过阈值
  bool isCountExceeded(int threshold) {
    return count > threshold;
  }
}