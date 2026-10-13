import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_type.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/providers/enhanced_filter_config_provider.dart';
import 'package:yourcallyourrule/features/local_filter/services/local_count_filter_service.dart';
import 'package:yourcallyourrule/features/remote_filter/services/remote_number_filter_service.dart';

part 'enhanced_composite_filter_service.g.dart';

@riverpod
EnhancedCompositeFilterService enhancedCompositeFilterService(Ref ref) {
  // 把所有的规则插件统一注入过滤链管道中：
  // simSlotRuleFilterService 放在第一位，在当前卡槽启用时享有优先判定特权
  final filters = [
    ref.watch(simSlotRuleFilterServiceProvider),
    ref.watch(callFilterServiceProvider),
    ref.watch(localCountFilterServiceProvider),
    ref.watch(remoteNumberFilterServiceProvider),
  ];

  return EnhancedCompositeFilterService(
    filters: filters,
    getConfig: () async => await ref.read(enhancedFilterConfigProvider.future),
  );
}

/// 增强版组合过滤器服务 (无状态、纯依赖注入、零字符串)
class EnhancedCompositeFilterService implements CallFilterInterface {
  final List<CallFilterInterface> _filters;
  final Future<EnhancedFilterConfigState> Function() _getConfig;

  List<CallFilterInterface> get filters => List.unmodifiable(_filters);

  EnhancedCompositeFilterService({
    required List<CallFilterInterface> filters,
    required Future<EnhancedFilterConfigState> Function() getConfig,
  }) : _filters = filters,
       _getConfig = getConfig;

  @override
  CallFilterType get filterType => CallFilterType.basicRule;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber, {SimInfo? simInfo}) async {
    final config = await _getConfig();
    final simSlotIndex = simInfo?.simSlotIndex;

    // 按照过滤链顺序依次检查各个过滤器
    for (final filter in _filters) {
      bool? slotSetting;
      if (simSlotIndex != null) {
        slotSetting = config.simSlotFilterConfigMap[simSlotIndex]?[filter.filterType];
      }
      final isEnabled = slotSetting ??
          config.filterEnabledMap[filter.filterType] ??
          true;

      if (isEnabled) {
        // 应用过滤器规则
        if (!await filter.shouldAcceptCall(phoneNumber, simInfo: simInfo)) {
          // 如果任何一个过滤器拒绝，流水线直接截断，返回拒绝
          return false;
        }
      }
    }
    return true;
  }

  /// 保持向后兼容的方法（供外部 handler 平滑调用）
  Future<bool> shouldAcceptCallWithSim(String phoneNumber, {SimInfo? simInfo}) {
    return shouldAcceptCall(phoneNumber, simInfo: simInfo);
  }

  @override
  Future<void> initialize() async {
    for (final filter in _filters) {
      await filter.initialize();
    }
  }
}