import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_sim_hub/pyro_sim_hub.dart';

part 'sim_call_handler.g.dart';

@Riverpod(keepAlive: true)
class SimCallHandler extends _$SimCallHandler {
  @override
  SimCardEntity? build() {
    ref.onDispose(() {});
    return null;
  }

  /// 直接委托给 packages/sim 的 SimHub 查询活跃卡槽
  Future<List<SimCardEntity>> getActiveSimCards() {
    return SimHub.instance.getActiveSimCards();
  }

  /// 直接委托给 packages/sim 的 SimHub 查询指定卡槽
  Future<SimCardEntity?> getSimBySlot(SimSlotIndex slot) {
    return SimHub.instance.getSimBySlot(slot);
  }
}
