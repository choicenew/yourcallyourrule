import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:rxdart/rxdart.dart';

import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/platform/call_channel_switcher.dart';

import 'package:yourcallyourrule/features/call_monitor/handlers/call_event_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/end_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/incoming_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/outgoing_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/should_accept_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/sim_call_handler.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/stir_call_handler.dart';

part 'caller_id_monitor_service.g.dart';

@Riverpod(keepAlive: true)
BehaviorSubject<CallerIdData> callerIdDataSubject(Ref ref) {
  final subject = BehaviorSubject<CallerIdData>();
  ref.onDispose(() => subject.close());
  return subject;
}

@Riverpod(keepAlive: true)
StreamController<MethodCall> rawCallEventStreamController(Ref ref) {
  final controller = StreamController<MethodCall>.broadcast();
  ref.onDispose(() => controller.close());
  return controller;
}

@Riverpod(keepAlive: true)
class CallerIdMonitorService extends _$CallerIdMonitorService {

  @override
  Future<void> build() async {
    await ref.watch(incomingCallHandlerProvider.future);
    ref.watch(outgoingCallHandlerProvider);
    ref.watch(shouldAcceptCallHandlerProvider);
    ref.watch(endCallHandlerProvider);
    ref.watch(stirCallHandlerProvider);
    ref.watch(simCallHandlerProvider);
    
    final channelManager = CallChannelSwitcher.getPlatformChannelManager();
    channelManager.onCallerIdCall = _handleCallerIdCall;
    channelManager.onShouldAcceptCallCall = _handleShouldAcceptCallCall;
    channelManager.onEndCallCall = _handleEndCallCall;
    channelManager.onStirCall = _handleStirCall;
    channelManager.onSimCall = _handleSimCall;
    
    channelManager.initialize();

    ref.onDispose(() async {
      if (await FloatingWindowAndroid.isShowing()) {
        FloatingWindowAndroid.closeOverlay();
      }
      debugPrint('>>> [MONITOR] CallerIdMonitorService FloatingWindowAndroid.closeOverlay.');
    });

    debugPrint('>>> [MONITOR] CallerIdMonitorService build method completed successfully.');
  }

  Stream<CallerIdData> get callerIdStream => ref.read(callerIdDataSubjectProvider).stream;
  Stream<CallerIdData> get callDataStream => callerIdStream;
  Stream<MethodCall> get rawCallEventStream => ref.read(rawCallEventStreamControllerProvider).stream;

  void _handleCallerIdCall(MethodCall call) async {
    ref.read(rawCallEventStreamControllerProvider).add(call);
    
    final callEventHandler = CallEventHandler(
      CallChannelSwitcher.getPlatformChannelManager(),
      null,
      incomingCallHandler: await ref.read(incomingCallHandlerProvider.future),
      outgoingCallHandler: ref.read(outgoingCallHandlerProvider),
      onCallerIdDataReceived: (data) => ref.read(callerIdDataSubjectProvider).add(data),
    );
    await callEventHandler.handleMethodCall(call);
  }

  Future<bool> _handleShouldAcceptCallCall(MethodCall call) async {
    final handler = ref.read(shouldAcceptCallHandlerProvider);
    return await handler.handleMethodCall(call);
  }

  Future<String?> _handleEndCallCall(MethodCall call) async {
    final handler = ref.read(endCallHandlerProvider);
    return await handler.handleMethodCall(call);
  }

  void _handleStirCall(MethodCall call) {
    final handler = ref.read(stirCallHandlerProvider.notifier);
    handler.handleMethodCall(call);
  }

  void _handleSimCall(MethodCall call) {
    final handler = ref.read(simCallHandlerProvider.notifier);
    handler.handleMethodCall(call);
  }
}