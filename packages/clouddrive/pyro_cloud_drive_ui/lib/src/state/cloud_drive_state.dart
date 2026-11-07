import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_cloud_drive_crypto/pyro_cloud_drive_crypto.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloud_drive_state.g.dart';

@riverpod
CloudDriveHub cloudDriveHub(Ref ref) => CloudDriveHub.instance;

@riverpod
CloudDriveSecureStorage cloudDriveCryptoStorage(Ref ref) => CloudDriveSecureStorage();

@riverpod
Future<bool> encryptionEnabled(Ref ref) async {
  final storage = ref.watch(cloudDriveCryptoStorageProvider);
  return storage.isEncryptionEnabled();
}

@riverpod
List<Type> availableCloudProviders(Ref ref) {
  final hub = ref.watch(cloudDriveHubProvider);
  return hub.availableProviders;
}

@riverpod
Future<bool> providerConnectionState(Ref ref, Type driverToken) async {
  final hub = ref.watch(cloudDriveHubProvider);
  final driver = hub.getDriver(driverToken);
  if (driver == null) return false;
  return await driver.isConnected();
}
