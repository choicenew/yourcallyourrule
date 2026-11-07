library pyro_phone_rules_ui;

import 'package:flutter/material.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';

/// 电话规则 ListTile 组件
class PhoneRuleTileView extends StatelessWidget {
  final PhoneRuleEntity rule;

  const PhoneRuleTileView({
    super.key,
    required this.rule,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.rule),
      title: Text(rule.name),
      subtitle: Text('${rule.phoneNumber} • Count: ${rule.count}'),
      trailing: Text(rule.actionType),
    );
  }
}
