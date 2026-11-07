import 'package:flutter/foundation.dart';
import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';

/// 真实内存级拦截统计持久化驱动 (MemoryPhoneCallStatisticDriver)
class MemoryPhoneCallStatisticDriver implements PhoneCallStatisticDriver {
  PhoneCallStatisticData _data = const PhoneCallStatisticData();

  MemoryPhoneCallStatisticDriver();

  @override
  Future<PhoneCallStatisticData> getStatistics() async {
    return _data;
  }

  @override
  Future<void> saveStatistics(PhoneCallStatisticData data) async {
    _data = data;
    debugPrint('[MemoryStatisticDriver] 持久化保存拦截统计数据: total=${data.totalCalls}, blocked=${data.blockedCalls}');
  }
}
