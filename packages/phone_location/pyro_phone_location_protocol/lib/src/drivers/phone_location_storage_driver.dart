import 'package:pyro_phone_location_protocol/src/models/phone_location_entry.dart';

/// 号码归属地持久化 Driver 抽象接口契约 (PhoneLocationStorageDriver)
abstract class PhoneLocationStorageDriver {
  Future<PhoneLocationEntry?> getByPhoneNumber(String phoneNumber);
  Future<void> saveLocation(PhoneLocationEntry entry);
  Future<List<PhoneLocationEntry>> getAllLocations();
}
