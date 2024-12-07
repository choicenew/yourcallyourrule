import 'package:flutter/material.dart';
import '../new_set_icons.dart';
import '../shared/const/theme_config.dart';

// 定义描边样式
const BorderSide borderStyle = BorderSide(width: 2);

// 定义 Shield Switch 样式
final ThemeData shieldSwitchThemeData = ThemeData(
  // 通过 colorScheme 定义不同状态下的颜色

).copyWith( // 使用 copyWith() 方法
  switchTheme: SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.outlineVariant; // Use outlineVariant for on state
        }
        return flexSchemeLight.outline; // Use outline for off state
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.primaryContainer; // Use outlineVariant for on state
        }
        return flexSchemeLight.surfaceContainerHighest; // Use outline for off state
      }),
    thumbIcon: shieldThumbIcon, // 设置 thumbIcon
  ),
);

// 先定义独立的 switch theme 配置
final SwitchThemeData shieldSwitchTheme = SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.outlineVariant; // Use outlineVariant for on state
        }
        return flexSchemeLight.outline; // Use outline for off state
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.primaryContainer; // Use outlineVariant for on state
        }
        return flexSchemeLight.surfaceContainerHighest; // Use outline for off state
      }),
    thumbIcon: shieldThumbIcon, // 设置 thumbIcon
  );


// 定义 MaterialStateProperty for thumb icon based on switch state
final WidgetStateProperty<Icon?> shieldThumbIcon =
  WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return const Icon(NewSet.whitelist_fill, color: Color(0xffffb59d)); // Use shield_on icon for on state with white color
    }
    return const Icon(NewSet.blacklist_fill, color: Colors.white); // Use shield_off icon for off state with grey color
  });








final ThemeData switchThemeData = ThemeData(
  ).copyWith(
    switchTheme: SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.outlineVariant; // Use outlineVariant for on state
        }
        return flexSchemeLight.outline; // Use outline for off state
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.primaryContainer; // Use outlineVariant for on state
        }
        return flexSchemeLight.surfaceContainerHighest; // Use outline for off state
      }),
      thumbIcon: switchThumbIcon, 
    ),
  );

// 先定义独立的 switch theme 配置
final SwitchThemeData switchTheme = SwitchThemeData(
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.outlineVariant; // Use outlineVariant for on state
        }
        return flexSchemeLight.outline; // Use outline for off state
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return flexSchemeLight.primaryContainer; // Use outlineVariant for on state
        }
        return flexSchemeLight.surfaceContainerHighest; // Use outline for off state
      }),
      thumbIcon: switchThumbIcon, 
    );



  final WidgetStateProperty<Icon?> switchThumbIcon =
  WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return const Icon(NewSet.check, color: Color.fromARGB(255, 0, 0, 0)); // Use shield_on icon for on state with white color
    }
    return const Icon(NewSet.close, color: Colors.white); // Use shield_off icon for off state with grey color
  });


// 然后创建一个类来应用这个配置，同时保持系统主题
class AppSwitchTheme {
  static ThemeData apply(BuildContext context, SwitchThemeData switchTheme) {
    return Theme.of(context).copyWith(
      switchTheme: switchTheme,
    );
  }
}





