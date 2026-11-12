import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_device_master_slave_protocol/pyro_device_master_slave_protocol.dart';
import 'package:yourcallyourrule/features/device/services/device_management_service_impl.dart';

final deviceManagementServiceProvider = Provider<DeviceManagementService>((ref) {
  return DeviceManagementServiceImpl();
});

final currentDeviceProvider = FutureProvider<DeviceNode>((ref) async {
  final service = ref.watch(deviceManagementServiceProvider);
  return service.getCurrentDevice();
});

final registeredDevicesProvider = FutureProvider<List<DeviceNode>>((ref) async {
  final service = ref.watch(deviceManagementServiceProvider);
  return service.getRegisteredDevices();
});
