import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:pyro_phone_call_overlay_hub/pyro_phone_call_overlay_hub.dart';

part 'overlay_handler.g.dart';

@Riverpod(keepAlive: true)
Future<OverlayHandler> overlayHandler(Ref ref) async {
  return OverlayHandler(ref);
}

class OverlayHandler {
  final Ref _ref;

  OverlayHandler(this._ref);

  Future<void> showCallerIdOverlay(
    CallerIdData callerIdData,
    StirInfo? stirInfo,
    SimInfo? simInfo,
  ) async {
    debugPrint('[OverlayHandler] Showing overlay for ${callerIdData.phoneNumber}');
    final name = callerIdData.name;
    final info = (name != null && name.isNotEmpty)
        ? name
        : (callerIdData.labels.isNotEmpty ? callerIdData.labels.join(', ') : '');
    await OverlayControlCenter.instance.showOverlay(callerIdData.phoneNumber, info);
  }

  Future<void> hideCallerIdOverlay() async {
    await OverlayControlCenter.instance.closeOverlay();
  }
}
