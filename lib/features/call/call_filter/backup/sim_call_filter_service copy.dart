import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';

/// SIM卡通话过滤服务
/// 作为CallFilterService的装饰器，用于处理基于SIM卡的过滤逻辑
class SimCallFilterService {
  final CallFilterService _callFilterService;
  final ConfigRepository _configRepository;
  Map<int, List<String>> _simSlotRules = {};

  SimCallFilterService({
    required CallFilterService callFilterService,
    required ConfigRepository configRepository,
  })
      : _callFilterService = callFilterService,
        _configRepository = configRepository;

  /// 初始化服务
  Future<void> initialize() async {
    await loadSimSlotRules();
    await _callFilterService.initialize();
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

  /// 判断是否应该接受来电
  Future<bool> shouldAcceptCall(String phoneNumber, {SimInfo? simInfo}) async {
    // 首先检查SIM卡槽位规则
    if (simInfo != null && simInfo.simSlotIndex != null) {
      if (!isNumberAllowedForSimSlot(phoneNumber, simInfo.simSlotIndex)) {
        return false;
      }
    }

    // 然后使用原有的过滤逻辑
    return await _callFilterService.shouldAcceptCall(phoneNumber);
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