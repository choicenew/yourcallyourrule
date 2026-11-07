import 'package:pyro_phone_live_activities_protocol/src/models/phone_live_activity_record.dart';

/// 灵动岛/Glance 实时活动平台 Driver 抽象接口契约 (PhoneLiveIslandDriver)
abstract class PhoneLiveIslandDriver {
  Future<void> publishLiveActivity(PhoneLiveActivityRecord record);
  Future<void> cancelLiveActivity(String activityId);
}
