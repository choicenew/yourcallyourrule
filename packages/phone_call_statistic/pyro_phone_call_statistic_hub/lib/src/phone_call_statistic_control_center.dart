import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_statistic_protocol/pyro_phone_call_statistic_protocol.dart';

part 'phone_call_statistic_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneCallStatisticControlCenter phoneCallStatisticControlCenter(Ref ref) {
  return PhoneCallStatisticControlCenter.instance;
}

/// 通话拦截统计控制中心 (PhoneCallStatisticControlCenter)
class PhoneCallStatisticControlCenter {
  static final PhoneCallStatisticControlCenter instance = PhoneCallStatisticControlCenter._();

  PhoneCallStatisticControlCenter._();

  PhoneCallStatisticDriver? _storageDriver;

  void registerStorageDriver(PhoneCallStatisticDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneCallStatisticHub] 已挂载注册统计持久化驱动: ${driver.runtimeType}');
  }

  PhoneCallStatisticDriver? get storageDriver => _storageDriver;

  Future<PhoneCallStatisticData> getStatistics() async {
    return await _storageDriver?.getStatistics() ?? const PhoneCallStatisticData();
  }

  Future<void> saveStatistics(PhoneCallStatisticData data) async {
    await _storageDriver?.saveStatistics(data);
    debugPrint('[PhoneCallStatisticHub] 保存通话拦截统计: blocked=${data.blockedCalls}');
  }
}
