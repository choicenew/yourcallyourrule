import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../services/device_service.dart';

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
