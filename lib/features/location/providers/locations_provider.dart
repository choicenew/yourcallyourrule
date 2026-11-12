import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';
import 'package:yourcallyourrule/features/location/repositories/location_repository.dart';
import 'package:yourcallyourrule/features/location/data/repositories/location_repository_impl.dart';

class LocationsNotifier extends AsyncNotifier<List<PhoneLocationEntry>> {
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
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  Future<void> addLocation(PhoneLocationEntry location) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.save(location);
      state = AsyncValue.data(await _loadLocations());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateLocation(PhoneLocationEntry location) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.update(location);
      state = AsyncValue.data(await _loadLocations());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteLocation(String locationId) async {
    state = const AsyncValue.loading();
    try {
      await _locationRepository.deleteById(locationId);
      state = AsyncValue.data(await _loadLocations());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final locationsProvider = AsyncNotifierProvider<LocationsNotifier, List<PhoneLocationEntry>>(() {
  return LocationsNotifier();
});
