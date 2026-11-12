import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

import 'base_sms_handler.dart';

class SmsFilterHandler extends BaseSmsHandler {
  final List<SmsRegexRuleEntity> smsRules;
  bool isEnabled = false;
  final ConfigRepository _configRepository;
  
  static const String smsFilterEnabledKey = 'config_sms_filter_enabled';

  SmsFilterHandler({
    List<SmsRegexRuleEntity>? initialRules,
    ConfigRepository? configRepository,
  }) : smsRules = initialRules ?? [],
       _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  @override
  Future<void> initialize() async {
    await loadSettings();
  }

  Future<void> loadSettings() async {
    final config = await _configRepository.getConfig(smsFilterEnabledKey);
    isEnabled = config?['enabled'] as bool? ?? false;
  }

  Future<void> setEnabled(bool enabled) async {
    if (isEnabled == enabled) return;

    isEnabled = enabled;
    await _configRepository.saveConfig(smsFilterEnabledKey, {'enabled': enabled});
  }

  void addRule(SmsRegexRuleEntity rule) {
    if (!smsRules.any((r) => r.id == rule.id)) {
      smsRules.add(rule);
    }
  }

  void addRules(List<SmsRegexRuleEntity> rules) {
    for (final rule in rules) {
      addRule(rule);
    }
  }

  void updateRule(SmsRegexRuleEntity rule) {
    final index = smsRules.indexWhere((r) => r.id == rule.id);
    if (index != -1) {
      smsRules[index] = rule;
    } else {
      addRule(rule);
    }
  }

  void removeRule(String ruleId) {
    smsRules.removeWhere((rule) => rule.id == ruleId);
  }

  Future<void> updateRules(List<SmsRegexRuleEntity> rules) async {
    smsRules.clear();
    addRules(rules);
  }

  Future<List<SmsRegexRuleEntity>> getRules() async {
    return List<SmsRegexRuleEntity>.from(smsRules);
  }

  Future<bool> shouldNotify(String phoneNumber, String messageContent) async {
    if (!isEnabled) return true;

    smsRules.sort((a, b) => b.priority.compareTo(a.priority));
    
    for (final rule in smsRules) {
      final reg = RegExp(rule.pattern);
      if (reg.hasMatch(messageContent) || reg.hasMatch(phoneNumber)) {
        if (rule.actionType == 'block' || rule.actionType == 'silence') {
          return false;
        }
        return true;
      }
    }

    return true;
  }
}
