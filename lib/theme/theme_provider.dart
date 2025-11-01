import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

// 1. 定义一个 Notifier
// 这个类持有我们的状态 (ThemeMode)，并提供一个方法来改变它。
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  // 构建初始状态：默认使用系统主题模式。
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  // 公共方法：UI 可以调用这个方法来更新主题模式。
  void setThemeMode(ThemeMode mode) {
    // 当我们给 `state` 赋一个新值时，Riverpod 会自动通知所有监听者。
    state = mode;
  }
}