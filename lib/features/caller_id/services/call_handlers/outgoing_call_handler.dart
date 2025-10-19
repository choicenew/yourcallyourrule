// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入项目中的实体类
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
// 导入它所依赖的 CallHandler Provider
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
// 导入为 OutgoingCallHandler 提供额外方法的扩展
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler_extension.dart';
// 【修正】: 不再需要导入 BaseCallHandler

// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'outgoing_call_handler.g.dart';

/// 去电处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OutgoingCallHandler 的单例，
/// 并通过 `ref` 将其所需要的核心依赖（`CallHandler`）注入进去。
///
/// 使用 `keepAlive: true` 确保这个单例在整个应用生命周期中都存在，
/// 以便能够随时处理去电事件。
@Riverpod(keepAlive: true)
OutgoingCallHandler outgoingCallHandler(Ref ref) {
  // 1. 从 Riverpod 获取共享的、唯一的 CallHandler Notifier 实例。
  //    我们使用 `.notifier` 来获取 Notifier 对象本身，因为它包含了我们需要调用的 `handleCall` 方法。
  final callHandler = ref.watch(callHandlerProvider.notifier);

  // 2. 将获取到的依赖注入到 OutgoingCallHandler 的构造函数中并返回。
  return OutgoingCallHandler(
    callHandler: callHandler,
  );
}


/// 去电处理器
/// 专门负责处理去电相关的逻辑
/// 【修正】: 移除了 `extends BaseCallHandler`，因为它不直接处理原生 MethodChannel 调用。
class OutgoingCallHandler {
  // 依赖现在通过 Provider 注入，而不是在外部手动创建
  final CallHandler _callHandler;

  /// 构造函数
  /// [callHandler] 由 Riverpod Provider 提供的 CallHandler Notifier 实例
  OutgoingCallHandler({
    required CallHandler callHandler,
  }) : _callHandler = callHandler;

  /// 处理去电的核心逻辑。
  ///
  /// 这个方法由外部（如 CallerIdMonitorService）在检测到去电事件时调用。
  /// [phoneNumber] 去电的电话号码
  /// [onCallerIdDataReceived] 一个回调函数，用于将获取到的来电显示数据传递出去
  Future<void> processOutgoingCall(String phoneNumber, Function(CallerIdData) onCallerIdDataReceived) async {
    // 1. 调用核心的 CallHandler 来处理通话，它会返回包含所有信息的 CallData 对象
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 2. 通过回调函数，将从 CallData 中提取的 CallerIdData 通知给调用方
    onCallerIdDataReceived(callData.callerIdData);
    
    // 3. 使用 `caller_id_handler_extension.dart` 中定义的扩展方法来记录本次去电
    //    这里的 `this` 指的是当前的 OutgoingCallHandler 实例
    this.recordOutgoingCallWithOptionalRecorder(phoneNumber, callData);
  }
}