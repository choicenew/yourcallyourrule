import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_sim_hub/pyro_sim_hub.dart';
import 'package:permission_handler/permission_handler.dart';

part 'sim_info_provider.g.dart';

/// 一个异步 Provider，负责请求权限并获取设备上所有 SIM 卡的信息。
/// 它会自动处理加载、错误和成功状态，并缓存结果。
/// Riverpod 会自动处理 keepAlive，确保信息只被获取一次。
@Riverpod(keepAlive: true)
Future<List<SimCardEntity>> simCards(Ref ref) async {
  // 1. 在 Android 平台处理权限请求。iOS平台不需要显式权限。
  if (Platform.isAndroid) {
    try {
      await Permission.phone.request();
    } catch (_) {}
  }
  
  // 2. 优先调用插件获取所有已检测到的 SIM 卡（无论是否激活或有信号）
  try {
    final allSimCards = await SimHub.instance.getActiveSimCards();
    if (allSimCards.isNotEmpty) {
      return allSimCards;
    }
  } catch (_) {}

  // 3. 兜底检查设备上是否有 SIM 卡（基于硬件槽位判定）
  try {
    final hasSim = await SimHub.instance.hasSimCard();
    if (hasSim) {
      // 若硬件判定有卡但没有读取出详情（如卡未激活 NOT_PROVISIONED），生成 SIM 1 兜底实体，确保用户可以设置卡槽规则
      return const [
        SimCardEntity(
          subscriptionId: 0,
          slotIndex: SimSlotIndex.slot1,
          state: SimStateType.unknown,
          phoneNumber: '',
          iccId: '',
          isDataRoaming: false,
          isNetworkRoaming: false,
          carrier: SimCarrierEntity(
            carrierName: 'No Service',
            displayName: 'SIM 1',
            countryIso: '',
            mcc: '',
            mnc: '',
          ),
        ),
      ];
    }
  } catch (_) {}
  
  return [];
}