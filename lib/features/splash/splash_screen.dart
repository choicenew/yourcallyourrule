// 文件路径: lib/screens/splash_screen.dart (或您存放的位置)
// 这个版本修复了时序竞争问题

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
// 确认路径正确
import 'package:yourcallyourrule/ads/adwidgets/app_open_ad.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  // --- 状态变量 ---
  bool _isFirstLaunch = true;
  bool _hasCompletedSetup = false;
  bool _isVipUser = false;
  bool _hasNavigated = false;
  bool _shouldLoadAd = false;
  
  // --- “双重门锁”控制变量 ---
  bool _minTimeElapsed = false;   // 门锁1: 最小时间是否已到
  bool _adLoadAttempted = false; // 门锁2: 广告加载尝试是否已完成（无论成功或失败）

  // --- UI ---
  late AnimationController _animationController;
  late Animation<double> _animation;

  // --- 广告管理器 ---
  final AppOpenAdManager _appOpenAdManager = AppOpenAdManager.instance;

  // --- 时间配置 ---
  static const Duration _minSplashDuration = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    _initializeAnimation();
    
    // 并行检查用户状态
    await Future.wait([
      _checkFirstLaunch(),
      _checkVipStatus(),
    ]);
    
    // 【核心约束】：如果是 VIP 用户，或者未完成 Onboarding 引导阶段/初始设置阶段，绝对不触发广告！
    _shouldLoadAd = !_isVipUser && !_isFirstLaunch && _hasCompletedSetup;
    debugPrint('初始化完成 - VIP用户: $_isVipUser, 首次启动(Onboarding未完成): $_isFirstLaunch, 初始设置已完成: $_hasCompletedSetup, 是否触发广告: $_shouldLoadAd');
    
    // 启动最小时间门锁
    Timer(_minSplashDuration, () {
      debugPrint('✅ 门锁1: 最小显示时间到达');
      _minTimeElapsed = true;
      _tryNavigate(); // 尝试开锁
    });

    if (_shouldLoadAd) {
      // 尝试加载广告
      debugPrint('开始加载广告...');
      _appOpenAdManager.loadAd().whenComplete(() {
        debugPrint('✅ 门锁2: 广告加载尝试完成 (isAdLoaded: ${_appOpenAdManager.isAdLoaded})');
        _adLoadAttempted = true;
        _tryNavigate(); // 尝试开锁
      });
    } else {
      // 如果不需要加载广告，则直接认为广告门锁已打开
      debugPrint('无需加载广告，广告门锁视为开启');
      _adLoadAttempted = true;
    }
  }

  /// 尝试导航，只有两个门锁都打开时才能通过
  void _tryNavigate() {
    if (_minTimeElapsed && _adLoadAttempted && mounted && !_hasNavigated) {
      debugPrint('🟢 双重门锁开启，开始最终导航决策');
      
      // 如果广告已加载，则显示它。showAdIfAvailable 会处理后续的导航。
      if (_shouldLoadAd && _appOpenAdManager.isAdLoaded) {
        debugPrint('广告已就绪，尝试显示');
        _appOpenAdManager.showAdIfAvailable(
          onAdDismissed: () {
            debugPrint('广告流程结束，导航到下一页');
            _navigateToNextScreen();
          },
        );
      } else {
        // 如果广告未加载或无需广告，则直接导航
        debugPrint('广告未就绪或无需广告，直接导航');
        _navigateToNextScreen();
      }
    } else {
      debugPrint('🟡 等待门锁... (时间到达: $_minTimeElapsed, 广告尝试完成: $_adLoadAttempted)');
    }
  }

  void _navigateToNextScreen() {
    if (!mounted || _hasNavigated) return;
    
    _hasNavigated = true;
    debugPrint('导航到下一页面 - 首次启动: $_isFirstLaunch, 初始设置已完成: $_hasCompletedSetup');
    
    try {
      if (_isFirstLaunch) {
        GoRouter.of(context).goNamed(AppRouter.onboarding);
      } else if (!_hasCompletedSetup) {
        GoRouter.of(context).goNamed(AppRouter.initialSetup);
      } else {
        GoRouter.of(context).goNamed(AppRouter.home);
      }
    } catch (e) {
      debugPrint('导航失败: $e');
    }
  }

  // --- 以下是无需修改的辅助方法 ---

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
    );
    _animationController.forward();
  }

  Future<void> _checkFirstLaunch() async {
    try {
      final configRepo = ref.read(configRepositoryProvider);
      final onboardingConfig = await configRepo.getConfig(AppPrefsKeys.firstLaunch);
      final setupConfig = await configRepo.getConfig(AppPrefsKeys.hasCompletedInitialSetup);

      final bool isOnboardingCompleted = onboardingConfig?['completed'] == true;
      final bool isInitialSetupCompleted = setupConfig?['completed'] == true;

      if (mounted) {
        _isFirstLaunch = !isOnboardingCompleted;
        _hasCompletedSetup = isInitialSetupCompleted;
      }
    } catch (e) {
      if (mounted) {
        _isFirstLaunch = false;
        _hasCompletedSetup = true;
      }
    }
  }
  
  Future<void> _checkVipStatus() async {
    try {
      await Future.delayed(const Duration(milliseconds: 100)); // 等待 a bit for Riverpod
      if (mounted) {
          final purchaseNotifier = ref.read(purchaseStateProvider.notifier);
          await purchaseNotifier.loadState();
          if (mounted) _isVipUser = purchaseNotifier.isPurchasesEnabled;
      }
    } catch (e) {
      if (mounted) _isVipUser = false;
    }
  }

  Future<void> _setFirstLaunchComplete() async {
    try {
      final configRepo = ref.read(configRepositoryProvider);
      await configRepo.saveConfig(AppPrefsKeys.firstLaunch, {'completed': true});
    } catch (_) {}
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
                  width: 200, height: 200,
                  errorBuilder: (c, e, s) => const Icon(Icons.error, size: 150),
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