import 'package:pyro_device_profile_protocol/src/models/device_raw_profile.dart';

/// 设备感知 Driver 抽象接口契约 (DeviceHardwareInfoDriver)
abstract class DeviceHardwareInfoDriver {
  Future<DeviceRawProfile> fetchRawProfile();
}
