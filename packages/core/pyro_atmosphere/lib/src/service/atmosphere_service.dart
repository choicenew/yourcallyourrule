import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/atmosphere_state.dart';

/// 统一气象与环境感知数据服务 (Atmosphere Service)
class AtmosphereService {
  static const String defaultForecastUrl = "https://api.open-meteo.com/v1/forecast";
  static const String defaultAqiUrl = "https://air-quality-api.open-meteo.com/v1/air-quality";

  final http.Client _client;
  final Duration cacheTtl;
  final void Function(String message)? _onLog;

  AtmosphereState? _cachedState;
  DateTime? _lastFetchTime;
  double? _lastLat;
  double? _lastLng;

  AtmosphereService({
    http.Client? client,
    this.cacheTtl = const Duration(minutes: 30),
    void Function(String message)? onLog,
  })  : _client = client ?? http.Client(),
        _onLog = onLog;

  /// 获取当前缓存的环境快照
  AtmosphereState? get cachedState => _cachedState;

  /// 获取实时大气与环境感知状态 (支持位置缓存)
  Future<AtmosphereState> getAtmosphere({
    required double lat,
    required double lng,
    bool forceRefresh = false,
  }) async {
    final now = DateTime.now();

    // 1. 检查缓存命中
    if (!forceRefresh &&
        _cachedState != null &&
        _lastFetchTime != null &&
        now.difference(_lastFetchTime!) < cacheTtl &&
        _lastLat == lat &&
        _lastLng == lng) {
      _log('[AtmosphereService] Hit cached atmosphere state');
      return _cachedState!;
    }

    // 2. 构造请求 URL
    final forecastUri = Uri.parse(
        "$defaultForecastUrl?latitude=$lat&longitude=$lng&current=temperature_2m,apparent_temperature,relative_humidity_2m,surface_pressure,weather_code,is_day,wind_speed_10m,wind_gusts_10m,visibility,cloud_cover,uv_index&daily=sunset&timezone=auto");
    final aqiUri = Uri.parse(
        "$defaultAqiUrl?latitude=$lat&longitude=$lng&current=us_aqi,pm10,pm2_5,grass_pollen,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone&timezone=auto");

    try {
      _log('[AtmosphereService] Fetching weather and air quality for ($lat, $lng)...');

      // 3. 并行拉取天气与空气质量
      final results = await Future.wait([
        _client.get(forecastUri),
        _client.get(aqiUri),
      ]);

      final forecastRes = results[0];
      final aqiRes = results[1];

      Map<String, dynamic> currentForecast = {};
      Map<String, dynamic> dailyForecast = {};
      if (forecastRes.statusCode == 200) {
        final json = jsonDecode(forecastRes.body) as Map<String, dynamic>;
        currentForecast = (json['current'] as Map<String, dynamic>?) ?? {};
        dailyForecast = (json['daily'] as Map<String, dynamic>?) ?? {};
      }

      Map<String, dynamic> currentAqi = {};
      if (aqiRes.statusCode == 200) {
        final json = jsonDecode(aqiRes.body) as Map<String, dynamic>;
        currentAqi = (json['current'] as Map<String, dynamic>?) ?? {};
      }

      DateTime? sunsetTime;
      if (dailyForecast['sunset'] != null && (dailyForecast['sunset'] as List).isNotEmpty) {
        sunsetTime = DateTime.tryParse(dailyForecast['sunset'][0].toString());
      }

      final state = AtmosphereState(
        temperature: (currentForecast['temperature_2m'] as num?)?.toDouble() ?? 20.0,
        apparentTemp: (currentForecast['apparent_temperature'] as num?)?.toDouble() ?? 20.0,
        humidity: (currentForecast['relative_humidity_2m'] as num?)?.toInt() ?? 50,
        pressure: (currentForecast['surface_pressure'] as num?)?.toDouble() ?? 1013.0,
        windSpeed: (currentForecast['wind_speed_10m'] as num?)?.toDouble() ?? 0.0,
        windGusts: (currentForecast['wind_gusts_10m'] as num?)?.toDouble() ?? 0.0,
        visibility: (currentForecast['visibility'] as num?)?.toDouble() ?? 10000.0,
        uvIndex: (currentForecast['uv_index'] as num?)?.toDouble() ?? 0.0,
        cloudCover: (currentForecast['cloud_cover'] as num?)?.toInt() ?? 0,
        weatherCode: (currentForecast['weather_code'] as num?)?.toInt() ?? 0,
        isDay: (currentForecast['is_day'] as num? ?? 1) == 1,
        sunset: sunsetTime,
        aqiUS: (currentAqi['us_aqi'] as num?)?.toDouble() ?? 0.0,
        pm2_5: (currentAqi['pm2_5'] as num?)?.toDouble() ?? 0.0,
        pollen: (currentAqi['grass_pollen'] as num?)?.toDouble() ?? 0.0,
        pollutionLevel: (currentAqi['nitrogen_dioxide'] as num?)?.toDouble() ?? 0.0,
        timestamp: now,
      );

      _cachedState = state;
      _lastFetchTime = now;
      _lastLat = lat;
      _lastLng = lng;
      _log('[AtmosphereService] Fetched successfully: temp=${state.temperature}°C, aqi=${state.aqiUS}');
      return state;
    } catch (e) {
      _log('[AtmosphereService] Weather fetch failed: $e, falling back to cached or standard state');
      return _cachedState ?? AtmosphereState.standard;
    }
  }

  void _log(String message) {
    _onLog?.call(message);
  }

  void dispose() {
    _client.close();
  }
}
