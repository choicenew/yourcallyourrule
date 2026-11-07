import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';

part 'phone_rules_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneRulesControlCenter phoneRulesControlCenter(Ref ref) {
  return PhoneRulesControlCenter.instance;
}

/// 电话规则控制中心 (PhoneRulesControlCenter)
class PhoneRulesControlCenter {
  static final PhoneRulesControlCenter instance = PhoneRulesControlCenter._();

  PhoneRulesControlCenter._();

  PhoneRuleStorageDriver? _storageDriver;

  void registerStorageDriver(PhoneRuleStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneRulesHub] 已挂载注册规则存储驱动: ${driver.runtimeType}');
  }

  PhoneRuleStorageDriver? get storageDriver => _storageDriver;

  Future<PhoneRuleEntity?> getRuleById(String id) async {
    return await _storageDriver?.getRuleById(id);
  }

  Future<void> saveRule(PhoneRuleEntity rule) async {
    await _storageDriver?.saveRule(rule);
    debugPrint('[PhoneRulesHub] 中枢保存规则: ${rule.name} -> ${rule.phoneNumber}');
  }
}
