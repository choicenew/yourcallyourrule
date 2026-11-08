import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/caller_identity/services/caller_identity_service.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';

part 'location_sync_service.g.dart';

@Riverpod(keepAlive: true)
LocationSyncService locationSyncService(Ref ref) {
  final callerIdentityService = ref.watch(callerIdentityServiceProvider);
  final locationService = ref.watch(locationServiceProvider);
  return LocationSyncService(callerIdentityService, locationService);
}

/// 归属地同步服务：监听 CallerIdentityService 数据流并落库 Location 数据�?
class LocationSyncService {
  final CallerIdentityService _callerIdentityService;
  final LocationService _locationService;
  StreamSubscription<CallerIdData>? _subscription;

  LocationSyncService(this._callerIdentityService, this._locationService);

  void start() {
    _subscription?.cancel();
    _subscription = _callerIdentityService.callerIdStream.listen(_handleCallerIdData);
  }

  Future<void> _handleCallerIdData(CallerIdData data) async {
    if (data.region != null && data.region!.isNotEmpty && data.region != 'Unknown') {
      final existingEntry = await _locationService.getByPhoneNumber(data.phoneNumber.value);
      if (existingEntry == null) {
        final locationEntry = LocationEntry(
          id: const Uuid().v4(),
          phoneNumber: data.phoneNumber,
          region: data.region,
          countryName: data.countryName,
          carrier: data.carrier,
          numberType: data.numberType,
        );
        await _locationService.saveLocation(locationEntry);
        debugPrint('[LocationSyncService] Saved new location for ${data.phoneNumber.value}: ${data.region}');
      }
    }
  }

  void dispose() {
    _subscription?.cancel();
  }
}
