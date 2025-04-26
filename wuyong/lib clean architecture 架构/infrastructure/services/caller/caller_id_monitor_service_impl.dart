import 'dart:async';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import '../../../common/platform/android/call_channel_manager.dart';
import '../../../domain/entities/caller/caller_id_data.dart';
import '../../../domain/entities/caller/stir_info.dart';
import '../../../domain/entities/caller/sim_info.dart';
import '../../../domain/entities/config/caller_id_config.dart';
import '../../../domain/services/caller_id_monitor_service.dart';
import '../../../domain/services/caller_id_service.dart';
import '../../../domain/services/overlay_service.dart';
import '../../../domain/services/rule_matcher_service.dart';
import '../../../domain/services/time_interceptor_service.dart';
import '../../../domain/services/repeated_call_service.dart';
import '../../../domain/repositories/call_repository.dart';
import '../../../domain/value_objects/phone_number.dart';
import '../base_service_impl.dart';
import '../notification_service_impl.dart';

/// 来电监控服务实现
class CallerIdMonitorServiceImpl extends BaseServiceImpl implements CallerIdMonitorService {
  final CallerIdService _callerIdService;
  final CallChannelManager _callChannelManager;
  final NotificationServiceImpl _notificationService;
  final SharedPreferences _preferences;
  final RuleMatcherService _ruleMatcherService;
  final OverlayService _overlayService;
  final CallRepository _callRepository;
  final TimeInterceptorService _timeInterceptorService;
  final RepeatedCallService _repeatedCallService;
  
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
  
  final _callDataSubject = BehaviorSubject<CallerIdData>();
  
  CallerIdMonitorServiceImpl(
    this._callerIdService,
    this._callChannelManager,
    this._notificationService,
    this._preferences,
    this._ruleMatcherService,
    this._overlayService,
    this._callRepository,
    this._timeInterceptorService,
    this._repeatedCallService,
  ) {
    _loadPreferences();
  }
  
  @override
  Stream<CallerIdData> get callDataStream => _callDataSubject.stream;
  
  Future<void> _loadPreferences() async {
    _useLocalNotification = _preferences.getBool(callLocalNotificationKey) ?? false;
    _cancelLocalNotification = _preferences.getBool(callCancelLocalNotificationKey) ?? false;
    _useStirNotification = _preferences.getBool(stirLocalNotificationKey) ?? false;
  }
  
  @override
  Future<void> loadSettings() async {
    await _loadPreferences();
    await _ruleMatcherService.loadRules();
    await _timeInterceptorService.loadConfig();
    await _repeatedCallService.loadConfig();
  }
  
  @override
  Future<void> setUseLocalNotification(bool value) async {
    _useLocalNotification = value;
    await _preferences.setBool(callLocalNotificationKey, value);
  }
  
  @override
  Future<void> setUseStirNotification(bool value) async {
    _useStirNotification = value;
    await _preferences.setBool(stirLocalNotificationKey, value);
  }
  
  @override
  Future<void> setCancelLocalNotification(bool value) async {
    _cancelLocalNotification = value;
    await _preferences.setBool(callCancelLocalNotificationKey, value);
  }
  
  @override
  Future<void> startMonitoring() async {
    if (_isMonitoring) return;
    
    // 初始化通道
    _callChannelManager.initialize();
    
    // 设置回调
    _callChannelManager.onCallerIdCall = _handleCallerIdCall;
    _callChannelManager.onStirCall = _handleStirCall;
    _callChannelManager.onSimCall = _handleSimCall;
    _callChannelManager.onShouldAcceptCallCall = _handleShouldAcceptCallCall;
    _callChannelManager.onEndCallCall = _handleEndCallCall;
    
    // 订阅来电数据流
    _callSubscription = _callerIdService.callerIdStream.listen((data) {
      _callDataSubject.add(data);
    });
    
    // 初始化来电显示服务
    await _callChannelManager.initializeCallerId();
    
    // 加载设置
    await loadSettings();
    
    _isMonitoring = true;
  }
  
  @override
  Future<void> stopMonitoring() async {
    if (!_isMonitoring) return;
    
    // 取消订阅
    await _callSubscription?.cancel();
    await _stirInfoSubscription?.cancel();
    await _simInfoSubscription?.cancel();
    
    _callSubscription = null;
    _stirInfoSubscription = null;
    _simInfoSubscription = null;
    
    // 关闭悬浮窗
    await closeOverlay();
    
    _isMonitoring = false;
  }
  
