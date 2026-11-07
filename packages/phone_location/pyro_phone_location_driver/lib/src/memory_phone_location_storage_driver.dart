import 'package:flutter/foundation.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

/// 真实内存级归属地持久化驱动 (MemoryPhoneLocationStorageDriver)
class MemoryPhoneLocationStorageDriver implements PhoneLocationStorageDriver {
  final Map<String, PhoneLocationEntry> _cache = {};

  MemoryPhoneLocationStorageDriver();

  @override
  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber) async {
    return _cache[phoneNumber];
  }

  @override
  Future<void> saveLocation(PhoneLocationEntry entry) async {
    _cache[entry.phoneNumber] = entry;
    debugPrint('[MemoryLocationDriver] 持久化保存号码归属地: ${entry.phoneNumber} -> ${entry.region}');
  }

  @override
  Future<List<PhoneLocationEntry>> getAllLocations() async {
    return _cache.values.toList();
  }
}
