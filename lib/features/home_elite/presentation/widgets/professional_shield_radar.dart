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

  @override
  void initState() {
    super.initState();
    // 匀速循环旋转，3秒一圈，平缓沉稳，显得非常可靠
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
            // 1. 最底层微弱绿色光晕底座（营造立体呼吸感）
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF10B981).withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // 2. 核心动画层（刻度圈 + 旋转扫描弧线 + 扫描点）
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(100, 100),
                  painter: _TechRadarPainter(_controller.value),
                );
              },
            ),

            // 3. 中心盾牌主体（静态，不参与每帧重绘）
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
                    color: const Color(0xFF10B981).withValues(alpha: 0.35),
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
  _TechRadarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2;

    // --- A. 绘制最外圈仪表盘刻度线 (极其显专业) ---
    final tickPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.35)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    const int tickCount = 60; // 60个微小刻度
    for (int i = 0; i < tickCount; i++) {
      final angle = (i * 2 * pi) / tickCount;
      // 长短相间的仪表盘细节
      final tickLength = (i % 5 == 0) ? 4.5 : 2.0; 
      final p1 = Offset(
        center.dx + (maxR - 2) * cos(angle),
        center.dy + (maxR - 2) * sin(angle),
      );
      final p2 = Offset(
        center.dx + (maxR - 2 - tickLength) * cos(angle),
        center.dy + (maxR - 2 - tickLength) * sin(angle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    // --- B. 中间层：静态淡绿导轨轨道 ---
    final trackRadius = maxR - 14;
    final trackPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, trackRadius, trackPaint);

    // --- C. 动态层：带旋转的扫描弧线 ---
    final startAngle = progress * 2 * pi;
    const sweepAngle = pi * 0.75; // 约 135 度的扫描弧长

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

    // --- D. 弧线头部的发光探头圆点 ---
    final headAngle = startAngle + sweepAngle;
    final dotX = center.dx + trackRadius * cos(headAngle);
    final dotY = center.dy + trackRadius * sin(headAngle);
    final dotCenter = Offset(dotX, dotY);

    // 探头外发光光圈
    final haloPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dotCenter, 5.5, haloPaint);

    // 探头核心实心点
    final dotPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dotCenter, 3.0, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _TechRadarPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}