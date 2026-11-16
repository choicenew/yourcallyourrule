import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:yourcallyourrule/features/common/base/base_call_handler.dart';
import 'package:yourcallyourrule/features/phone_evaluators/config/intercept_action_config_provider.dart';
import 'intercept_event_provider.dart';

part 'end_call_handler.g.dart';

@Riverpod(keepAlive: true)
EndCallHandler endCallHandler(Ref ref) {
  return EndCallHandler(ref);
}

class EndCallHandler implements BaseCallHandler {
  final Ref _ref;
  final Map<String, InterceptAction> _injectedActionsByPhone = {};
  InterceptAction? _fallbackInjectedAction;

  EndCallHandler(this._ref);

  void setInjectedActionForPhone(String phoneNumber, InterceptAction? action) {
    if (action != null) {
      _injectedActionsByPhone[phoneNumber] = action;
    } else {
      _injectedActionsByPhone.remove(phoneNumber);
    }
  }

  void setInjectedAction(InterceptAction? action) {
    _fallbackInjectedAction = action;
  }

  @override
  Future<String?> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onEndCallInitializationComplete":
        _handleInitializationComplete();
        return null;
      case "interceptAction":
        final phoneNumber = call.arguments as String? ?? '';
        final actionName = await _handleInterceptAction(phoneNumber);
        
        if (actionName != null) {
          debugPrint("📢 [EndCallHandler] Broadcasting intercept event for $phoneNumber with raw action name: $actionName");
          _ref.read(interceptEventStreamControllerProvider).add(
            InterceptEvent(phoneNumber: phoneNumber, actionName: actionName)
          );
        }
        
        return actionName;
      default:
        throw UnimplementedError('EndCallHandler: 未实现的方法: ${call.method}');
    }
  }

  void _handleInitializationComplete() {}

  Future<String?> _handleInterceptAction(String phoneNumber) async {
    final action = _injectedActionsByPhone.remove(phoneNumber) ??
        _fallbackInjectedAction ??
        _ref.read(interceptActionConfigProvider);
    _fallbackInjectedAction = null;
    final actionName = action?.actionName ?? InterceptAction.endCall.actionName;
    debugPrint(">>> [EndCallHandler EXECUTE] Handled intercept action for $phoneNumber: $actionName");
    return actionName;
  }
  
  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}
}

