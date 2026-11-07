import 'package:pyro_phone_call_statistic_protocol/src/models/phone_call_statistic_data.dart';

/// 统计数据持久化 Driver 抽象接口契约 (PhoneCallStatisticDriver)
abstract class PhoneCallStatisticDriver {
  Future<PhoneCallStatisticData> getStatistics();
  Future<void> saveStatistics(PhoneCallStatisticData data);
}
