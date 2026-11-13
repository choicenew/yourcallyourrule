import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:pyro_analytics_firebase/pyro_analytics_firebase.dart';

/// Firebase服务类 —— 全量集成与调配 pyro_analytics_firebase (FirebaseTelemetryService)
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  FirebaseService._internal();

  /// 初始化 Firebase 基础设施并一键装配 FirebaseTelemetryService
  Future<void> initialize() async {
    try {
      // 调配零阻塞异步初始化、冷启动 50 条缓冲队列与参数自动清洗的微包服务
      await FirebaseTelemetryService.instance.init();
      debugPrint('Firebase & FirebaseTelemetryService 装配成功');
    } catch (e, stackTrace) {
      debugPrint('Firebase初始化错误: $e');
      debugPrint('堆栈跟踪: $stackTrace');
    }
  }

  /// 记录自定义事件
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    await FirebaseTelemetryService.instance.logEvent(name, parameters: parameters);
  }

  /// 设置用户ID
  Future<void> setUserId(String? userId) async {
    await FirebaseTelemetryService.instance.setUserId(userId);
  }

  /// 记录应用崩溃/异常
  Future<void> recordError(dynamic exception, StackTrace stack, {bool fatal = false}) async {
    await FirebaseTelemetryService.instance.recordError(exception, stack, fatal: fatal);
  }

  /// 记录应用启动事件
  Future<void> logAppOpen() async {
    await FirebaseTelemetryService.instance.logEvent('app_open');
  }

  /// 记录登录事件
  Future<void> logLogin({String? loginMethod}) async {
    await FirebaseTelemetryService.instance.logEvent('login', parameters: {'method': loginMethod ?? 'unknown'});
  }

  /// 记录注册事件
  Future<void> logSignUp({String? signUpMethod}) async {
    await FirebaseTelemetryService.instance.logEvent('sign_up', parameters: {'method': signUpMethod ?? 'unknown'});
  }

  /// 记录搜索事件
  Future<void> logSearch({required String searchTerm}) async {
    await FirebaseTelemetryService.instance.logEvent('search', parameters: {'search_term': searchTerm});
  }

  /// 记录来电识别事件
  Future<void> logCallerIdEvent({required String eventType, Map<String, Object>? parameters}) async {
    await FirebaseTelemetryService.instance.logEvent('caller_id_$eventType', parameters: parameters);
  }

  /// 记录过滤器事件
  Future<void> logFilterEvent({required String eventType, Map<String, Object>? parameters}) async {
    await FirebaseTelemetryService.instance.logEvent('filter_$eventType', parameters: parameters);
  }

  /// 记录日志消息
  Future<void> log(String message) async {
    await FirebaseTelemetryService.instance.log(message);
  }

  /// 获取 App Check 令牌
  Future<String?> getAppCheckToken() async {
    try {
      return await FirebaseAppCheck.instance.getToken();
    } catch (e) {
      debugPrint('获取App Check令牌失败: $e');
      return null;
    }
  }
}
