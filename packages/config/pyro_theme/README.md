# 🎨 PyroTheme - FlexColorScheme, Dynamic Color, High Contrast & Design Tokens Package

`pyro_theme` 是基于 **pub.dev 顶级开源主题与美学包** 深度吸收、集成持久化存储、无障碍高对比度 (High Contrast)、自定义 Brand Theme、设计令牌扩展与 Android 12+ 原生 Dynamic Color 壁纸取色的一站式主题微包。

---

## 🌟 核心功能一览

1. **真实接入 Android 12+ / Material You 原生取色**：通过 `DynamicThemeScope` 与 `DynamicColorBuilder` 捕获系统动态调色板并注入 `FlexColorScheme`。
2. **无障碍高对比度 (High Contrast)**：支持无障碍高对比度亮色与暗色模式。
3. **全量硬核 Design Tokens**：提供包含 Spacing (xs~xxl)、Radius (sm~xl)、Animation Durations (fast/normal/slow)、Curves 与 Glassmorphism 参数的 `DesignTokensThemeExtension`。
4. **SharedPreferences 自动持久化 & 防闪烁预加载**：用户选择的主题模式（Light/Dark/System）、FlexScheme 预设、True Black OLED、Primary Swap、High Contrast、FontFamily 与 TextScaleFactor 在重启后**自动恢复**。
5. **平滑过渡动画**：内置 `AnimatedThemeScope`，切换主题时享受顺滑过渡。
6. **与 Riverpod 3.0 无缝整合**，提供 `lightThemeProvider`、`darkThemeProvider` 与 `DynamicThemeScope` 开箱即用支持。

---

## 🚀 快速使用代码示例

### 1. 配置 App 根节点 (`DynamicThemeScope` & `AnimatedThemeScope`)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_theme/pyro_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicThemeScope(
      builder: (context, lightTheme, darkTheme, themeMode) {
        return MaterialApp(
          title: 'Pyro Theme App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: const AnimatedThemeScope(
            child: HomeScreen(),
          ),
        );
      },
    );
  }
}
```

### 2. 动态切换主题与高对比度控制

```dart
// 切换主题模式 (Light / Dark / System)
ref.read(themePreferenceProvider.notifier).setThemeMode(ThemeMode.dark);

// 开启/关闭无障碍高对比度模式
ref.read(isHighContrastProvider.notifier).toggleHighContrast(true);

// 切换 40+ 种 FlexScheme 预设
ref.read(flexSchemeProvider.notifier).setFlexScheme(FlexScheme.sakura);

// 开关 OLED True Black 纯黑模式
ref.read(isTrueBlackProvider.notifier).toggleTrueBlack(true);

// 动态设置 App 字体与字号缩放
ref.read(fontFamilyProvider.notifier).setFontFamily('Roboto');
ref.read(textScaleFactorProvider.notifier).setTextScaleFactor(1.1);
```
