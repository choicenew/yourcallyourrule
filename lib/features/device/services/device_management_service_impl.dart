import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_device_primary_secondary_protocol/pyro_device_primary_secondary_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

abstract class DeviceManagementService {
  Future<String> getCurrentDeviceId();
  Future<DeviceNode> getCurrentDevice();
  Future<List<DeviceNode>> getRegisteredDevices();
  Future<bool> registerDevice(DeviceNode device);
  Future<bool> updateDeviceName(String newName);
  Future<bool> removeDevice(String deviceId);
}

class DeviceManagementServiceImpl implements DeviceManagementService {
  static const String _deviceIdKey = 'config_device_id';
  static const String _deviceNameKey = 'config_device_name';
  static const String _registeredDevicesKey = 'config_registered_devices';

  final ConfigRepository _configRepository;
  final Uuid _uuid = const Uuid();

  DeviceNode? _currentDevice;
  final List<DeviceNode> _registeredDevices = [];

  DeviceManagementServiceImpl({ConfigRepository? configRepository})
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository();

  @override
  Future<String> getCurrentDeviceId() async {
    final config = await _configRepository.getConfig(_deviceIdKey);
    String? deviceId = config?['value'] as String?;

    if (deviceId == null) {
      deviceId = _uuid.v4();
      await _configRepository.saveConfig(_deviceIdKey, {'value': deviceId});
    }

    return deviceId;
  }

  @override
  Future<DeviceNode> getCurrentDevice() async {
    if (_currentDevice != null) {
      return _currentDevice!;
    }

    final deviceId = await getCurrentDeviceId();
    final config = await _configRepository.getConfig(_deviceNameKey);
    String? deviceName = config?['value'] as String?;

    if (deviceName == null) {
      deviceName = DeviceNodeToken.localPrimaryName;
      await _configRepository.saveConfig(_deviceNameKey, {'value': deviceName});
    }

    _currentDevice = DeviceNode(
      deviceId: deviceId,
      deviceName: deviceName,
      isPrimary: true,
      lastHeartbeatTime: DateTime.now(),
    );

    return _currentDevice!;
  }

  @override
  Future<List<DeviceNode>> getRegisteredDevices() async {
    if (_registeredDevices.isNotEmpty) {
      return List.unmodifiable(_registeredDevices);
    }

    final config = await _configRepository.getConfig(_registeredDevicesKey);
    final rawDevices = config?['devices'];

    if (rawDevices is List) {
      try {
        _registeredDevices.clear();
        for (final item in rawDevices) {
          if (item is Map<String, dynamic>) {
            _registeredDevices.add(DeviceNode.fromJson(item));
          } else if (item is Map) {
            _registeredDevices.add(DeviceNode.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      } catch (e) {
        debugPrint('Error parsing registered devices: $e');
      }
    }

    if (_registeredDevices.isEmpty) {
      final currentDevice = await getCurrentDevice();
      _registeredDevices.add(currentDevice);
      await _saveRegisteredDevices();
    }

    return List.unmodifiable(_registeredDevices);
  }

  @override
  Future<bool> registerDevice(DeviceNode device) async {
    try {
      final index = _registeredDevices.indexWhere((d) => d.deviceId == device.deviceId);
      if (index >= 0) {
        _registeredDevices[index] = device;
      } else {
        _registeredDevices.add(device);
      }
      await _saveRegisteredDevices();
      return true;
    } catch (e) {
      debugPrint('Error registering device: $e');
      return false;
    }
  }

  @override
  Future<bool> updateDeviceName(String newName) async {
    try {
      await _configRepository.saveConfig(_deviceNameKey, {'value': newName});

      if (_currentDevice != null) {
        _currentDevice = _currentDevice!.copyWith(deviceName: newName);
      }

      return true;
    } catch (e) {
      debugPrint('Error updating device name: $e');
      return false;
    }
  }

  @override
  Future<bool> removeDevice(String deviceId) async {
    try {
      _registeredDevices.removeWhere((d) => d.deviceId == deviceId);
      await _saveRegisteredDevices();
      return true;
    } catch (e) {
      debugPrint('Error removing device: $e');
      return false;
    }
  }

  Future<void> _saveRegisteredDevices() async {
    final list = _registeredDevices.map((d) => d.toJson()).toList();
    await _configRepository.saveConfig(_registeredDevicesKey, {'devices': list});
  }
}
