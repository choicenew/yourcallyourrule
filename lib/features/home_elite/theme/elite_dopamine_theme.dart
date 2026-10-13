import 'package:flutter/material.dart';

/// Elite 多巴胺亮色与暖色调设计系统（标准主题设计规范，全局可重用设计 Token）
class EliteDopamineTheme {
  // --- 暖色多巴胺核心主色 ---
  static const Color warmSunAmber = Color(0xFFFFB300);    // 阳光暖琥珀
  static const Color vibrantCoral = Color(0xFFFF6E6A);    // 活力珊瑚粉
  static const Color freshMint = Color(0xFF00E676);       // 清新薄荷绿
  static const Color sunsetTangerine = Color(0xFFFF9100); // 暖阳落日橙
  static const Color softLilac = Color(0xFFBA68C8);       // 柔和香芋紫
  static const Color skyAzure = Color(0xFF29B6F6);        // 晴空晴蓝

  // --- 高级通透文本颜色体系 (Slate 调性) ---
  static const Color textPrimary = Color(0xFF0F172A);   // 深色主文本 (Slate 900)
  static const Color textSecondary = Color(0xFF64748B); // 次要副文本 (Slate 500)
  static const Color textMuted = Color(0xFF94A3B8);     // 弱化占位文本 (Slate 400)
  static const Color textBody = Color(0xFF334155);      // 正文内容文本 (Slate 700)

  // --- 表面与冷灰边框体系 ---
  static const Color warmCanvasBackground = Color(0xFFFBF9F5); // 温暖米白画布底色
  static const Color cardSurface = Colors.white;               // 纯净卡片表面
  static const Color slateSurface = Color(0xFFF8FAFC);          // 通透冷灰表面 (Slate 50)
  static const Color slateSubtle = Color(0xFFF1F5F9);           // 次级冷灰小胶囊 (Slate 100)
  static const Color slateBorder = Color(0xFFE2E8F0);           // 标准精细冷灰边框 (Slate 200)
  static const Color slateMediumBorder = Color(0xFFCBD5E1);     // 中度冷灰边框 (Slate 300)

  // --- 功能性指标色彩 Token ---
  static const Color redBadgeBg = Color(0xFFFEF2F2);   // 红色警示背景
  static const Color redIcon = Color(0xFFEF4444);      // 红色图标/数值
  static const Color amberBadgeBg = Color(0xFFFFFBEB); // 琥珀/规则背景
  static const Color amberIcon = Color(0xFFD97706);    // 琥珀图标/数值
  static const Color amberBorder = Color(0xFFF59E0B);  // 金色高亮边框

  // --- 多巴胺暖光渐变束 ---
  static const LinearGradient heroWarmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9100), Color(0xFFFFB300), Color(0xFFFFE082)],
  );

  static const LinearGradient shieldMintGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2DD4BF), Color(0xFF10B981)],
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

  static const LinearGradient orangeActionGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF97316), Color(0xFFEA580C)],
  );

  // --- 全局卡片与容器通用装饰 Style ---

  /// 标准高质感卡片装饰 (纯白底色 + 微阴影 + 精细边框)
  static BoxDecoration cleanCardDecoration({
    BorderRadius? borderRadius,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: cardSurface,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(
        color: borderColor ?? slateBorder,
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  /// 嵌合控制台容器装饰 (通透冷灰 Slate 背景)
  static BoxDecoration insetConsoleDecoration({
    BorderRadius? borderRadius,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: slateSurface,
      borderRadius: borderRadius ?? BorderRadius.circular(18),
      border: Border.all(
        color: borderColor ?? slateBorder,
        width: 1.0,
      ),
    );
  }

  /// 搜索与极速验证框装饰 (纯白 + 金精细边框 + 微光晕)
  static BoxDecoration amberSearchBoxDecoration({
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: cardSurface,
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      border: Border.all(
        color: amberBorder,
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: amberBorder.withValues(alpha: 0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// 暖色多巴胺卡片外壳装饰
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
