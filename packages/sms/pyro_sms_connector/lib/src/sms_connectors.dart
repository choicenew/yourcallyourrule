import 'package:flutter/foundation.dart';
import 'package:pyro_sms_driver_openphish/pyro_sms_driver_openphish.dart';
import 'package:pyro_sms_driver_otp_guard/pyro_sms_driver_otp_guard.dart';
import 'package:pyro_sms_driver_keyword_bloom_filter/pyro_sms_driver_keyword_bloom_filter.dart';
import 'package:pyro_sms_driver_telephony_fallback/pyro_sms_driver_telephony_fallback.dart';
import 'package:pyro_sms_driver_notification_listener/pyro_sms_driver_notification_listener.dart';

/// Central Plug-and-Play Assembly Connector for Pyro SMS Package Suite
class SmsConnectors {
  static bool _mounted = false;

  /// Single-line plug-and-play entrypoint for host app assembly.
  static void ensureMounted({
    bool enableOpenPhish = true,
    bool enableOtpGuard = true,
    bool enableBloomFilter = true,
    bool enableTelephonyFallback = true,
    bool enableNotificationListener = true,
  }) {
    if (_mounted) return;
    _mounted = true;

    debugPrint('[SmsConnectors] Mounting self-registering SMS drivers...');

    if (enableOpenPhish) OpenPhishDriver.register();
    if (enableOtpGuard) OtpGuardDriver.register();
    if (enableBloomFilter) KeywordBloomFilterDriver.register();
    if (enableTelephonyFallback) TelephonyFallbackDriver.register();
    if (enableNotificationListener) SmsNotificationListenerDriver.register();

    debugPrint('[SmsConnectors] SMS Package suite assembly complete.');
  }
}
