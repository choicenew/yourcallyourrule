import '../entities/caller/caller_id_data.dart';
import '../entities/caller/stir_info.dart';
import '../entities/caller/sim_info.dart';

/// 悬浮窗服务接口
abstract class OverlayService {
  /// 显示来电悬浮窗
  Future<void> showCallerIdOverlay(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo);
  
  /// 关闭悬浮窗
  Future<void> closeOverlay();
  
  /// 检查悬浮窗权限
  Future<bool> checkOverlayPermission();
  
  /// 请求悬浮窗权限
  Future<bool> requestOverlayPermission();
}