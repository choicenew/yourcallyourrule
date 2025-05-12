import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../call/call_filter/call_filter_service.dart';
import 'base_call_handler.dart';

/// 结束通话处理器
/// 负责处理与结束通话相关的方法调用
class EndCallHandler extends BaseCallHandler {
  @override
  dynamic handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onEndCallInitializationComplete":
        return _handleInitializationComplete();
      case "interceptAction":
        return await _handleInterceptAction(call.arguments as String);
      default:
        throw UnimplementedError('未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成
  void _handleInitializationComplete() {
    // 初始化完成后的处理逻辑
  }

  /// 处理拦截动作
  /// 
  /// 首先检查CallFilterService中是否有规则指定的拦截动作
  /// 如果没有，则使用全局默认设置
  Future<String?> _handleInterceptAction(String phoneNumber) async {
    // 首先检查CallFilterService中是否有规则指定的拦截动作
    final ruleAction = CallFilterService.getCurrentInterceptAction();
    
    // 如果规则指定了拦截动作，优先使用
    if (ruleAction != null) {
      return ruleAction;
    }
    
    // 否则使用全局默认设置
    SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final interceptAction =
        await asyncPrefs.getString('intercept_action') ?? 'endCall';

    return interceptAction;
  }
}

/// SharedPreferences异步包装类
/// 提供异步访问SharedPreferences的方法
class SharedPreferencesAsync {
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}