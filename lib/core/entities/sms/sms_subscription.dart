import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';

/// 短信订阅实体
class SmsSubscription extends Subscription {
  const SmsSubscription({
    required super.id,
    required super.name,
    required super.url,
    super.isEnabled = true,
    super.action = RuleAction.block,
    required super.lastUpdated,
    super.autoUpdate = false,
  }) : super(tableType: 'sms');

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
    );
  }

  @override
  SmsSubscription copyWith({
    String? name,
    Url? url,
    bool? isEnabled,
    RuleAction? action,
    DateTime? lastUpdated,
    bool? autoUpdate,
    String? tableType,
  }) {
    return SmsSubscription(
      id: id,
      name: name ?? this.name,
      url: url ?? this.url,
      isEnabled: isEnabled ?? this.isEnabled,
      action: action ?? this.action,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      autoUpdate: autoUpdate ?? this.autoUpdate,
    );
  }
}

















