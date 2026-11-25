import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:pyro_phone_call_overlay_hub/pyro_phone_call_overlay_hub.dart';
import 'package:yourcallyourrule/features/common/utils/global_variable.dart';
import 'package:yourcallyourrule/features/phone_call/call_overlay/configuration/call_overlay_config.dart';
import 'package:yourcallyourrule/features/phone_call/call_overlay/providers/call_overlay_style_security_provider.dart';

part 'overlay_handler.g.dart';

@Riverpod(keepAlive: true)
Future<OverlayHandler> overlayHandler(Ref ref) async {
  return OverlayHandler(ref);
}

class OverlayHandler {
  final Ref _ref;
  OverlayPosition? storedPosition;

  OverlayHandler(this._ref);

  Future<void> _ensurePixelRatio() async {
    pixelRatio ??= await FloatingWindowAndroid.getDevicePixelRatio();
  }

  Future<void> showCallerIdOverlay(
    CallerIdData callerIdData,
    StirInfo? stirInfo,
    SimInfo? simInfo,
  ) async {
    debugPrint('[OverlayHandler] Showing overlay for ${callerIdData.phoneNumber}');
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
      await FloatingWindowAndroid.shareData({
        "configType": "stirInfo",
        ...stirInfo,
      });
    }

    if (simInfo != null) {
      await FloatingWindowAndroid.shareData({
        "configType": "simInfo",
        ...simInfo,
      });
    }

    await FloatingWindowAndroid.showOverlay(
      enableDrag: true,
      overlayTitle: "Call",
      overlayContent:
          "name:${callerIdData.phoneNumber},region:${callerIdData.countryName},carrier:${callerIdData.carrier}",
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.lockScreen,
      notificationVisibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: (config.windowHeight * (pixelRatio ?? 3.0)).toInt(),
      width: (config.windowWidth * (pixelRatio ?? 3.0)).toInt(),
      startPosition: storedPosition!,
    );

    final name = callerIdData.name;
    final info = (name != null && name.isNotEmpty)
        ? name
        : (callerIdData.labels.isNotEmpty ? callerIdData.labels.join(', ') : '');
    await OverlayControlCenter.instance.showOverlay(callerIdData.phoneNumber, info);
  }

  Future<void> hideCallerIdOverlay() async {
    await FloatingWindowAndroid.closeOverlay();
    await OverlayControlCenter.instance.closeOverlay();
  }

  Future<void> updateAndShareConfiguration(CallOverlayConfig config) async {
    await FloatingWindowAndroid.shareData({
      "configType": "callerIdStyle",
      ...config.toMap(),
    });
  }
}
