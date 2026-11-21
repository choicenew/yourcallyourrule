import 'package:flutter/foundation.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'package:pyro_sms_connector/pyro_sms_connector.dart';
import 'package:pyro_sms_driver_telephony_fallback/pyro_sms_driver_telephony_fallback.dart';

/// Central Assembly Connector with Telephony Fallback Driver for GitHub/F-Droid Builds.
class SmsGithubConnectors {
  /// Mounts all standard SMS drivers plus TelephonyFallbackDriver to the SmsHub.
  static void mountToHub(
    SmsHub hub, {
    bool enableOpenPhish = true,
    bool enableOtpGuard = true,
    bool enableBloomFilter = true,
    bool enableTelephonyFallback = true,
    bool enableNotificationListener = true,
  }) {
    debugPrint('[SmsGithubConnectors] Mounting full SMS drivers including TelephonyFallback to SmsHub...');

    // 1. Mount standard Play-compliant drivers
    SmsConnectors.mountToHub(
      hub,
      enableOpenPhish: enableOpenPhish,
      enableOtpGuard: enableOtpGuard,
      enableBloomFilter: enableBloomFilter,
      enableNotificationListener: enableNotificationListener,
    );

    // 2. Mount native TelephonyFallbackDriver for high-privilege side-load builds
    if (enableTelephonyFallback) {
      TelephonyFallbackDriver.register(hub);
    }

    debugPrint('[SmsGithubConnectors] Full SMS Package suite assembly complete.');
  }

  /// Single-line plug-and-play entrypoint for host app assembly in GitHub/F-Droid builds.
  static void ensureMounted({
    SmsHub? hub,
    bool enableOpenPhish = true,
    bool enableOtpGuard = true,
    bool enableBloomFilter = true,
    bool enableTelephonyFallback = true,
    bool enableNotificationListener = true,
  }) {
    if (hub != null) {
      mountToHub(
        hub,
        enableOpenPhish: enableOpenPhish,
        enableOtpGuard: enableOtpGuard,
        enableBloomFilter: enableBloomFilter,
        enableTelephonyFallback: enableTelephonyFallback,
        enableNotificationListener: enableNotificationListener,
      );
    }
  }
}
