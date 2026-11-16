import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_stir_hub/pyro_stir_hub.dart';
import 'package:yourcallyourrule/features/common/base/base_call_handler.dart';

part 'stir_call_handler.g.dart';

@Riverpod(keepAlive: true)
class StirCallHandler extends _$StirCallHandler implements BaseCallHandler {
  @override
  StirResultEntity? build() {
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
        final map = call.arguments is Map ? (call.arguments as Map) : <dynamic, dynamic>{};
        state = StirResultEntity.fromMap(map);
        return null;
      default:
        throw UnimplementedError('StirCallHandler: 未实现的方法: ${call.method}');
    }
  }

  void _handleInitializationComplete() {}

  /// 直接委托给 packages/stir 的 StirHub 执行 STIR 验真
  Future<StirResultEntity?> checkStirStatus(String phoneNumber) {
    return StirHub.instance.checkStirStatus(phoneNumber);
  }
}
