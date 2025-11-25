// lib/features/call/live_activities/handlers/live_activity_handler.dart

import 'package:flutter/foundation.dart';
import 'package:live_updates/live_updates.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/notification_payload_builder.dart';

import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';

import 'package:yourcallyourrule/features/call/live_activities/services/live_notification_config_service.dart';

import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart'; // 确保这个 import 存在
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service.dart';

part 'live_activity_handler.g.dart';

// --- 100% 模仿你的 notificationHandler Provider 模式 ---
@Riverpod(keepAlive: true)
Future<LiveActivityHandler> liveActivityHandler(Ref ref) async {
  final configRepository = ref.watch(configRepositoryProvider);
  final configService = LiveNotificationConfigService(configRepository);
  
  final handler = LiveActivityHandler(configService: configService);
  await handler.initialize();
  return handler;
}


/// Live Activity 处理器
/// 专门负责处理 Live Activity 相关的创建、更新和结束逻辑
class LiveActivityHandler {
  final LiveNotificationConfigService _configService;
  final Uuid _uuid;

  String? _currentActivityId;

  /// 构造函数
  LiveActivityHandler({
    required LiveNotificationConfigService configService,
  })  : _configService = configService,
        _uuid = const Uuid();

  /// 初始化
  Future<void> initialize() async {
    // live_updates 无需插件实例初始化，这里保留空实现以兼容调用方。
  }

  /// 显示或更新来电信息 Live Activity
  Future<void> showCallerIdActivity({
    required CallerIdData callerIdData,
    required SimInfo? simInfo,
    required StirInfo? stirInfo,
  }) async {
    try {
      // 计算并设置通知标题：号码与 SIM 信息进入系统头部
      final context = AppRouter.navigatorKey.currentContext;
      final String numberDisplay = callerIdData.phoneNumber.value;
      final String simSuffix = simInfo == null ? '' : '-SIM${simInfo.simSlotIndex! + 1}';
      final bool isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
      final String finalTitle = () {
        if (context != null) {
          if (isFraudCall) {
            return "⚠️ ${AppLocalizations.of(context)!.fraudAlertTitle} ($numberDisplay)$simSuffix";
          } else {
            return "${AppLocalizations.of(context)!.callerIdNotificationTitle} ($numberDisplay)$simSuffix";
          }
        }
        // 无 context 回退，保持可读性
        return "Incoming Call ($numberDisplay)$simSuffix";
      }();

      // 本地化安全消息文本
      final String securityMessageText = () {
        if (context != null) {
          return AppLocalizations.of(context)!.securityMessage;
        }
        // 无上下文时的英文回退文本
        return 'Do not trust any phone calls. Always verify customer service numbers independently. Never share passwords, verification codes, card numbers, or personal information.';
      }();

      final config = await _configService.loadConfigOrDefault();
      final payload = await LiveNotificationPayloadBuilder.build(
        config,
        callerIdData,
        simInfo,
        stirInfo,
        securityMessage: securityMessageText,
      );

      // --- 新增代码: 创建用于导航的 payload ---
      final navigationPayload = {
        'type': 'call_history',
        // 您也可以在这里添加其他需要的数据，例如通话记录的 ID
        // 'call_id': callerIdData.id,
      };
      // -------------------------------------

      if (_currentActivityId != null) {
        await LiveUpdates.showLayoutNotification(
          notificationId: _currentActivityId!.hashCode,
          layoutName: 'live_activity',
          smallIconName: 'ic_notification',
          title: finalTitle,
          ongoing: true,
          viewData: payload,
          // --- 新增代码: 传递 payload ---
          payload: jsonEncode(navigationPayload),
          // --------------------------------
        );
      } else {
        final newActivityId = _uuid.v4();
        await LiveUpdates.showLayoutNotification(
          notificationId: newActivityId.hashCode,
          layoutName: 'live_activity',
          smallIconName: 'ic_notification',
          title: finalTitle,
          ongoing: true,
          viewData: payload,
          // --- 新增代码: 传递 payload ---
          payload: jsonEncode(navigationPayload),
          // --------------------------------
        );
        _currentActivityId = newActivityId;
      }
    } catch (e) {
      debugPrint('Failed to show/update Live Activity: $e');
    }
  }

  /// 结束当前的 Live Activity
  Future<void> endActivity() async {
    if (_currentActivityId != null) {
      try {
        await LiveUpdates.cancelNotification(_currentActivityId!.hashCode);
        _currentActivityId = null;
      } catch (e) {
        debugPrint('Failed to end Live Activity: $e');
        _currentActivityId = null;
      }
    }
  }
}