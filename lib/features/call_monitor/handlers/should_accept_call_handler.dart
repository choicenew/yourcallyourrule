import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'base_call_handler.dart';

part 'should_accept_call_handler.g.dart';

@Riverpod(keepAlive: true)
ShouldAcceptCallHandler shouldAcceptCallHandler(Ref ref) {
  return ShouldAcceptCallHandler();
}

class ShouldAcceptCallHandler extends BaseCallHandler {
  StreamController<bool>? _currentDecisionController;

  @override
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onShouldAcceptCallInitializationComplete':
        return;
      case 'shouldAcceptCall':
        return await _handleShouldAcceptCall();
      default:
        throw UnimplementedError('ShouldAcceptCallHandler: 未实现的方法: ${call.method}');
    }
  }

  Future<bool> _handleShouldAcceptCall() async {
    _currentDecisionController = StreamController<bool>();
    final result = await _currentDecisionController!.stream.first;
    await _currentDecisionController!.close();
    _currentDecisionController = null;
    debugPrint("_handleShouldAcceptCall decision returned: $result");
    return result;
  }

  void sendDecision(bool shouldAccept) {
    _currentDecisionController?.add(shouldAccept);
  }

  @override
  Future<void> dispose() async {
    if (_currentDecisionController != null && !_currentDecisionController!.isClosed) {
      await _currentDecisionController!.close();
    }
    _currentDecisionController = null;
    super.dispose();
  }
}
