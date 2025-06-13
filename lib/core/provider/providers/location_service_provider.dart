import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/location/services/location_service.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/location_repository_provider.dart';

/// LocationService的Provider
final locationServiceProvider = Provider<LocationService>((ref) {
  final locationRepository = ref.watch(locationRepositoryProvider);
  return LocationService(locationRepository);
});