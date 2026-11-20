import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_sim_slot_rules_protocol/pyro_phone_sim_slot_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/data/datasources/local_sim_slot_rule_datasource.dart';

part 'sim_slot_rule_service.g.dart';

@Riverpod(keepAlive: true)
SimSlotRuleService simSlotRuleService(Ref ref) {
  final simSlotDatasource = ref.watch(localSimSlotRuleDataSourceProvider);
  return SimSlotRuleService(simSlotDatasource);
}

/// SIM 卡槽规则服务：100% 消费 pyro_sim_slot_rules_protocol 专属微包协议
class SimSlotRuleService {
  final LocalSimSlotRuleDataSource _simSlotDatasource;

  SimSlotRuleService(this._simSlotDatasource);

  Future<List<SimSlotRuleEntity>> getSimSlotRules(int simSlotIndex) async {
    return await _simSlotDatasource.getBySimSlot(simSlotIndex);
  }

  Future<List<SimSlotRuleEntity>> getAllSimSlotRules() async {
    return await _simSlotDatasource.getAll();
  }

  Future<void> addSimSlotRule(Map<String, dynamic> entry, int simSlotIndex, {dynamic action}) async {
    final entity = SimSlotRuleEntity(
      id: entry['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: entry['name']?.toString() ?? '',
      phoneNumber: entry['phoneNumber']?.toString() ?? '',
      simSlotIndex: simSlotIndex,
      actionType: action?.toString() ?? entry['actionType']?.toString() ?? 'block',
      priority: entry['priority'] is int ? entry['priority'] as int : 0,
      isEnabled: entry['isEnabled'] is bool ? entry['isEnabled'] as bool : true,
    );
    await _simSlotDatasource.insertRule(entity);
  }

  Future<void> removeSimSlotRule(String ruleId) async {
    await _simSlotDatasource.deleteRule(ruleId);
  }

  Future<void> updateSimSlotRule(SimSlotRuleEntity rule) async {
    await _simSlotDatasource.updateRule(rule);
  }

  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    final rule = await _simSlotDatasource.getById(ruleId);
    if (rule != null) {
      await _simSlotDatasource.updateRule(rule.copyWith(isEnabled: isEnabled));
    }
  }
}
