import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_overlay_protocol/pyro_phone_call_overlay_protocol.dart';

part 'overlay_control_center.g.dart';

@Riverpod(keepAlive: true)
OverlayControlCenter overlayControlCenter(Ref ref) {
  return OverlayControlCenter.instance;
}

/// 悬浮窗控制中心 (OverlayControlCenter)
class OverlayControlCenter {
  static final OverlayControlCenter instance = OverlayControlCenter._();

  OverlayControlCenter._();

  PhoneOverlayDriver? _overlayDriver;

  void registerOverlayDriver(PhoneOverlayDriver driver) {
    _overlayDriver = driver;
    debugPrint('[PhoneOverlayHub] 已挂载注册悬浮窗驱动: ${driver.runtimeType}');
  }

  PhoneOverlayDriver? get overlayDriver => _overlayDriver;

  Future<void> showOverlay(String phoneNumber, String info) async {
    await _overlayDriver?.showOverlay(phoneNumber, info);
    debugPrint('[PhoneOverlayHub] 中枢显示悬浮窗: $phoneNumber');
  }

  Future<void> closeOverlay() async {
    await _overlayDriver?.closeOverlay();
    debugPrint('[PhoneOverlayHub] 中枢关闭悬浮窗。');
  }
}
