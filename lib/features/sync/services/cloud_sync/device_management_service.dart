

import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';

/// Interface for device management services
abstract class DeviceManagementService {
  /// Initialize the device management service
  Future<void> initialize();
  
  /// Get the current device ID
  Future<String> getCurrentDeviceId();
  
  /// Get the current device entity
  Future<DeviceEntity> getCurrentDevice();
  
  /// Update the current device name
  Future<bool> updateDeviceName(String newName);
  
  /// Register a new device
  Future<bool> registerDevice(DeviceEntity device);
  
  /// Unregister a device
  Future<bool> unregisterDevice(String deviceId);
  
  /// Get all registered devices
  Future<List<DeviceEntity>> getRegisteredDevices();
  
  /// Update device sync status
  Future<bool> updateDeviceSyncStatus(String deviceId, DateTime syncTime);
  
  /// Generate a unique sync identifier for the current device
  Future<String> generateSyncIdentifier();
}