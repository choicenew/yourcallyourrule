import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_count_filter_protocol/pyro_phone_count_filter_protocol.dart';

part 'phone_count_filter_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneCountFilterControlCenter phoneCountFilterControlCenter(Ref ref) {
  return PhoneCountFilterControlCenter.instance;
}

/// 本地频次过滤控制中心 (PhoneCountFilterControlCenter)
class PhoneCountFilterControlCenter {
  static final PhoneCountFilterControlCenter instance = PhoneCountFilterControlCenter._();

  PhoneCountFilterControlCenter._();

  PhoneCountStorageDriver? _storageDriver;

  void registerStorageDriver(PhoneCountStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneCountFilterHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  PhoneCountStorageDriver? get storageDriver => _storageDriver;

  Future<bool> evaluateCountThreshold(int count) async {
    final config = await _storageDriver?.getConfig() ?? const PhoneCountFilterConfig();
    if (!config.enableLocalCountFilter) return true;
    if (count >= config.countThreshold && config.rejectExceededNumbers) {
      debugPrint('[PhoneCountFilterHub] 频次 $count 超过阈值 ${config.countThreshold}，触发拦截！');
      return false;
    }
    return true;
  }
}
