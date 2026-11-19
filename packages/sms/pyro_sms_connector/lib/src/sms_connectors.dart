import 'package:flutter/foundation.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'package:pyro_sms_driver_openphish/pyro_sms_driver_openphish.dart';
import 'package:pyro_sms_driver_otp_guard/pyro_sms_driver_otp_guard.dart';
import 'package:pyro_sms_driver_keyword_bloom_filter/pyro_sms_driver_keyword_bloom_filter.dart';
import 'package:pyro_sms_driver_telephony_fallback/pyro_sms_driver_telephony_fallback.dart';
import 'package:pyro_sms_driver_notification_listener/pyro_sms_driver_notification_listener.dart';

/// Central Plug-and-Play Assembly Connector for Pyro SMS Package Suite
class SmsConnectors {
  /// 将所有短信驱动挂载到指定的 SmsHub 实例中，消除任何隐式全局静态单例
  static void mountToHub(
    SmsHub hub, {
    bool enableOpenPhish = true,
    bool enableOtpGuard = true,
    bool enableBloomFilter = true,
    bool enableTelephonyFallback = true,
    bool enableNotificationListener = true,
  }) {
    debugPrint('[SmsConnectors] Mounting SMS drivers to SmsHub...');

    if (enableOpenPhish) OpenPhishDriver.register(hub);
    if (enableOtpGuard) OtpGuardDriver.register(hub);
    if (enableBloomFilter) KeywordBloomFilterDriver.register(hub);
    if (enableTelephonyFallback) TelephonyFallbackDriver.register(hub);
    if (enableNotificationListener) SmsNotificationListenerDriver.register(hub);

    debugPrint('[SmsConnectors] SMS Package suite assembly complete.');
  }

  /// Single-line plug-and-play entrypoint for host app assembly.
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
