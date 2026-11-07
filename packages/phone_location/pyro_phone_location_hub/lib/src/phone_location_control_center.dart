import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

part 'phone_location_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneLocationControlCenter phoneLocationControlCenter(Ref ref) {
  return PhoneLocationControlCenter.instance;
}

/// 电话号码归属地中枢控制中心 (PhoneLocationControlCenter)
class PhoneLocationControlCenter {
  static final PhoneLocationControlCenter instance = PhoneLocationControlCenter._();

  PhoneLocationControlCenter._();

  PhoneLocationStorageDriver? _storageDriver;

  void registerStorageDriver(PhoneLocationStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[PhoneLocationHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  PhoneLocationStorageDriver? get storageDriver => _storageDriver;

  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber) async {
    return await _storageDriver?.getByPhoneNumber(phoneNumber);
  }

  Future<void> saveLocation(PhoneLocationEntry entry) async {
    await _storageDriver?.saveLocation(entry);
    debugPrint('[PhoneLocationHub] 中枢保存号码归属地: ${entry.phoneNumber} -> ${entry.region}');
  }
}
