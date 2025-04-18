import 'dart:async';

import 'call_channel_adapter.dart';
import '../../lib/domain/entities/call/call_log.dart';
import '../../lib/domain/entities/call/caller_id_data.dart';
import '../../lib/domain/entities/call/stir_info.dart';
import '../../lib/domain/entities/call/sim_info.dart';
import '../../lib/domain/value_objects/phone_number.dart';
import '../../lib/domain/value_objects/rule_action.dart';
import '../../lib/infrastructure/services/base_service_impl.dart';
import '../../lib/infrastructure/services/notification_service_impl.dart';
import 'call_overlay_service_impl.dart';
import 'caller_id_service_impl.dart';
import 'should_accept_service_impl.dart';

/// 来电监控服务实现
/// 负责监听来电事件并调用来电识别服务进行处理
class CallerIdMonitorServiceImpl extends BaseServiceImpl {
  final CallerIdServiceImpl _callerIdService;
  final CallChannel _callChannel;
  final ShouldAcceptServiceImpl _shouldAcceptService;
  final CallOverlayServiceImpl _callOverlayService;
  final NotificationServiceImpl _notificationService;
  
  StreamSubscription? _callSubscription;
  StreamSubscription? _stirInfoSubscription;
  StreamSubscription? _simInfoSubscription;
  bool _isMonitoring = false;
  
  // 存储最新的STIR和SIM信息
  StirInfo? _lastStirInfo;
  SimInfo? _lastSimInfo;
  
  // 通知设置
  bool _useLocalNotification = false;
  bool _cancelLocalNotification = false;
  bool _useStirNotification = false;
  
  static const String callLocalNotificationKey = 'call_local_notification';
  static const String callCancelLocalNotificationKey = 'call_cancel_local_notification';
  static const String stirLocalNotificationKey = 'stir_local_notification';
  
  CallerIdMonitorServiceImpl(
    this._callerIdService,
    this._callChannel,
    this._shouldAcceptService,
    this._callOverlayService,
    this._notificationService,
  );
  
  /// 开始监控来电
  Future<void> startMonitoring() async {
    if (_isMonitoring) return;
    
    try {
      await _callChannel.initialize();
      await _shouldAcceptService.initialize();
      await _callOverlayService.initialize();
      await _notificationService.initialize();
      await _loadSettings();
      
      _callSubscription = _callChannel.callStream.listen(_handleIncomingCall);
      _stirInfoSubscription = _callChannel.stirInfoStream.listen(_handleStirInfo);
      _simInfoSubscription = _callChannel.simInfoStream.listen(_handleSimInfo);
      _isMonitoring = true;
      
      logOperation('开始监控来电');
    } catch (e) {
      logOperation('监控来电失败', details: e.toString());
      rethrow;
    }
  }
  
