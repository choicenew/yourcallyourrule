import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:yourcallyourrule/features/call_policy/evaluators/intercept_action.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/intercept_action_config_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/call_log_extension.dart';
import 'package:yourcallyourrule/features/call_monitor/handlers/intercept_event_provider.dart';
import 'base_call_handler.dart';

part 'end_call_handler.g.dart';

@Riverpod(keepAlive: true)
EndCallHandler endCallHandler(Ref ref) {
  return EndCallHandler(ref);
}

class EndCallHandler implements BaseCallHandler {
  final Ref _ref;

  EndCallHandler(this._ref);

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
    final rawAction = CallFilterService.getCurrentInterceptAction();
    if (rawAction != null) {
      final ruleAction = InterceptAction.fromString(rawAction.name);
      setInterceptAction(ruleAction);
      debugPrint("_handleInterceptAction (from rule): ${ruleAction.name}");
      return ruleAction.name;
    }

    final defaultAction = _ref.read(interceptActionConfigProvider);

    debugPrint(">>> [EndCallHandler EXECUTE] Read latest action from provider: $defaultAction");
    setInterceptAction(defaultAction);
    debugPrint("_handleInterceptAction (from global default): ${defaultAction.name}");
    return defaultAction.name;
  }
  
  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}
}
