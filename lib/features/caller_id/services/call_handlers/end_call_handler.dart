import 'package:flutter/services.dart';

import '../../../call/call_filter/call_filter_service.dart';
import '../../config/caller_id_config_repository.dart';
import 'base_call_handler.dart';
import 'caller_id_handler_extension.dart';

/// 结束通话处理器
/// 负责处理与结束通话相关的方法调用
class EndCallHandler extends BaseCallHandler {
  final CallerIdConfigRepository _configRepository;
  
  /// 构造函数
  EndCallHandler(this._configRepository);
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
      // 记录拦截动作
      this.setInterceptAction(ruleAction);
      
      return ruleAction;
    }
    
    // 否则使用全局默认设置
    final interceptAction = await _configRepository.getInterceptAction();
    
    // 记录拦截动作
    this.setInterceptAction(interceptAction);
    
    return interceptAction;
  }
}