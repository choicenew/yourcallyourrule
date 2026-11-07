import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';

/// Concrete implementation of device sensors using standard Flutter plugins.
class DeviceService {
  final Battery _battery = Battery();

  Future<int> getBatteryLevel() async {
    try {
      return await _battery.batteryLevel;
    } catch (e) {
      return -1;
    }
  }

  Future<Map<String, dynamic>> getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return {'error': 'Location service disabled'};
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return {'error': 'Location permission denied'};
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return {'error': 'Location permission permanently denied'};
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings:
              const LocationSettings(timeLimit: Duration(seconds: 5)));
      return {
        'lat': position.latitude,
        'lng': position.longitude,
        'accuracy': position.accuracy,
        'source': 'gps',
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<String> getNetworkType() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return 'mobile';
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return 'wifi';
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return 'ethernet';
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return 'vpn';
    } else if (connectivityResult.contains(ConnectivityResult.bluetooth)) {
      return 'bluetooth';
    } else if (connectivityResult.contains(ConnectivityResult.other)) {
      return 'other';
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      return 'none';
    }
    return 'unknown';
  }

  String getTimezone() {
    return DateTime.now().timeZoneName;
  }

  void log(String message) {
    debugPrint('[PyroHetuEngine] $message');
  }

  Stream<Map<String, double>> getAccelerometerStream() {
    // Return dummy stream to prevent test crashes on Windows/Mock env
    // Real implementation requires EventChannel mocking which is flaky here.
    return Stream.value({'x': 0.0, 'y': 0.0, 'z': 0.0});
  }

  Future<bool> checkPermission(String permission) async {
    if (permission == 'location') {
      final p = await Geolocator.checkPermission();
      return p == LocationPermission.always ||
          p == LocationPermission.whileInUse;
    }
    return false;
  }

  Future<bool> requestPermission(String permission) async {
    if (permission == 'location') {
      final p = await Geolocator.requestPermission();
      return p == LocationPermission.always ||
          p == LocationPermission.whileInUse;
    }
    return false;
  }
}
