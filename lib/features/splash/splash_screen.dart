import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/initial_setup/providers/initial_setup_provider.dart';

/// 纯粹干净的启动 Splash 页面组件 —— 仅在管线交付后响应基础配置重定向
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isNavigating = false;

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
    _animationController.forward().then((_) {
      _checkAndNavigate();
    });
  }

  Future<void> _checkAndNavigate() async {
    if (_isNavigating || !mounted) return;
    _isNavigating = true;

    try {
      final initialSetupService = ref.read(initialSetupServiceProvider);
      final isInitialSetupCompleted = await initialSetupService.isInitialSetupCompleted();
      if (!mounted) return;

      if (!isInitialSetupCompleted) {
        context.goNamed(AppRouter.initialSetup);
      } else {
        context.go('/');
      }
    } catch (_) {
      if (mounted) {
        context.go('/');
      }
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
    );
  }
}


