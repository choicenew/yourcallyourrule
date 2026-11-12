import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';

import 'package:yourcallyourrule/features/call_monitor/services/caller_id_monitor_service.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/intercept_event_provider.dart';

part 'overlay_control_handler.g.dart';

@Riverpod(keepAlive: true)
OverlayControlHandler overlayControlHandler(Ref ref) {
  final monitorService = ref.read(callerIdMonitorServiceProvider);
  final interceptEventController = ref.read(interceptEventStreamControllerProvider);

  final handler = OverlayControlHandler(monitorService, interceptEventController.stream);
  handler.initialize();
  ref.onDispose(() => handler.dispose());

  return handler;
}

class OverlayControlHandler {
  final CallerIdMonitorService _monitorService;
  final Stream<InterceptEvent> _interceptEventStream;

  StreamSubscription<CallerIdData>? _callerIdSubscription;
  StreamSubscription<InterceptEvent>? _interceptEventSubscription;

  OverlayControlHandler(this._monitorService, this._interceptEventStream);

  void initialize() {
    _callerIdSubscription?.cancel(); 
    _interceptEventSubscription?.cancel();
    
    _callerIdSubscription = _monitorService.callerIdStream.listen((data) {
      debugPrint('🖼️ [OverlayControlHandler] Received callerIdStream data');
    });
    _interceptEventSubscription = _interceptEventStream.listen(_handleInterceptEvent);
    
    debugPrint("✅ [OverlayControlHandler] Initialized and listening to callerIdStream and interceptEventStream.");
  }

  void _handleInterceptEvent(InterceptEvent event) {
    debugPrint('🖼️ [OverlayControlHandler] Received intercept event for ${event.phoneNumber}, action: ${event.actionName}');
    switch (event.actionName) {
      case 'endCall':
      case 'answerThenHangup':
      case 'silenceNoAnswer':
        debugPrint('... Intercept event matched. Closing overlay...');
        _closeOverlay();
        break;
      default:
        debugPrint('... Intercept event matched. Closing overlay...');
        _closeOverlay();
    }
  }

  Future<void> _closeOverlay() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await FloatingWindowAndroid.closeOverlay();
    }
  }

  void dispose() {
    _callerIdSubscription?.cancel();
    _interceptEventSubscription?.cancel();
    debugPrint("🗑️ [OverlayControlHandler] Disposed and cancelled all subscriptions.");
  }
}
