// lib/features/caller_id/services/call_handlers/overlay_handler.dart

import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // <-- 1. 导入 Riverpod
import 'package:yourcallyourrule/common/utils/global_variable.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
// <-- 2. 导入我们新的全局 Provider

import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';

// 删除了所有对旧 Provider 和 Manager 的 import

/// 浮窗处理器
/// 负责处理来电显示浮窗的显示和关闭
class OverlayHandler {
  // 状态数据
  OverlayPosition? storedPosition;
   // [REMOVED] 不再需要实例变量来存储 pixelRatio
  // double? pixelRatio; 
  
  // 构造函数现在非常简单，不再需要任何依赖
  OverlayHandler();

  /// 这是一个辅助方法，用于按需获取最新的配置。
  /// 它创建了一个临时的 ProviderContainer 来读取全局 Provider 的值。
  Future<CallerIdConfig> _getCurrentConfig() async {
    // 创建一个临时的、独立的 Provider 容器
    final container = ProviderContainer();
    // 从容器中异步读取我们全局 provider 的当前状态
    // .future 会等待 provider 初始化完成
    final config = await container.read(callerIdStyleSecurityProvider.future);
    // 使用完毕后，销毁容器以释放资源
    container.dispose();
    return config;
  }

  /// 显示来电显示浮窗 (方法签名保持不变！)
  Future<void> showCallerIdOverlay(
      CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    
    // 关键修改：不再自己创建和加载 Provider，而是直接获取最新的配置
    final config = await _getCurrentConfig();

    // 首先，更新并共享样式配置
    await updateAndShareConfiguration(config);

    // 获取当前 Overlay 位置
    if (await FloatingWindowAndroid.isShowing()) {
      storedPosition = await FloatingWindowAndroid.getOverlayPosition();
    } else {
      storedPosition = storedPosition ?? OverlayPosition(0, 0);
    }

    // 共享来电数据
    final dataToSend = {
      "configType": "callerIdData",
      ...callerIdData.toMap(),
    };
    await FloatingWindowAndroid.shareData(dataToSend);

    // 共享 STIR 信息
    if (stirInfo != null) {
      await FloatingWindowAndroid.shareData({ "configType": "stirInfo", ...stirInfo.toJson() });
    }

    // 共享 SIM 卡信息
    if (simInfo != null) {
      await FloatingWindowAndroid.shareData({ "configType": "simInfo", ...simInfo.toJson() });
    }

    // 显示 Overlay
    await FloatingWindowAndroid.showOverlay(
      enableDrag: true,
      overlayTitle: "Call",
      overlayContent: "name:${callerIdData.phoneNumber},region:${callerIdData.countryName},carrier:${callerIdData.carrier}",
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.lockScreen,
      notificationVisibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: (config.windowHeight * (pixelRatio ?? 3.0)).toInt(),
      width: (config.windowWidth * (pixelRatio ?? 3.0)).toInt(),
       //  height: (config.windowHeight ).toInt(),
    // width: (config.windowWidth).toInt(),
      startPosition: storedPosition!,
    );
  }

  /// 关闭浮窗 (保持不变)
  void closeOverlay() {
    FloatingWindowAndroid.closeOverlay();
  }

  /// 更新并共享配置
  /// 关键修改：这个方法现在接收 CallerIdConfig
  Future<void> updateAndShareConfiguration(CallerIdConfig config) async {
    final dataToSend = {
      "configType": "callerIdStyle",
      ...config.toMap(),
    };
    await FloatingWindowAndroid.shareData(dataToSend);
  }

  /// 设置像素比例 (保持不变)
  void setPixelRatio(double ratio) {
    pixelRatio = ratio;
  }
}