import 'dart:async';
import '../entities/caller/caller_id_data.dart';
import '../entities/caller/stir_info.dart';
import '../entities/caller/sim_info.dart';
import '../value_objects/phone_number.dart';
import '../entities/config/caller_id_config.dart';

/// 来电监控服务接口
abstract class CallerIdMonitorService {
  /// 开始监控来电
  Future<void> startMonitoring();
  
  /// 停止监控来电
  Future<void> stopMonitoring();
  
  /// 处理来电事件
  Future<void> handleIncomingCall(PhoneNumber phoneNumber);
  
  /// 处理去电事件
  Future<void> handleOutgoingCall(PhoneNumber phoneNumber);
  
  /// 处理通话结束事件
  Future<void> handleCallEnded();
  
  /// 处理STIR验证信息
  Future<void> handleStirInfo(StirInfo stirInfo);
  
  /// 处理SIM卡信息
  Future<void> handleSimInfo(SimInfo simInfo);
  
  /// 判断是否应该接听来电
  Future<bool> shouldAcceptCall(PhoneNumber phoneNumber);
  
  /// 获取来电数据流
  Stream<CallerIdData> get callDataStream;
  
  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool value);
  
  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool value);
  
  /// 设置是否取消本地通知
  Future<void> setCancelLocalNotification(bool value);
  
  /// 加载设置
  Future<void> loadSettings();
  
  /// 更新并共享配置
  Future<void> updateAndShareConfiguration(CallerIdConfig config);
  
  /// 显示来电悬浮窗
  Future<void> showCallerIdOverlay(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo);
  
  /// 关闭悬浮窗
  Future<void> closeOverlay();
  
  /// 保存悬浮窗位置
  Future<void> saveOverlayPosition(double x, double y);
  
  /// 获取悬浮窗位置
  Future<Map<String, double>?> getOverlayPosition();
}