import 'package:flutter/foundation.dart';
import 'package:pyro_sms_hub/pyro_sms_hub.dart';
import 'package:pyro_sms_driver_openphish/pyro_sms_driver_openphish.dart';
import 'package:pyro_sms_driver_otp_guard/pyro_sms_driver_otp_guard.dart';
import 'package:pyro_sms_driver_keyword_bloom_filter/pyro_sms_driver_keyword_bloom_filter.dart';
import 'package:pyro_sms_driver_notification_listener/pyro_sms_driver_notification_listener.dart';

/// Central Plug-and-Play Assembly Connector for Pyro SMS Package Suite (Play Store Compliant)
class SmsConnectors {
  /// 将所有 Play 合规（免危险权限）短信驱动挂载到指定的 SmsHub 实例中
  static void mountToHub(
    SmsHub hub, {
    bool enableOpenPhish = true,
    bool enableOtpGuard = true,
    bool enableBloomFilter = true,
    bool enableNotificationListener = true,
    bool enableTelephonyFallback = false,
  }) {
    debugPrint('[SmsConnectors] Mounting Play-compliant SMS drivers to SmsHub...');

    if (enableOpenPhish) OpenPhishDriver.register(hub);
    if (enableOtpGuard) OtpGuardDriver.register(hub);
    if (enableBloomFilter) KeywordBloomFilterDriver.register(hub);
    if (enableNotificationListener) SmsNotificationListenerDriver.register(hub);

    debugPrint('[SmsConnectors] Play-compliant SMS Package suite assembly complete.');
  }

  /// Single-line plug-and-play entrypoint for host app assembly.
  static void ensureMounted({
    SmsHub? hub,
    bool enableOpenPhish = true,
    bool enableOtpGuard = true,
    bool enableBloomFilter = true,
    bool enableNotificationListener = true,
    bool enableTelephonyFallback = false,
  }) {
    if (hub != null) {
      mountToHub(
        hub,
        enableOpenPhish: enableOpenPhish,
        enableOtpGuard: enableOtpGuard,
        enableBloomFilter: enableBloomFilter,
        enableNotificationListener: enableNotificationListener,
        enableTelephonyFallback: enableTelephonyFallback,
      );
    }
  }
}
