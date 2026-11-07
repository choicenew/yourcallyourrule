import 'package:flutter/foundation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';

/// 真实内存级电话规则持久化驱动 (MemoryPhoneRuleStorageDriver)
class MemoryPhoneRuleStorageDriver implements PhoneRuleStorageDriver {
  final Map<String, PhoneRuleEntity> _rules = {};

  MemoryPhoneRuleStorageDriver();

  @override
  Future<PhoneRuleEntity?> getRuleById(String id) async {
    return _rules[id];
  }

  @override
  Future<void> saveRule(PhoneRuleEntity rule) async {
    _rules[rule.id] = rule;
    debugPrint('[MemoryPhoneRuleDriver] 持久化保存电话规则: ${rule.name} (${rule.phoneNumber})');
  }

  @override
  Future<void> deleteRule(String id) async {
    _rules.remove(id);
  }

  @override
  Future<List<PhoneRuleEntity>> getAllRules() async {
    return _rules.values.toList();
  }
}
