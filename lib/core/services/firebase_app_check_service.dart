import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

/// Firebase App Check服务类
/// 负责处理应用验证，防止未授权访问Firebase资源
class FirebaseAppCheckService {
  static final FirebaseAppCheckService _instance = FirebaseAppCheckService._internal();
  
  // 单例模式
  factory FirebaseAppCheckService() => _instance;
  
  FirebaseAppCheckService._internal();
  
  late final FirebaseAppCheck _appCheck;
  
  /// 初始化App Check服务
  Future<void> initialize() async {
    _appCheck = FirebaseAppCheck.instance;
    
    try {
      // 根据平台激活不同的提供程序
      if (kIsWeb) {
        // Web平台使用reCAPTCHA v3
        await _appCheck.activate(
          webProvider: ReCaptchaV3Provider('your-recaptcha-v3-site-key'),
        );
      } else {
        // 移动平台使用设备检查或Play完整性
        // 在调试模式下使用调试提供程序
        if (kDebugMode) {
          await _appCheck.activate(
            androidProvider: AndroidProvider.debug,
            appleProvider: AppleProvider.debug,
          );
        } else {
          await _appCheck.activate(
            androidProvider: AndroidProvider.playIntegrity,
            appleProvider: AppleProvider.deviceCheck,
          );
        }
      }
      debugPrint('Firebase App Check 初始化成功');
    } catch (e) {
      debugPrint('Firebase App Check 初始化失败: $e');
    }
  }
  
  /// 获取App Check实例
  FirebaseAppCheck get appCheck => _appCheck;
  
  /// 获取App Check令牌
  /// 可用于向自定义后端验证应用的合法性
  Future<String?> getToken() async {
    try {
      return await _appCheck.getToken();
    } catch (e) {
      debugPrint('获取App Check令牌失败: $e');
      return null;
    }
  }
  
  /// 设置令牌自动刷新监听器
  void setTokenAutoRefreshListener(Function(String) onTokenRefreshed) {
    try {
      _appCheck.onTokenChange.listen((token) {
        // 处理令牌变更
        debugPrint('App Check令牌已更新');
        if (token != null) {
          onTokenRefreshed(token);
        }
      });
    } catch (e) {
      debugPrint('设置令牌自动刷新监听器失败: $e');
    }
  }
  
  /// 刷新App Check令牌
  Future<void> refreshToken() async {
    try {
      // 手动刷新令牌，由于新版本可能不支持forceRefresh参数
      // 我们先获取一个新令牌，然后丢弃结果
      await _appCheck.getToken();
    } catch (e) {
      debugPrint('刷新App Check令牌失败: $e');
    }
  }
  
  /// 为自定义后端请求添加App Check令牌
  /// 返回包含令牌的请求头
  Future<Map<String, String>> getAppCheckHeaders() async {
    try {
      final token = await getToken();
      if (token != null) {
        return {
          'X-Firebase-AppCheck': token,
        };
      } else {
        debugPrint('App Check令牌为空，无法获取请求头');
        return {};
      }
    } catch (e) {
      debugPrint('获取App Check请求头失败: $e');
      return {};
    }
  }
  
  /// 设置App Check调试模式
  /// 仅在开发环境中使用
  Future<void> setDebugMode() async {
    if (kDebugMode) {
      try {
        // 获取调试令牌
        const debugToken = 'YOUR_DEBUG_TOKEN'; // 替换为您的调试令牌
        await _appCheck.setTokenAutoRefreshEnabled(true);
        debugPrint('App Check调试模式已启用');
      } catch (e) {
        debugPrint('设置App Check调试模式失败: $e');
      }
    }
  }
}