import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Firebase Analytics服务类
/// 负责处理应用内的分析事件跟踪和用户属性设置
class FirebaseAnalyticsService {
  static final FirebaseAnalyticsService _instance = FirebaseAnalyticsService._internal();
  
  // 单例模式
  factory FirebaseAnalyticsService() => _instance;
  
  FirebaseAnalyticsService._internal();
  
  late final FirebaseAnalytics _analytics;
  late final FirebaseAnalyticsObserver observer;
  
  /// 初始化Analytics服务
  Future<void> initialize() async {
    try {
      _analytics = FirebaseAnalytics.instance;
      observer = FirebaseAnalyticsObserver(analytics: _analytics);
      
      // 设置分析收集启用状态
      // 在调试模式下可以选择禁用
      await _analytics.setAnalyticsCollectionEnabled(!kDebugMode);
      
      debugPrint('Firebase Analytics 初始化成功');
    } catch (e) {
      debugPrint('Firebase Analytics 初始化失败: $e');
    }
  }
  
  /// 获取Analytics实例
  FirebaseAnalytics get analytics => _analytics;
  
  /// 记录自定义事件
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
    } catch (e) {
      debugPrint('记录事件失败: $e');
    }
  }
  
  /// 记录应用启动事件
  Future<void> logAppOpen() async {
    try {
      await _analytics.logAppOpen();
    } catch (e) {
      debugPrint('记录应用启动事件失败: $e');
    }
  }
  
  /// 记录用户登录事件
  Future<void> logLogin({String? loginMethod}) async {
    try {
      await _analytics.logLogin(loginMethod: loginMethod ?? 'unknown');
    } catch (e) {
      debugPrint('记录登录事件失败: $e');
    }
  }
  
  /// 记录用户注册事件
  Future<void> logSignUp({String? signUpMethod}) async {
    try {
      await _analytics.logSignUp(signUpMethod: signUpMethod ?? 'unknown');
    } catch (e) {
      debugPrint('记录注册事件失败: $e');
    }
  }
  
  /// 记录搜索事件
  Future<void> logSearch({required String searchTerm}) async {
    try {
      await _analytics.logSearch(searchTerm: searchTerm);
    } catch (e) {
      debugPrint('记录搜索事件失败: $e');
    }
  }
  
  /// 记录内容查看事件
  Future<void> logViewContent({
    String? contentType,
    String? itemId,
    String? itemName,
  }) async {
    try {
      // 使用自定义事件替代，因为logViewContent方法在新版本中可能不存在
      await _analytics.logEvent(
        name: 'view_content',
        parameters: {
          if (contentType != null) 'content_type': contentType,
          if (itemId != null) 'item_id': itemId,
          if (itemName != null) 'item_name': itemName,
        },
      );
    } catch (e) {
      debugPrint('记录内容查看事件失败: $e');
    }
  }
  
  /// 记录屏幕浏览事件
  Future<void> logScreenView({required String screenName, String? screenClass}) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
    } catch (e) {
      debugPrint('记录屏幕浏览事件失败: $e');
    }
  }
  
  /// 设置用户ID
  Future<void> setUserId(String? userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      debugPrint('设置用户ID失败: $e');
    }
  }
  
  /// 设置用户属性
  Future<void> setUserProperty({required String name, required String? value}) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      debugPrint('设置用户属性失败: $e');
    }
  }
  
  /// 重置分析数据
  Future<void> resetAnalyticsData() async {
    try {
      await _analytics.resetAnalyticsData();
    } catch (e) {
      debugPrint('重置分析数据失败: $e');
    }
  }
  
  /// 为应用内的特定功能创建自定义事件
  /// 来电相关事件
  Future<void> logCallEvent({
    required String action,
    String? callType,
    String? result,
  }) async {
    try {
      await logEvent(
        name: 'call_action',
        parameters: <String, Object>{
          'action': action,
          if (callType != null) 'call_type': callType,
          if (result != null) 'result': result,
        },
      );
    } catch (e) {
      debugPrint('记录来电事件失败: $e');
    }
  }
  
  /// 过滤器相关事件
  Future<void> logFilterEvent({
    required String filterType,
    required String action,
    String? result,
  }) async {
    try {
      await logEvent(
        name: 'filter_action',
        parameters: <String, Object>{
          'filter_type': filterType,
          'action': action,
          if (result != null) 'result': result,
        },
      );
    } catch (e) {
      debugPrint('记录过滤器事件失败: $e');
    }
  }
  
  /// 设置相关事件
  Future<void> logSettingsEvent({
    required String settingName,
    required String value,
  }) async {
    try {
      await logEvent(
        name: 'settings_change',
        parameters: <String, Object>{
          'setting_name': settingName,
          'value': value,
        },
      );
    } catch (e) {
      debugPrint('记录设置事件失败: $e');
    }
  }
}