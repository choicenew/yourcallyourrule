import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


import 'package:yourcallyourrule/cloud_sync/entities/device_entity.dart';
import 'package:yourcallyourrule/cloud_sync/services/device_management_service.dart';

/// Implementation of the device management service
class DeviceManagementServiceImpl implements DeviceManagementService {
  /// Shared preferences key for device ID
  static const String _deviceIdKey = 'device_id';
  
  /// Shared preferences key for device name
  static const String _deviceNameKey = 'device_name';
  
  /// Shared preferences key for registered devices
  static const String _registeredDevicesKey = 'registered_devices';
  
  /// Device info plugin
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  
  /// UUID generator
  final Uuid _uuid = const Uuid();
  
  /// Current device entity
  DeviceEntity? _currentDevice;
  
  /// List of registered devices
  List<DeviceEntity> _registeredDevices = [];
  
  /// Initialize the device management service
  @override
  Future<void> initialize() async {
    await _loadCurrentDevice();
    await _loadRegisteredDevices();
  }
  
  /// Get the current device ID
  @override
  Future<String> getCurrentDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString(_deviceIdKey);
    
    if (deviceId == null) {
      deviceId = _uuid.v4();
      await prefs.setString(_deviceIdKey, deviceId);
    }
    
    return deviceId;
  }
  
  /// Get the current device entity
  @override
  Future<DeviceEntity> getCurrentDevice() async {
    if (_currentDevice != null) {
      return _currentDevice!;
    }
    
    await _loadCurrentDevice();
    return _currentDevice!;
  }
  
  /// Load the current device information
  Future<void> _loadCurrentDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = await getCurrentDeviceId();
    String? deviceName = prefs.getString(_deviceNameKey);
    
    if (deviceName == null) {
      deviceName = await _getDefaultDeviceName();
      await prefs.setString(_deviceNameKey, deviceName);
    }
    
    final deviceModel = await _getDeviceModel();
    final deviceInfo = await _getDeviceInfo();
    
    _currentDevice = DeviceEntity(
      id: deviceId,
      name: deviceName,
      model: deviceModel,
      lastSyncTime: DateTime.now(),
      isActive: true,
      deviceInfo: deviceInfo,
    );
  }
  
  /// Get default device name based on device model
  Future<String> _getDefaultDeviceName() async {
    final model = await _getDeviceModel();
    return '$model-${_uuid.v4().substring(0, 4)}';
  }
  
  /// Get device model information
  Future<String> _getDeviceModel() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await _deviceInfo.androidInfo;
        return '${androidInfo.manufacturer} ${androidInfo.model}';
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return '${iosInfo.name} ${iosInfo.model}';
      } else {
        return 'Unknown Device';
      }
    } catch (e) {
      debugPrint('Error getting device model: $e');
      return 'Unknown Device';
    }
  }
  
  /// Get detailed device information
  Future<Map<String, dynamic>> _getDeviceInfo() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await _deviceInfo.androidInfo;
        return {
          'version': androidInfo.version.release,
          'sdkInt': androidInfo.version.sdkInt,
          'manufacturer': androidInfo.manufacturer,
          'brand': androidInfo.brand,
          'isPhysicalDevice': androidInfo.isPhysicalDevice,
        };
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return {
          'systemName': iosInfo.systemName,
          'systemVersion': iosInfo.systemVersion,
          'name': iosInfo.name,
          'isPhysicalDevice': iosInfo.isPhysicalDevice,
        };
      } else {
        return {'platform': defaultTargetPlatform.toString()};
      }
    } catch (e) {
      debugPrint('Error getting device info: $e');
      return {'error': e.toString()};
    }
  }
  
  /// Update the current device name
  @override
  Future<bool> updateDeviceName(String newName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_deviceNameKey, newName);
      
      if (_currentDevice != null) {
        _currentDevice = _currentDevice!.copyWith(name: newName);
      }
      
      return true;
    } catch (e) {
      debugPrint('Error updating device name: $e');
      return false;
    }
  }
  
  /// Register a new device
  @override
  Future<bool> registerDevice(DeviceEntity device) async {
    try {
      // Check if device already exists
      final existingIndex = _registeredDevices.indexWhere((d) => d.id == device.id);
      
      if (existingIndex >= 0) {
        // Update existing device
        _registeredDevices[existingIndex] = device;
      } else {
        // Add new device
        _registeredDevices.add(device);
      }
      
      await _saveRegisteredDevices();
      return true;
    } catch (e) {
      debugPrint('Error registering device: $e');
      return false;
    }
  }
  
  /// Unregister a device
  @override
  Future<bool> unregisterDevice(String deviceId) async {
    try {
      _registeredDevices.removeWhere((device) => device.id == deviceId);
      await _saveRegisteredDevices();
      return true;
    } catch (e) {
      debugPrint('Error unregistering device: $e');
      return false;
    }
  }
  
  /// Get all registered devices
  @override
  Future<List<DeviceEntity>> getRegisteredDevices() async {
    await _loadRegisteredDevices();
    return _registeredDevices;
  }
  
  /// Update device sync status
  @override
  Future<bool> updateDeviceSyncStatus(String deviceId, DateTime syncTime) async {
    try {
      final deviceIndex = _registeredDevices.indexWhere((d) => d.id == deviceId);
      
      if (deviceIndex >= 0) {
        _registeredDevices[deviceIndex] = _registeredDevices[deviceIndex].copyWith(
          lastSyncTime: syncTime,
        );
        
        await _saveRegisteredDevices();
        return true;
      }
      
      return false;
    } catch (e) {
      debugPrint('Error updating device sync status: $e');
      return false;
    }
  }
  
  /// Load registered devices from shared preferences
  Future<void> _loadRegisteredDevices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final devicesJson = prefs.getString(_registeredDevicesKey);
      
      if (devicesJson != null) {
        final List<dynamic> devicesList = jsonDecode(devicesJson);
        _registeredDevices = devicesList
            .map((json) => DeviceEntity.fromJson(json))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading registered devices: $e');
      _registeredDevices = [];
    }
  }
  
  /// Save registered devices to shared preferences
  Future<void> _saveRegisteredDevices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final devicesJson = jsonEncode(
        _registeredDevices.map((device) => device.toJson()).toList(),
      );
      
      await prefs.setString(_registeredDevicesKey, devicesJson);
    } catch (e) {
      debugPrint('Error saving registered devices: $e');
    }
  }
  
  /// Generate a unique sync identifier for the current device
  @override
  Future<String> generateSyncIdentifier() async {
    final device = await getCurrentDevice();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final data = '${device.id}:$timestamp';
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    
    return digest.toString();
  }
}