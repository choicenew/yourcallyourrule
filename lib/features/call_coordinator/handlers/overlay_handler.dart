import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/common/utils/global_variable.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/providers/call_overlay_style_security_provider.dart';

part 'overlay_handler.g.dart';

@Riverpod(keepAlive: true)
OverlayHandler overlayHandler(Ref ref) {
  return OverlayHandler(ref);
}

/// 生产级全功能 Overlay 悬浮窗处理器
class OverlayHandler {
  final Ref _ref;
  OverlayPosition? storedPosition;

  OverlayHandler(this._ref);

  Future<void> _ensurePixelRatio() async {
    pixelRatio ??= await FloatingWindowAndroid.getDevicePixelRatio();
  }

  Future<void> showCallerIdOverlay(
    CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    
    final config = await _ref.read(callOverlayStyleSecurityProvider.future);
    await _ensurePixelRatio();
    await updateAndShareConfiguration(config);

    if (await FloatingWindowAndroid.isShowing()) {
      storedPosition = await FloatingWindowAndroid.getOverlayPosition();
    } else {
      storedPosition = storedPosition ?? OverlayPosition(0, 0);
    }

    await FloatingWindowAndroid.shareData({
      "configType": "callerIdData",
      ...callerIdData.toMap(),
    });

    if (stirInfo != null) {
      await FloatingWindowAndroid.shareData({ "configType": "stirInfo", ...stirInfo.toJson() });
    }

    if (simInfo != null) {
      await FloatingWindowAndroid.shareData({ "configType": "simInfo", ...simInfo.toJson() });
    }

    await FloatingWindowAndroid.showOverlay(
      enableDrag: true,
      overlayTitle: "Call",
      overlayContent: "name:${callerIdData.phoneNumber},region:${callerIdData.countryName},carrier:${callerIdData.carrier}",
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.lockScreen,
      notificationVisibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: (config.windowHeight * (pixelRatio ?? 3.0)).toInt(),
      width: (config.windowWidth * (pixelRatio ?? 3.0)).toInt(),
      startPosition: storedPosition!,
    );
  }

  void closeOverlay() {
    FloatingWindowAndroid.closeOverlay();
  }

  Future<void> updateAndShareConfiguration(CallOverlayConfig config) async {
    await FloatingWindowAndroid.shareData({
      "configType": "callerIdStyle",
      ...config.toMap(),
    });
  }

  void setPixelRatio(double ratio) {
    pixelRatio = ratio;
  }
}
