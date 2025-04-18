import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../entities/caller/caller_id_data.dart';

/// STIR信息
class StirInfo {
  final String verstat;
  final String attestation;
  
  StirInfo({required this.verstat, required this.attestation});
  
  Map<String, dynamic> toJson() {
    return {
      'verstat': verstat,
      'attestation': attestation,
    };
  }
  
  factory StirInfo.fromJson(Map<String, dynamic> json) {
    return StirInfo(
      verstat: json['verstat'] as String,
      attestation: json['attestation'] as String,
    );
  }
}

/// SIM卡信息
class SimInfo {
  final String simSlotIndex;
  final String displayName;
  final String carrierName;
  final String countryIso;
  
  SimInfo({
    required this.simSlotIndex,
    required this.displayName,
    required this.carrierName,
    required this.countryIso,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'simSlotIndex': simSlotIndex,
      'displayName': displayName,
      'carrierName': carrierName,
      'countryIso': countryIso,
    };
  }
  
  factory SimInfo.fromJson(Map<String, dynamic> json) {
    return SimInfo(
      simSlotIndex: json['simSlotIndex'] as String,
      displayName: json['displayName'] as String,
      carrierName: json['carrierName'] as String,
      countryIso: json['countryIso'] as String,
    );
  }
}

/// 通话数据
class CallData {
  final CallerIdData callerIdData;
  final StirInfo? stirInfo;
  final SimInfo? simInfo;
  
  CallData({
    required this.callerIdData,
    this.stirInfo,
    this.simInfo,
  });
}

/// 来电显示监控服务接口
abstract class ICallerIdMonitorService {
  /// 获取来电显示数据流
  Stream<CallerIdData> get callerIdStream;
  
  /// 初始化服务
  Future<void> initialize();
  
  /// 处理来电显示调用
  void handleCallerIdCall(MethodCall call);
  
  /// 显示来电显示悬浮窗
  Future<void> showCallerIdOverlay(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo);
  
  /// 设置是否使用本地通知
  Future<void> setUseLocalNotification(bool value);
  
  /// 关闭本地通知
  Future<void> closeLocalNotification(bool value);
  
  /// 设置是否使用STIR通知
  Future<void> setUseStirNotification(bool value);
  
  /// 关闭服务
  Future<void> dispose();
  
  /// 本地通知键
  static const String callLocalNotificationKey = 'call_local_notification';
  
  /// 取消本地通知键
  static const String callCancelLocalNotificationKey = 'call_cancel_local_notification';
  
  /// STIR通知键
  static const String stirLocalNotificationKey = 'stir_local_notification';
}