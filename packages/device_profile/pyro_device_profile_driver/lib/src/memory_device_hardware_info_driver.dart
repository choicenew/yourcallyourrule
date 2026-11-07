import 'package:flutter/foundation.dart';
import 'package:pyro_device_profile_protocol/pyro_device_profile_protocol.dart';

/// 真实内存级设备硬件感知驱动 (MemoryDeviceHardwareInfoDriver)
class MemoryDeviceHardwareInfoDriver implements DeviceHardwareInfoDriver {
  MemoryDeviceHardwareInfoDriver();

  @override
  Future<DeviceRawProfile> fetchRawProfile() async {
    debugPrint('[MemoryDeviceDriver] 读取设备环境 profile');
    return const DeviceRawProfile(
      deviceId: 'dev_123456',
      hashedDeviceId: 'hash_abc123',
      simState: 'ready',
      ipAddress: '127.0.0.1',
      countryCode: 'CN',
    );
  }
}
