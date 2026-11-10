import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'base_call_handler.dart';

part 'stir_call_handler.g.dart';

@Riverpod(keepAlive: true)
class StirCallHandler extends _$StirCallHandler implements BaseCallHandler {
  @override
  StirInfo? build() {
    ref.onDispose(() {});
    return null;
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}

  @override
  dynamic handleMethodCall(MethodCall call) {
    switch (call.method) {
      case "onStirInitializationComplete":
        return _handleInitializationComplete();
      case "onStirResult":
        return _handleStirResult(
          call.arguments['isVerified'],
          call.arguments['isNotVerified'],
          call.arguments['isFailed'],
          call.arguments['phoneNumber'],
        );
      default:
        throw UnimplementedError('StirCallHandler: 未实现的方法: ${call.method}');
    }
  }

  void _handleInitializationComplete() {}

  void _handleStirResult(
    dynamic isVerified,
    dynamic isNotVerified,
    dynamic isFailed,
    dynamic phoneNumber,
  ) {
    final bool verified = isVerified is bool ? isVerified : false;
    final bool notVerified = isNotVerified is bool ? isNotVerified : false;
    final bool failed = isFailed is bool ? isFailed : false;
    final String? phoneNum = phoneNumber is String ? phoneNumber : null;

    final newStirInfo = <String, dynamic>{
      'isVerified': verified,
      'isNotVerified': notVerified,
      'isFailed': failed,
      'phoneNumber': phoneNum,
    };

    state = newStirInfo;
  }
}
