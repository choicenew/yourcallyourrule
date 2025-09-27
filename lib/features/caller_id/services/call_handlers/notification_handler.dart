// features/caller_id/handlers/notification_handler.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/notification_providers.dart';

import 'package:yourcallyourrule/core/services/notification_service.dart';
import 'package:yourcallyourrule/core/services/notification_service_contract.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_provider.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service_new.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

part 'notification_handler.g.dart';

@Riverpod(keepAlive: true)
Future<NotificationHandler> notificationHandler(Ref ref) async {
  final notificationService = ref.watch(notificationServiceProvider);
  final configRepository = ref.watch(callerIdConfigRepositoryProvider); 
  
  final handler = NotificationHandler(
    notificationService: notificationService,
    configRepository: configRepository,
  );
  await handler.initialize();
  return handler;
}

/// 通知处理器
/// 专门负责处理通知相关的逻辑
class NotificationHandler {
  final NotificationServiceContract _notificationService;
  final CallerIdConfigRepository _configRepository;

  // 通知设置
  bool useLocalNotification = false;
  bool cancelLocalNotification = false;
  bool useStirNotification = false;

  /// 构造函数
  NotificationHandler({
    required NotificationServiceContract notificationService,
    required CallerIdConfigRepository configRepository,
  })  : _notificationService = notificationService,
        _configRepository = configRepository;

  /// 初始化通知
  Future<void> initialize() async {
    await loadSettings();
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
    if (!useLocalNotification) return;
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    
    
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
    if (!useStirNotification) return;
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    
    String stirResultMessage;

    if (isVerified) { stirResultMessage = AppLocalizations.of(context)!.stirVerified; }
    else if (isNotVerified) { stirResultMessage = AppLocalizations.of(context)!.stirNotVerified; }
    else if (isFailed) { stirResultMessage = AppLocalizations.of(context)!.stirFailed; }
    else { stirResultMessage = AppLocalizations.of(context)!.stirUnknown; }

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
    if (!useLocalNotification) return;



        // 1. 在任何 await 之前，立即获取 context。
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    // 2. 同样在 await 之前，使用 context 准备好所有需要的数据。
    // 在这里，我们提前创建好 notificationConfig。
    final notificationConfig = isFraudCall 
        ? NotificationService.fraudAlertConfig(context) 
        : NotificationService.blockedCallConfig(context);


    if (isFraudCall) {
      // 3. 现在可以安全地执行异步操作了。
      await FraudDetectionService.triggerFraudAlert(callerIdData.phoneNumber.value);
    }


    // 4. 在 await 之后，使用我们预先准备好的 notificationConfig 变量，
    // 而不是直接使用可能已经失效的 context。
    await _notificationService.showNotification(
      config: notificationConfig,
      title: title,
      body: body,
      notificationId: callerIdData.phoneNumber.value.hashCode,
      payload: {'type': 'call_history'},
      autoCancel: cancelLocalNotification,
    );
  }
}