  /// 停止监控来电
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) return;
    
    await _callSubscription?.cancel();
    await _stirInfoSubscription?.cancel();
    await _simInfoSubscription?.cancel();
    _callSubscription = null;
    _stirInfoSubscription = null;
    _simInfoSubscription = null;
    _isMonitoring = false;
    
    logOperation('停止监控来电');
  }
  
  /// 加载设置
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _useLocalNotification = prefs.getBool(callLocalNotificationKey) ?? false;
    _cancelLocalNotification = prefs.getBool(callCancelLocalNotificationKey) ?? false;
    _useStirNotification = prefs.getBool(stirLocalNotificationKey) ?? false;
    
    logOperation('加载设置完成');
  }
  
  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool useLocal) async {
    if (_useLocalNotification == useLocal) return;
    
    _useLocalNotification = useLocal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(callLocalNotificationKey, useLocal);
    
    logOperation('设置本地通知', details: useLocal ? '启用' : '禁用');
  }
  
  /// 设置是否取消本地通知
  Future<void> closeLocalNotification(bool cancelLocal) async {
    if (_cancelLocalNotification == cancelLocal) return;
    
    _cancelLocalNotification = cancelLocal;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(callCancelLocalNotificationKey, cancelLocal);
    
    logOperation('设置取消本地通知', details: cancelLocal ? '启用' : '禁用');
  }
  
  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool useStir) async {
    if (_useStirNotification == useStir) return;
    
    _useStirNotification = useStir;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(stirLocalNotificationKey, useStir);
    
    logOperation('设置STIR通知', details: useStir ? '启用' : '禁用');
  }
  
  /// 处理来电
  void _handleIncomingCall(CallEvent event) {
    if (event.state != 'ringing') return;
    
    logOperation('收到来电', details: '${event.phoneNumber}');
    
    // 使用异步操作但不返回Future
    _processIncomingCall(event);
  }
  
  /// 处理STIR信息
  void _handleStirInfo(StirInfo stirInfo) {
    _lastStirInfo = stirInfo;
    logOperation('收到STIR信息', details: '${stirInfo.phoneNumber}');
    
    if (_useStirNotification) {
      _showStirNotification(stirInfo);
    }
  }
  
  /// 处理SIM卡信息
  void _handleSimInfo(SimInfo simInfo) {
    _lastSimInfo = simInfo;
    logOperation('收到SIM卡信息', details: '${simInfo.phoneNumber}');
  }
  
  /// 处理来电的异步逻辑
  Future<void> _processIncomingCall(CallEvent event) async {
    // 识别来电
    final callerIdData = await _callerIdService.identifyCaller(event.phoneNumber);
    
    // 显示来电悬浮窗
    final styleProvider = await _getCallerIdStyleProvider();
    await _callOverlayService.showCallerIdOverlay(
      callerIdData: callerIdData,
      stirInfo: _lastStirInfo,
      simInfo: _lastSimInfo,
      styleProvider: styleProvider,
    );
    
    // 记录通话
    final callLog = CallLog(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      phoneNumber: PhoneNumber(event.phoneNumber),
      name: callerIdData.name,
      source: 'incoming_monitor',
      timestamp: DateTime.now(),
      duration: 0,
      type: 'incoming',
      status: 'ringing',
    );
    
    // 保存通话记录
    // await _callLogRepository.saveCallLog(callLog);
    
    logOperation('处理来电完成', details: event.phoneNumber);
  }
  
  /// 显示STIR通知
  Future<void> _showStirNotification(StirInfo stirInfo) async {
    String title = '来电验证';
    String body = '';
    
    if (stirInfo.isVerified) {
      body = '${stirInfo.phoneNumber} 已通过STIR验证';
    } else if (stirInfo.isNotVerified) {
      body = '${stirInfo.phoneNumber} 未通过STIR验证';
    } else if (stirInfo.isFailed) {
      body = '${stirInfo.phoneNumber} STIR验证失败';
    } else {
      body = '${stirInfo.phoneNumber} STIR验证状态未知';
    }
    
    await _notificationService.showNotification(
      id: 1,
      title: title,
      body: body,
      payload: 'stir_info',
    );
    
    if (_cancelLocalNotification) {
      await Future.delayed(const Duration(seconds: 5));
      await _notificationService.cancelNotification(1);
    }
  }
  
  /// 获取来电显示样式提供者
  Future<CallerIdStyleProvider> _getCallerIdStyleProvider() async {
    // 实际实现中应该从配置中加载样式
    return CallerIdStyleProvider(
      windowWidth: 300,
      windowHeight: 200,
    );
  }
  
  /// 释放资源
  Future<void> dispose() async {
    await stopMonitoring();
    await _callOverlayService.dispose();
    await _shouldAcceptService.dispose();
    logOperation('释放资源');
  }
}

/// 以下是必要的辅助类，实际使用时应该从正确的导入路径引入
class SharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    return SharedPreferences();
  }
  
  bool? getBool(String key) {
    return false;
  }
  
  Future<bool> setBool(String key, bool value) async {
    return true;
  }
}