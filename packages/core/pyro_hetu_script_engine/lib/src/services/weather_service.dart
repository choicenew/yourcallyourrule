import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  void log(String message) {
    debugPrint('[PyroHetuEngine] $message');
  }

  // --- Weather (OpenMeteo Integration) ---
  Future<Map<String, dynamic>> getWeather(double lat, double lng) async {
    try {
      // 1. Define Forecast API URL (Maximal Data)
      const forecastBaseUrl = 'https://api.open-meteo.com/v1/forecast';
      final forecastUrl = Uri.parse(
          '$forecastBaseUrl?latitude=$lat&longitude=$lng'
          '&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,rain,showers,snowfall,weather_code,cloud_cover,pressure_msl,surface_pressure,wind_speed_10m,wind_direction_10m,wind_gusts_10m,visibility'
          '&daily=sunrise,sunset,daylight_duration,sunshine_duration,uv_index_max,precipitation_sum,rain_sum,showers_sum,snowfall_sum,precipitation_probability_max'
          '&hourly=temperature_2m,relative_humidity_2m,precipitation_probability,weather_code,is_day'
          '&timezone=auto&forecast_days=2');

      // 2. Define Air Quality API URL
      const aqBaseUrl = 'https://air-quality-api.open-meteo.com/v1/air-quality';
      final aqUrl = Uri.parse('$aqBaseUrl?latitude=$lat&longitude=$lng'
          '&current=us_aqi,european_aqi,pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone,dust,uv_index'
          '&hourly=pm10,pm2_5,us_aqi'
          '&timezone=auto&forecast_days=2');

      log('[WeatherService] Fetching Weather & AQI...\n  Forecast: $forecastUrl\n  AQI: $aqUrl');

      // 3. Parallel Execution
      final results = await Future.wait([
        http.get(forecastUrl),
        http.get(aqUrl),
      ]);

      final forecastRes = results[0];
      final aqRes = results[1];

      final Map<String, dynamic> finalData = {};

      // 4. Process Forecast Data
      if (forecastRes.statusCode == 200) {
        final data = jsonDecode(forecastRes.body);
        final current = data['current'] ?? {};
        final dailyRaw = data['daily'] ?? {};
        final hourlyRaw = data['hourly'] ?? {};

        finalData['weather'] = {
          'current': {
            'temp': current['temperature_2m'],
            'feels_like': current['apparent_temperature'],
            'humidity': current['relative_humidity_2m'],
            'is_day': current['is_day'] == 1,
            'precipitation': current['precipitation'],
            'rain': current['rain'],
            'showers': current['showers'],
            'snow': current['snowfall'],
            'code': current['weather_code'],
            'cloud_cover': current['cloud_cover'],
            'pressure': current['pressure_msl'],
            'wind_speed': current['wind_speed_10m'],
            'wind_dir': current['wind_direction_10m'],
            'visibility': current['visibility'],
          },
          'daily': {
            'sunrise': dailyRaw['sunrise']?[0],
            'sunset': dailyRaw['sunset']?[0],
            'uv_max': dailyRaw['uv_index_max']?[0],
            'rain_prob': dailyRaw['precipitation_probability_max']?[0]
          },
          'hourly': _simplifyHourlyData(hourlyRaw)
        };
      } else {
        finalData['weather_error'] = 'Status ${forecastRes.statusCode}';
      }

      // 5. Process Air Quality Data
      if (aqRes.statusCode == 200) {
        final data = jsonDecode(aqRes.body);
        final current = data['current'] ?? {};

        finalData['air_quality'] = {
          'current': {
            'aqi_us': current['us_aqi'],
            'aqi_eu': current['european_aqi'],
            'pm2_5': current['pm2_5'],
            'pm10': current['pm10'],
            'co': current['carbon_monoxide'],
            'no2': current['nitrogen_dioxide'],
            'so2': current['sulphur_dioxide'],
            'o3': current['ozone'],
            'dust': current['dust']
          }
        };
      } else {
        finalData['aqi_error'] = 'Status ${aqRes.statusCode}';
      }

      return finalData;
    } catch (e) {
      log('[WeatherService] Weather Fetch Error: $e');
      return {'error': e.toString()};
    }
  }

  // Helper to reduce hourly data size (take next 24h only)
  List<Map<String, dynamic>> _simplifyHourlyData(Map<String, dynamic> hourly) {
    if (hourly['time'] == null) return [];
    List<dynamic> times = hourly['time'];
    List<Map<String, dynamic>> result = [];

    int limit = times.length > 24 ? 24 : times.length;

    for (int i = 0; i < limit; i++) {
      result.add({
        'time': times[i],
        'temp': hourly['temperature_2m']?[i],
        'rain_prob': hourly['precipitation_probability']?[i],
        'is_day': hourly['is_day']?[i]
      });
    }
    return result;
  }
}
