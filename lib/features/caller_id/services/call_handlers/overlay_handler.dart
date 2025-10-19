import 'package:floating_window_android/floating_window_android.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// 导入 Riverpod 代码生成注解
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/common/utils/global_variable.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
// 导入它所依赖的 Provider
import 'package:yourcallyourrule/features/call/caller_id/providers/callerid_style_security_provider.dart';

// part 指令是代码生成所必需的
part 'overlay_handler.g.dart';

/// 浮窗处理器 Provider
///
/// 这是一个简单的服务型 Provider。它的职责是创建并提供一个 OverlayHandler 的单例，
/// 并通过 `ref` 将其所需要的依赖（如配置 Provider）注入进去。
/// 这避免了在类内部手动创建 ProviderContainer 的反模式。
@Riverpod(keepAlive: true)
OverlayHandler overlayHandler(Ref ref) {
  // Provider 的创建函数，在这里进行依赖注入
  return OverlayHandler(ref);
}

/// 浮窗处理器
/// 负责处理来电显示浮窗的显示和关闭
class OverlayHandler {
  // 新增：持有 Riverpod 的 Ref 对象，用于访问其他 Provider
  final Ref _ref;

  // 状态数据
  OverlayPosition? storedPosition;

  // 修改：构造函数现在接收一个 Ref 对象
  OverlayHandler(this._ref);

  // 【移除】不再需要 _getCurrentConfig 这个性能低下的反模式方法
  /*
  Future<CallerIdConfig> _getCurrentConfig() async {
    final container = ProviderContainer();
    final config = await container.read(callerIdStyleSecurityProvider.future);
    container.dispose();
    return config;
  }
  */

  /// 懒加载并缓存设备像素比。
  Future<void> _ensurePixelRatio() async {
    // 使用全局变量来缓存像素比，避免重复调用
    pixelRatio ??= await FloatingWindowAndroid.getDevicePixelRatio();
  }

  /// 显示来电显示浮窗
  Future<void> showCallerIdOverlay(
    CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    
    // 【核心改动】
    // 通过注入的 _ref，以正确、高效的方式读取依赖的 Provider 的状态。
    // 我们在这里 watch provider，这样如果配置在未来变成可实时变化的，这里也能响应。
    final config = await _ref.read(callerIdStyleSecurityProvider.future);

    // 确保像素比已经被初始化
    await _ensurePixelRatio();

    // 更新并共享样式配置
    await updateAndShareConfiguration(config);

    // 获取当前 Overlay 位置
    if (await FloatingWindowAndroid.isShowing()) {
      storedPosition = await FloatingWindowAndroid.getOverlayPosition();
    } else {
      storedPosition = storedPosition ?? OverlayPosition(0, 0);
    }

    // 共享来电数据
    await FloatingWindowAndroid.shareData({
      "configType": "callerIdData",
      ...callerIdData.toMap(),
    });

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
      // 使用全局变量 pixelRatio，并通过 ?? 提供一个安全的回退值
      height: (config.windowHeight * (pixelRatio ?? 3.0)).toInt(),
      width: (config.windowWidth * (pixelRatio ?? 3.0)).toInt(),
      startPosition: storedPosition!,
    );
  }

  /// 关闭浮窗
  void closeOverlay() {
    FloatingWindowAndroid.closeOverlay();
  }

  /// 更新并共享配置
  Future<void> updateAndShareConfiguration(CallerIdConfig config) async {
    await FloatingWindowAndroid.shareData({
      "configType": "callerIdStyle",
      ...config.toMap(),
    });
  }

  // 【移除】不再需要外部设置像素比，由内部 _ensurePixelRatio 管理,，但保留以防止需要外部覆盖
 
  void setPixelRatio(double ratio) {
    pixelRatio = ratio;
  }
 
}