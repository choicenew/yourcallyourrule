import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';

class ContactRule extends RuleBase {
  final String contactId;
  final bool isSubscribed;

  const ContactRule({
    required super.id,
    required super.name,
    required super.priority,
    required super.action,
    required this.contactId,
    this.isSubscribed = false,
    super.isEnabled = true,
  });

  @override
  bool matches(String input) {
    return isEnabled && contactId == input;
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'contactId': contactId,
      'isSubscribed': isSubscribed,
    });
    return map;
  }

  factory ContactRule.fromMap(Map<String, dynamic> map) {
    return ContactRule(
      id: map['id'],
      name: map['name'],
      priority: RulePriority.fromInt(map['priority']),
      action: RuleAction.fromString(map['action']),
      contactId: map['contactId'],
      isSubscribed: map['isSubscribed'] ?? false,
      isEnabled: map['isEnabled'] ?? true,
    );
  }

  ContactRule copyWith({
    String? id,
    String? name,
    RulePriority? priority,
    RuleAction? action,
    String? contactId,
    bool? isSubscribed,
    bool? isEnabled,
  }) {
    return ContactRule(
      id: id ?? this.id,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      action: action ?? this.action,
      contactId: contactId ?? this.contactId,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  List<Object?> get props => [id, name, priority, action, contactId, isSubscribed, isEnabled];
}