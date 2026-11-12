import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/location/repositories/location_repository.dart';
import 'package:yourcallyourrule/features/location/data/repositories/location_repository_impl.dart';

part 'location_sync_service.g.dart';

@Riverpod(keepAlive: true)
LocationSyncService locationSyncService(Ref ref) {
  final locationRepository = ref.watch(locationRepositoryProvider);
  return LocationSyncService(locationRepository);
}

class LocationSyncService {
  final LocationRepository _locationRepository;
  final Uuid _uuid = const Uuid();

  LocationSyncService(this._locationRepository);

  Future<void> saveLocation(String phoneNumber, String province, String city, {String? carrier}) async {
    final locationEntry = PhoneLocationEntry(
      id: _uuid.v4(),
      phoneNumber: phoneNumber,
      region: '$province $city',
      countryName: province,
      carrier: carrier,
    );
    await _locationRepository.save(locationEntry);
    debugPrint('[LocationSyncService] Saved location for $phoneNumber: $province $city');
  }
}
