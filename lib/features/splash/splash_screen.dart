import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  bool _isFirstLaunch = true;
  bool _isVipUser = false;
  bool _hasNavigated = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  static const Duration _minSplashDuration = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    await Future.wait([
      _checkFirstLaunch(),
      _checkVipStatus(),
      Future.delayed(_minSplashDuration),
    ]);

    _navigateToNextScreen();
  }

  Future<void> _checkFirstLaunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isFirstLaunch = prefs.getBool('first_launch') ?? true;
    } catch (_) {
      _isFirstLaunch = true;
    }
  }

  Future<void> _checkVipStatus() async {
    _isVipUser = false;
  }

  Future<void> _setFirstLaunchComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('first_launch', false);
    } catch (_) {}
  }

  void _navigateToNextScreen() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;

    if (_isFirstLaunch) {
      _setFirstLaunchComplete();
      context.go('/onboarding');
    } else {
      context.go('/');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  width: 200,
                  height: 200,
                  errorBuilder: (c, e, s) => const Icon(Icons.shield_rounded, size: 150, color: Colors.orange),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Your Call Your Rule", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9800))),
            ],
          ),
        ),
      ),
    );
  }
}
