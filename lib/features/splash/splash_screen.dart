import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_app_launch_guard/pyro_app_launch_guard.dart';

/// 纯粹的启动 Splash 动画与 Logo 展示屏 —— 启动管线全量下沉委派给 pyro_app_launch_guard
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PyroAppLaunchGuard(
      splashBuilder: (context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Image.asset(
                    "assets/app_logo.png",
                    width: 180,
                    height: 180,
                    errorBuilder: (c, e, s) => const Icon(Icons.shield_rounded, size: 120, color: Colors.orange),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Your Call Your Rule",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9800)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
