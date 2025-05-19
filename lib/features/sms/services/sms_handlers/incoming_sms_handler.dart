import 'package:flutter/services.dart';
import 'package:yourcallyourrule/features/call_statistic/domain/repositories/blocked_call_repository.dart';
import 'base_sms_handler.dart';
import 'filter_handler.dart';
import 'notification_handler.dart';

/// 接收SMS处理器
/// 专门负责处理接收到的SMS
class IncomingSmsHandler extends BaseSmsHandler {
  final SmsFilterHandler _filterHandler;
  final SmsNotificationHandler _notificationHandler;
  final BlockedCallRepository _blockedCallRepository;

  /// 构造函数
  IncomingSmsHandler({
    required SmsFilterHandler filterHandler,
    required SmsNotificationHandler notificationHandler,
    BlockedCallRepository? blockedCallRepository,
  }) : 
    _filterHandler = filterHandler,
    _notificationHandler = notificationHandler,
    _blockedCallRepository = blockedCallRepository ?? BlockedCallRepository();

  /// 处理SMS通道调用
  @override
  Future<void> handleSmsChannelCall(MethodCall call) async {
    if (call.method == "onReceivedSms") {
      final String phoneNumber = call.arguments['phoneNumber'];
      final String messageContent = call.arguments['messageContent'];
      await handleIncomingSms(phoneNumber, messageContent);
    }
  }

  /// 处理接收到的SMS
  Future<void> handleIncomingSms(String phoneNumber, String messageContent) async {
    // 重新加载设置
    await _filterHandler.loadSettings();
    await _notificationHandler.loadSettings();

    // 如果过滤功能未启用，直接返回
    if (!_filterHandler.isEnabled) return;

    // 判断是否应该通知
    bool shouldNotifyUser = await _filterHandler.shouldNotify(phoneNumber, messageContent);

    // 根据过滤结果显示通知
    if (shouldNotifyUser) {
      await _notificationHandler.showSmsNotification(phoneNumber, messageContent);
    } else {
      // 显示拦截通知
      await _notificationHandler.showBlockedSmsNotification(phoneNumber);
      
      // 添加到短信拦截记录
      await _blockedCallRepository.addBlockedSms(phoneNumber);
    }
  }
}