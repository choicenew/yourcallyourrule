import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../services/device_service.dart';

class MotionBinding extends HTExternalClass {
  Map<String, double> _lastAccel = {'x': 0.0, 'y': 0.0, 'z': 0.0};

  MotionBinding(DeviceService service) : super('Motion') {
    service.getAccelerometerStream().listen((event) {
      _lastAccel = event;
    });
  }

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Motion.getAccelerometer':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) =>
            _lastAccel;
      case 'Motion.isMoving':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          final x = _lastAccel['x']?.abs() ?? 0.0;
          final y = _lastAccel['y']?.abs() ?? 0.0;
          final z = _lastAccel['z']?.abs() ?? 0.0;
          return (x + y + z) > 0.5;
        };
      default:
        throw HTError.undefined(id);
    }
  }
}

class NetworkBinding extends HTExternalClass {
  final DeviceService service;
  NetworkBinding(this.service) : super('Network');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    if (id == 'Network.type') {
      return ({List<dynamic> positionalArgs = const [],
              Map<String, dynamic> namedArgs = const {}}) async =>
          await service.getNetworkType();
    }
    throw HTError.undefined(id);
  }
}

class LocationBinding extends HTExternalClass {
  final DeviceService service;
  LocationBinding(this.service) : super('Location');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Location.getCurrentPosition':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) =>
            service.getLocation();
      case 'Location.checkPermission':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) =>
            service.checkPermission('location');
      case 'Location.requestPermission':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) =>
            service.requestPermission('location');
      default:
        throw HTError.undefined(id);
    }
  }
}

class TimeBinding extends HTExternalClass {
  final DeviceService service;
  TimeBinding(this.service) : super('Time');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Time.hour':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) =>
            DateTime.now().hour;
      case 'Time.isDaytime':
        return ({List<dynamic> positionalArgs = const [],
            Map<String, dynamic> namedArgs = const {}}) {
          final h = DateTime.now().hour;
          return h >= 6 && h < 18;
        };
      case 'Time.timezone':
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) =>
            service.getTimezone();
      default:
        throw HTError.undefined(id);
    }
  }
}
