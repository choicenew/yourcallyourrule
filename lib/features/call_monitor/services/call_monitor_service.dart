import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourcallyourrule/features/call_monitor/events/call_monitor_events.dart';
import 'package:yourcallyourrule/platform/call_channel_switcher.dart';

final callMonitorServiceProvider = Provider<CallMonitorService>((ref) {
  final service = CallMonitorService();
  ref.onDispose(() => service.dispose());
  service.initialize();
  return service;
});

class CallMonitorService {
  final _eventSubject = BehaviorSubject<CallMonitorEvent>();

  Stream<CallMonitorEvent> get eventStream => _eventSubject.stream;

  void initialize() {
    final channelManager = CallChannelSwitcher.getPlatformChannelManager();
    
    channelManager.onCallerIdCall = (MethodCall call) {
      final args = call.arguments is Map ? Map<String, dynamic>.from(call.arguments as Map) : <String, dynamic>{};
      final number = args['phoneNumber']?.toString() ?? args['rawNumber']?.toString() ?? '';
      if (number.isNotEmpty) {
        _eventSubject.add(IncomingCallEvent(
          phoneNumber: number,
          rawHandle: number,
          timestampMs: DateTime.now().millisecondsSinceEpoch,
        ));
      }
    };

    channelManager.onSimCall = (MethodCall call) {
      final args = call.arguments is Map ? Map<String, dynamic>.from(call.arguments as Map) : <String, dynamic>{};
      final number = args['phoneNumber']?.toString() ?? '';
      final slot = (args['slot'] as num?)?.toInt() ?? 0;
      _eventSubject.add(SimInfoEvent(
        phoneNumber: number,
        simSlot: slot,
        carrierName: args['carrier']?.toString(),
        countryIso: args['countryIso']?.toString(),
      ));
    };

    channelManager.onStirCall = (MethodCall call) {
      final args = call.arguments is Map ? Map<String, dynamic>.from(call.arguments as Map) : <String, dynamic>{};
      final number = args['phoneNumber']?.toString() ?? '';
      final status = args['status']?.toString() ?? 'UNKNOWN';
      final isVerified = args['isVerified'] == true;
      _eventSubject.add(StirInfoEvent(
        phoneNumber: number,
        status: status,
        isVerified: isVerified,
      ));
    };

    channelManager.onEndCallCall = (MethodCall call) async {
      final args = call.arguments is Map ? Map<String, dynamic>.from(call.arguments as Map) : <String, dynamic>{};
      final number = args['phoneNumber']?.toString() ?? '';
      _eventSubject.add(CallEndedEvent(
        phoneNumber: number,
        timestampMs: DateTime.now().millisecondsSinceEpoch,
      ));
      return null;
    };

    channelManager.initialize();
    debugPrint('[CallMonitorService] Subscribed to native platform channel events.');
  }

  void dispose() {
    _eventSubject.close();
  }
}
