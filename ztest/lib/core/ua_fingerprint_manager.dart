/// [UAFingerprintManager]
///
/// Responsible for generating Client Hints based on User-Agent.
/// Ensures consistent fingerprinting between Native (Dio) and WebView.
class UAFingerprintManager {
  static final UAFingerprintManager _instance =
      UAFingerprintManager._internal();

  factory UAFingerprintManager() {
    return _instance;
  }

  UAFingerprintManager._internal();

  /// Generates Client Hints headers based on User-Agent
  Map<String, String> generateClientHints(String? userAgent) {
    if (userAgent == null || userAgent.isEmpty) {
      return {};
    }

    // Only generate for Chrome/Chromium based UAs
    if (!userAgent.contains("Chrome")) {
      return {};
    }

    final headers = <String, String>{};

    // 1. Extract Version
    final versionMatch = RegExp(r'Chrome\/(\d+)').firstMatch(userAgent);
    final version = versionMatch != null ? versionMatch.group(1) : "100";

    // 2. Identify Platform
    String platform = '"Unknown"';
    if (userAgent.contains("Windows")) {
      platform = '"Windows"';
    } else if (userAgent.contains("Macintosh")) {
      platform = '"macOS"';
    } else if (userAgent.contains("Android")) {
      platform = '"Android"';
    } else if (userAgent.contains("Linux")) {
      platform = '"Linux"';
    }

    // 3. Identify Mobile Status
    final bool isMobile =
        userAgent.contains("Mobile") || userAgent.contains("Android");
    final String mobileHeader = isMobile ? '?1' : '?0';

    // 4. Generate Headers
    if (userAgent.contains("wv") || userAgent.contains("Android WebView")) {
      headers['sec-ch-ua'] =
          '"Android WebView";v="$version", "Chromium";v="$version", "Not?A_Brand";v="24"';
    } else {
      headers['sec-ch-ua'] =
          '"Chromium";v="$version", "Google Chrome";v="$version", "Not?A_Brand";v="99"';
    }

    headers['sec-ch-ua-mobile'] = mobileHeader;
    headers['sec-ch-ua-platform'] = platform;

    return headers;
  }
}
