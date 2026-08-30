import 'package:flutter/material.dart';

/// Elite 多巴胺亮色与暖色调设计系统（绝无暗黑色调，纯粹阳光、温润、活力多巴胺）
class EliteDopamineTheme {
  // --- 暖色多巴胺核心主色 ---
  static const Color warmSunAmber = Color(0xFFFFB300);    // 阳光暖琥珀
  static const Color vibrantCoral = Color(0xFFFF6E6A);    // 活力珊瑚粉
  static const Color freshMint = Color(0xFF00E676);       // 清新薄荷绿
  static const Color sunsetTangerine = Color(0xFFFF9100); // 暖阳落日橙
  static const Color softLilac = Color(0xFFBA68C8);       // 柔和香芋紫
  static const Color skyAzure = Color(0xFF29B6F6);        // 晴空晴蓝

  // --- 暖色与白底背景体系 ---
  static const Color warmCanvasBackground = Color(0xFFFBF9F5); // 温暖米白画布底色
  static const Color cardSurface = Colors.white;               // 纯净卡片表面

  // --- 多巴胺暖光渐变束 ---
  static const LinearGradient heroWarmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9100), Color(0xFFFFB300), Color(0xFFFFE082)],
  );

  static const LinearGradient shieldMintGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00E676), Color(0xFF00B0FF), Color(0xFF80D8FF)],
  );

  static const LinearGradient coralSunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF5252), Color(0xFFFF7043), Color(0xFFFFB74D)],
  );

  static const LinearGradient lilacAzureGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFAB47BC), Color(0xFF7E57C2), Color(0xFF42A5F5)],
  );

  // --- 暖色多巴胺卡片外壳装饰 ---
  static BoxDecoration warmCardDecoration({
    required BuildContext context,
    Color? baseColor,
    Gradient? gradient,
    BorderRadius? borderRadius,
    Color? glowColor,
  }) {
    final defaultRadius = borderRadius ?? BorderRadius.circular(24);
    final accentGlow = glowColor ?? warmSunAmber;

    return BoxDecoration(
      color: gradient == null ? (baseColor ?? cardSurface) : null,
      gradient: gradient,
      borderRadius: defaultRadius,
      border: Border.all(
        color: accentGlow.withValues(alpha: 0.15),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: accentGlow.withValues(alpha: 0.08),
          blurRadius: 18,
          offset: const Offset(0, 6),
          spreadRadius: 1,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
