import 'package:yourcallyourrule/core/base/base_entity.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';


import '../../value_objects/url.dart';



/// 短信订阅实体
class SmsSubscription extends BaseEntity {
  final String name;
  final Url url;
  final bool isEnabled;
  final RuleAction action;
  final DateTime lastUpdated;
  final bool autoUpdate;
  final String tableType; // 添加表类型字段

  const SmsSubscription({
    required super.id,
    required this.name,
    required this.url,
    this.isEnabled = true,
    this.action = RuleAction.block,
    required this.lastUpdated,
    this.autoUpdate = false,
    this.tableType = 'sms', // 默认为sms类型
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url.toString(),
      'isEnabled': isEnabled ? 1 : 0,
      'action': action.toString(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'autoUpdate': autoUpdate ? 1 : 0,
      'table_type': tableType, // 添加表类型字段
    };
  }

  factory SmsSubscription.fromMap(Map<String, dynamic> map) {
    return SmsSubscription(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: Url.fromString(map['url'] ?? ''),
      isEnabled: map['isEnabled'] == 1 || map['isEnabled'] == true,
      action: RuleAction.fromString(map['action'] ?? 'block'),
      lastUpdated: map['lastUpdated'] != null 
          ? DateTime.tryParse(map['lastUpdated']) ?? DateTime.now()
          : DateTime.now(),
      autoUpdate: map['autoUpdate'] == 1 || map['autoUpdate'] == true,
      tableType: map['table_type'] ?? 'sms', // 从map中获取表类型
    );
  }

  SmsSubscription copyWith({
    String? id,
    String? name,
    Url? url,
    bool? isEnabled,
    RuleAction? action,
    DateTime? lastUpdated,
    bool? autoUpdate,
  }) {
    return SmsSubscription(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      isEnabled: isEnabled ?? this.isEnabled,
      action: action ?? this.action,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      autoUpdate: autoUpdate ?? this.autoUpdate,
    );
  }
}

















