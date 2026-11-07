import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/display_mode.dart';
import 'package:yourcallyourrule/features/caller_identity/config/caller_identity_config_repository.dart';
import 'package:yourcallyourrule/features/caller_identity/config/caller_identity_config_provider.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/overlay_handler.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/kit_live_activity_handler.dart';

part 'display_mode_handler.g.dart';

@Riverpod(keepAlive: true)
Future<DisplayModeHandler> displayModeHandler(Ref ref) async {
  final configRepository = ref.watch(callerIdConfigRepositoryProvider);
  final handler = DisplayModeHandler(
    ref: ref,
    configRepository: configRepository,
  );
  await handler.initialize();
  return handler;
}

class DisplayModeHandler {
  final Ref _ref;
  final CallerIdConfigRepository _configRepository;

  DisplayModeHandler({
    required Ref ref,
    required CallerIdConfigRepository configRepository,
  }) : _ref = ref,
       _configRepository = configRepository;

  Future<void> initialize() async {
    final initialMode = await _configRepository.getDisplayMode();
    await _manageEngineLifecycle(initialMode);
  }

  Future<void> _manageEngineLifecycle(DisplayMode mode) async {
    if (mode == DisplayMode.overlay) {
      debugPrint("Initializing FloatingWindowAndroid engine...");
      await FloatingWindowAndroid.initialize();
    } else {
      debugPrint("Disposing FloatingWindowAndroid engine...");
      await FloatingWindowAndroid.dispose();
    }
  }

  Future<void> showCallerIdInfo(
    CallerIdData callerIdData,
    StirInfo? stirInfo,
    SimInfo? simInfo,
  ) async {
    final currentDisplayMode = await _configRepository.getDisplayMode();
    await _manageEngineLifecycle(currentDisplayMode);

    switch (currentDisplayMode) {
      case DisplayMode.overlay:
        final overlayHandler = _ref.read(overlayHandlerProvider);
        await overlayHandler.showCallerIdOverlay(
          callerIdData,
          stirInfo,
          simInfo,
        );
        break;

      case DisplayMode.notification:
        final notificationHandler = await _ref.read(
          notificationHandlerProvider.future,
        );
        await notificationHandler.showCallerIdNotification(
          callerIdData: callerIdData,
          simInfo: simInfo,
          stirInfo: stirInfo,
        );
        break;

      case DisplayMode.liveActivity:
        final kitHandler = await _ref.read(
          kitLiveActivityHandlerProvider.future,
        );
        await kitHandler.showCallerIdActivity(
          callerIdData: callerIdData,
          simInfo: simInfo,
          stirInfo: stirInfo,
        );
        break;
    }
  }

  Future<void> closeDisplay() async {
    final overlayHandler = _ref.read(overlayHandlerProvider);
    final kitHandler = await _ref.read(
      kitLiveActivityHandlerProvider.future,
    );

    overlayHandler.closeOverlay();
    await kitHandler.endActivity();
  }
}
