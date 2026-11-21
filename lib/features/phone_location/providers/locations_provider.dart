import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/phone_location/repositories/location_repository.dart';
import 'package:yourcallyourrule/features/phone_location/data/repositories/location_repository_impl.dart';

part 'locations_provider.g.dart';

@Riverpod(keepAlive: true)
class LocationsNotifier extends _$LocationsNotifier {
  late final LocationRepository _locationRepository;

  @override
  Future<List<PhoneLocationEntry>> build() async {
    _initRepository();
    return _loadLocations();
  }

  void _initRepository() {
    _locationRepository = ref.read(locationRepositoryProvider);
  }

  Future<List<PhoneLocationEntry>> _loadLocations() async {
    try {
      return await _locationRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  Future<void> addLocation(PhoneLocationEntry location) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.save(location);
      state = AsyncValue.data(await _loadLocations());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateLocation(PhoneLocationEntry location) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.save(location);
      state = AsyncValue.data(await _loadLocations());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> deleteLocation(String locationId) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.deleteById(locationId);
      state = AsyncValue.data(await _loadLocations());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
