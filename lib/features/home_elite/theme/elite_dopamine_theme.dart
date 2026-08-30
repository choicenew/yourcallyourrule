import 'package:flutter/material.dart';

/// Elite 多巴胺设计系统配色方案与视觉规范
class EliteDopamineTheme {
  // --- 核心多巴胺主色调 ---
  static const Color emeraldGreen = Color(0xFF00E676);    // 守护能量绿
  static const Color neonCyan = Color(0xFF00E5FF);        // 科技冰川青
  static const Color electricViolet = Color(0xFF7C4DFF);  // 梦幻极光紫
  static const Color sunsetOrange = Color(0xFFFF9100);    // 活力落日橙
  static const Color coralPink = Color(0xFFFF4081);       // 珊瑚警示粉
  static const Color goldAmber = Color(0xFFFFD700);       // 尊贵星耀金

  // --- 活力多巴胺渐变束 ---
  static const LinearGradient shieldActiveGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00E676), Color(0xFF00B0FF), Color(0xFF7C4DFF)],
  );

  static const LinearGradient shieldWarningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9100), Color(0xFFFF5252), Color(0xFFFF4081)],
  );

  static const LinearGradient communityHeroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF651FFF), Color(0xFF3D5AFE), Color(0xFF00E5FF)],
  );

  static const LinearGradient statsCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF6D00), Color(0xFFFFAB00), Color(0xFFFFD600)],
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E1E2E), Color(0xFF181825)],
  );

  // --- 卡片样式与阴影 ---
  static BoxDecoration dopamineCardDecoration({
    required BuildContext context,
    Color? baseColor,
    Gradient? gradient,
    BorderRadius? borderRadius,
    Color? glowColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultRadius = borderRadius ?? BorderRadius.circular(24);

    return BoxDecoration(
      color: gradient == null
          ? (baseColor ?? (isDark ? const Color(0xFF1E1E2E) : Colors.white))
          : null,
      gradient: gradient,
      borderRadius: defaultRadius,
      border: Border.all(
        color: isDark
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.black.withValues(alpha: 0.05),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: (glowColor ?? (isDark ? Colors.black : Colors.blueGrey))
              .withValues(alpha: isDark ? 0.35 : 0.08),
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 1,
        ),
      ],
    );
  }
}
