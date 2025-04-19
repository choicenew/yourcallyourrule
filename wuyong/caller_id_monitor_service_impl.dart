import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib clean architecture 架构/common/platform/android/call_channel.dart';
import '../lib clean architecture 架构/domain/entities/caller/caller_id_data.dart';
import 'caller_id_monitor_service.dart';
import '../lib clean architecture 架构/infrastructure/services/base_service_impl.dart';

/// 来电显示监控服务实现类
class CallerIdMonitorServiceImpl extends BaseServiceImpl implements ICallerIdMonitorService {
  final AndroidCallChannel _callChannel;
  final FlutterLocalNotificationsPlugin _notificationsPlugin;
  
  final _callerIdSubject = BehaviorSubject<CallerIdData>();
  
  bool _useLocalNotification = false;
  bool _cancelLocalNotification = false;
  bool _useStirNotification = false;
  
  OverlayEntry? _currentOverlay;
  StirInfo? _lastStirInfo;
  SimInfo? _lastSimInfo;
  OverlayPosition? _storedPosition;
  
  /// 获取来电显示数据流
  @override
  Stream<CallerIdData> get callerIdStream => _callerIdSubject.stream;
  
  CallerIdMonitorServiceImpl({
    AndroidCallChannel? callChannel,
    FlutterLocalNotificationsPlugin? notificationsPlugin,
  }) : 
    _callChannel = callChannel ?? AndroidCallChannel(),
    _notificationsPlugin = notificationsPlugin ?? FlutterLocalNotificationsPlugin();
  
  /// 初始化服务
  @override
  Future<void> initialize() async {
    logOperation('初始化来电显示监控服务');
    
    // 设置通道回调
    AndroidCallChannel.onCallerIdCall = handleCallerIdCall;
    AndroidCallChannel.onStirCall = _handleStirCall;
    AndroidCallChannel.onSimCall = _handleSimCall;
    
    // 初始化通知
    await _initializeNotifications();
    
    // 加载设置
    await _loadSettings();
    
    // 初始化通道
    await AndroidCallChannel.initialize();
  }
  
