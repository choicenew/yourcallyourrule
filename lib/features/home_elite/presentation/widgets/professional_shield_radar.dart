import 'dart:math';
import 'package:flutter/material.dart';

class ProfessionalShieldRadar extends StatefulWidget {
  const ProfessionalShieldRadar({super.key});

  @override
  State<ProfessionalShieldRadar> createState() => _ProfessionalShieldRadarState();
}

class _ProfessionalShieldRadarState extends State<ProfessionalShieldRadar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  // 带有 90° ~ 270° 安全极距保底的真随机错开角：既保证每次进入页面都有独一无二的随机感，又 100% 确保内外圈起点不会碰撞
  late final double _phaseOffset;

  @override
  void initState() {
    super.initState();
    // 随机生成 90° 到 270° 之间的错开角度 (1.57 ~ 4.71 弧度)
    final randomDegree = 90.0 + Random().nextDouble() * 180.0;
    _phaseOffset = randomDegree * (pi / 180.0);

    // 匀速循环旋转，3秒一圈
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 110,
        height: 110,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. 核心动态层（独立流转的背景能量光罩 + 高对比呼吸波纹 + 错开起点的外圈刻度 + 独立旋转扫描线）
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(110, 110),
                  painter: _TechRadarPainter(
                    progress: _controller.value,
                    phaseOffset: _phaseOffset,
                  ),
                );
              },
            ),

            // 2. 中心盾牌主体（高对比晶透高光盾）
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF2DD4BF), Color(0xFF10B981)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.55),
                    blurRadius: 18,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.verified_user_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechRadarPainter extends CustomPainter {
  final double progress;
  final double phaseOffset;

  _TechRadarPainter({
    required this.progress,
    required this.phaseOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2;

    // --- 0. 基础角度计算 ---
    // 内圈扫描实线：顺时针 3 秒/圈独立旋转 (0 -> 2π)
    final startAngle = progress * 2 * pi;
    const sweepAngle = pi * 0.75; // 约 135 度的扫描弧长
    final headAngle = startAngle + sweepAngle;

    // --- A. 最底层动态能量呼吸背景光晕 (大大提升深色模式下的对比度) ---
    final glowSine = (sin(progress * 2 * pi) + 1.0) / 2.0; // 0.0 ~ 1.0
    final glowRadius = 38.0 + glowSine * 8.0; // 38 ~ 46 像素半径
    final glowAlpha = 0.25 + glowSine * 0.25; // 0.25 ~ 0.50 透明度大幅提升，深色背景极度清晰

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF10B981).withValues(alpha: glowAlpha),
          const Color(0xFF2DD4BF).withValues(alpha: glowAlpha * 0.6),
          Colors.transparent,
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: glowRadius));

    canvas.drawCircle(center, glowRadius, glowPaint);

    // --- B. 高对比深色清晰的能量呼吸波纹线 (Energy Ripple Line) ---
    // 大幅提升不透明度和线宽，增加发光阴影，确保深色背景下非常醒目
    final rippleProgress = (progress * 1.5) % 1.0; 
    final rippleRadius = 26.0 + rippleProgress * 22.0; // 从盾牌边缘 (26) 扩散到 (48)
    final rippleAlpha = (1.0 - rippleProgress) * 0.65; // 提高最高透明度到 0.65

    if (rippleProgress > 0) {
      // 呼吸线外发光阴影
      final rippleGlowPaint = Paint()
        ..color = const Color(0xFF2DD4BF).withValues(alpha: rippleAlpha * 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5;
      canvas.drawCircle(center, rippleRadius, rippleGlowPaint);

      // 呼吸线核心亮线
      final ripplePaint = Paint()
        ..color = const Color(0xFF34D399).withValues(alpha: rippleAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(center, rippleRadius, ripplePaint);
    }

    // --- C. 外圈刻度盘：完全独立的慢速逆时针流转 (7.5秒一圈) + 初始起点大幅错开 150 度 ---
    // 使用真实时间戳保证外圈转速独立且永不蹦跳跳变
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final tickBaseRotation = -(nowMs / 7500.0) * 2 * pi + phaseOffset; 
    const int tickCount = 60; // 60 个钟表级微刻度

    for (int i = 0; i < tickCount; i++) {
      final isMajor = (i % 5 == 0);
      final tickAngle = (i * 2 * pi) / tickCount + tickBaseRotation;

      // 计算该刻度线相对于扫描探头 (headAngle) 的拖尾角距离 (0 ~ 2pi)
      double delta = (headAngle - tickAngle) % (2 * pi);
      if (delta < 0) delta += 2 * pi;

      // 根据角距离计算高亮系数
      double intensity = 0.30; // 提高深色模式下的基础刻度可见度
      if (delta <= sweepAngle * 1.1) {
        final factor = 1.0 - (delta / (sweepAngle * 1.1));
        intensity = 0.30 + 0.70 * pow(factor, 1.5);
      }

      final tickLength = isMajor ? (5.0 + intensity * 2.0) : (2.5 + intensity * 1.0);
      
      final tickPaint = Paint()
        ..color = Color.lerp(
          const Color(0xFF10B981).withValues(alpha: intensity * 0.55),
          const Color(0xFF34D399).withValues(alpha: intensity),
          intensity,
        )!
        ..strokeWidth = isMajor ? (1.5 + intensity * 0.8) : (1.0 + intensity * 0.5)
        ..strokeCap = StrokeCap.round;

      final p1 = Offset(
        center.dx + (maxR - 2) * cos(tickAngle),
        center.dy + (maxR - 2) * sin(tickAngle),
      );
      final p2 = Offset(
        center.dx + (maxR - 2 - tickLength) * cos(tickAngle),
        center.dy + (maxR - 2 - tickLength) * sin(tickAngle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    // --- D. 中间层：动态流光导轨底圈 ---
    final trackRadius = maxR - 14;
    final trackPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, trackRadius, trackPaint);

    // --- E. 核心层：内圈独立 3 秒旋转扫描实线 ---
    final arcPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.8;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: trackRadius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );

    // --- F. 弧线头部的发光探头圆点 ---
    final dotX = center.dx + trackRadius * cos(headAngle);
    final dotY = center.dy + trackRadius * sin(headAngle);
    final dotCenter = Offset(dotX, dotY);

    // 探头外发光光圈
    final haloPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dotCenter, 6.5, haloPaint);

    // 探头核心实心点
    final dotPaint = Paint()
      ..color = const Color(0xFF34D399)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dotCenter, 3.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _TechRadarPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.phaseOffset != phaseOffset;
  }
}