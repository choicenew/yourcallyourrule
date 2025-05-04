import 'package:yourcallyourrule/core/entities/device_entity.dart';

abstract class DeviceManagementService {
  Future<void> initialize();
  Future<String> getCurrentDeviceId();
  Future<DeviceEntity> getCurrentDevice();
  Future<bool> updateDeviceName(String newName);
  Future<bool> registerDevice(DeviceEntity device);
  Future<bool> unregisterDevice(String deviceId);
  Future<List<DeviceEntity>> getRegisteredDevices();
  Future<bool> updateDeviceSyncStatus(String deviceId, DateTime syncTime);
  Future<String> generateSyncIdentifier();
}