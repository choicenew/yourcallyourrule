import 'package:hetu_script/hetu_script.dart';
import 'package:hetu_script/binding.dart';
import '../../../delegates/delegates.dart';
import '../../services/weather_service.dart';

class WeatherBinding extends HTExternalClass {
  // Dual mode: Delegate (priority) + Service (default/integrated)
  final WeatherDelegate? delegate;
  final WeatherService service;

  WeatherBinding({this.delegate, required this.service}) : super('Weather');

  @override
  dynamic memberGet(String id, {String? from, bool isRecursive = false, bool ignoreUndefined = false}) {
    if (id == 'Weather.fetch') {
      return ({List<dynamic> positionalArgs = const [],
          Map<String, dynamic> namedArgs = const {}}) async {
        if (positionalArgs.length >= 2) {
          final lat = (positionalArgs[0] as num).toDouble();
          final lng = (positionalArgs[1] as num).toDouble();

          // Delegate > Internal Service
          if (delegate != null) {
            try {
              return await delegate!.getWeather(lat, lng);
            } catch (_) {
              // 委托失败回退到内部服务
              return await service.getWeather(lat, lng);
            }
          }
          // Default Integration
          return await service.getWeather(lat, lng);
        }
        return {'error': 'Missing args'};
      };
    }
    throw HTError.undefined(id);
  }
}
