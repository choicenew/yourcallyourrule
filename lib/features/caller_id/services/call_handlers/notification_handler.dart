// 导入 Riverpod 的代码生成注解包
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入其他所有需要的包和文件
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
import 'package:yourcallyourrule/features/notifications/config/notification_config.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service_contract.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:yourcallyourrule/features/call/caller_id/core/extensions/phone_number_type_extension.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_asset_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

// part 指令
part 'notification_handler.g.dart';

/// 通知处理器 Provider
///
/// 【恢复并修正】: 这是一个 FutureProvider，因为它所创建的 NotificationHandler
/// 需要执行异步的 `initialize()` 方法来加载配置。
/// 这是您原始的、正确的设计。
@Riverpod(keepAlive: true)
Future<NotificationHandler> notificationHandler(Ref ref) async {
  // 1. 获取所有依赖
  final notificationService = ref.watch(notificationServiceProvider);
  final configRepository = ref.watch(callerIdConfigRepositoryProvider); 
    // 【新增】获取新的资源服务
  final assetService = ref.watch(notificationAssetServiceProvider);

  // 2. 创建 handler 实例
  final handler = NotificationHandler(
    notificationService: notificationService,
    configRepository: configRepository,
    assetService: assetService, // 【新增】注入依赖
  );

  // 3. await 它的异步初始化方法
  await handler.initialize();
  
  // 4. 返回完全就绪的 handler 实例
  return handler;
}

/// 通知处理器
/// 专门负责处理通知相关的逻辑
class NotificationHandler {
  final NotificationServiceContract _notificationService;
  final CallerIdConfigRepository _configRepository;
  // 【新增】依赖新的资源服务
  final NotificationAssetService _assetService;

 
 
 
 
 

  /// 构造函数
  NotificationHandler({
    required NotificationServiceContract notificationService,
    required CallerIdConfigRepository configRepository,
    required NotificationAssetService assetService, // 【新增】构造函数参数
  })  : _notificationService = notificationService,
        _configRepository = configRepository,
        _assetService = assetService; // 【新增】初始化依赖

  /// 初始化通知处理器
  Future<void> initialize() async {
    // 调用加载设置
   
  }

          
       
       
  /// 显示拦截通知
  Future<void> showBlockedCallNotification(String phoneNumber) async {
    try {
      final useLocalNotification = await _configRepository.getUseLocalNotification();
      debugPrint(">>> [NotificationHandler] Attempting to show BlockedCall notification. Is useLocalNotification enabled? $useLocalNotification");
      if (!useLocalNotification) return;
      
      final context = AppRouter.navigatorKey.currentContext;
      if (context == null) {
        debugPrint(">>> [NotificationHandler] Failed to show notification: context is null.");
        return;
      }
      final cancelNotification = await _configRepository.getCancelLocalNotification();
      final cancelDelay = await _configRepository.getNotificationAutoCancelDelay();

      final l10n = AppLocalizations.of(context);
      final String title = l10n?.blockedCallTitle ?? 'Call Blocked';
      final String body = l10n?.blockedCallBody(phoneNumber) ?? 'Blocked call from $phoneNumber';

      debugPrint(">>> [NotificationHandler] Showing BlockedCall notification for $phoneNumber.");
      await _notificationService.showNotification(
        config: NotificationService.blockedCallConfig(context),
        title: title,
        body: body,
        notificationId: phoneNumber.hashCode,
        payload: {'type': 'call_history'},
        autoCancel: cancelNotification,
        autoCancelDelay: cancelDelay,
      );
    } catch (e, stack) {
      debugPrint(">>> [NotificationHandler] Error in showBlockedCallNotification: $e\n$stack");
    }
  }

  /// 显示STIR验证通知
  Future<void> showStirCallNotification(String phoneNumber, bool isVerified,
      bool isNotVerified, bool isFailed) async {
    try {
      final useStirNotification = await _configRepository.getUseStirNotification();
      debugPrint(">>> [NotificationHandler] Attempting to show StirCall notification. Is useStirNotification enabled? $useStirNotification");
      
      if (!useStirNotification) return;

      final context = AppRouter.navigatorKey.currentContext;
      if (context == null) {
        debugPrint(">>> [NotificationHandler] Failed to show StirCall notification: context is null.");
        return;
      }
      final cancelNotification = await _configRepository.getCancelLocalNotification();
      final cancelDelay = await _configRepository.getNotificationAutoCancelDelay();
      final l10n = AppLocalizations.of(context);
    
      String stirResultMessage;
      if (isVerified) { stirResultMessage = l10n?.stirVerified ?? 'STIR Pass'; }
      else if (isNotVerified) { stirResultMessage = l10n?.stirNotVerified ?? 'STIR Not Pass'; }
      else if (isFailed) { stirResultMessage = l10n?.stirFailed ?? 'Verification Failed'; }
      else { stirResultMessage = l10n?.stirUnknown ?? 'Unknown Verification Status'; }

      final String title = l10n?.stirVerificationTitle ?? 'STIR Status';
      final String body = l10n?.stirVerificationBody(stirResultMessage, phoneNumber) ?? '$stirResultMessage: $phoneNumber';

      debugPrint(">>> [NotificationHandler] Showing StirCall notification for $phoneNumber with result: $stirResultMessage");
      await _notificationService.showNotification(
        config: NotificationService.stirResultConfig(context),
        title: title,
        body: body,
        notificationId: phoneNumber.hashCode,
        payload: {'type': 'call_history'},
        autoCancel: cancelNotification,
        autoCancelDelay: cancelDelay,
      );
    } catch (e, stack) {
      debugPrint(">>> [NotificationHandler] Error in showStirCallNotification: $e\n$stack");
    }
  }

