import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_live_activities_protocol/pyro_phone_live_activities_protocol.dart';

part 'live_hub_control_center.g.dart';

@Riverpod(keepAlive: true)
LiveHubControlCenter liveHubControlCenter(Ref ref) {
  return LiveHubControlCenter.instance;
}

/// 灵动岛中枢控制中心 (LiveHubControlCenter)
class LiveHubControlCenter {
  static final LiveHubControlCenter instance = LiveHubControlCenter._();

  LiveHubControlCenter._();

  PhoneLiveIslandDriver? _islandDriver;

  void registerIslandDriver(PhoneLiveIslandDriver driver) {
    _islandDriver = driver;
    debugPrint('[LiveActivitiesHub] 已挂载注册灵动岛驱动: ${driver.runtimeType}');
  }

  PhoneLiveIslandDriver? get islandDriver => _islandDriver;

  Future<void> publishLiveActivity(PhoneLiveActivityRecord record) async {
    await _islandDriver?.publishLiveActivity(record);
    debugPrint('[LiveActivitiesHub] 发布灵动岛卡片: ${record.activityId} (${record.title})');
  }

  Future<void> cancelLiveActivity(String activityId) async {
    await _islandDriver?.cancelLiveActivity(activityId);
    debugPrint('[LiveActivitiesHub] 取消灵动岛卡片: $activityId');
  }
}
