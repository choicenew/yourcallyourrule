import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../services/device_service.dart';

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
