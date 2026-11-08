import 'dart:async';

/// 100% 编译期类型安全的设备操作/广播处理器签名 (0 物理依赖任何存储、数据库或网络 SDK)
typedef DeviceOperationHandler = Future<bool> Function(
  String action,
  Map<String, dynamic> payload,
);

/// 全局设备抽象接口句柄入口 (类似 SyncInterface / RenderAdInterface)
class DeviceInterface {
  static DeviceOperationHandler? _handler;

  /// 最外层 (装配层 Main App) 启动时单向注入设备处理器能力
  static void setDeviceHandler(DeviceOperationHandler handler) {
    _handler = handler;
  }

  /// 广播或触发设备操作，零物理依赖具体驱动
  static Future<bool> performDeviceOperation({
    required String action,
    required Map<String, dynamic> payload,
  }) async {
    if (_handler == null) {
      return false; // 未注入设备处理器时自动无感静默返回
    }
    return await _handler!(action, payload);
  }
}
