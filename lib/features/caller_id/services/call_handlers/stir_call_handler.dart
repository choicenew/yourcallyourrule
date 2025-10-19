// 导入 Flutter 的服务包，用于 MethodCall
import 'package:flutter/services.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入 STIR 信息的实体类
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
// 【修正】: 重新导入 BaseCallHandler，以保持接口一致性
import 'base_call_handler.dart';

// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'stir_call_handler.g.dart';

/// STIR验证处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与STIR验证相关的原生方法调用，并将其结果作为状态（StirInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `stirCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。
@Riverpod(keepAlive: true)
// 【修正】: 使用 `implements BaseCallHandler` 来确保符合工厂类的接口契约。
// 这要求我们必须实现 BaseCallHandler 中的所有方法。
class StirCallHandler extends _$StirCallHandler implements BaseCallHandler {
  /// build 方法是 Provider 的初始化入口。
  ///
  /// 当这个 Provider 第一次被读取时，该方法会被调用。
  /// 它必须返回 Notifier 管理的状态的初始值。
  @override
  StirInfo? build() {
    // 【新增】: 使用 ref.onDispose 来处理清理逻辑，对应 BaseCallHandler 的 dispose 方法。
    ref.onDispose(() {
      // 在这里可以放置当 Provider 被销毁时需要执行的清理代码。
      // 对于 StirCallHandler，目前没有需要清理的资源，但这是正确的实现位置。
    });

    // 返回 null 作为 StirInfo 的初始状态。
    return null;
  }

  /// 【新增】: 实现 BaseCallHandler 的 `initialize` 方法。
  ///
  /// 在 Riverpod 的 Notifier 模式中，主要的初始化逻辑已经放在了 `build` 方法里。
  /// 因此，这个方法可以是一个空的实现，以满足接口要求。
  /// 如果有额外的、需要在 `build` 之外执行的异步初始化，可以放在这里。
  @override
  Future<void> initialize() async {
    // No-op, initialization is handled in `build`.
  }

  /// 【新增】: 实现 BaseCallHandler 的 `dispose` 方法。
  ///
  /// 在 Notifier 模式中，清理逻辑由 `ref.onDispose` 在 `build` 方法中注册。
  /// 这个方法同样可以是一个空的实现来满足接口。
  @override
  Future<void> dispose() async {
    // No-op, disposal is handled by `ref.onDispose`.
  }

  /// 处理来自原生平台（Android/iOS）的 MethodChannel 调用。
  ///
  /// 这个公共方法是本处理器与外部世界（特别是原生代码）交互的入口。
  /// 它会被 AndroidCallChannelManager 调用。
  /// 【修正】: 添加 @override 注解，明确表示这是对 BaseCallHandler 抽象方法的实现。
  @override
  dynamic handleMethodCall(MethodCall call) {
    // 使用 switch 语句根据方法名分发到不同的处理函数
    switch (call.method) {
      case "onStirInitializationComplete":
        return _handleInitializationComplete();
      case "onStirResult":
        // 解析参数并调用结果处理函数
        return _handleStirResult(
          call.arguments['isVerified'],
          call.arguments['isNotVerified'],
          call.arguments['isFailed'],
          call.arguments['phoneNumber'],
        );
      default:
        // 如果收到了未定义的方法名，抛出错误，方便调试
        throw UnimplementedError('StirCallHandler: 未实现的方法: ${call.method}');
    }
  }

  /// 处理 STIR 初始化完成的事件。
  ///
  /// 这是一个私有方法，目前没有具体逻辑，为未来扩展保留。
  void _handleInitializationComplete() {
    // STIR 初始化完成，可以在这里进行一些初始化操作（可选）
  }

  /// 处理 STIR 验证结果的核心逻辑。
  ///
  /// [isVerified], [isNotVerified], [isFailed], [phoneNumber] 是从原生代码传递过来的动态类型参数。
  void _handleStirResult(
    dynamic isVerified,
    dynamic isNotVerified,
    dynamic isFailed,
    dynamic phoneNumber,
  ) {
    // 安全地转换参数类型，如果类型不匹配或为null，则提供默认值 false
    final bool verified = isVerified is bool ? isVerified : false;
    final bool notVerified = isNotVerified is bool ? isNotVerified : false;
    final bool failed = isFailed is bool ? isFailed : false;
    final String? phoneNum = phoneNumber is String ? phoneNumber : null;

    // 创建一个新的 StirInfo 实例来封装结果
    final newStirInfo = StirInfo(
      isVerified: verified,
      isNotVerified: notVerified,
      isFailed: failed,
      phoneNumber: phoneNum,
    );

    // 更新 Provider 的状态。
    // Riverpod 会自动将这个新的状态通知给所有正在监听（listen/watch）
    // `stirCallHandlerProvider` 的其他 Provider 或 Widget。
    state = newStirInfo;

    // 保留额外的业务逻辑，例如在验证失败时执行某些操作
    if (failed) {
      // 可以在这里触发其他服务或记录日志
    }
  }
}