  void _handleCallerIdCall(MethodCall call) async {
    final args = call.arguments as Map<dynamic, dynamic>? ?? {};
    
    if (call.method == "onCallerIdInitializationComplete") {
      await _callChannelManager.initializeCallerId();
    } else if (call.method == 'onIncomingCall') {
      final phoneNumberStr = args['phoneNumber'] as String?;
      if (phoneNumberStr != null) {
        await handleIncomingCall(PhoneNumber(phoneNumberStr));
      }
    } else if (call.method == 'onCallEnded') {
      await _handleCallEnded();
    } else if (call.method == 'onOutgoingCall') {
      final phoneNumberStr = args['phoneNumber'] as String?;
      if (phoneNumberStr != null) {
        await _handleOutgoingCall(PhoneNumber(phoneNumberStr));
      }
    }
  }
  
  void _handleStirCall(MethodCall call) async {
    final args = call.arguments as Map<dynamic, dynamic>? ?? {};
    final stirInfo = StirInfo(
      isVerified: args['isVerified'] ?? false,
      isNotVerified: args['isNotVerified'] ?? false,
      isFailed: args['isFailed'] ?? false,
      phoneNumber: args['phoneNumber'] as String?,
    );
    
    await handleStirInfo(stirInfo);
  }
  
  void _handleSimCall(MethodCall call) async {
    final args = call.arguments as Map<dynamic, dynamic>? ?? {};
    final simInfo = SimInfo(
      simSlot: args['simSlot'] as int?,
      simId: args['simId'] as String?,
      carrierName: args['carrierName'] as String?,
      phoneNumber: args['phoneNumber'] as String?,
    );
    
    await handleSimInfo(simInfo);
  }
  
  Future<bool> _handleShouldAcceptCallCall(MethodCall call) async {
    final args = call.arguments as Map<dynamic, dynamic>? ?? {};
    final phoneNumberStr = args['phoneNumber'] as String?;
    
    if (phoneNumberStr != null) {
      return await shouldAcceptCall(PhoneNumber(phoneNumberStr));
    }
    
    return true; // 默认允许
  }
  
  Future<String?> _handleEndCallCall(MethodCall call) async {
    await handleCallEnded();
    return null;
  }
  
  @override
  Future<void> handleIncomingCall(PhoneNumber phoneNumber) async {
    // 记录重复来电
    await _repeatedCallService.recordCall(phoneNumber);
    
    // 获取来电显示数据
    final callerIdData = await _callerIdService.getCallerId(phoneNumber, Localizations.localeOf(navigatorKey.currentContext!).toString());
    
    // 加载过滤规则配置
    await _ruleMatcherService.loadRules();
    
    // 判断是否应该接听来电
    final shouldAccept = await shouldAcceptCall(phoneNumber);
    
    // 显示本地通知
    if (_useLocalNotification) {
      if (!shouldAccept) {
        // 显示已阻止通知
        await _notificationService.showBlockedCallNotification(
          phoneNumber.value,
          callerIdData.location ?? '',
        );
        
        if (_cancelLocalNotification) {
          await Future.delayed(const Duration(seconds: 5));
          await _notificationService.cancelNotification(0);
        }
        
        // 记录被阻止的通话
        await _callRepository.addBlockedCall(phoneNumber.value, DateTime.now());
      } else {
        // 显示来电通知
        await _notificationService.showCallerIdNotification(
          callerIdData.name ?? callerIdData.phoneNumber.value,
          callerIdData.location ?? '',
        );
      }
    }
    
    // 如果允许接听，显示悬浮窗
    if (shouldAccept) {
      await showCallerIdOverlay(callerIdData, _lastStirInfo, _lastSimInfo);
    }
    
    // 保存来电数据到缓存
    await _callerIdService.saveCallerIdDataToCache(phoneNumber, callerIdData);
    
    // 更新数据流
    _callDataSubject.add(callerIdData);
  }
  
  /// 处理去电
  Future<void> _handleOutgoingCall(PhoneNumber phoneNumber) async {
    // 获取来电显示数据
    final callerIdData = await _callerIdService.getCallerId(phoneNumber, Localizations.localeOf(navigatorKey.currentContext!).toString());
    
    // 显示悬浮窗
    await showCallerIdOverlay(callerIdData, _lastStirInfo, _lastSimInfo);
    
    // 保存来电数据到缓存
    await _callerIdService.saveCallerIdDataToCache(phoneNumber, callerIdData);
    
    // 更新数据流
    _callDataSubject.add(callerIdData);
  }
  
