import 'package:flutter/material.dart';

// 使用一个类来组织主题相关的静态数据，使其更清晰
class AppTheme {
  // 私有构造函数，防止外部实例化
  AppTheme._();

  // 定义亮色主题
  static final ThemeData lightTheme = ThemeData(
    // 推荐在新的 Flutter 项目中使用 Material 3
    useMaterial3: true,
    // 主题亮度
    brightness: Brightness.light,
    // 使用 ColorScheme.fromSeed 可以自动生成一套和谐的颜色方案
    // 它比旧的 primarySwatch 更强大和推荐
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.light,
    ),
    // App Bar 的主题
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white, // AppBar 上的标题和图标颜色
    ),
    // 视觉密度，以适应不同平台的密度
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  // 定义暗色（黑色）主题
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    // 主题亮度
    brightness: Brightness.dark,
    // 基于同一个种子颜色生成暗色方案
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.dark, // 关键！指定为暗色模式
    ),
    // 在暗色模式下，你可能希望 AppBar 有不同的外观
    // 如果不指定，它会根据 ColorScheme 自动调整
    // appBarTheme: AppBarTheme(
    //   backgroundColor: Colors.grey[900], // 举例：深灰色
    // ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}