  /// 处理STIR信息
  Future<void> processStirInfo(StirInfo stirInfo) async {
    if (stirInfo.phoneNumber == null) return;
    await showStirCallNotification(
      stirInfo.phoneNumber!,
      stirInfo.isVerified,
      stirInfo.isNotVerified,
      stirInfo.isFailed,
    );
  }
  
  /// 显示来电信息通知
  Future<void> showCallerIdNotification({
    required CallerIdData callerIdData,
    required SimInfo? simInfo,
    required StirInfo? stirInfo,
    bool forceShow = false,
  }) async {
    try {
      final useLocalNotification = await _configRepository.getUseLocalNotification();
      debugPrint(">>> [NotificationHandler] Attempting to show CallerId notification. Is useLocalNotification enabled? $useLocalNotification, forceShow: $forceShow");
      if (!useLocalNotification && !forceShow) return;

      final context = AppRouter.navigatorKey.currentContext;
      if (context == null) {
        debugPrint(">>> [NotificationHandler] Context is null, skipping showCallerIdNotification.");
        return;
      }
      
      final cancelNotification = await _configRepository.getCancelLocalNotification();
      final cancelDelay = await _configRepository.getNotificationAutoCancelDelay();
      final l10n = AppLocalizations.of(context);

      // --- 1. 准备文本内容 ---
      final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
      final String name = callerIdData.name ?? 'Unknown';
      final String number = callerIdData.phoneNumber.value;
      
      String finalTitle;
      NotificationConfig notificationConfig;

      // --- 【核心修正】: 按绝对优先级构建正文 (Body) ---
      final List<String> bodyParts = [];
      // 1. 姓名 (如果有有效姓名)
      if (name.isNotEmpty && name != 'Unknown') {
        bodyParts.add(name);
      }
      // 2. 类别 / 标签
      if (callerIdData.labels != null && callerIdData.labels!.isNotEmpty) {
        bodyParts.add(callerIdData.labels!.map((l) => l.label).join(', '));
      }
      // 3. 标记次数
      if (callerIdData.count > 0 && l10n != null) {
        bodyParts.add(l10n.callerIdMarkedByCount(callerIdData.count));
      }
      // 4. SIM 卡槽
      if (simInfo?.displayName != null && simInfo!.displayName!.isNotEmpty) {
        bodyParts.add(simInfo.displayName!);
      }
      // 5. 运营商与位置信息
      final locationInfo = [callerIdData.carrier, callerIdData.region, callerIdData.countryName]
          .where((s) => s != null && s.isNotEmpty)
          .join(', ');
      if (locationInfo.isNotEmpty) {
        bodyParts.add(locationInfo);
      }
      // 6. 号码类型 (本地化)
      if (callerIdData.numberType != PhoneNumberType.unknown) {
        bodyParts.add(callerIdData.numberType.translated(context));
      }
      // 7. STIR 校验结果 (仅在存在且校验通过时显示)
      if (stirInfo != null && stirInfo.isVerified && l10n != null) {
        bodyParts.add(l10n.stirVerified);
      }

      // 将所有部分连接成最终的正文
      String finalBody = bodyParts.join(' - ');

      // --- 2. 根据是否诈骗，构建标题和配置 ---
      if (isFraudCall) {
        final String fraudTitle = l10n?.fraudAlertTitle ?? 'Fraud Alert';
        finalTitle = "⚠️ $fraudTitle ($number)${simInfo == null ? '' : '-SIM${simInfo.simSlotIndex! + 1}'}";
        notificationConfig = NotificationService.fraudAlertConfig(context);
        await FraudDetectionService.triggerFraudAlert(callerIdData.phoneNumber.value);
      } else {
        final String callerIdTitle = l10n?.callerIdNotificationTitle ?? 'Incoming Call';
        finalTitle = "$callerIdTitle ($number)";
        notificationConfig = NotificationService.defaultConfig(context); 
      }

      // --- 3. 准备头像文件路径 (逻辑不变) ---
      String? avatarResourcePath;
      final String? labelText = (callerIdData.labels != null && callerIdData.labels!.isNotEmpty) ? callerIdData.labels!.first.label : null;
      if (callerIdData.avatar != null && callerIdData.avatar!.isNotEmpty) {
        avatarResourcePath = callerIdData.avatar;
      } else if (labelText != null && labelText.isNotEmpty) {
        avatarResourcePath = AvatarUtils.getSafeAvatarPath(labelText);
      }
      String? avatarFilePath;
      if (avatarResourcePath != null) {
        try {
          avatarFilePath = await _assetService.prepareAsset(assetOrUrl: avatarResourcePath);
        } catch (e) {
          debugPrint(">>> [NotificationHandler] Failed to prepare avatar asset: $e");
        }
      }
      
      // --- 4. 构建通用的 NotificationStyle 对象 ---
      final notificationStyle = NotificationStyle(
        largeIconPath: avatarFilePath,
        color: isFraudCall ? null : AvatarUtils.getColorFromName(name),
        useBigTextStyle: true,
      );
      
      // 5. 调用 `_notificationService` 显示通知
      await _notificationService.showNotification(
        config: notificationConfig,
        title: finalTitle,
        body: finalBody,
        notificationId: callerIdData.phoneNumber.value.hashCode,
        payload: {'type': 'call_history'},
        autoCancel: cancelNotification,
        autoCancelDelay: cancelDelay,
        style: notificationStyle,
      );
    } catch (e, stack) {
      debugPrint(">>> [NotificationHandler] Error in showCallerIdNotification: $e\n$stack");
    }
  }
}