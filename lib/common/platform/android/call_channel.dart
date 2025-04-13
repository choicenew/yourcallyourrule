import 'package:flutter/services.dart';

import '../../../common/error/exceptions.dart';

/// Android平台通话通道
class AndroidCallChannel {
  // 定义与原始代码相同的通道
  static const MethodChannel _callerIdChannel = MethodChannel('com.yours.yourcallyourrule/caller_id');
  static const MethodChannel _endCallChannel = MethodChannel('com.yours.yourcallyourrule/end_call');
  static const MethodChannel _shouldAcceptCallChannel = MethodChannel('com.yours.yourcallyourrule/should_accept_call');
  static const MethodChannel _stirChannel = MethodChannel('com.yours.yourcallyourrule/stir_check');
  static const MethodChannel _simChannel = MethodChannel('com.yours.yourcallyourrule/sim_check');
  
  // 兼容新架构的通道
  static const MethodChannel _channel = MethodChannel('com.yourcallyourrule.app/call');

  const AndroidCallChannel._();

  // 回调函数类型定义
  static Function(MethodCall)? onCallerIdCall;
  static Function(MethodCall)? onStirCall;
  static Function(MethodCall)? onSimCall;
  static Future<bool> Function(MethodCall)? onShouldAcceptCallCall;
  static Future<String?> Function(MethodCall)? onEndCallCall;

  /// 初始化所有通道
  static Future<void> initialize() async {
    _setupCallerIdChannel();
    _setupShouldAcceptCallChannel();
    _setupEndCallChannel();
    _setupStirChannel();
    _setupSimChannel();
  }

  /// 设置来电显示通道
  static void _setupCallerIdChannel() {
    _callerIdChannel.setMethodCallHandler((call) async {
      onCallerIdCall?.call(call);
      return null;
    });
  }

  /// 设置是否接听来电通道
  static void _setupShouldAcceptCallChannel() {
    _shouldAcceptCallChannel.setMethodCallHandler((call) async {
      if (onShouldAcceptCallCall != null) {
        return await onShouldAcceptCallCall!(call);
      }
      return true; // 默认返回
    });
  }

  /// 设置结束通话通道
  static void _setupEndCallChannel() {
    _endCallChannel.setMethodCallHandler((call) async {
      if (onEndCallCall != null) {
        return await onEndCallCall!(call);
      }
      return null; // 默认返回
    });
  }

  /// 设置STIR验证通道
  static void _setupStirChannel() {
    _stirChannel.setMethodCallHandler((call) async {
      onStirCall?.call(call);
      return null;
    });
  }

  /// 设置SIM卡信息通道
  static void _setupSimChannel() {
    _simChannel.setMethodCallHandler((call) async {
      onSimCall?.call(call);
      return null;
    });
  }

  /// 初始化来电显示服务
  static Future<void> initializeCallerId() async {
    try {
      await _callerIdChannel.invokeMethod('initialize');
    } on PlatformException catch (e) {
      throw PlatformException('初始化来电显示服务失败: ${e.message}', code: e.code);
    }
  }

  /// 获取通话记录
  static Future<List<Map<String, dynamic>>> getCallLogs({int? limit}) async {
    try {
      final result = await _channel.invokeMethod('getCallLogs', {'limit': limit});
      return List<Map<String, dynamic>>.from(result ?? []);
    } on PlatformException catch (e) {
      throw PlatformException('获取通话记录失败: ${e.message}', code: e.code);
    }
  }

  /// 拦截来电
  static Future<bool> blockIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('blockIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('拦截来电失败: ${e.message}', code: e.code);
    }
  }

  /// 允许来电
  static Future<bool> allowIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('allowIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('允许来电失败: ${e.message}', code: e.code);
    }
  }

  /// 静音来电
  static Future<bool> silentIncomingCall(String phoneNumber) async {
    try {
      final result = await _channel.invokeMethod('silentIncomingCall', {'phoneNumber': phoneNumber});
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('静音来电失败: ${e.message}', code: e.code);
    }
  }

  /// 重定向来电
  static Future<bool> redirectIncomingCall(String phoneNumber, String redirectTo) async {
    try {
      final result = await _channel.invokeMethod('redirectIncomingCall', {
        'phoneNumber': phoneNumber,
        'redirectTo': redirectTo
      });
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('重定向来电失败: ${e.message}', code: e.code);
    }
  }

  /// 注册来电监听器
  static Future<bool> registerCallListener() async {
    try {
      final result = await _channel.invokeMethod('registerCallListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('注册来电监听器失败: ${e.message}', code: e.code);
    }
  }

  /// 取消注册来电监听器
  static Future<bool> unregisterCallListener() async {
    try {
      final result = await _channel.invokeMethod('unregisterCallListener');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('取消注册来电监听器失败: ${e.message}', code: e.code);
    }
  }

  /// 检查通话权限
  static Future<bool> checkCallPermission() async {
    try {
      final result = await _channel.invokeMethod('checkCallPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('检查通话权限失败: ${e.message}', code: e.code);
    }
  }

  /// 请求通话权限
  static Future<bool> requestCallPermission() async {
    try {
      final result = await _channel.invokeMethod('requestCallPermission');
      return result ?? false;
    } on PlatformException catch (e) {
      throw PlatformException('请求通话权限失败: ${e.message}', code: e.code);
    }
  }
}