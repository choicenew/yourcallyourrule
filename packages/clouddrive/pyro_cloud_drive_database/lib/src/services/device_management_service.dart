import '../models/device_entity.dart';
import 'package:pyro_cloud_drive_hub/pyro_cloud_drive_hub.dart';
import 'dart:convert';
import 'dart:typed_data';

abstract class DeviceManagementService {
  Future<List<DeviceEntity>> getDevices({Type? driverToken});
  Future<void> registerDevice({required DeviceEntity device, Type? driverToken});
  Future<void> removeDevice({required String deviceId, Type? driverToken});
}

class DeviceManagementServiceImpl implements DeviceManagementService {
  final CloudDriveHub _hub;
  static const String _devicesFilePath = 'sync_meta/devices.json';

  DeviceManagementServiceImpl({CloudDriveHub? hub}) : _hub = hub ?? CloudDriveHub.instance;

  @override
  Future<List<DeviceEntity>> getDevices({Type? driverToken}) async {
    final adapter = _hub.getDriver(driverToken) ?? _hub.currentDriver;
    if (adapter == null) return [];

    try {
      final bytes = await adapter.readFile(_devicesFilePath);
      final jsonList = json.decode(utf8.decode(bytes)) as List<dynamic>;
      return jsonList.map((e) => DeviceEntity.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> registerDevice({required DeviceEntity device, Type? driverToken}) async {
    final adapter = _hub.getDriver(driverToken) ?? _hub.currentDriver;
    if (adapter == null) return;

    final devices = await getDevices(driverToken: driverToken);
    final idx = devices.indexWhere((d) => d.deviceId == device.deviceId);
    if (idx != -1) {
      devices[idx] = device;
    } else {
      devices.add(device);
    }

    final bytes = Uint8List.fromList(utf8.encode(json.encode(devices.map((d) => d.toJson()).toList())));
    await adapter.writeFile(_devicesFilePath, bytes);
  }

  @override
  Future<void> removeDevice({required String deviceId, Type? driverToken}) async {
    final adapter = _hub.getDriver(driverToken) ?? _hub.currentDriver;
    if (adapter == null) return;

    final devices = await getDevices(driverToken: driverToken);
    devices.removeWhere((d) => d.deviceId == deviceId);

    final bytes = Uint8List.fromList(utf8.encode(json.encode(devices.map((d) => d.toJson()).toList())));
    await adapter.writeFile(_devicesFilePath, bytes);
  }
}
