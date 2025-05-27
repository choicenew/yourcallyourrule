// SIM卡过滤服务，用于处理与SIM卡相关的过滤逻辑

import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';

/// SIM卡过滤服务
/// 处理与SIM卡相关的过滤逻辑，如SIM卡槽位规则
class SimFilterService implements CallFilterInterface {
  final ConfigRepository _configRepository;
  Map<int, List<String>> _simSlotRules = {};

  SimFilterService({
    required ConfigRepository configRepository,
  }) : _configRepository = configRepository;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    // 默认接受来电，因为没有SIM卡信息
    return true;
  }
  
  /// 判断是否应该接受来电（带SIM卡信息）
  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) async {
    // 如果没有SIM卡信息，则默认接受
    if (simInfo == null || simInfo.simSlotIndex == null) {
      return true;
    }
    
    // 检查号码是否允许在指定的SIM卡槽位
    return isNumberAllowedForSimSlot(phoneNumber, simInfo.simSlotIndex);
  }

  /// 初始化服务
  @override
  Future<void> initialize() async {
    await loadSimSlotRules();
  }

  /// 加载SIM卡槽位规则
  Future<void> loadSimSlotRules() async {
    final rulesMap = await _configRepository.getConfig('sim_slot_rules');
    if (rulesMap != null) {
      _simSlotRules = Map<int, List<String>>.from(
        rulesMap.map((key, value) => MapEntry(
              int.parse(key),
              (value as List<dynamic>).cast<String>(),
            )),
      );
    }
  }

  /// 保存SIM卡槽位规则
  Future<void> saveSimSlotRules() async {
    final rulesMap = _simSlotRules.map(
      (key, value) => MapEntry(key.toString(), value),
    );
    await _configRepository.saveConfig('sim_slot_rules', rulesMap);
  }

  /// 添加SIM卡槽位规则
  Future<void> addSimSlotRule(int simSlotIndex, String phoneNumber) async {
    if (!_simSlotRules.containsKey(simSlotIndex)) {
      _simSlotRules[simSlotIndex] = [];
    }
    if (!_simSlotRules[simSlotIndex]!.contains(phoneNumber)) {
      _simSlotRules[simSlotIndex]!.add(phoneNumber);
      await saveSimSlotRules();
    }
  }

  /// 移除SIM卡槽位规则
  Future<void> removeSimSlotRule(int simSlotIndex, String phoneNumber) async {
    if (_simSlotRules.containsKey(simSlotIndex)) {
      _simSlotRules[simSlotIndex]!.remove(phoneNumber);
      if (_simSlotRules[simSlotIndex]!.isEmpty) {
        _simSlotRules.remove(simSlotIndex);
      }
      await saveSimSlotRules();
    }
  }

  /// 检查号码是否允许在指定的SIM卡槽位
  bool isNumberAllowedForSimSlot(String phoneNumber, int? simSlotIndex) {
    if (simSlotIndex == null) return true;
    return !_simSlotRules.containsKey(simSlotIndex) ||
        _simSlotRules[simSlotIndex]!.contains(phoneNumber);
  }

  /// 获取指定SIM卡槽位的所有规则
  List<String> getSimSlotRules(int simSlotIndex) {
    return _simSlotRules[simSlotIndex] ?? [];
  }

  /// 清除指定SIM卡槽位的所有规则
  Future<void> clearSimSlotRules(int simSlotIndex) async {
    _simSlotRules.remove(simSlotIndex);
    await saveSimSlotRules();
  }

  /// 清除所有SIM卡槽位规则
  Future<void> clearAllSimSlotRules() async {
    _simSlotRules.clear();
    await saveSimSlotRules();
  }
}