import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yourcallyourrule/ads/adwidgets/app_open_ad.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  bool _isFirstLaunch = true;
  bool _isVipUser = false;
  bool _isInitialized = false;
  bool _hasNavigated = false;
  
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _splashTimer;
  Timer? _timeoutTimer;
  Timer? _adTimeoutTimer; // 广告加载超时定时器
  bool _adLoadFailed = false;
  bool _shouldLoadAd = false;
  
  // 使用 AppOpenAdManager 来管理开屏广告
  final AppOpenAdManager _appOpenAdManager = AppOpenAdManager.instance;

  // 时间配置
  static const Duration _splashTimeout = Duration(seconds: 6);
  static const Duration _minSplashDuration = Duration(milliseconds: 6500);
  static const Duration _adLoadTimeout = Duration(seconds: 3); // 广告加载超时

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      debugPrint('开始初始化应用...');
      
      // 初始化动画
      _initializeAnimation();
      
      // 并行执行初始化任务
      await Future.wait([
        _checkFirstLaunch(),
        _checkVipStatus(),
      ], eagerError: false); // 即使有错误也继续执行
      
      setState(() {
        _isInitialized = true;
        _shouldLoadAd = !_isVipUser;
      });
      
      debugPrint('初始化完成 - VIP用户: $_isVipUser, 首次启动: $_isFirstLaunch');
      
      // 如果不是VIP用户，尝试加载开屏广告
      if (_shouldLoadAd) {
        _loadAppOpenAdWithTimeout();
      }
      
      // 设置定时器
      _setupTimers();
      
    } catch (e) {
      debugPrint('初始化失败: $e');
      // 即使初始化失败，也要确保能导航到下一页
      setState(() {
        _isInitialized = true;
        _isVipUser = false; // 默认为非VIP
      });
      _setupFallbackNavigation();
    }
  }

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

  void _setupTimers() {
    // 最小显示时间定时器
    _splashTimer = Timer(_minSplashDuration, () {
      if (mounted && !_hasNavigated) {
        debugPrint('最小显示时间到达，准备导航...');
        _handleSplashComplete();
      }
    });
    
    // 超时保护定时器
    _timeoutTimer = Timer(_splashTimeout, () {
      if (mounted && !_hasNavigated) {
        debugPrint('Splash screen 超时，强制导航');
        _navigateToNextScreen();
      }
    });
  }

  void _setupFallbackNavigation() {
    Timer(const Duration(milliseconds: 3000), () {
      if (mounted && !_hasNavigated) {
        debugPrint('启用备用导航');
        _navigateToNextScreen();
      }
    });
  }

  void _handleSplashComplete() {
    if (!_isInitialized) {
      // 如果还没初始化完成，等待一下再检查
      Timer(const Duration(milliseconds: 500), () {
        if (mounted && !_hasNavigated) {
          _handleSplashComplete();
        }
      });
      return;
    }

    // 检查是否应该显示广告
    if (_shouldLoadAd && _appOpenAdManager.isAdLoaded) {
      debugPrint('显示开屏广告');
      _showAppOpenAd();
    } else {
      debugPrint('跳过广告，直接导航 - shouldLoadAd: $_shouldLoadAd, adLoaded: ${_appOpenAdManager.isAdLoaded}, adFailed: $_adLoadFailed');
      _navigateToNextScreen();
    }
  }
  
  void _navigateToNextScreen() {
    if (!mounted || _hasNavigated) return;
    
    _hasNavigated = true;
    debugPrint('导航到下一页面 - 首次启动: $_isFirstLaunch');
    
    // 取消所有定时器
    _cancelAllTimers();
    
    try {
      // 使用 GoRouter 进行导航，而不是 Navigator.pushReplacement
      if (_isFirstLaunch) {
        GoRouter.of(context).goNamed('onboarding');
        _setFirstLaunchComplete();
      } else {
        GoRouter.of(context).goNamed('home');
      }
    } catch (e) {
      debugPrint('导航失败: $e');
    }
  }

  void _cancelAllTimers() {
    _splashTimer?.cancel();
    _splashTimer = null;
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
    _adTimeoutTimer?.cancel();
    _adTimeoutTimer = null;
  }
  
  void _loadAppOpenAdWithTimeout() {
    debugPrint('开始加载开屏广告...');
    
    // 设置广告加载超时
    _adTimeoutTimer = Timer(_adLoadTimeout, () {
      if (mounted && !_appOpenAdManager.isAdLoaded && !_adLoadFailed) {
        debugPrint('广告加载超时');
        _adLoadFailed = true;
        // 不阻塞导航流程
      }
    });
    
    _loadAppOpenAd();
  }
  
  void _loadAppOpenAd() {
    try {
      // 使用 AppOpenAdManager 加载广告
      _appOpenAdManager.loadAd().then((success) {
        if (mounted) {
          if (success) {
            debugPrint('开屏广告加载成功');
            // 如果最小显示时间已过，检查是否可以显示广告
            if (_splashTimer?.isActive == false && !_hasNavigated) {
              _handleSplashComplete();
            }
          } else {
            debugPrint('开屏广告加载失败');
            _adLoadFailed = true;
            // 如果最小显示时间已过，直接导航
            if (_splashTimer?.isActive == false && !_hasNavigated) {
              _navigateToNextScreen();
            }
          }
        }
      });
    } catch (e) {
      debugPrint('加载开屏广告异常: $e');
      _adLoadFailed = true;
    }
  }
  
  void _showAppOpenAd() {
    if (_appOpenAdManager.isAdLoaded && mounted && !_hasNavigated) {
      try {
        // 显示广告前设置回调，确保广告关闭后导航到下一个页面
        if (_appOpenAdManager.appOpenAd != null) {
          _appOpenAdManager.appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('开屏广告被关闭，导航到下一页面');
              _navigateToNextScreen();
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              debugPrint('开屏广告显示失败: ${error.message}，导航到下一页面');
              _navigateToNextScreen();
            },
            onAdShowedFullScreenContent: (ad) {
              debugPrint('开屏广告开始显示');
            },
            onAdImpression: (ad) {
              debugPrint('开屏广告产生展示');
            },
          );
          
          // 直接调用广告的show方法
          _appOpenAdManager.appOpenAd!.show();
          debugPrint('开屏广告显示成功');
        } else {
          debugPrint('开屏广告实例为null，直接导航');
          _navigateToNextScreen();
        }
      } catch (e) {
        debugPrint('显示开屏广告异常: $e');
        _navigateToNextScreen();
      }
    } else {
      debugPrint('广告不可用，直接导航 - isAdLoaded: ${_appOpenAdManager.isAdLoaded}, mounted: $mounted, hasNavigated: $_hasNavigated');
      _navigateToNextScreen();
    }
  }
  























  Future<void> _checkFirstLaunch() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) {
        final isFirst = prefs.getBool('first_launch') ?? true;
        setState(() {
          _isFirstLaunch = isFirst;
        });
        debugPrint('首次启动检查: $isFirst');
      }
    } catch (e) {
      debugPrint('检查首次启动状态失败: $e');
      if (mounted) {
        setState(() {
          _isFirstLaunch = true;
        });
      }
    }
  }
  
  Future<void> _checkVipStatus() async {
    try {
      // 延迟获取 Provider，确保 widget 树已构建完成
      await Future.delayed(const Duration(milliseconds: 100));
      
      if (mounted) {
        try {
          final purchaseStateNotifier = ref.read(purchaseStateProvider.notifier);
          // 确保先加载状态
          await purchaseStateNotifier.loadState();
          
          // 检查配置是否正确加载
          debugPrint('购买状态加载完成，检查配置...');
          
          // 获取 VIP 状态 - 从配置中读取的实际值
          final isVip = purchaseStateNotifier.isPurchasesEnabled;
          final hasTempAccess = purchaseStateNotifier.hasTempPurchase;
          
          // 检查是否有临时访问权限或已购买
          final isPurchasedOrHasTempAccess = purchaseStateNotifier.isPurchasedOrHasTempAccess();
          
          if (mounted) {
            setState(() {
              _isVipUser = isPurchasedOrHasTempAccess;
            });
            debugPrint('VIP状态检查: 已购买=$isVip, 临时访问=$hasTempAccess, 最终VIP状态=$isPurchasedOrHasTempAccess');
            
            // 添加更多日志以便调试
            if (isPurchasedOrHasTempAccess) {
              debugPrint('用户有VIP权限，广告将被禁用');
            } else {
              debugPrint('用户无VIP权限，广告将被启用');
            }
          }
        } catch (e) {
          debugPrint('获取VIP状态失败: $e');
          if (mounted) {
            setState(() {
              _isVipUser = false;
            });
          }
        }
      }
    } catch (e) {
      debugPrint('VIP状态检查异常: $e');
      if (mounted) {
        setState(() {
          _isVipUser = false;
        });
      }
    }
  }

  Future<void> _setFirstLaunchComplete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('first_launch', false);
      debugPrint('首次启动标志已设置为完成');
    } catch (e) {
      debugPrint('设置首次启动完成状态失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 应用 Logo 带动画效果
                  FadeTransition(
                    opacity: _animation,
                    child: Image.asset(
                      "assets/app_logo.png",
                      width: 150,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Logo 加载失败: $error');
                        return Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.apps,
                            size: 60,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your Call Your Rule",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // 加载指示器
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9800)),
                  ),
                  const SizedBox(height: 20),
                  // 显示当前状态
                  _buildStatusText(),
                ],
              ),
            ),

        /*   
            // 底部广告 - 仅对非 VIP 用户显示且已初始化
            // 原始的底部广告 我们已经不再使用了
            if (_isInitialized && !_isVipUser)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // 添加容器包装，防止广告加载失败影响布局
                  child: const GoogleAdWidget(adInfo: AdManager.appOpenAd),
                ),
              ),
*/

          ],
        ),
      ),
    );
  }

  Widget _buildStatusText() {
    if (!_isInitialized) {
      return Text(
        AppLocalizations.of(context)!.initializing,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      );
    }
    
    if (_shouldLoadAd && !_appOpenAdManager.isAdLoaded && !_adLoadFailed) {
      return Text(
        AppLocalizations.of(context)!.loading,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      );
    }
    
    return const SizedBox.shrink();
  }
  
  @override
  void dispose() {
    debugPrint('SplashScreen dispose');
    
    // 取消所有定时器
    _cancelAllTimers();
    
    // 安全地释放动画控制器
    try {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
      _animationController.dispose();
    } catch (e) {
      debugPrint('释放动画控制器失败: $e');
    }
    
    // 释放广告资源
    _appOpenAdManager.dispose();
    
    super.dispose();
  }
}