// 导入 Flutter 的服务包，用于 MethodCall
import 'package:flutter/services.dart';
// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入 SIM 卡信息的实体类
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
// 【修正】: 重新导入 BaseCallHandler，以保持接口一致性
import 'base_call_handler.dart';

// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'sim_call_handler.g.dart';

/// SIM卡信息处理器 Provider
///
/// 使用 Riverpod 3.0 的 Notifier API 进行状态管理。
/// 它负责处理与SIM卡信息相关的原生方法调用，并将其结果作为状态（SimInfo）暴露出来。
///
/// 通过 @Riverpod 注解，代码生成器会自动创建一个名为 `simCallHandlerProvider` 的 Provider。
/// 我们使用 `keepAlive: true` 来确保这个处理器在应用后台运行时不会被自动销毁。
@Riverpod(keepAlive: true)
// 【修正】: 使用 `implements BaseCallHandler` 来确保符合工厂类的接口契约。
// 这要求我们必须实现 BaseCallHandler 中的所有方法。
class SimCallHandler extends _$SimCallHandler implements BaseCallHandler {
  /// build 方法是 Provider 的初始化入口。
  ///
  /// 当这个 Provider 第一次被读取时，该方法会被调用。
  /// 它必须返回 Notifier 管理的状态的初始值。
  @override
  SimInfo? build() {
    // 【新增】: 使用 ref.onDispose 来处理清理逻辑，对应 BaseCallHandler 的 dispose 方法。
    ref.onDispose(() {
      // 在这里可以放置当 Provider 被销毁时需要执行的清理代码。
      // 对于 SimCallHandler，目前没有需要清理的资源，但这是正确的实现位置。
    });

    // 返回 null 作为 SimInfo 的初始状态。
    return null;
  }

  /// 【新增】: 实现 BaseCallHandler 的 `initialize` 方法。
  ///
  /// 在 Riverpod 的 Notifier 模式中，主要的初始化逻辑已经放在了 `build` 方法里。
  /// 因此，这个方法可以是一个空的实现，以满足接口要求。
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
      case "onSimInitializationComplete":
        return _handleInitializationComplete();
      case "onSimInfo":
        // 解析 call.arguments 并调用结果处理函数
        // 这里假设 arguments 是一个 Map<dynamic, dynamic>
        final args = call.arguments as Map<dynamic, dynamic>? ?? {};
        return _handleSimInfo(
          args['carrierName'] as String?,
          args['displayName'] as String?,
          args['iccId'] as String?,
          args['countryIso'] as String?,
          args['incomingPhoneNumber'] as String?,
          args['simSlotIndex'] as int?,
          args['subscriptionId'] as int?,
          args['mccString'] as String?,
          args['mncString'] as String?,
          args['simPhoneNumber'] as String?,
          args['callType'] as String?,
        );
      default:
        // 如果收到了未定义的方法名，抛出错误，方便调试
        throw UnimplementedError('SimCallHandler: 未实现的方法: ${call.method}');
    }
  }

  /// 处理 SIM 初始化完成的事件。
  ///
  /// 这是一个私有方法，目前没有具体逻辑，为未来扩展保留。
  void _handleInitializationComplete() {
    // 初始化完成后的处理逻辑
  }

  /// 处理接收到的 SIM 卡信息的核心逻辑。
  ///
  /// 所有参数都是从原生代码传递过来的，类型可能为 null。
  void _handleSimInfo(
    String? carrierName,
    String? displayName,
    String? iccId,
    String? countryIso,
    String? phoneNumber,
    int? simSlotIndex,
    int? subscriptionId,
    String? mccString,
    String? mncString,
    String? simPhoneNumber,
    String? callType,
  ) {
    // 创建一个新的 SimInfo 实例来封装接收到的信息
    final newSimInfo = SimInfo(
      carrierName: carrierName,
      displayName: displayName,
      iccId: iccId,
      countryIso: countryIso,
      phoneNumber: phoneNumber,
      simSlotIndex: simSlotIndex,
      subscriptionId: subscriptionId,
      mccString: mccString,
      mncString: mncString,
      simPhoneNumber: simPhoneNumber,
      callType: callType,
    );

    // 更新 Provider 的状态。
    // 将 `state` 属性设置为新的 `newSimInfo` 对象。
    // Riverpod 会自动将这个新的状态通知给所有正在监听（listen/watch）
    // `simCallHandlerProvider` 的其他 Provider 或 Widget。
    state = newSimInfo;
  }
}