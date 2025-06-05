import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/ad_state.dart';
import 'package:yourcallyourrule/ads/ad_control_service.dart';
import 'package:yourcallyourrule/ads/adwidgets/inline_adaptive_ad.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/onboarding/pages/onboarding_page.dart';
import 'package:yourcallyourrule/features/home/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yourcallyourrule/purchase/purchase_provider.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _isFirstLaunch = true;
  bool _isAdLoaded = false;
  bool _isVipUser = false; // 是否为VIP用户
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _splashTimer;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
    _checkVipStatus();
    
    // 初始化动画控制器
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
    
    // 设置最小显示时间，确保启动屏幕不会闪烁
    _splashTimer = Timer(const Duration(milliseconds: 3500), () {
      setState(() {
        _isAdLoaded = true;
      });
      
      // 在适当的时机移除原生启动屏幕
      FlutterNativeSplash.remove();
    });
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirstLaunch = prefs.getBool('first_launch') ?? true;
    });
  }
  
  Future<void> _checkVipStatus() async {
    // 简化VIP状态检查，AdControlService会自动处理广告状态
    try {
      final purchaseProvider = Provider.of<PurchaseProvider>(context, listen: false);
      setState(() {
        _isVipUser = purchaseProvider.purchaseState.isPurchasesEnabled;
      });
      // 不需要手动控制广告状态，AdControlService会自动处理
    } catch (e) {
      // 如果获取失败，默认为非VIP用户
      setState(() {
        _isVipUser = false;
      });
    }
  }

  Future<void> _setFirstLaunchComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_launch', false);
  }

  @override
  Widget build(BuildContext context) {
    final adState = Provider.of<AdState>(context);
    
    return FlutterSplashScreen(
      duration: const Duration(milliseconds: 4000), // 延长显示时间
      nextScreen: _isFirstLaunch 
          ? const OnboardingPage() 
          : const HomePage(),
      backgroundColor: Colors.white,
      onEnd: () {
        if (_isFirstLaunch) {
          _setFirstLaunchComplete();
        }
      },
      splashScreenBody: Stack(
        alignment: Alignment.center,
        children: [
          // 应用 Logo 带动画效果
          FadeTransition(
            opacity: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/app_logo.png",
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Your Call Your Rule",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9800),
                  ),
                ),
                const SizedBox(height: 40),
                // 添加加载指示器
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9800)),
                ),
              ],
            ),
          ),
          
          // 底部广告 - 仅对非VIP用户显示
          if (adState.isAdEnabled && !_isVipUser)
            Positioned(
              bottom: 20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const InlineAdaptiveBannerAdWidget(
                  adInfo: AdManager.adaptiveBannerAd,
                ),
              ),
            ),
        ],
      ),
      // 删除错误的onFinish参数
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _splashTimer?.cancel();
    super.dispose();
  }
}