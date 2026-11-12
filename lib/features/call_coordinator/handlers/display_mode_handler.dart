import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';

part 'display_mode_handler.g.dart';

@Riverpod(keepAlive: true)
Future<DisplayModeHandler> displayModeHandler(Ref ref) async {
  return DisplayModeHandler(ref);
}

class DisplayModeHandler {
  final Ref _ref;

  DisplayModeHandler(this._ref);

  Future<void> handleDisplayMode(
    CallerIdData callerIdData, {
    StirInfo? stirInfo,
    SimInfo? simInfo,
  }) async {
    debugPrint('[DisplayModeHandler] Processing display mode for ${callerIdData.phoneNumber}');
  }
}
