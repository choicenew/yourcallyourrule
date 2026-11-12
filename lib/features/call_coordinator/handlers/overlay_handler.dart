import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';

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
  }

  Future<void> hideCallerIdOverlay() async {}
}
