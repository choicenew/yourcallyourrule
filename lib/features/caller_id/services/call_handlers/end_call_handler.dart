// 导入 Flutter 核心包
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入项目中的实体类和配置
import 'package:yourcallyourrule/features/caller_id/config/intercept_action.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
// 导入依赖的 Provider
// 【注意】请确保这个 provider 文件的路径是正确的
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
// 导入其他依赖的服务和扩展
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler_extension.dart';
import 'base_call_handler.dart';

// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'end_call_handler.g.dart';

/// 结束通话处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 EndCallHandler 的单例，
/// 并通过 `ref` 将其所需要的依赖（CallerIdConfigRepository）注入进去。
///
/// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
/// 因为它需要持续响应来自原生平台的调用。
@Riverpod(keepAlive: true)
EndCallHandler endCallHandler(Ref ref) {
  // 1. 从 Riverpod 获取共享的、唯一的 CallerIdConfigRepository 实例。
  //    使用 `watch` 可以确保如果 repository 本身发生变化（虽然不太可能），这个 Provider 也会重建。
  final configRepository = ref.watch(callerIdConfigRepositoryProvider);

  // 2. 将获取到的依赖注入到 EndCallHandler 的构造函数中并返回。
  return EndCallHandler(configRepository);
}


/// 结束通话处理器
/// 负责处理与结束通话相关的方法调用
class EndCallHandler extends BaseCallHandler {
  // 依赖现在通过 Provider 注入，而不是在外部手动创建
  final CallerIdConfigRepository _configRepository;

  /// 构造函数
  /// [configRepository] 由 Riverpod Provider 提供的配置仓库实例
  EndCallHandler(this._configRepository);

  /// 处理来自原生平台的 MethodChannel 调用。
  ///
  /// 这个方法是本处理器与外部世界（特别是原生代码）交互的入口。
  /// 它会被 AndroidCallChannelManager 调用。
  @override
  dynamic handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onEndCallInitializationComplete":
        return _handleInitializationComplete();
      case "interceptAction":
        // 确保参数类型正确
        final phoneNumber = call.arguments as String? ?? '';
        return await _handleInterceptAction(phoneNumber);
      default:
        throw UnimplementedError('EndCallHandler: 未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成事件。
  void _handleInitializationComplete() {
    // 初始化完成后的处理逻辑（可选）
  }

  /// 处理拦截动作的核心逻辑。
  ///
  /// 首先检查 CallFilterService 中是否有规则指定的拦截动作，
  /// 如果没有，则使用从 _configRepository 获取的全局默认设置。
  Future<String?> _handleInterceptAction(String phoneNumber) async {
    // 首先检查是否有由具体规则指定的、临时的拦截动作
    // CallFilterService.getCurrentInterceptAction() 是一个静态方法，可以直接调用
    final InterceptAction? ruleAction = CallFilterService.getCurrentInterceptAction();

    // 如果规则指定了拦截动作，则优先使用它
    if (ruleAction != null) {
      // 使用扩展方法记录本次调用的拦截动作（用于调试或日志）
      this.setInterceptAction(ruleAction);
      debugPrint("_handleInterceptAction (from rule): ${ruleAction.name}");
      // 将动作名称（字符串）返回给原生平台
      return ruleAction.name;
    }

    // 如果没有规则指定动作，则从配置仓库获取全局的默认设置
    // _configRepository 是通过 Provider 注入的，保证了数据源的统一
    final defaultAction = await _configRepository.getInterceptAction();

    // 记录全局默认的拦截动作
    this.setInterceptAction(defaultAction);
    debugPrint("_handleInterceptAction (from global default): ${defaultAction.name}");
    // 将动作名称（字符串）返回给原生平台
    return defaultAction.name;
  }
}