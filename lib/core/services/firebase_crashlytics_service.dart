import 'dart:isolate';
import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Firebase Crashlytics服务类
/// 负责处理应用崩溃报告和错误记录
class FirebaseCrashlyticsService {
  static final FirebaseCrashlyticsService _instance = FirebaseCrashlyticsService._internal();
  
  // 单例模式
  factory FirebaseCrashlyticsService() => _instance;
  
  FirebaseCrashlyticsService._internal();
  
  late final FirebaseCrashlytics _crashlytics;
  
  /// 初始化Crashlytics服务
  Future<void> initialize() async {
    try {
      _crashlytics = FirebaseCrashlytics.instance;
      
      // 仅在非调试模式下启用Crashlytics
      if (!kDebugMode) {
        // 捕获Flutter错误
        FlutterError.onError = (FlutterErrorDetails details) {
          _crashlytics.recordFlutterFatalError(details);
        };
        
        // 捕获未处理的异步错误
        PlatformDispatcher.instance.onError = (error, stack) {
          _crashlytics.recordError(error, stack, fatal: true);
          return true;
        };
        
        // 捕获非Flutter错误（例如在isolate中）
        // 创建一个接收端口来接收来自Isolate的错误
        final ReceivePort port = ReceivePort();
        final isolateErrorListener = IsolateNameServer.registerPortWithName(
          port.sendPort,
          'crashlytics-isolate-error-listener',
        );
        
        if (isolateErrorListener) {
          port.listen((dynamic message) {
            // 处理来自isolate的错误
            if (message is List && message.length == 2) {
              final dynamic error = message[0];
              final dynamic stack = message[1];
              _crashlytics.recordError(error, stack, fatal: false);
            }
          });
        }
        
        // 启用Crashlytics数据收集
        await _crashlytics.setCrashlyticsCollectionEnabled(true);
      } else {
        // 调试模式下禁用Crashlytics
        await _crashlytics.setCrashlyticsCollectionEnabled(false);
      }
      
      print('Firebase Crashlytics 初始化成功');
    } catch (e) {
      print('Firebase Crashlytics 初始化失败: $e');
    }
  }
  
  /// 获取Crashlytics实例
  FirebaseCrashlytics get crashlytics => _crashlytics;
  
  /// 记录非致命错误
  Future<void> recordError(dynamic exception, StackTrace stack, {bool fatal = false, String? reason}) async {
    try {
      if (!kDebugMode) {
        await _crashlytics.recordError(
          exception, 
          stack, 
          fatal: fatal,
          reason: reason,
          printDetails: true,
        );
      } else {
        // 在调试模式下打印错误信息
        print('Crashlytics would record: $exception');
        print('Reason: $reason');
        print('Stack trace: $stack');
      }
    } catch (e) {
      print('记录错误到Crashlytics失败: $e');
    }
  }
  
  /// 记录自定义错误信息
  Future<void> recordCustomError({
    required String message,
    required String reason,
    StackTrace? stackTrace,
    bool fatal = false,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      // 添加自定义键值对
      if (additionalData != null) {
        await setCustomKeys(additionalData);
      }
      
      final customError = Exception('$message: $reason');
      await recordError(
        customError, 
        stackTrace ?? StackTrace.current,
        fatal: fatal,
        reason: reason,
      );
    } catch (e) {
      print('记录自定义错误到Crashlytics失败: $e');
    }
  }
  
  /// 设置用户标识符
  Future<void> setUserIdentifier(String identifier) async {
    try {
      await _crashlytics.setUserIdentifier(identifier);
    } catch (e) {
      print('设置Crashlytics用户标识符失败: $e');
    }
  }
  
  /// 添加自定义键值对到Crashlytics报告
  Future<void> setCustomKey(String key, dynamic value) async {
    try {
      await _crashlytics.setCustomKey(key, value);
    } catch (e) {
      print('设置Crashlytics自定义键值对失败: $e');
    }
  }
  
  /// 添加多个自定义键值对
  Future<void> setCustomKeys(Map<String, dynamic> customKeys) async {
    try {
      for (final entry in customKeys.entries) {
        await _crashlytics.setCustomKey(entry.key, entry.value);
      }
    } catch (e) {
      print('设置多个Crashlytics自定义键值对失败: $e');
    }
  }
  
  /// 记录自定义日志消息
  Future<void> log(String message) async {
    try {
      await _crashlytics.log(message);
    } catch (e) {
      print('记录日志到Crashlytics失败: $e');
    }
  }
  
  /// 强制触发崩溃（仅用于测试）
  void forceCrash() {
    if (kDebugMode) {
      // 在调试模式下，只打印消息
      print('在调试模式下，不会触发实际崩溃');
      return;
    }
    
    try {
      // 使用异常触发崩溃，因为crash()方法返回void不能被使用
      throw Exception('强制触发的崩溃');
    } catch (e) {
      // 记录异常并重新抛出以触发崩溃
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current, reason: '手动触发崩溃');
      throw e; // 重新抛出异常以触发实际崩溃
    }
  }
  
  /// 启用/禁用Crashlytics数据收集
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    try {
      await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
    } catch (e) {
      print('设置Crashlytics数据收集状态失败: $e');
    }
  }
  
  /// 检查最后一次运行是否崩溃
  Future<bool> didCrashOnPreviousExecution() async {
    try {
      return await _crashlytics.didCrashOnPreviousExecution();
    } catch (e) {
      print('检查上次运行崩溃状态失败: $e');
      return false;
    }
  }
  
  /// 发送未捕获的错误到Crashlytics
  /// 用于处理非Flutter代码中的错误
  void sendUnhandledErrorToCrashlytics(dynamic error, StackTrace stack) {
    try {
      // 获取isolate的发送端口
      final SendPort? sendPort = IsolateNameServer.lookupPortByName(
        'crashlytics-isolate-error-listener',
      );
      
      if (sendPort != null) {
        sendPort.send([error, stack]);
      } else {
        // 如果找不到端口，直接记录错误
        recordError(error, stack);
      }
    } catch (e) {
      print('发送未捕获错误到Crashlytics失败: $e');
    }
  }
}