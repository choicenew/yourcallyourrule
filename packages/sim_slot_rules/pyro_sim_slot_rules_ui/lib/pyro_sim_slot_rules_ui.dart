library pyro_sim_slot_rules_ui;

import 'package:flutter/material.dart';
import 'package:pyro_sim_slot_rules_protocol/pyro_sim_slot_rules_protocol.dart';

/// 卡槽规则显示组件 (SimSlotRuleTileView)
class SimSlotRuleTileView extends StatelessWidget {
  final SimSlotRuleEntity rule;

  const SimSlotRuleTileView({
    super.key,
    required this.rule,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.sim_card),
      title: Text('${rule.name} (SIM ${rule.simSlotIndex + 1})'),
      subtitle: Text(rule.phoneNumber),
      trailing: Text(rule.actionType),
    );
  }
}
