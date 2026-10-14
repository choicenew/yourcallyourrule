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
  late final double _randomPhaseOffset;

  @override
  void initState() {
    super.initState();
    // 随机生成外圈刻度的初始角度错开相位 (0 ~ 2π)，确保内外圈起点绝对错开
    _randomPhaseOffset = Random().nextDouble() * 2 * pi;

    // 匀速循环旋转，3秒一圈，平缓沉稳
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
            // 1. 核心动态层（背景呼吸能量光晕 + 能量涟漪波纹 + 刻度圈 + 扫描弧线 + 发光探头）
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(110, 110),
                  painter: _TechRadarPainter(
                    progress: _controller.value,
                    phaseOffset: _randomPhaseOffset,
                  ),
                );
              },
            ),

            // 2. 中心盾牌主体（高级玻璃感质感）
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
                    color: const Color(0xFF10B981).withValues(alpha: 0.4),
                    blurRadius: 16,
                    spreadRadius: 2,
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

    // --- 0. 基础角度与周期计算 ---
    // 内圈扫描线：顺时针旋转 (0 -> 2π)
    final startAngle = progress * 2 * pi;
    const sweepAngle = pi * 0.75; // 约 135 度的扫描弧长
    final headAngle = startAngle + sweepAngle;

    // --- A. 最底层动态能量呼吸背景光晕 (Breathing Aura Glow) ---
    // 利用正弦波让背景绿光像生命呼吸一样平滑徐缓扩张与收缩
    final glowSine = (sin(progress * 2 * pi) + 1.0) / 2.0; // 0.0 ~ 1.0
    final glowRadius = 38.0 + glowSine * 8.0; // 38 ~ 46 像素半径 (对应 76 ~ 92 宽度)
    final glowAlpha = 0.12 + glowSine * 0.15; // 0.12 ~ 0.27 透明度律动

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF10B981).withValues(alpha: glowAlpha),
          const Color(0xFF2DD4BF).withValues(alpha: glowAlpha * 0.5),
          Colors.transparent,
        ],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: glowRadius));

    canvas.drawCircle(center, glowRadius, glowPaint);

    // --- B. 动态防护能量波纹 (Energy Ripple Ring) ---
    // 像防御盾牌向外施放能量罩一样，定期从盾牌边缘扩散出微弱的翡翠光环
    final rippleProgress = (progress * 1.5) % 1.0; // 扩散周期进度
    final rippleRadius = 26.0 + rippleProgress * 22.0; // 从盾牌边缘 (26) 扩散到 (48)
    final rippleAlpha = (1.0 - rippleProgress) * 0.22; // 扩散过程中逐渐淡出隐没

    if (rippleProgress > 0) {
      final ripplePaint = Paint()
        ..color = const Color(0xFF34D399).withValues(alpha: rippleAlpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      canvas.drawCircle(center, rippleRadius, ripplePaint);
    }

    // --- C. 外圈刻度盘：逆时针方向旋转，且叠加随机起点相位差 (_phaseOffset) ---
    final tickBaseRotation = -progress * 2 * pi + phaseOffset; 
    const int tickCount = 60; // 60 个钟表级微刻度

    for (int i = 0; i < tickCount; i++) {
      final isMajor = (i % 5 == 0);
      final tickAngle = (i * 2 * pi) / tickCount + tickBaseRotation;

      // 计算该刻度线相对于扫描探头 (headAngle) 的拖尾角距离 (0 ~ 2pi)
      double delta = (headAngle - tickAngle) % (2 * pi);
      if (delta < 0) delta += 2 * pi;

      // 根据角距离计算高亮系数 (当处于 135 度扫描弧线及拖尾区时高亮衰减)
      double intensity = 0.25; // 基准透明度
      if (delta <= sweepAngle * 1.1) {
        final factor = 1.0 - (delta / (sweepAngle * 1.1));
        intensity = 0.25 + 0.75 * pow(factor, 1.5); // 平滑过度的发光衰减曲线
      }

      final tickLength = isMajor ? (4.5 + intensity * 2.0) : (2.0 + intensity * 1.0);
      
      final tickPaint = Paint()
        ..color = Color.lerp(
          const Color(0xFF10B981).withValues(alpha: intensity * 0.4),
          const Color(0xFF34D399).withValues(alpha: intensity),
          intensity,
        )!
        ..strokeWidth = isMajor ? (1.2 + intensity * 0.8) : (0.9 + intensity * 0.4)
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

    // --- D. 中间层：动态流光轨道底圈 ---
    final trackRadius = maxR - 14;
    final trackPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, trackRadius, trackPaint);

    // --- E. 核心层：带旋转的扫描弧线 ---
    final arcPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

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
      ..color = const Color(0xFF10B981).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dotCenter, 6.0, haloPaint);

    // 探头核心实心点
    final dotPaint = Paint()
      ..color = const Color(0xFF34D399)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dotCenter, 3.2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _TechRadarPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.phaseOffset != phaseOffset;
  }
}