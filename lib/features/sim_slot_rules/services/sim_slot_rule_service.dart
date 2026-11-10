import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/rules/repositories/rule_repository.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_service.dart';

part 'sim_slot_rule_service.g.dart';

@Riverpod(keepAlive: true)
SimSlotRuleService simSlotRuleService(Ref ref) {
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  final configRepository = ref.watch(configRepositoryProvider);
  return SimSlotRuleService(ruleRepository, configRepository);
}

/// SIM 卡槽位规则服务
class SimSlotRuleService {
  final RuleRepository _ruleRepository;
  final ConfigRepository _configRepository;
  final RuleImportExportService _importExportService;

  static const String _configKey = 'config_sim_slot_filter_enabled';

  SimSlotRuleService(this._ruleRepository, this._configRepository)
      : _importExportService = RuleImportExportService(_ruleRepository);

  RuleImportExportService get importExportService => _importExportService;

  Future<bool> isSimSlotFilterEnabled(int simSlotIndex) async {
    final configMap = await _configRepository.getConfig(_configKey);
    return configMap?[simSlotIndex.toString()] as bool? ?? false;
  }

  Future<void> enableSimSlotFilter(int simSlotIndex) async {
    final configMap = await _configRepository.getConfig(_configKey) ?? {};
    final newConfig = Map<String, dynamic>.from(configMap);
    newConfig[simSlotIndex.toString()] = true;
    await _configRepository.saveConfig(_configKey, newConfig);
  }

  Future<void> disableSimSlotFilter(int simSlotIndex) async {
    final configMap = await _configRepository.getConfig(_configKey) ?? {};
    final newConfig = Map<String, dynamic>.from(configMap);
    newConfig[simSlotIndex.toString()] = false;
    await _configRepository.saveConfig(_configKey, newConfig);
  }

  Future<List<PhoneRuleEntity>> getSimSlotRules(int simSlotIndex) async {
    final rules = await _ruleRepository.getAll();
    return rules.where((r) => r.subscriptionId == simSlotIndex.toString()).toList();
  }

  Future<List<PhoneRuleEntity>> getAllSimSlotRules() async {
    final rules = await _ruleRepository.getAll();
    return rules.where((r) => r.subscriptionId != null).toList();
  }

  Future<void> removeSimSlotRule(String ruleId) async {
    await _ruleRepository.deleteRule(ruleId);
  }
}