  @override
  Future<void> handleOutgoingCall(PhoneNumber phoneNumber) async {
    await _handleOutgoingCall(phoneNumber);
  }
  
  /// 处理通话结束
  Future<void> _handleCallEnded() async {
    // 关闭悬浮窗
    await closeOverlay();
  }
  
  @override
  Future<void> handleCallEnded() async {
    await _handleCallEnded();
  }
  
  @override
  Future<void> handleStirInfo(StirInfo stirInfo) async {
    _lastStirInfo = stirInfo;
    
    // 显示STIR通知
    if (_useStirNotification && stirInfo.phoneNumber != null) {
      String stirResultMessage = '';
      if (stirInfo.isVerified) {
        stirResultMessage = '已验证';
      } else if (stirInfo.isNotVerified) {
        stirResultMessage = '未验证';
      } else if (stirInfo.isFailed) {
        stirResultMessage = '验证失败';
      }
      
      await _notificationService.showStirNotification(
        stirResultMessage,
        stirInfo.phoneNumber!,
      );
    }
    
    // 更新悬浮窗
    final cachedData = await _callerIdService.getCallerIdDataFromCache(PhoneNumber(stirInfo.phoneNumber ?? ''));
    if (cachedData != null) {
      await showCallerIdOverlay(cachedData, stirInfo, _lastSimInfo);
    }
  }
  
  @override
  Future<void> handleSimInfo(SimInfo simInfo) async {
    _lastSimInfo = simInfo;
    
    // 更新悬浮窗
    final cachedData = await _callerIdService.getCallerIdDataFromCache(PhoneNumber(simInfo.phoneNumber ?? ''));
    if (cachedData != null) {
      await showCallerIdOverlay(cachedData, _lastStirInfo, simInfo);
    }
  }
  
  @override
  Future<bool> shouldAcceptCall(PhoneNumber phoneNumber) async {
    // 检查是否应该阻止号码
    final shouldBlock = await _callerIdService.shouldBlockNumber(phoneNumber);
    
    // 如果规则匹配器决定阻止，再检查时间拦截器
    if (shouldBlock) {
      // 检查时间拦截器
      final timeConfig = _timeInterceptorService.getConfig();
      final shouldInterceptByTime = timeConfig['shouldIntercept'] == true && 
                                   await _timeInterceptorService.shouldIntercept(phoneNumber);
      
      // 如果时间拦截器也决定拦截，再检查重复来电
      if (shouldInterceptByTime) {
        // 检查是否为重复来电
        final isRepeated = await _repeatedCallService.isRepeatedCall(phoneNumber);
        final callCount = await _repeatedCallService.getCallCount(phoneNumber);
        
        // 如果是重复来电且次数超过阈值，允许接听
        if (isRepeated && callCount >= 3) { // 假设阈值为3次
          return true;
        }
        
        return false;
      }
      
      return false;
    }
    
    return true;
  }
  
  @override
  Future<void> showCallerIdOverlay(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    await _overlayService.showCallerIdOverlay(callerIdData, stirInfo, simInfo);
  }
  
  @override
  Future<void> closeOverlay() async {
    await _overlayService.closeOverlay();
  }
  
  @override
  Future<void> saveOverlayPosition(double x, double y) async {
    await _preferences.setDouble('overlay_position_x', x);
    await _preferences.setDouble('overlay_position_y', y);
  }
  
  @override
  Future<Map<String, double>?> getOverlayPosition() async {
    final x = _preferences.getDouble('overlay_position_x');
    final y = _preferences.getDouble('overlay_position_y');
    
    if (x != null && y != null) {
      return {'x': x, 'y': y};
    }
    
    return null;
  }
  
  @override
  Future<void> updateAndShareConfiguration(CallerIdConfig config) async {
    // 传输配置给 isolated overlay
    final configMap = config.toMap();
    
    // 添加 configType 标识
    final dataToSend = {
      "configType": "callerIdStyle",
      ...configMap,
    };
    
    // 传递 Map 对象
    await FlutterOverlayWindow.shareData(dataToSend);
  }
}