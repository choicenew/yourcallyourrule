/// 全局环境与天气感知快照模型 (Atmospheric & Environmental Snapshot)
class AtmosphereState {
  final double temperature; // 摄氏度
  final double apparentTemp; // 体感温度
  final int humidity; // 相对湿度 (0-100%)
  final double pressure; // 气压 (hPa)
  final double windSpeed; // 风速 (m/s)
  final double windGusts; // 阵风
  final double visibility; // 能见度 (m)
  final double uvIndex; // 紫外线指数
  final int cloudCover; // 云量 (0-100%)
  final int weatherCode; // WMO 天气代码
  final bool isDay; // 是否为白天
  final DateTime? sunset; // 日落时间

  // --- AQI 空气质量指标 ---
  final double aqiUS; // 美国标准 AQI
  final double pm2_5; // PM2.5 颗粒物浓度
  final double pollen; // 花粉指数
  final double pollutionLevel; // 二氧化氮 / 污染综合指数
  final DateTime timestamp; // 记录时间戳

  AtmosphereState({
    this.temperature = 20.0,
    this.apparentTemp = 20.0,
    this.humidity = 50,
    this.pressure = 1013.0,
    this.windSpeed = 0.0,
    this.windGusts = 0.0,
    this.visibility = 10000.0,
    this.uvIndex = 0.0,
    this.cloudCover = 0,
    this.weatherCode = 0,
    this.isDay = true,
    this.sunset,
    this.aqiUS = 0.0,
    this.pm2_5 = 0.0,
    this.pollen = 0.0,
    this.pollutionLevel = 0.0,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  /// 默认清爽天气状态
  static AtmosphereState get standard => AtmosphereState();

  /// 是否为雨雪恶劣天气
  bool get isPrecipitation =>
      (weatherCode >= 51 && weatherCode <= 67) || (weatherCode >= 71 && weatherCode <= 86);

  /// 是否为严重空气污染
  bool get isHeavyPollution => aqiUS > 150 || pm2_5 > 75;

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'apparentTemp': apparentTemp,
        'humidity': humidity,
        'pressure': pressure,
        'windSpeed': windSpeed,
        'windGusts': windGusts,
        'visibility': visibility,
        'uvIndex': uvIndex,
        'cloudCover': cloudCover,
        'weatherCode': weatherCode,
        'isDay': isDay,
        'sunset': sunset?.toIso8601String(),
        'aqiUS': aqiUS,
        'pm2_5': pm2_5,
        'pollen': pollen,
        'pollutionLevel': pollutionLevel,
        'timestamp': timestamp.toIso8601String(),
      };

  factory AtmosphereState.fromJson(Map<String, dynamic> json) => AtmosphereState(
        temperature: (json['temperature'] as num?)?.toDouble() ?? 20.0,
        apparentTemp: (json['apparentTemp'] as num?)?.toDouble() ?? 20.0,
        humidity: (json['humidity'] as num?)?.toInt() ?? 50,
        pressure: (json['pressure'] as num?)?.toDouble() ?? 1013.0,
        windSpeed: (json['windSpeed'] as num?)?.toDouble() ?? 0.0,
        windGusts: (json['windGusts'] as num?)?.toDouble() ?? 0.0,
        visibility: (json['visibility'] as num?)?.toDouble() ?? 10000.0,
        uvIndex: (json['uvIndex'] as num?)?.toDouble() ?? 0.0,
        cloudCover: (json['cloudCover'] as num?)?.toInt() ?? 0,
        weatherCode: (json['weatherCode'] as num?)?.toInt() ?? 0,
        isDay: json['isDay'] as bool? ?? true,
        sunset: json['sunset'] != null ? DateTime.tryParse(json['sunset'] as String) : null,
        aqiUS: (json['aqiUS'] as num?)?.toDouble() ?? 0.0,
        pm2_5: (json['pm2_5'] as num?)?.toDouble() ?? 0.0,
        pollen: (json['pollen'] as num?)?.toDouble() ?? 0.0,
        pollutionLevel: (json['pollutionLevel'] as num?)?.toDouble() ?? 0.0,
        timestamp: json['timestamp'] != null
            ? DateTime.tryParse(json['timestamp'] as String) ?? DateTime.now()
            : DateTime.now(),
      );
}
