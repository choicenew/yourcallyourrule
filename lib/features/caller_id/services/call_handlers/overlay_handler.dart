
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/security_message_provider.dart';

/// 浮窗处理器
/// 负责处理来电显示浮窗的显示和关闭
class OverlayHandler {
  // 状态数据
  OverlayPosition? storedPosition;
  double? pixelRatio;
  
  // 配置相关
  final ConfigRepository _configRepository;
  late final ConfigurationManager _configManager;

  /// 构造函数
  OverlayHandler({ConfigRepository? configRepository}) 
      : _configRepository = configRepository ?? SharedPreferencesConfigRepository() {
    _configManager = ConfigurationManager(_configRepository);
  }

  /// 显示来电显示浮窗
  Future<void> showCallerIdOverlay(
      CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    // 创建样式提供者
    final styleProvider = CallerIdStyleProvider();
    final securityProvider = SecurityMessageProvider();
    
    // 从仓库加载配置
    await _configManager.loadFromRepository(styleProvider, securityProvider);

    // 更新并共享配置
    await updateAndShareConfiguration(styleProvider, securityProvider);

    // 获取当前 Overlay 位置，如果 Overlay 处于激活状态
    if (await FlutterOverlayWindow.isActive()) {
      storedPosition = await FlutterOverlayWindow.getOverlayPosition();
    } else {
      // 如果 Overlay 未激活，则初始化位置或使用默认位置
      storedPosition = storedPosition ?? const OverlayPosition(0, 0);
    }

    // 添加 configType 标识
    final dataToSend = {
      "configType": "callerIdData", // 添加 configType 字段
      ...callerIdData.toMap(),
    };

    // 传递 Map 对象
    FlutterOverlayWindow.shareData(dataToSend);

    if (stirInfo != null) {
      await FlutterOverlayWindow.shareData({
        "configType": "stirInfo", // 添加 configType 字段
        ...stirInfo.toJson(),
      });
    }

    if (simInfo != null) {
      await FlutterOverlayWindow.shareData({
        "configType": "simInfo", // 添加 configType 字段
        ...simInfo.toJson(),
      });
    }

    // 如果 Overlay 未激活，则显示 Overlay 并设置初始位置
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      overlayTitle: "Call",
      overlayContent:
          "name:${callerIdData.phoneNumber},region:${callerIdData.countryName},carrier:${callerIdData.carrier}",
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: (styleProvider.windowHeight * (pixelRatio ?? 3.0))
          .toInt(), // 使用 styleProvider.windowHeight
      width: (styleProvider.windowWidth * (pixelRatio ?? 3.0)).toInt(),
      startPosition: storedPosition!,
    );
  }

  /// 关闭浮窗
  void closeOverlay() {
    // 直接使用 FlutterOverlayWindow 关闭 overlay 应用
    FlutterOverlayWindow.closeOverlay();
  }

  /// 更新并共享配置
  Future<void> updateAndShareConfiguration(
      CallerIdStyleProvider styleProvider, SecurityMessageProvider securityProvider) async {
    // 创建配置对象
    final config = CallerIdConfigX.fromProviders(styleProvider, securityProvider);
    
    // 添加 configType 标识
    final dataToSend = {
      "configType": "callerIdStyle",
      ...config.toMap(),
    };

    // 传递 Map 对象
    FlutterOverlayWindow.shareData(dataToSend);
  }

  /// 设置像素比例
  void setPixelRatio(double ratio) {
    pixelRatio = ratio;
  }
}