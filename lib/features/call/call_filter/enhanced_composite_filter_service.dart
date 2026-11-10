import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
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

/// 增强版组合过滤器服务
class EnhancedCompositeFilterService implements CallFilterInterface {
  final List<CallFilterInterface> _filters;
  final Future<EnhancedFilterConfigState> Function() _getConfig;

  List<CallFilterInterface> get filters => List.unmodifiable(_filters);

  EnhancedCompositeFilterService({
    required List<CallFilterInterface> filters,
    required Future<EnhancedFilterConfigState> Function() getConfig,
  })  : _filters = filters,
        _getConfig = getConfig;

  @override
  CallFilterType get filterType => CallFilterType.basicRule;

  @override
  Future<bool> shouldAcceptCall(String phoneNumber, {SimInfo? simInfo}) async {
    final config = await _getConfig();
    final simSlotIndex = simInfo?.simSlotIndex;

    for (final filter in _filters) {
      bool? slotSetting;
      if (simSlotIndex != null) {
        slotSetting = config.simSlotFilterConfigMap[simSlotIndex]?[filter.filterType];
      }
      final isEnabled = slotSetting ??
          config.filterEnabledMap[filter.filterType] ??
          true;

      if (isEnabled) {
        if (!await filter.shouldAcceptCall(phoneNumber, simInfo: simInfo)) {
          return false;
        }
      }
    }
    return true;
  }

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
