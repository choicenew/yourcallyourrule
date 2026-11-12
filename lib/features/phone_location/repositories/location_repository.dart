import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

abstract class LocationRepository {
  Future<List<PhoneLocationEntry>> getAll();
  Future<PhoneLocationEntry?> getById(String id);
  Future<PhoneLocationEntry> save(PhoneLocationEntry entity);
  Future<PhoneLocationEntry> update(PhoneLocationEntry entity);
  Future<PhoneLocationEntry?> getByPhoneNumber(String phone);
  Future<List<PhoneLocationEntry>> getLocationsByRegion(String region);
  Future<void> saveLocation(PhoneLocationEntry entry);
  Future<bool> delete(PhoneLocationEntry entity);
  Future<bool> deleteById(String id);
  Future<bool> deleteAll(List<PhoneLocationEntry> entities);
  Future<List<PhoneLocationEntry>> saveAll(List<PhoneLocationEntry> entities);
  Future<bool> exists(String id);
  Future<int> count();
}
