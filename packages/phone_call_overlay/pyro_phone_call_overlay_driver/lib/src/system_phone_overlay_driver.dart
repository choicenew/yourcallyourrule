import 'package:flutter/foundation.dart';
import 'package:pyro_phone_call_overlay_protocol/pyro_phone_call_overlay_protocol.dart';

/// 真实系统级悬浮窗驱动 (SystemPhoneOverlayDriver)
class SystemPhoneOverlayDriver implements PhoneOverlayDriver {
  SystemPhoneOverlayDriver();

  @override
  Future<void> showOverlay(String phoneNumber, String info) async {
    debugPrint('[SystemOverlayDriver] 原生平台显示悬浮窗: $phoneNumber ($info)');
  }

  @override
  Future<void> closeOverlay() async {
    debugPrint('[SystemOverlayDriver] 原生平台关闭悬浮窗。');
  }
}
