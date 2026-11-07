abstract class WebViewDelegate {
  Future<String> fetch(
    String url, {
    List<String>? purgeRules,
    String? waitFor,
    Map<String, String>? headers,
    bool allowNavigation = false,
  });

  Future<String> openAndGetCookies(String url, {String? userAgent});

  String? getUserAgent();
}

abstract class UserDelegate {
  Future<Map<String, int>> getWeights({String? type});
  Future<List<String>> getLastTags({String? type});
  Future<List<Map<String, dynamic>>> getHistory({String? type});
  Future<List<Map<String, dynamic>>> getCollections({String? type});
}

abstract class ConfigDelegate {
  Future<dynamic> getValue(String key);
  Future<void> setValue(String key, dynamic value);
  Future<void> updateConfig(Map<String, dynamic> config);
}

abstract class StorageDelegate {
  Future<String?> getValue(String key);
  Future<bool> setValue(String key, String value);
}

/// Abstract interface for device sensors and capabilities
abstract class DeviceDelegate {
  Future<int> getBatteryLevel();
  Future<Map<String, dynamic>> getLocation();
  Future<String> getNetworkType();
  String getTimezone();
  void log(String message);

  // Motion sensors
  Stream<Map<String, double>> getAccelerometerStream();

  // Permissions (optional, can be part of specific features)
  Future<bool> checkPermission(String permission);
  Future<bool> requestPermission(String permission);
}

/// Abstract interface for weather services
abstract class WeatherDelegate {
  Future<Map<String, dynamic>> getWeather(double lat, double lng);
}

/// Abstract interface for cookie management and synchronization
abstract class CookieDelegate {
  /// Get cookies for a specific URL from the host system
  Future<String?> getCookies(String url);

  /// Notify the host system of new cookies (Set-Cookie)
  Future<void> setCookies(String url, List<String> cookies);

  /// Trigger a manual verification UI for a specific URL
  Future<bool> solveChallenge(String url);
}

/// Abstract interface for translation services
abstract class TranslationDelegate {
  Future<String> translate(String text,
      {String targetLang = 'en', String sourceLang = 'auto'});
}
