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
