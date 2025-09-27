import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/services/notification_service_contract.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service_new.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/notification_handler.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_handlers/overlay_handler.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';

/// 显示模式处理器
/// 负责管理来电信息的显示方式（浮窗或通知）
class DisplayModeHandler {
  final OverlayHandler _overlayHandler;
  final NotificationHandler _notificationHandler;
  final CallerIdConfigRepository _configRepository;
  
  // 状态数据
  String _displayMode = 'overlay'; // 默认使用浮窗模式

  /// 构造函数
  DisplayModeHandler({
    required CallerIdConfigRepository configRepository,
       // 2. 添加 'notificationService' 作为必需的参数
    required NotificationServiceContract notificationService, 
    OverlayHandler? overlayHandler,
    NotificationHandler? notificationHandler,
  }) : 
    _configRepository = configRepository,
    _overlayHandler = overlayHandler ?? OverlayHandler(),
        // 3. 在这里，我们将从外部接收到的 `notificationService` 传递给 `NotificationHandler`
    _notificationHandler = notificationHandler ?? NotificationHandler(
      configRepository: configRepository,
      notificationService: notificationService, // <-- 将依赖传递进去
    ) {
    _loadDisplayMode();
  }
  
  /// 加载显示模式配置
  Future<void> _loadDisplayMode() async {
    _displayMode = await _configRepository.getDisplayMode();
  }
  
  /// 显示来电信息
  Future<void> showCallerIdInfo(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    // 根据配置选择显示方式
    if (_displayMode == 'overlay') {
      // 显示来电显示浮窗
      await _overlayHandler.showCallerIdOverlay(callerIdData, stirInfo, simInfo);
    } else if (_displayMode == 'notification') {
      final context = AppRouter.navigatorKey.currentContext;
      if (context == null) return;

      final isFraudCall = FraudDetectionService.checkForFraudLabels(callerIdData); 

      // 显示来电显示通知
      await _notificationHandler.showCallerIdNotification(
        title: AppLocalizations.of(context)!.callerIdNotificationTitle,
        body: AppLocalizations.of(context)!.callerIdBody(callerIdData.phoneNumber.value),
        callerIdData: callerIdData,
        isFraudCall: isFraudCall,
      );
    }
  }
  
  /// 关闭浮窗和通知
  void closeDisplay() {
    _overlayHandler.closeOverlay();
    // 可以添加关闭通知的逻辑
  }
  
  /// 设置显示模式
  Future<void> setDisplayMode(String mode) async {
    if (_displayMode != mode) {
      _displayMode = mode;
      await _configRepository.setDisplayMode(mode);
    }
  }
  
  /// 获取当前显示模式
  String get displayMode => _displayMode;
  
  /// 设置像素比例（用于浮窗显示）
  void setPixelRatio(double ratio) {
    _overlayHandler.setPixelRatio(ratio);
  }
  
  /// 获取通知处理器
  NotificationHandler get notificationHandler => _notificationHandler;
  
  /// 获取浮窗处理器
  OverlayHandler get overlayHandler => _overlayHandler;
}