import 'package:yourcallyourrule/core/entities/sms/sms_regex_rule.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/models/rule_model.dart';

class SmsRegexRuleModel extends RuleModel {
  final String contentRegex;
  final String? senderRegex;

  SmsRegexRuleModel({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.contentRegex,
    this.senderRegex,
    super.isEnabled = true,
  }) : super(ruleType: 'sms_regex');

  factory SmsRegexRuleModel.fromEntity(SmsRegexRule entity) {
    return SmsRegexRuleModel(
      id: entity.id,
      name: entity.name,
      priority: entity.priority.value,
      action: entity.action.toString(),
      contentRegex: entity.contentPattern.pattern,
      senderRegex: entity.senderPattern?.pattern,
      isEnabled: entity.isEnabled,
    );
  }

  @override
  SmsRegexRule toEntity() {
    return SmsRegexRule(
      id: id,
      name: name,
      contentRegex: contentRegex,
      senderRegex: senderRegex,
      action: RuleAction.fromString(action),
      priority: RulePriority(priority),
      isEnabled: isEnabled,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'contentRegex': contentRegex,
      'senderRegex': senderRegex,
    });
    return map;
  }

  factory SmsRegexRuleModel.fromMap(Map<String, dynamic> map) {
    return SmsRegexRuleModel(
      id: map['id'],
      name: map['name'],
      priority: map['priority'],
      action: map['action'],
      contentRegex: map['contentRegex'],
      senderRegex: map['senderRegex'],
      isEnabled: map['isEnabled'] ?? true,
    );
  }

  SmsRegexRuleModel copyWith({
    String? id,
    String? name,
    String? contentRegex,
    String? senderRegex,
    String? action,
    int? priority,
    bool? isEnabled,
  }) {
    return SmsRegexRuleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      contentRegex: contentRegex ?? this.contentRegex,
      senderRegex: senderRegex ?? this.senderRegex,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}