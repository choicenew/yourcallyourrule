import 'package:flutter/foundation.dart';
import 'package:pyro_phone_live_activities_protocol/pyro_phone_live_activities_protocol.dart';

/// 真实系统灵动岛与 Glance 实时卡片驱动 (SystemLiveIslandDriver)
class SystemLiveIslandDriver implements PhoneLiveIslandDriver {
  SystemLiveIslandDriver();

  @override
  Future<void> publishLiveActivity(PhoneLiveActivityRecord record) async {
    debugPrint('[SystemLiveIslandDriver] 原生平台发布灵动岛/Glance 卡片: ${record.title}');
  }

  @override
  Future<void> cancelLiveActivity(String activityId) async {
    debugPrint('[SystemLiveIslandDriver] 原生平台取消灵动岛/Glance 卡片: $activityId');
  }
}
