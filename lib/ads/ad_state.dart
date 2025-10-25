// ad_state.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ad_state.g.dart';

// 使用 @Riverpod 注解，并设置为 keepAlive
@Riverpod(keepAlive: true)
class AdState extends _$AdState {
  // 初始状态为广告启用
  @override
  bool build() {
    return true;
  }

  // 获取当前广告状态
  bool get isAdEnabled => state;

  // 禁用广告
  void disableAds() {
    state = false;
  }

  // 启用广告
  void enableAds() {
    state = true;
  }
}