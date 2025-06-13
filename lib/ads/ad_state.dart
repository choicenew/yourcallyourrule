// ad_state.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 使用 StateNotifier 替代 ChangeNotifier
class AdState extends StateNotifier<bool> {
  // 初始状态为广告启用
  AdState() : super(true);

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

// 创建 AdState 的 Provider
final adStateProvider = StateNotifierProvider<AdState, bool>((ref) {
  return AdState();
});