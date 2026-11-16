import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_stir_hub/pyro_stir_hub.dart';

part 'stir_call_handler.g.dart';

@Riverpod(keepAlive: true)
class StirCallHandler extends _$StirCallHandler {
  @override
  StirResultEntity? build() {
    ref.onDispose(() {});
    return null;
  }

  /// 直接委托给 packages/stir 的 StirHub 执行 STIR 验真
  Future<StirResultEntity?> checkStirStatus(String phoneNumber) {
    return StirHub.instance.checkStirStatus(phoneNumber);
  }
}
