// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入项目中的实体类和接口
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/provider/providers/enhanced_composite_filter_service_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/time_interceptor_service_provider.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_interface.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/providers/blocked_call_repository_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
// 导入所有依赖的 Provider
// 【注意】请确保这些 provider 文件的路径是正确的
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/caller_id_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/should_accept_call_handler.dart';



// 导入为 IncomingCallHandler 提供额外方法的扩展
import 'caller_id_handler_extension.dart';

// part 指令是代码生成所必需的，它会链接到由 build_runner 生成的文件
part 'incoming_call_handler.g.dart';

/// 来电处理器 Provider
///
/// 这是一个服务型 Provider，负责创建并提供一个 IncomingCallHandler 的单例。
/// 它是一个高层级的业务流程编排器，通过 `ref` 将所有它需要的、更底层的服务
/// （如 CallHandler, CallFilterService 等）注入进来。
///
/// 【修正】这是一个异步 Provider，因为它依赖于一个或多个 FutureProvider (如 NotificationHandler)。
/// 它的创建过程是异步的，使用它的地方需要 `await` 它的 `.future`。
@Riverpod(keepAlive: true)
Future<IncomingCallHandler> incomingCallHandler(Ref ref) async {
  // 1. 从 Riverpod 获取所有依赖的、共享的服务实例。
  final callHandler = ref.watch(callHandlerProvider.notifier);
  final callFilterService = ref.watch(enhancedCompositeFilterServiceProvider);
  final timeInterceptorService = ref.watch(timeInterceptorServiceProvider);
  final shouldAcceptCallHandler = ref.watch(shouldAcceptCallHandlerProvider);
  // NotificationHandler 是一个 FutureProvider，我们必须 `await` 它才能获取到实例。
  final notificationHandler = await ref.watch(notificationHandlerProvider.future);
  final configRepository = ref.watch(callerIdConfigRepositoryProvider);
  final blockedCallRepository = ref.watch(blockedCallRepositoryProvider);

  // 2. 将所有获取到的依赖注入到 IncomingCallHandler 的构造函数中并返回。
  return IncomingCallHandler(
    callHandler: callHandler,
    callFilterService: callFilterService,
    timeInterceptorService: timeInterceptorService,
    shouldAcceptCallHandler: shouldAcceptCallHandler,
    notificationHandler: notificationHandler,
    configRepository: configRepository,
    blockedCallRepository: blockedCallRepository,
  );
}


/// 来电处理器
/// 专门负责处理来电相关的逻辑
/// 【修正】: 移除了 `extends BaseCallHandler`，因为它不直接处理原生 MethodChannel 调用。
class IncomingCallHandler {
  final CallHandler _callHandler;
  final CallFilterInterface _callFilterService;
  final TimeInterceptorService _timeInterceptorService;
  final ShouldAcceptCallHandler _shouldAcceptCallHandler;
  final NotificationHandler _notificationHandler;
  final BlockedCallRepository _blockedCallRepository;
  final CallerIdConfigRepository _configRepository;
  
  /// 构造函数
  /// 所有依赖都由 Riverpod Provider 注入
  IncomingCallHandler({
    required CallHandler callHandler,
    required CallFilterInterface callFilterService,
    required TimeInterceptorService timeInterceptorService,
    required ShouldAcceptCallHandler shouldAcceptCallHandler,
    required NotificationHandler notificationHandler,
    required CallerIdConfigRepository configRepository,
    required BlockedCallRepository blockedCallRepository,
  }) : 
    _callHandler = callHandler,
    _callFilterService = callFilterService,
    _timeInterceptorService = timeInterceptorService,
    _shouldAcceptCallHandler = shouldAcceptCallHandler,
    _notificationHandler = notificationHandler,
    _configRepository = configRepository,
    _blockedCallRepository = blockedCallRepository;

  /// 处理来电的核心逻辑
  /// [phoneNumber] 来电号码
  /// [onCallerIdDataReceived] 用于传递数据出去的回调
  /// [simInfo] 可选的SIM卡信息
  Future<void> processIncomingCall(String phoneNumber, Function(CallerIdData) onCallerIdDataReceived, {SimInfo? simInfo}) async {
    // 1. 调用核心 CallHandler 处理通话，获取详细数据
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 2. 通过回调通知调用方 CallerIdData 已准备好
    onCallerIdDataReceived(callData.callerIdData);

    // 3. 准备需要被过滤服务测试的号码列表（过滤掉空字符串和null）
    final numbersToTest = [
      phoneNumber,
      callData.nationalNumber,
      callData.e164Number
    ].where((n) => n.isNotEmpty).cast<String>();

    // 4. 初始化依赖的服务（如果需要）
    if (_callFilterService is EnhancedCompositeFilterService) {
      await (_callFilterService).initialize();
    }
    await _timeInterceptorService.loadConfig();

    // 5. 并行地对所有可能的号码格式进行过滤检查，只要有一个通过即可
    final shouldAccept = await Future.any(
      numbersToTest.map((number) async {
        bool decision;
        
        if (_callFilterService is EnhancedCompositeFilterService && simInfo != null) {
          decision = await (_callFilterService).shouldAcceptCallWithSim(number, simInfo: simInfo);
        } else {
          decision = await _callFilterService.shouldAcceptCall(number);
        }
        
        // 如果被过滤服务拒绝，再检查时间拦截服务是否也拒绝
        if (!decision && _timeInterceptorService.config.shouldIntercept) {
          // 时间拦截服务返回 true 是要拦截，所以需要取反来得到“是否应该接听”
          decision = !await _timeInterceptorService.shouldIntercept(number);
        }

        return decision;
      }),
    );

    // 6. 将最终的决策（接听或拒绝）发送给正在等待的原生调用
    _shouldAcceptCallHandler.sendDecision(shouldAccept);

    // 7. 如果最终决策是拒绝，则执行拦截处理
    if (!shouldAccept) {
      await _handleCallRejection(phoneNumber, callData);
    }
  }

  /// 处理电话被拒绝/拦截的私有方法
  Future<void> _handleCallRejection(String phoneNumber, [CallData? callData]) async {
    // 从配置仓库读取用户设置的拦截方式（例如：挂断、静音等）
    // final interceptAction = await _configRepository.getInterceptAction();
    // 此处可以根据 interceptAction 执行具体操作，但当前代码未实现
    
    // 如果用户开启了通知，则显示一个电话被拦截的通知
    if (_notificationHandler.useLocalNotification) {
      await _notificationHandler.showBlockedCallNotification(phoneNumber);
    }
    
    // 将被拦截的电话号码添加到本地存储的拦截记录中
    await _blockedCallRepository.addBlockedCall(phoneNumber);
    
    // 如果有完整的 CallData，也使用扩展方法进行记录
    if (callData != null) {
      this.recordBlockedCallWithOptionalRecorder(phoneNumber, callData);
    }
  }
}