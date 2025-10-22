// 导入 Riverpod 的代码生成注解包
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// 导入其他所有需要的包和文件
import 'package:flutter/material.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/features/notifications/providers/notification_providers.dart';
import 'package:yourcallyourrule/features/notifications/config/notification_config.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service.dart';
import 'package:yourcallyourrule/features/notifications/service/notification_service_contract.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service_new.dart';
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

  // 【恢复】: 内部状态变量，用于缓存在初始化时加载的配置。
  // 这是您原始的、正确的设计，因为它避免了每次都去异步读取 SharedPreferences。
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  bool useStirNotification = false;

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
    await loadSettings();
  }

  /// 从仓库加载设置并缓存在成员变量中
  Future<void> loadSettings() async {
    useLocalNotification = await _configRepository.getUseLocalNotification();
    cancelLocalNotification = await _configRepository.getCancelLocalNotification();
    useStirNotification = await _configRepository.getUseStirNotification();
    // 【DEBUG】
    debugPrint(">>> [NotificationHandler] Settings loaded: useLocal=$useLocalNotification, cancelLocal=$cancelLocalNotification, useStir=$useStirNotification");
  }

  // --- 【恢复】所有 set... 方法 ---
  // 它们负责更新内部缓存并将其写回仓库，这是您原始的、正确的逻辑。
  
  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (useLocalNotification == useLocal) return;
    useLocalNotification = useLocal;
    await _configRepository.setUseLocalNotification(useLocal);
    debugPrint(">>> [NotificationHandler] Setting 'useLocalNotification' updated to: $useLocal");
  }

  /// 设置是否关闭本地通知
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (cancelLocalNotification == cancelLocal) return;
    cancelLocalNotification = cancelLocal;
    await _configRepository.setCancelLocalNotification(cancelLocal);
    debugPrint(">>> [NotificationHandler] Setting 'cancelLocalNotification' updated to: $cancelLocal");
  }

  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool useStir) async {
    if (useStirNotification == useStir) return;
    useStirNotification = useStir;
    await _configRepository.setUseStirNotification(useStir);
    debugPrint(">>> [NotificationHandler] Setting 'useStirNotification' updated to: $useStir");
  }

  /// 显示拦截通知
  Future<void> showBlockedCallNotification(String phoneNumber) async {
    // 【DEBUG】
    debugPrint(">>> [NotificationHandler] Attempting to show BlockedCall notification. Is useLocalNotification enabled? $useLocalNotification");
    
    // 使用内部缓存的状态进行判断
    if (!useLocalNotification) return;
    
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) {
      debugPrint(">>> [NotificationHandler] Failed to show notification: context is null.");
      return;
    }

    debugPrint(">>> [NotificationHandler] Showing BlockedCall notification for $phoneNumber.");
    await _notificationService.showNotification(
      config: NotificationService.blockedCallConfig(context),
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
    // 【DEBUG】
    debugPrint(">>> [NotificationHandler] Attempting to show StirCall notification. Is useStirNotification enabled? $useStirNotification");
    
    if (!useStirNotification) return;

    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) {
      debugPrint(">>> [NotificationHandler] Failed to show StirCall notification: context is null.");
      return;
    }

    String stirResultMessage;
    if (isVerified) { stirResultMessage = AppLocalizations.of(context)!.stirVerified; }
    else if (isNotVerified) { stirResultMessage = AppLocalizations.of(context)!.stirNotVerified; }
    else if (isFailed) { stirResultMessage = AppLocalizations.of(context)!.stirFailed; }
    else { stirResultMessage = AppLocalizations.of(context)!.stirUnknown; }

    debugPrint(">>> [NotificationHandler] Showing StirCall notification for $phoneNumber with result: $stirResultMessage");
    await _notificationService.showNotification(
      config: NotificationService.stirResultConfig(context),
      title: AppLocalizations.of(context)!.stirVerificationTitle,
      body: AppLocalizations.of(context)!.stirVerificationBody(stirResultMessage, phoneNumber),
      notificationId: phoneNumber.hashCode,
      payload: {'type': 'call_history'},
    );
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
  }) async {
    debugPrint(">>> [NotificationHandler] Attempting to show CallerId notification. Is useLocalNotification enabled? $useLocalNotification");
    if (!useLocalNotification) return;

    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;
    
    // --- 1. 准备文本内容 ---
    final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData);
    final String name = callerIdData.name ?? 'Unknown';
    final String number = callerIdData.phoneNumber.value;
    
    String finalTitle;
    NotificationConfig notificationConfig;

    // --- 【核心修正】: 构建正文 (Body)，不再包含号码 ---
    final List<String> bodyParts = [];
    // 只有在有有效姓名时才加入
    if (name.isNotEmpty && name != 'Unknown') {
      bodyParts.add(name);
    }
    // 加入标签
    if (callerIdData.labels != null && callerIdData.labels!.isNotEmpty) {
      bodyParts.add(callerIdData.labels!.map((l) => l.label).join(', '));
    }
    // 加入位置信息
    final locationInfo = [callerIdData.region, callerIdData.carrier]
        .where((s) => s != null && s.isNotEmpty)
        .join(', ');
    if (locationInfo.isNotEmpty) {
      bodyParts.add(locationInfo);
    }
    // 将所有部分连接成最终的正文
    String finalBody = bodyParts.join(' - ');

    // --- 2. 根据是否诈骗，构建标题和配置 ---
    if (isFraudCall) {
      // 标题包含警告和号码
      finalTitle = "⚠️ ${AppLocalizations.of(context)!.fraudAlertTitle} ($number)";
      // 使用高优先级的诈骗配置
      notificationConfig = NotificationService.fraudAlertConfig(context);
      // 触发增强警告
      await FraudDetectionService.triggerFraudAlert(callerIdData.phoneNumber.value);
    } else {
      // 普通来电标题只包含“来电”和号码
      finalTitle = "${AppLocalizations.of(context)!.callerIdNotificationTitle} ($number)";
      // 使用默认配置
      notificationConfig = NotificationService.defaultConfig(context); 
    }

    // --- 3. 准备头像文件路径 (逻辑不变) ---
    String? avatarResourcePath;
    final String? labelText = (callerIdData.labels != null && callerIdData.labels!.isNotEmpty) ? callerIdData.labels!.first.label : null;
    if (callerIdData.avatar != null && callerIdData.avatar!.isNotEmpty) {
      avatarResourcePath = callerIdData.avatar;
    } else if (labelText != null && labelText.isNotEmpty) {
      avatarResourcePath = 'assets/avatars/$labelText.png';
    }
    String? avatarFilePath;
    if (avatarResourcePath != null) {
      avatarFilePath = await _assetService.prepareAsset(assetOrUrl: avatarResourcePath);
    }
    
    // --- 4. 构建通用的 NotificationStyle 对象 ---
    final notificationStyle = NotificationStyle(
      largeIconPath: avatarFilePath,
      // 【核心修正】: 颜色逻辑
      // 如果不是诈骗电话，我们使用从姓名生成的颜色。
      // 如果是诈骗电话，我们让它为 null，这样 `NotificationService` 就会使用
      // `fraudAlertConfig` 中定义的醒目的红色。
      color: isFraudCall ? null : AvatarUtils.getColorFromName(name),
      useBigTextStyle: true, // 告诉 NotificationService 使用大文本样式
    );
    
    // 5. 调用 `_notificationService` 显示通知
    await _notificationService.showNotification(
      config: notificationConfig,
      title: finalTitle,
      body: finalBody,
      notificationId: callerIdData.phoneNumber.value.hashCode,
      payload: {'type': 'call_history'},
      autoCancel: cancelLocalNotification,
      style: notificationStyle,
    );
  }
}