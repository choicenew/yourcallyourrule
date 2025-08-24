import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/database/sync/device_id_service.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';

final deviceIdServiceProvider = Provider<DeviceIdService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return DeviceIdService(configRepository);
});