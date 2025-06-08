import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/firebase_options.dart';

/// Firebase服务类，负责初始化和管理Firebase相关功能
/// 包括Analytics、Crashlytics和App Check
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  
  // 单例模式
  factory FirebaseService() => _instance;
  
  FirebaseService._internal();
  
  late final FirebaseAnalytics analytics;
  late final FirebaseAnalyticsObserver observer;
  
  /// 初始化Firebase服务
  Future<void> initialize() async {
    try {
      // 初始化Firebase Core
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      
      // 初始化Firebase Analytics
      analytics = FirebaseAnalytics.instance;
      observer = FirebaseAnalyticsObserver(analytics: analytics);
      
      // 初始化Firebase Crashlytics
      await _initializeCrashlytics();
      
      // 初始化Firebase App Check
      await _initializeAppCheck();
      
      print('Firebase服务初始化成功');
    } catch (e, stackTrace) {
      print('Firebase初始化错误: $e');
      print('堆栈跟踪: $stackTrace');
    }
  }
  
  /// 初始化Crashlytics
  Future<void> _initializeCrashlytics() async {
    // 仅在非调试模式下启用Crashlytics
    if (!kDebugMode) {
      // 捕获Flutter错误
      FlutterError.onError = (FlutterErrorDetails details) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };
      
      // 捕获未处理的异步错误
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      
      // 启用Crashlytics数据收集
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // 调试模式下禁用Crashlytics
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }
  }
  
  /// 初始化App Check
  Future<void> _initializeAppCheck() async {
    await FirebaseAppCheck.instance.activate(
      // 使用调试提供程序进行开发，生产环境使用适当的提供程序
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
      appleProvider: kDebugMode ? AppleProvider.debug : AppleProvider.deviceCheck,
    );
  }
  
  /// 记录自定义事件
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    try {
      await analytics.logEvent(name: name, parameters: parameters);
    } catch (e) {
      print('记录事件失败: $e');
    }
  }
  
  /// 设置用户ID
  Future<void> setUserId(String? userId) async {
    try {
      await analytics.setUserId(id: userId);
      await setUserIdentifier(userId ?? 'anonymous');
    } catch (e) {
      print('设置用户ID失败: $e');
    }
  }
  
  /// 设置当前屏幕
  Future<void> setCurrentScreen({required String screenName, String? screenClass}) async {
    try {
      // 使用logScreenView方法，但不使用screenClassOverride参数
      await analytics.logScreenView(screenName: screenName);
    } catch (e) {
      print('设置当前屏幕失败: $e');
    }
  }
  
  /// 记录应用崩溃
  Future<void> recordError(dynamic exception, StackTrace stack, {bool fatal = false}) async {
    if (!kDebugMode) {
      try {
        await FirebaseCrashlytics.instance.recordError(exception, stack, fatal: fatal);
      } catch (e) {
        print('记录崩溃失败: $e');
      }
    }
  }
  
  /// 记录应用启动事件
  Future<void> logAppOpen() async {
    try {
      await analytics.logAppOpen();
    } catch (e) {
      print('记录应用启动事件失败: $e');
    }
  }
  
  /// 记录登录事件
  Future<void> logLogin({String? loginMethod}) async {
    try {
      await analytics.logLogin(loginMethod: loginMethod);
    } catch (e) {
      print('记录登录事件失败: $e');
    }
  }
  
  /// 记录注册事件
  Future<void> logSignUp({String? signUpMethod}) async {
    try {
      await analytics.logSignUp(signUpMethod: signUpMethod ?? 'unknown');
    } catch (e) {
      print('记录注册事件失败: $e');
    }
  }
  
  /// 记录搜索事件
  Future<void> logSearch({required String searchTerm}) async {
    try {
      await analytics.logSearch(searchTerm: searchTerm);
    } catch (e) {
      print('记录搜索事件失败: $e');
    }
  }
  
  /// 记录来电识别事件
  Future<void> logCallerIdEvent({required String eventType, Map<String, Object>? parameters}) async {
    try {
      await logEvent(name: 'caller_id_$eventType', parameters: parameters);
    } catch (e) {
      print('记录来电识别事件失败: $e');
    }
  }
  
  /// 记录过滤器事件
  Future<void> logFilterEvent({required String eventType, Map<String, Object>? parameters}) async {
    try {
      await logEvent(name: 'filter_$eventType', parameters: parameters);
    } catch (e) {
      print('记录过滤器事件失败: $e');
    }
  }
  
  /// 设置用户标识符（用于Crashlytics）
  Future<void> setUserIdentifier(String identifier) async {
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier(identifier);
    } catch (e) {
      print('设置用户标识符失败: $e');
    }
  }
  
  /// 添加自定义键值对到Crashlytics报告
  Future<void> setCustomKey(String key, dynamic value) async {
    try {
      await FirebaseCrashlytics.instance.setCustomKey(key, value);
    } catch (e) {
      print('设置自定义键值对失败: $e');
    }
  }
  
  /// 记录日志消息到Crashlytics
  Future<void> log(String message) async {
    try {
      await FirebaseCrashlytics.instance.log(message);
    } catch (e) {
      print('记录日志消息失败: $e');
    }
  }
  
  /// 获取Firebase Analytics观察者
  /// 用于自动跟踪页面浏览
  NavigatorObserver getAnalyticsObserver() {
    return observer;
  }
  
  /// 获取App Check令牌
  Future<String?> getAppCheckToken() async {
    try {
      return await FirebaseAppCheck.instance.getToken();
    } catch (e) {
      print('获取App Check令牌失败: $e');
      return null;
    }
  }
}