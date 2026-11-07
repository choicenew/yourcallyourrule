library pyro_phone_call_overlay_connector;

import 'package:pyro_phone_call_overlay_protocol/pyro_phone_call_overlay_protocol.dart';
import 'package:pyro_phone_call_overlay_hub/pyro_phone_call_overlay_hub.dart';
import 'package:pyro_phone_call_overlay_driver/pyro_phone_call_overlay_driver.dart';

/// 悬浮窗外观装配线 (Facade Assembly)
class PyroPhoneCallOverlayConnector {
  static void registerAll({PhoneOverlayDriver? customOverlayDriver}) {
    final driver = customOverlayDriver ?? SystemPhoneOverlayDriver();
    OverlayControlCenter.instance.registerOverlayDriver(driver);
  }
}
