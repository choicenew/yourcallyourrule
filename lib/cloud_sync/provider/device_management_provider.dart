import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/services/device_management_service.dart';
import 'package:yourcallyourrule/cloud_sync/services/device_management_service_impl.dart';




/// Provider for device management service
final deviceManagementServiceProvider = Provider<DeviceManagementService>((ref) {
  return DeviceManagementServiceImpl();
});

/// Provider for current device
final currentDeviceProvider = FutureProvider<DeviceEntity>((ref) async {
  final deviceService = ref.watch(deviceManagementServiceProvider);
  return deviceService.getCurrentDevice();
});

/// Provider for registered devices
final registeredDevicesProvider = FutureProvider<List<DeviceEntity>>((ref) async {
  final deviceService = ref.watch(deviceManagementServiceProvider);
  return deviceService.getRegisteredDevices();
});