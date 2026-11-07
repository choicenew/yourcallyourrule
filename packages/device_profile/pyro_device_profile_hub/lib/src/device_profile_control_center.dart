import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_device_profile_protocol/pyro_device_profile_protocol.dart';

part 'device_profile_control_center.g.dart';

@Riverpod(keepAlive: true)
DeviceProfileControlCenter deviceProfileControlCenter(Ref ref) {
  return DeviceProfileControlCenter.instance;
}

/// 设备环境控制中心 (DeviceProfileControlCenter)
class DeviceProfileControlCenter {
  static final DeviceProfileControlCenter instance = DeviceProfileControlCenter._();

  DeviceProfileControlCenter._();

  DeviceHardwareInfoDriver? _hardwareDriver;

  void registerHardwareDriver(DeviceHardwareInfoDriver driver) {
    _hardwareDriver = driver;
    debugPrint('[DeviceProfileHub] 已挂载注册硬件感知驱动: ${driver.runtimeType}');
  }

  DeviceHardwareInfoDriver? get hardwareDriver => _hardwareDriver;

  Future<DeviceRawProfile> getRawProfile() async {
    return await _hardwareDriver?.fetchRawProfile() ?? const DeviceRawProfile();
  }
}
