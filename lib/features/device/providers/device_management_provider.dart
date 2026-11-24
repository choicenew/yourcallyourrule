import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_device_primary_secondary_protocol/pyro_device_primary_secondary_protocol.dart';
import 'package:yourcallyourrule/features/device/services/device_management_service_impl.dart';

part 'device_management_provider.g.dart';

@Riverpod(keepAlive: true)
DeviceManagementService deviceManagementService(Ref ref) {
  return DeviceManagementServiceImpl();
}

@Riverpod(keepAlive: true)
Future<DeviceNode> currentDevice(Ref ref) async {
  final service = ref.watch(deviceManagementServiceProvider);
  return service.getCurrentDevice();
}

@Riverpod(keepAlive: true)
Future<List<DeviceNode>> registeredDevices(Ref ref) async {
  final service = ref.watch(deviceManagementServiceProvider);
  return service.getRegisteredDevices();
}