  /// 加载设置
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _useLocalNotification = prefs.getBool(ICallerIdMonitorService.callLocalNotificationKey) ?? false;
    _cancelLocalNotification = prefs.getBool(ICallerIdMonitorService.callCancelLocalNotificationKey) ?? false;
    _useStirNotification = prefs.getBool(ICallerIdMonitorService.stirLocalNotificationKey) ?? false;
  }
  
  /// 初始化通知
  Future<void> _initializeNotifications() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _notificationsPlugin.initialize(initializationSettings);
  }
  
  /// 处理来电显示调用
  @override
  void handleCallerIdCall(MethodCall call) async {
    if (call.method == "onCallerIdInitializationComplete") {
      logOperation('来电显示初始化完成');
    } else if (call.method == 'onIncomingCall') {
      final phoneNumber = call.arguments['phoneNumber'] as String;
      logOperation('收到来电', details: phoneNumber);
      await _handleIncomingCall(phoneNumber);
    } else if (call.method == 'onCallEnded') {
      logOperation('通话结束');
      _handleCallEnded();
    } else if (call.method == 'onOutgoingCall') {
      final phoneNumber = call.arguments['phoneNumber'] as String;
      logOperation('拨出电话', details: phoneNumber);
      await _handleOutgoingCall(phoneNumber);
    }
  }
  
  /// 处理STIR调用
  void _handleStirCall(MethodCall call) {
    if (call.method == "onStirInitializationComplete") {
      logOperation('STIR初始化完成');
    } else if (call.method == "onStirResult") {
      final verstat = call.arguments['verstat'] as String;
      final attestation = call.arguments['attestation'] as String;
      
      _lastStirInfo = StirInfo(
        verstat: verstat,
        attestation: attestation,
      );
      
      logOperation('收到STIR信息', details: 'verstat: $verstat, attestation: $attestation');
    }
  }
  
  /// 处理SIM卡调用
  void _handleSimCall(MethodCall call) {
    if (call.method == "onSimInitializationComplete") {
      logOperation('SIM卡信息初始化完成');
    } else if (call.method == "onSimInfo") {
      final simSlotIndex = call.arguments['simSlotIndex'] as String? ?? '0';
      final displayName = call.arguments['displayName'] as String? ?? 'Unknown';
      final carrierName = call.arguments['carrierName'] as String? ?? 'Unknown';
      final countryIso = call.arguments['countryIso'] as String? ?? 'Unknown';
      
      _lastSimInfo = SimInfo(
        simSlotIndex: simSlotIndex,
        displayName: displayName,
        carrierName: carrierName,
        countryIso: countryIso,
      );
      
      logOperation('收到SIM卡信息', details: 'carrier: $carrierName, country: $countryIso');
    }
  }
  
  /// 处理来电
  Future<void> _handleIncomingCall(String phoneNumber) async {
    // 创建基本的来电显示数据
    // 实际项目中应该调用来电识别服务获取详细信息
    final callerIdData = CallerIdData(
      phoneNumber: phoneNumber,
      name: 'Unknown',
      countryName: 'Unknown',
      avatar: 'assets/avatars/Unknown.png',
      labels: [],
    );
    
    // 发送来电显示数据
    _callerIdSubject.add(callerIdData);
    
    // 显示来电显示悬浮窗
    await showCallerIdOverlay(callerIdData, _lastStirInfo, _lastSimInfo);
    
    // 如果启用了本地通知，显示通知
    if (_useLocalNotification) {
      await _showIncomingCallNotification(phoneNumber);
    }
  }
  
  /// 处理拨出电话
  Future<void> _handleOutgoingCall(String phoneNumber) async {
    // 创建基本的来电显示数据
    // 实际项目中应该调用来电识别服务获取详细信息
    final callerIdData = CallerIdData(
      phoneNumber: phoneNumber,
      name: 'Unknown',
      countryName: 'Unknown',
      avatar: 'assets/avatars/Unknown.png',
      labels: [],
    );
    
    // 发送来电显示数据
    _callerIdSubject.add(callerIdData);
    
    // 显示来电显示悬浮窗
    await showCallerIdOverlay(callerIdData, _lastStirInfo, _lastSimInfo);
  }
  
  /// 处理通话结束
  void _handleCallEnded() {
    if (_currentOverlay != null) {
      _enableOverlayDismissal();
    }
  }
  
  /// 显示来电显示悬浮窗
  @override
  Future<void> showCallerIdOverlay(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    // 获取当前Overlay位置，如果Overlay处于激活状态
    if (await FlutterOverlayWindow.isActive()) {
      _storedPosition = await FlutterOverlayWindow.getOverlayPosition();
    } else {
      // 如果Overlay未激活，则初始化位置或使用默认位置
      _storedPosition = _storedPosition ?? const OverlayPosition(0, 0);
    }
    
    // 添加configType标识
    final dataToSend = {
      "configType": "callerIdData",
      ...callerIdData.toJson(),
    };
    
    // 传递Map对象
    await FlutterOverlayWindow.shareData(dataToSend);
    
    if (stirInfo != null) {
      await FlutterOverlayWindow.shareData({
        "configType": "stirInfo",
        ...stirInfo.toJson(),
      });
    }
    
    if (simInfo != null) {
      await FlutterOverlayWindow.shareData({
        "configType": "simInfo",
        ...simInfo.toJson(),
      });
    }
    
    // 显示Overlay
    await FlutterOverlayWindow.showOverlay(
      enableDrag: true,
      overlayTitle: "Call",
      overlayContent: "name:${callerIdData.phoneNumber},region:${callerIdData.countryName},carrier:${callerIdData.carrier}",
      alignment: OverlayAlignment.center,
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.auto,
      height: 300,
      width: 250,
      startPosition: _storedPosition!,
    );
  }
  
  /// 启用悬浮窗关闭
  void _enableOverlayDismissal() {
    FlutterOverlayWindow.closeOverlay();
  }
  
  /// 显示来电通知
  Future<void> _showIncomingCallNotification(String phoneNumber) async {
    const androidDetails = AndroidNotificationDetails(
      'call_notification_channel',
      'Call Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    
    await _notificationsPlugin.show(
      0,
      'Incoming Call',
      'Call from $phoneNumber',
      notificationDetails,
    );
    
    // 如果启用了取消通知，延迟后取消通知
    if (_cancelLocalNotification) {
      await Future.delayed(const Duration(seconds: 5));
      await _notificationsPlugin.cancel(0);
    }
  }
  
  /// 显示STIR通知
  Future<void> _showStirNotification(String phoneNumber, StirInfo stirInfo) async {
    if (!_useStirNotification) return;
    
    const androidDetails = AndroidNotificationDetails(
      'stir_notification_channel',
      'STIR Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    
    await _notificationsPlugin.show(
      1,
      'STIR Verification',
      'Verification status: ${stirInfo.verstat} for $phoneNumber',
      notificationDetails,
    );
  }
  
  /// 设置是否使用本地通知
  @override
  Future<void> setUseLocalNotification(bool value) async {
    if (_useLocalNotification == value) return;
    
    _useLocalNotification = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ICallerIdMonitorService.callLocalNotificationKey, value);
    
    logOperation('设置本地通知', details: value ? '启用' : '禁用');
  }
  
  /// 关闭本地通知
  @override
  Future<void> closeLocalNotification(bool value) async {
    if (_cancelLocalNotification == value) return;
    
    _cancelLocalNotification = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ICallerIdMonitorService.callCancelLocalNotificationKey, value);
    
    logOperation('设置自动关闭通知', details: value ? '启用' : '禁用');
  }
  
  /// 设置是否使用STIR通知
  @override
  Future<void> setUseStirNotification(bool value) async {
    if (_useStirNotification == value) return;
    
    _useStirNotification = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ICallerIdMonitorService.stirLocalNotificationKey, value);
    
    logOperation('设置STIR通知', details: value ? '启用' : '禁用');
  }
  
  /// 关闭服务
  @override
  Future<void> dispose() async {
    logOperation('关闭来电显示监控服务');
    
    // 关闭数据流
    await _callerIdSubject.close();
    
    // 关闭悬浮窗
    if (await FlutterOverlayWindow.isActive()) {
      await FlutterOverlayWindow.closeOverlay();
    }
  }
}