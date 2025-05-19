import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/entities/call/call_data.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/call_filter/call_filter_service.dart';
import 'package:yourcallyourrule/features/call/time_interceptor/time_interceptor_service.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';

import '../call_handlers/call_handler.dart';
import '../call_handlers/notification_handler.dart';
import '../call_handlers/should_accept_call_handler.dart';

/// 来电处理器
/// 专门负责处理来电相关的逻辑
class IncomingCallHandler {
  final CallHandler _callHandler;
  final CallFilterService _callFilterService;
  final TimeInterceptorService _timeInterceptorService;
  final ShouldAcceptCallHandler _shouldAcceptCallHandler;
  final NotificationHandler _notificationHandler;
  final BlockedCallRepository _blockedCallRepository;
  
  /// 构造函数
  IncomingCallHandler({
    required CallHandler callHandler,
    required CallFilterService callFilterService,
    required TimeInterceptorService timeInterceptorService,
    required ShouldAcceptCallHandler shouldAcceptCallHandler,
    required NotificationHandler notificationHandler,
    BlockedCallRepository? blockedCallRepository,
  }) : 
    _callHandler = callHandler,
    _callFilterService = callFilterService,
    _timeInterceptorService = timeInterceptorService,
    _shouldAcceptCallHandler = shouldAcceptCallHandler,
    _notificationHandler = notificationHandler,
    _blockedCallRepository = blockedCallRepository ?? BlockedCallRepository();

  /// 处理来电
  Future<void> processIncomingCall(String phoneNumber, Function(CallerIdData) onCallerIdDataReceived) async {
    // 处理通话并获取通话数据
    CallData callData = await _callHandler.handleCall(phoneNumber);
    
    // 通知监听器
    onCallerIdDataReceived(callData.callerIdData);

    // 使用列表和 any 方法进行优先级判断
    final numbersToTest = [
      phoneNumber,
      callData.nationalNumber,
      callData.e164Number
    ].whereType<String>();

    await _callFilterService.loadConfig(); // 重新加载配置
    await _timeInterceptorService.loadConfig();

    final shouldAccept = await Future.any(
      numbersToTest.map((number) async {
        bool shouldAccept = await _callFilterService.shouldAcceptCall(number);
        // 如果 _callFilterService 不允许接听，再判断 _timeInterceptorService 的结果
        if (!shouldAccept && _timeInterceptorService.config.shouldIntercept) {
          shouldAccept = !await _timeInterceptorService.shouldIntercept(number);
        }

        return shouldAccept;
      }),
    );

    // 发送决策结果
    _shouldAcceptCallHandler.sendDecision(shouldAccept);

    if (!shouldAccept) {
      // 拦截来电
      await _handleCallRejection(phoneNumber);
    }
  }

  /// 处理拒接来电
  Future<void> _handleCallRejection(String phoneNumber) async {
    // 从 SharedPreferences 读取拦截方式
    final prefs = await SharedPreferences.getInstance();
    final interceptAction = prefs.getString('intercept_action') ?? 'endCall';
    
    // 显示通知（如果启用）
    if (_notificationHandler.useLocalNotification) {
      await _notificationHandler.showBlockedCallNotification(phoneNumber);
    }
    
    // 添加到拦截记录
    await _blockedCallRepository.addBlockedCall(phoneNumber);
  }
}