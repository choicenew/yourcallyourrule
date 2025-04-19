import 'dart:async';

import 'package:flutter/services.dart';

import '../../lib clean architecture 架构/infrastructure/services/base_service_impl.dart';

/// 来电接受决策服务实现
/// 负责判断是否应该接受来电
class ShouldAcceptServiceImpl extends BaseServiceImpl {
  final MethodChannel _shouldAcceptCallChannel;
  final CallFilter _callFilter;
  final TimeBasedInterceptor _timeBasedInterceptor = TimeBasedInterceptor();
  
  // 每次来电创建新的 StreamController
  StreamController<bool>? _currentDecisionController;
  
  ShouldAcceptServiceImpl(
    this._shouldAcceptCallChannel,
    this._callFilter,
  ) {
    _setupChannelCallbacks();
  }
  
  void _setupChannelCallbacks() {
    _shouldAcceptCallChannel.setMethodCallHandler(_handleShouldAcceptCallCall);
    logOperation('设置shouldAccept通道回调');
  }
  
  /// 处理shouldAcceptCall通道的调用
  Future<dynamic> _handleShouldAcceptCallCall(MethodCall call) async {
    if (call.method == 'onShouldAcceptCallInitializationComplete') {
      logOperation('shouldAccept初始化完成');
      return true;
    } else if (call.method == 'shouldAcceptCall') {
      final phoneNumber = call.arguments['phoneNumber'] as String;
      logOperation('收到shouldAcceptCall请求', details: phoneNumber);
      
      _currentDecisionController = StreamController<bool>();
      final result = await _processDecision(phoneNumber);
      
      // 发送决策结果
      _currentDecisionController?.add(result);
      
      // 关闭当前决策控制器
      await _currentDecisionController!.close();
      _currentDecisionController = null;
      
      return result;
    }
    return true;
  }
  
  /// 处理来电决策逻辑
  Future<bool> _processDecision(String phoneNumber) async {
    await _callFilter.loadConfig(); // 重新加载配置
    await _timeBasedInterceptor.loadConfig();
    
    // 解析电话号码获取不同格式
    final parsedData = await parsePhoneNumber(phoneNumber);
    final e164Number = parsedData['e164Number'] ?? '';
    final nationalNumber = parsedData['nationalNumber'] ?? '';
    
    // 使用列表和 any 方法进行优先级判断
    final numbersToTest = [
      phoneNumber,
      nationalNumber,
      e164Number
    ].whereType<String>().where((s) => s.isNotEmpty).toList();
    
    // 对每个号码格式进行判断，任一格式通过即可接听
    for (final number in numbersToTest) {
      bool shouldAccept = await _callFilter.shouldAcceptCall(number);
      
      // 如果 _callFilter 不允许接听，再判断 _timeBasedInterceptor 的结果
      if (!shouldAccept && _timeBasedInterceptor.config.shouldIntercept) {
        shouldAccept = !await _timeBasedInterceptor.shouldIntercept(number);
      }
      
      if (shouldAccept) {
        logOperation('决定接受来电', details: number);
        return true;
      }
    }
    
    logOperation('决定拒绝来电', details: phoneNumber);
    return false;
  }
  
  /// 初始化服务
  Future<void> initialize() async {
    logOperation('初始化shouldAccept服务');
  }
  
  /// 释放资源
  Future<void> dispose() async {
    await _currentDecisionController?.close();
    _currentDecisionController = null;
    logOperation('释放shouldAccept服务资源');
  }
}

/// 以下是必要的辅助类，实际使用时应该从正确的导入路径引入
class TimeBasedInterceptor {
  final TimeBasedInterceptorConfig config = TimeBasedInterceptorConfig();
  
  Future<void> loadConfig() async {
    // 实际实现中应该从存储加载配置
  }
  
  Future<bool> shouldIntercept(String phoneNumber) async {
    // 实际实现中应该根据时间规则判断是否拦截
    return false;
  }
}

class TimeBasedInterceptorConfig {
  bool shouldIntercept = false;
}

class CallFilter {
  Future<void> loadConfig() async {
    // 实际实现中应该从存储加载配置
  }
  
  Future<bool> shouldAcceptCall(String phoneNumber) async {
    // 实际实现中应该根据过滤规则判断是否接受来电
    return true;
  }
}

Future<Map<String, String>> parsePhoneNumber(String phoneNumber) async {
  // 实际实现中应该使用电话号码解析库
  return {
    'e164Number': phoneNumber,
    'nationalNumber': phoneNumber,
  };
}