import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../services/device_service.dart';

class BatteryBinding extends HTExternalClass {
  final DeviceService service;
  BatteryBinding(this.service) : super('Battery');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    switch (id) {
      case 'Battery.level': // Assuming original API was static style or instance?
        // Original folder had battery.ht: let's assume simple static like NativeContext logic
        return ({List<dynamic> positionalArgs = const [],
                Map<String, dynamic> namedArgs = const {}}) =>
            service.getBatteryLevel();
      default:
        throw HTError.undefined(id);
    }
  }
}
