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

    // --- 0. 基础角度计算 ---
    final startAngle = progress * 2 * pi;
    const sweepAngle = pi * 0.75; // 约 135 度的扫描弧长
    final headAngle = startAngle + sweepAngle;

    // --- A. 动态绘制最外圈仪表盘刻度线（慢速逆时针自转 + 扫描线实时划过高亮余晖）---
    // 外圈钟表刻度盘以慢速逆时针自转，呈现陀螺仪机械仪表感
    final tickBaseRotation = -progress * 2 * pi * 0.25; 
    const int tickCount = 60; // 60 个钟表级微刻度

    for (int i = 0; i < tickCount; i++) {
      final isMajor = (i % 5 == 0);
      // 计算刻度线当前旋转后的实际角度
      final tickAngle = (i * 2 * pi) / tickCount + tickBaseRotation;

      // 计算该刻度线相对于扫描探头 (headAngle) 的拖尾角距离 (0 ~ 2pi)
      double delta = (headAngle - tickAngle) % (2 * pi);
      if (delta < 0) delta += 2 * pi;

      // 根据角距离计算高亮系数 (当处于 135 度扫描弧线及拖尾区时高亮衰减，其余保持精致暗光)
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

    // --- B. 中间层：动态流光轨道底圈 ---
    final trackRadius = maxR - 14;
    final trackPaint = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, trackRadius, trackPaint);

    // --- C. 核心层：带旋转的扫描弧线 ---
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
    return oldDelegate.progress != progress;
  }
}