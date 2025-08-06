import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';

import 'package:yourcallyourrule/core/services/notification_service.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service_new.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 通知处理器
/// 专门负责处理通知相关的逻辑
class NotificationHandler {
  final NotificationService _notificationService;
  final CallerIdConfigRepository _configRepository;

  // 通知设置
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  bool useStirNotification = false;

  /// 构造函数
  NotificationHandler({
    NotificationService? notificationService,
    required CallerIdConfigRepository configRepository,
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  })  : _notificationService = notificationService ?? NotificationService(notificationsPlugin: notificationsPlugin),
        _configRepository = configRepository;

  /// 初始化通知
  Future<void> initialize() async {
    await loadSettings();
    // 初始化操作已移至NotificationService
  }

  /// 加载设置
  Future<void> loadSettings() async {
    useLocalNotification = await _configRepository.getUseLocalNotification();
    cancelLocalNotification = await _configRepository.getCancelLocalNotification();
    useStirNotification = await _configRepository.getUseStirNotification();
  }

  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;

    useLocalNotification = useLocal;
    await _configRepository.setUseLocalNotification(useLocal);
  }

  /// 设置是否关闭本地通知
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;

    cancelLocalNotification = cancelLocal;
    await _configRepository.setCancelLocalNotification(cancelLocal);
  }

  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool useStir) async {
    if (useStirNotification == useStir) return;

    useStirNotification = useStir;
    await _configRepository.setUseStirNotification(useStir);
  }

  /// 显示拦截通知
  Future<void> showBlockedCallNotification(String phoneNumber) async {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;
    await _notificationService.showNotification(
      config: NotificationService.blockedCallConfig,
      title: AppLocalizations.of(context)!.blockedCallTitle,
      body: AppLocalizations.of(context)!.blockedCallBody(phoneNumber),
      notificationId: phoneNumber.hashCode,
      payload: {'type': 'call_history'},
      autoCancel: cancelLocalNotification,
    );
  }

  /// 显示STIR验证通知
  Future<void> showStirCallNotification(String phoneNumber, bool isVerified,
      bool isNotVerified, bool isFailed) async {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    String stirResultMessage;

    if (isVerified) {
      stirResultMessage = AppLocalizations.of(context)!.stirVerified;
    } else if (isNotVerified) {
      stirResultMessage = AppLocalizations.of(context)!.stirNotVerified;
    } else if (isFailed) {
      stirResultMessage = AppLocalizations.of(context)!.stirFailed;
    } else {
      stirResultMessage = AppLocalizations.of(context)!.stirUnknown;
    }

    await _notificationService.showNotification(
      config: NotificationService.stirResultConfig,
      title: AppLocalizations.of(context)!.stirVerificationTitle,
      body: AppLocalizations.of(context)!.stirVerificationBody(stirResultMessage, phoneNumber),
      notificationId: phoneNumber.hashCode,
      payload: {'type': 'call_history'},
    );
  }

  /// 处理STIR信息
  Future<void> processStirInfo(StirInfo stirInfo) async {
    if (!useStirNotification) return;

    await showStirCallNotification(
      stirInfo.phoneNumber!,
      stirInfo.isVerified,
      stirInfo.isNotVerified,
      stirInfo.isFailed,
    );
  }
  

  /// 显示来电信息通知
  Future<void> showCallerIdNotification({
    required String title,
    required String body,
    required CallerIdData callerIdData,
    required bool isFraudCall,
  }) async {
    if (isFraudCall) {
      await FraudDetectionService.triggerFraudAlert(callerIdData.phoneNumber.value);
    }

    // 显示通知
    await _notificationService.showNotification(
      config: isFraudCall ? NotificationService.fraudAlertConfig : NotificationService.blockedCallConfig,
      title: title,
      body: body,
      notificationId: callerIdData.phoneNumber.value.hashCode,
      payload: {'type': 'call_history'},
      autoCancel: cancelLocalNotification,
    );
  }
}