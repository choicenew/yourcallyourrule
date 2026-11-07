# 液态玻璃 (Liquid Glass / Glassmorphism) 全局主题集成设计说明书

## 一、 架构核心设计意图 (Original Core Intent)

本主题包 (`pyro_theme` / `pyro_theme_ui`) 的原始核心设计目标是：**将液态高斯玻璃 (Liquid Glass / Glassmorphism) 特效深度整合并下沉到 Flutter 框架全局默认的组件主题 (Component Themes) 之中**。

### 核心预期行为：
1. **全局无感透显**：让主 App 及各个独立微包在直接使用 Flutter 原生 `Card()`、`AlertDialog`、`BottomSheet`、`NavigationBar` 组件时，无需手动包裹 `GlassmorphicContainer`，即可自动继承高斯模糊与半透明液态玻璃质感。
2. **主题参数联动**：通过 `ThemeData` 的 `cardTheme`、`dialogTheme`、`bottomSheetTheme` 联动 `glassBlur` (高斯模糊半径) 与 `glassOpacity` (玻璃不透明度) 参数。

---

## 二、 现状说明与临时调优 (Current Temporary State)

在冷启动与基础真机测试阶段，为了优先保证真机编译通过率以及排查极小概率的底层 Window 容器灰底显露问题，暂时将 `palette_tokens.dart` 中的默认 `cardTheme` / `dialogTheme` 背景恢复为了标准的 Material 3 饱满实色（`colorScheme.surfaceContainerLow`）。

---

## 三、 后续恢复与液态玻璃主题重构测试 SOP (Testing & Restoration SOP)

接手开发者如需对“全局液态玻璃主题覆盖”进行二次测试与效果调优，请按以下步骤恢复并配置：

### 1. 修改 `packages/config/pyro_theme/lib/src/palette_tokens.dart`

在 `_applyGlassmorphicComponentThemes` 方法中将 `cardTheme` 等背景重新绑定为半透明 `glassFillColor`：

```dart
static ThemeData _applyGlassmorphicComponentThemes(
  ThemeData baseTheme, {
  required double glassBlur,
  required double glassOpacity,
  required bool isDark,
}) {
  final glassFillColor = isDark
      ? Colors.black.withValues(alpha: (glassOpacity * 0.95).clamp(0.55, 0.90))
      : Colors.white.withValues(alpha: (glassOpacity * 1.05).clamp(0.65, 0.95));

  final glassBorderColor = Colors.white.withValues(
    alpha: isDark ? 0.25 : 0.50,
  );

  return baseTheme.copyWith(
    cardTheme: baseTheme.cardTheme.copyWith(
      color: glassFillColor, // 👈 重新开启 Card 全局液态玻璃半透明
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: glassBorderColor, width: 1.0),
      ),
    ),
    dialogTheme: baseTheme.dialogTheme.copyWith(
      backgroundColor: isDark
          ? Colors.black.withValues(alpha: (glassOpacity * 1.1).clamp(0.75, 0.95))
          : Colors.white.withValues(alpha: (glassOpacity * 1.15).clamp(0.80, 0.96)),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: glassBorderColor, width: 1.0),
      ),
    ),
    bottomSheetTheme: baseTheme.bottomSheetTheme.copyWith(
      backgroundColor: isDark
          ? Colors.black.withValues(alpha: (glassOpacity * 1.15).clamp(0.80, 0.95))
          : Colors.white.withValues(alpha: (glassOpacity * 1.2).clamp(0.85, 0.98)),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
    ),
    navigationBarTheme: baseTheme.navigationBarTheme.copyWith(
      backgroundColor: baseTheme.colorScheme.surface.withValues(alpha: isDark ? 0.72 : 0.82),
      elevation: 0,
    ),
  );
}
```

### 2. 配套环境要求
- 确保底层 Window / Scaffold 的 `backgroundColor` 设置有明亮或符合美学搭配的背景壁纸/渐变图，避免深灰 Window 底色透过半透明卡片产生灰度偏差。
