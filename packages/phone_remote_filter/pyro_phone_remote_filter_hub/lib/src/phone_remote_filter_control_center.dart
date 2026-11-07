import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_remote_filter_protocol/pyro_phone_remote_filter_protocol.dart';

part 'phone_remote_filter_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneRemoteFilterControlCenter phoneRemoteFilterControlCenter(Ref ref) {
  return PhoneRemoteFilterControlCenter.instance;
}

/// 远程高危过滤控制中心 (PhoneRemoteFilterControlCenter)
class PhoneRemoteFilterControlCenter {
  static final PhoneRemoteFilterControlCenter instance = PhoneRemoteFilterControlCenter._();

  PhoneRemoteFilterControlCenter._();

  RemoteNumberStorageDriver? _storageDriver;

  void registerStorageDriver(RemoteNumberStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneRemoteFilterHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  RemoteNumberStorageDriver? get storageDriver => _storageDriver;

  Future<bool> evaluateRemoteRisk(String phoneNumber) async {
    final entry = await _storageDriver?.getByPhoneNumber(phoneNumber);
    if (entry != null && entry.isEnabled && entry.actionType == 'block') {
      debugPrint('[PhoneRemoteFilterHub] 远程库判定为高危风险号码，触发拦截: $phoneNumber');
      return false;
    }
    return true;
  }
}
