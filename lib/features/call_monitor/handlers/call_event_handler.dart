import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/platform/call_channel_switcher.dart';

import 'base_call_handler.dart';
import 'incoming_call_handler.dart';
import 'outgoing_call_handler.dart';

class CallEventHandler extends BaseCallHandler {
  final CallChannelInterface _channelManager;
  final IncomingCallHandler _incomingCallHandler;
  final OutgoingCallHandler _outgoingCallHandler;
  final Function(CallerIdData) _onCallerIdDataReceived;
  
  CallEventHandler(
    this._channelManager,
    dynamic _, {
    required IncomingCallHandler incomingCallHandler,
    required OutgoingCallHandler outgoingCallHandler,
    Function(CallerIdData)? onCallerIdDataReceived,
  }) : 
    _incomingCallHandler = incomingCallHandler,
    _outgoingCallHandler = outgoingCallHandler,
    _onCallerIdDataReceived = onCallerIdDataReceived ?? ((data) {});

  @override
  dynamic handleMethodCall(MethodCall call) async {
    final int? timestamp = (call.arguments is Map) ? call.arguments['timestamp'] as int? : null;

    switch (call.method) {
      case "onCallerIdInitializationComplete":
        return await _handleInitializationComplete();
      case 'onIncomingCall':
        debugPrint("onIncomingCall-timestamp: $timestamp");
        return await _handleIncomingCall(call.arguments['phoneNumber'], timestamp);
      case 'onCallEnded':
        debugPrint("onCallEnded-timestamp: $timestamp");
        return _handleCallEnded(timestamp);
      case 'onCallAnswered':
        debugPrint("onCallAnswered-timestamp: $timestamp");
        return _handleCallAnswered(timestamp);
      case 'onOutgoingCall':
        return await _handleOutgoingCall(call.arguments['phoneNumber'], timestamp);
      default:
        throw UnimplementedError('未实现的方法: ${call.method}');
    }
  }

  Future<void> _handleInitializationComplete() async {
    await _channelManager.initializeCallerId();
  }

  Future<void> _handleIncomingCall(String phoneNumber, int? timestamp) async {
    await _incomingCallHandler.processIncomingCall(phoneNumber, _onCallerIdDataReceived);
  }

  void _handleCallEnded(int? timestamp) {}
  void _handleCallAnswered(int? timestamp) {}

  Future<void> _handleOutgoingCall(String phoneNumber, int? timestamp) async {
    await _outgoingCallHandler.processOutgoingCall(phoneNumber, _onCallerIdDataReceived);
  }
}
