import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../services/device_service.dart';

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
