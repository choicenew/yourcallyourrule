import 'package:flutter/material.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 定义一个 StateNotifier
// 这个类持有我们的状态 (ThemeMode)，并提供一个方法来改变它。
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  // 构造函数：我们通过 `super()` 来设置初始状态。
  // 默认使用系统主题模式。
  ThemeModeNotifier() : super(ThemeMode.system);

  // 公共方法：UI 可以调用这个方法来更新主题模式。
  void setThemeMode(ThemeMode mode) {
    // 当我们给 `state` 赋一个新值时，Riverpod 会自动通知所有监听者。
    state = mode;
  }
}


// 2. 创建一个全局的 StateNotifierProvider
// 这是我们在整个 App 中用来访问 ThemeModeNotifier 的东西。
// 它是一个全局常量，所以可以在任何地方使用。
final themeModeNotifierProvider = 
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  // 这个函数告诉 Riverpod 如何创建我们的 ThemeModeNotifier。
  // 它只会在第一次被使用时调用一次。
  return ThemeModeNotifier();
});