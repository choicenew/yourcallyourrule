import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_sim_hub/pyro_sim_hub.dart';
import 'package:yourcallyourrule/features/common/base/base_call_handler.dart';

part 'sim_call_handler.g.dart';

@Riverpod(keepAlive: true)
class SimCallHandler extends _$SimCallHandler implements BaseCallHandler {
  @override
  SimCardEntity? build() {
    ref.onDispose(() {});
    return null;
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}

  @override
  dynamic handleMethodCall(MethodCall call) {
    switch (call.method) {
      case "onSimInitializationComplete":
        return _handleInitializationComplete();
      case "onSimInfo":
        final args = call.arguments as Map<dynamic, dynamic>? ?? {};
        try {
          state = SimCardEntity.fromMap(args);
        } catch (_) {}
        return null;
      default:
        throw UnimplementedError('SimCallHandler: 未实现的方法: ${call.method}');
    }
  }

  void _handleInitializationComplete() {}

  /// 直接委托给 packages/sim 的 SimHub 查询活跃卡槽
  Future<List<SimCardEntity>> getActiveSimCards() {
    return SimHub.instance.getActiveSimCards();
  }

  /// 直接委托给 packages/sim 的 SimHub 查询指定卡槽
  Future<SimCardEntity?> getSimBySlot(SimSlotIndex slot) {
    return SimHub.instance.getSimBySlot(slot);
  }
}
