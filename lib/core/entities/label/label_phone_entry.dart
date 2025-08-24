// 电话标签条目实体，用于表示电话号码的标签信息

import '../../value_objects/phone_number.dart';
import '../../value_objects/rule_action.dart';
import '../../value_objects/rule_priority.dart';
import '../rule/rule_base.dart';

class LabelPhoneEntry extends RuleBase {
  // 电话号码值对象
  final PhoneNumber phoneNumber;
  
  // 标签ID，引用PredefinedLabel
  final String labelId;

  // 头像（可选）
  final String? avatar;

  // 标签图标（可选）
  final String? icon;

  // 为标签定义默认优先级（例如，一个较低或中性的值）
  static const RulePriority defaultPriority = RulePriority(0);
  // 为标签定义默认动作（通常是 none，因为标签本身不执行动作）
  static const RuleAction defaultAction = RuleAction.none;

  // 构造函数 - priority 和 action 提供默认值，使其在调用时可选
  const LabelPhoneEntry({
    required super.id,
    String? name, // name 仍然是可选的
    super.priority = defaultPriority, // 提供默认值
    required this.phoneNumber,
    required this.labelId, // 必须提供labelId
    super.action = defaultAction, // 提供默认值
    super.isEnabled = true,
    this.avatar,
    this.icon,
  }) : super(
          name: name ?? '',     // 传递 action (可能是默认值)
        );

  // 实现规则匹配方法 - 标签通常只用于识别，不直接参与规则匹配决策
  @override
  bool matches(String input) {
    // 这里的匹配逻辑可以根据需要调整，
    // 但对于纯标签，可能总是返回 false 或只匹配号码用于信息展示
    return isEnabled && phoneNumber.value == input;
  }

  // 重写toMap方法，添加标签条目特有的字段，并包含类型信息
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap(); // 获取基类的 map (id, name, priority, action, isEnabled)
    map.addAll({
      'type': 'label_phone_entry', // 添加类型标识符，用于反序列化
      'phoneNumber': phoneNumber.value,
      'labelId': labelId,
      'avatar': avatar,
      'icon': icon,
    });
    return map;
  }

  // 从Map创建实例的工厂构造函数 - 处理可选字段和默认值
  factory LabelPhoneEntry.fromMap(Map<String, dynamic> map) {
    // 确认类型是否匹配，如果 'type' 字段存在的话
    // assert(map['type'] == 'label_phone_entry', 'Map is not for LabelPhoneEntry');

    return LabelPhoneEntry(
      id: map['id'],
      name: map['name'], // name 可能为 null 或空字符串
      priority: RulePriority.fromInt(map['priority'] ?? defaultPriority.value), // 使用默认值
      phoneNumber: PhoneNumber.fromString(map['phoneNumber']),
      labelId: map['labelId'], // 使用labelId
      action: RuleAction.fromString(map['action'] ?? defaultAction.toString().split('.').last), // 使用默认值
      isEnabled: map['isEnabled'] ?? true,
      avatar: map['avatar'],
      icon: map['icon'],
    );
  }  
  // 可选的 copyWith 方法，用于方便地创建修改后的副本
  @override
  LabelPhoneEntry copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    PhoneNumber? phoneNumber,
    String? labelId,
    RuleAction? action,
    bool? isEnabled,
    String? avatar,
    String? icon,
  }) {
    return LabelPhoneEntry(
      id: id ?? this.id,
      name: name ?? this.name, // 使用 this.name 访问基类的 name
      priority: priority ?? this.priority,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      labelId: labelId ?? this.labelId,
      action: action ?? this.action,
      isEnabled: isEnabled ?? this.isEnabled,
      avatar: avatar ?? this.avatar,
      icon: icon ?? this.icon,
    );
  }
  
}

// 为了向后兼容，保留LabelEntry类型别名
//typedef LabelEntry = LabelPhoneEntry;