import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

// 新增LocationRepository接口

import 'base_repository.dart';

abstract class LocationRepository extends BaseRepository<LocationEntry, String> {
  Future<LocationEntry?> getByPhoneNumber(String phone);
  Future<List<LocationEntry>> getLocationsByRegion(String region);



  Future<void> saveLocation(LocationEntry entry);

}