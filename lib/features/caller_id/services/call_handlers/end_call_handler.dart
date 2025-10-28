// 导入 Flutter 核心包
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入项目中的实体类和配置
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';
// 【核心】: 导入需要读取的 interceptActionConfigProvider
import 'package:yourcallyourrule/features/caller_id/config/intercept_action_config_provider.dart'; 
// 导入其他依赖
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler_extension.dart';
import 'base_call_handler.dart';

// part 指令
part 'end_call_handler.g.dart';

/// 结束通话处理器 Provider
///
/// 这是一个简单的服务型 Provider，负责创建 EndCallHandler 的单例。
/// 【最终方案】: 它只注入通用的 `ref` 对象，让 Handler 可以在需要时访问任何 Provider。
@Riverpod(keepAlive: true)
EndCallHandler endCallHandler(Ref ref) {
  return EndCallHandler(ref);
}

/// 结束通话处理器
/// 负责响应原生平台关于如何执行拦截的询问。
class EndCallHandler implements BaseCallHandler {
  // 【最终方案】: 只依赖通用的 Ref 对象。
  final Ref _ref;

  EndCallHandler(this._ref);

  /// 处理来自原生平台的 MethodChannel 调用。
  @override
  Future<String?> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onEndCallInitializationComplete":
        _handleInitializationComplete();
        return null;
      case "interceptAction":
        final phoneNumber = call.arguments as String? ?? '';
        return await _handleInterceptAction(phoneNumber);
      default:
        throw UnimplementedError('EndCallHandler: 未实现的方法: ${call.method}');
    }
  }

  void _handleInitializationComplete() {}

  /// 处理拦截动作的核心逻辑。
  Future<String?> _handleInterceptAction(String phoneNumber) async {
    // 检查是否有由规则指定的临时拦截动作
    final InterceptAction? ruleAction = CallFilterService.getCurrentInterceptAction();
    if (ruleAction != null) {
      setInterceptAction(ruleAction);
      debugPrint("_handleInterceptAction (from rule): ${ruleAction.name}");
      return ruleAction.name;
    }

    // 【最终的、正确的逻辑】:
    // 在执行的这一刻，直接通过 `_ref.read` 获取 `interceptActionConfigProvider` 的最新状态。
    // `ref.read` 会访问 Riverpod 容器中唯一的、权威的 Notifier 实例，并返回其当前的 state。
    // 这保证了我们拿到的永远是 UI刚刚更新的、内存中的最新值，彻底解决了所有同步问题。
    final defaultAction = _ref.read(interceptActionConfigProvider);

    debugPrint(">>> [EndCallHandler EXECUTE] Read latest action from provider: $defaultAction");
    this.setInterceptAction(defaultAction);
    debugPrint("_handleInterceptAction (from global default): ${defaultAction.name}");
    return defaultAction.name;
  }
  
  // 实现 BaseCallHandler 的其他方法
  @override
  Future<void> initialize() async {}

  @override
  Future<void> dispose() async {}
}