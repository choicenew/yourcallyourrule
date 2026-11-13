import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

part 'phone_location_service.g.dart';

@Riverpod(keepAlive: true)
PhoneLocationService phoneLocationService(Ref ref) {
  return PhoneLocationService();
}

/// 电话号码归属地服务中枢 (PhoneLocationService)
class PhoneLocationService {
  final Map<String, PhoneLocationEntry> _locationCache = {};

  PhoneLocationService();

  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber) async {
    return _locationCache[phoneNumber];
  }

  Future<void> saveLocation(PhoneLocationEntry entry) async {
    _locationCache[entry.phoneNumber] = entry;
    debugPrint('[PhoneLocationHub] 保存号码归属地条目: ${entry.phoneNumber} -> ${entry.region}');
  }
}
