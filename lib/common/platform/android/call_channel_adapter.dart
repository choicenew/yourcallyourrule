import 'dart:async';

import 'package:flutter/services.dart';

import 'call_channel.dart';

/// STIR/SHAKEN验证信息
class StirInfo {
  final bool isVerified;
  final bool isNotVerified;
  final bool isFailed;
  final String? phoneNumber;

  StirInfo({
    required this.isVerified,
    required this.isNotVerified,
    required this.isFailed,
    this.phoneNumber,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
      'isNotVerified': isNotVerified,
      'isFailed': isFailed,
      'phoneNumber': phoneNumber,
    };
  }

  factory StirInfo.fromJson(Map<String, dynamic> json) {
    return StirInfo(
      isVerified: json['isVerified'],
      isNotVerified: json['isNotVerified'],
      isFailed: json['isFailed'],
      phoneNumber: json['phoneNumber'],
    );
  }
  
  bool isStirVerified() {
    return isVerified;
  }
}

/// SIM卡信息
class SimInfo {
  final String? carrierName;
  final String? displayName;
  final String? iccId;
  final String? countryIso;
  final String? phoneNumber;
  final int? simSlotIndex;
  final int? subscriptionId;
  final String? mccString;
  final String? mncString;
  final String? simPhoneNumber;
  final String? callType;

  SimInfo({
    this.carrierName,
    this.displayName,
    this.iccId,
    this.countryIso,
    this.phoneNumber,
    this.simSlotIndex,
    this.subscriptionId,
    this.mccString,
    this.mncString,
    this.simPhoneNumber,
    this.callType,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'carrierName': carrierName,
      'displayName': displayName,
      'iccId': iccId,
      'countryIso': countryIso,
      'phoneNumber': phoneNumber,
      'simSlotIndex': simSlotIndex,
      'subscriptionId': subscriptionId,
      'mccString': mccString,
      'mncString': mncString,
      'simPhoneNumber': simPhoneNumber,
      'callType': callType,
    };
  }

  factory SimInfo.fromJson(Map<String, dynamic> json) {
    return SimInfo(
      carrierName: json['carrierName'],
      displayName: json['displayName'],
      iccId: json['iccId'],
      countryIso: json['countryIso'],
      phoneNumber: json['phoneNumber'],
      simSlotIndex: json['simSlotIndex'],
      subscriptionId: json['subscriptionId'],
      mccString: json['mccString'],
      mncString: json['mncString'],
      simPhoneNumber: json['simPhoneNumber'],
      callType: json['callType'],
    );
  }
}

/// 通话通道适配器
/// 提供与平台通话功能交互的方法，适配Android平台API
class CallChannel {
  // 来电流控制器
  final _callStreamController = StreamController<CallEvent>.broadcast();
  final _stirInfoController = StreamController<StirInfo>.broadcast();
  final _simInfoController = StreamController<SimInfo>.broadcast();
  
  /// 来电流
  Stream<CallEvent> get callStream => _callStreamController.stream;
  
  /// STIR/SHAKEN验证信息流
  Stream<StirInfo> get stirInfoStream => _stirInfoController.stream;
  
  /// SIM卡信息流
  Stream<SimInfo> get simInfoStream => _simInfoController.stream;
  
  // 存储最新的STIR和SIM信息
  StirInfo? _lastStirInfo;
  SimInfo? _lastSimInfo;
  
  /// 获取最新的STIR信息
  StirInfo? get lastStirInfo => _lastStirInfo;
  
  /// 获取最新的SIM信息
  SimInfo? get lastSimInfo => _lastSimInfo;
  
  CallChannel();
  
  /// 初始化通话通道
  Future<void> initialize() async {
    await AndroidCallChannel.initialize();
    
    // 设置各种回调
    AndroidCallChannel.onCallerIdCall = _handleCallerIdCall;
    AndroidCallChannel.onStirCall = _handleStirCall;
    AndroidCallChannel.onSimCall = _handleSimCall;
  }
  
  /// 处理来电回调
  void _handleCallerIdCall(MethodCall call) {
    if (call.method == 'onIncomingCall') {
      final phoneNumber = call.arguments['phoneNumber'] as String;
      _callStreamController.add(
        CallEvent(
          phoneNumber: phoneNumber,
          state: 'ringing',
        ),
      );
    } else if (call.method == 'onCallEnded') {
      // 处理通话结束事件
      _callStreamController.add(
        CallEvent(
          phoneNumber: '',
          state: 'ended',
        ),
      );
    } else if (call.method == 'onOutgoingCall') {
      final phoneNumber = call.arguments['phoneNumber'] as String;
      _callStreamController.add(
        CallEvent(
          phoneNumber: phoneNumber,
          state: 'outgoing',
        ),
      );
    }
  }
  
  /// 处理STIR/SHAKEN验证回调
  void _handleStirCall(MethodCall call) {
    if (call.method == 'onStirResult') {
      final isVerified = call.arguments['isVerified'] as bool;
      final isNotVerified = call.arguments['isNotVerified'] as bool;
      final isFailed = call.arguments['isFailed'] as bool;
      final phoneNumber = call.arguments['phoneNumber'] as String?;
      
      _lastStirInfo = StirInfo(
        isVerified: isVerified,
        isNotVerified: isNotVerified,
        isFailed: isFailed,
        phoneNumber: phoneNumber,
      );
      
      _stirInfoController.add(_lastStirInfo!);
    }
  }
  
  /// 处理SIM卡信息回调
  void _handleSimCall(MethodCall call) {
    if (call.method == 'onSimInfo') {
      final carrierName = call.arguments['carrierName'] as String?;
      final displayName = call.arguments['displayName'] as String?;
      final iccId = call.arguments['iccId'] as String?;
      final countryIso = call.arguments['countryIso'] as String?;
      final phoneNumber = call.arguments['incomingPhoneNumber'] as String?;
      final simSlotIndex = call.arguments['simSlotIndex'] as int?;
      final subscriptionId = call.arguments['subscriptionId'] as int?;
      final mccString = call.arguments['mccString'] as String?;
      final mncString = call.arguments['mncString'] as String?;
      final simPhoneNumber = call.arguments['simPhoneNumber'] as String?;
      final callType = call.arguments['callType'] as String?;
      
      _lastSimInfo = SimInfo(
        carrierName: carrierName,
        displayName: displayName,
        iccId: iccId,
        countryIso: countryIso,
        phoneNumber: phoneNumber,
        simSlotIndex: simSlotIndex,
        subscriptionId: subscriptionId,
        mccString: mccString,
        mncString: mncString,
        simPhoneNumber: simPhoneNumber,
        callType: callType,
      );
      
      _simInfoController.add(_lastSimInfo!);
    }
  }
  
  /// 拒绝来电
  Future<bool> rejectCall(String phoneNumber) async {
    try {
      return await AndroidCallChannel.blockIncomingCall(phoneNumber);
    } catch (e) {
      throw Exception('Failed to reject call: $e');
    }
  }
  
  /// 允许来电
  Future<bool> allowCall(String phoneNumber) async {
    try {
      return await AndroidCallChannel.allowIncomingCall(phoneNumber);
    } catch (e) {
      throw Exception('Failed to allow call: $e');
    }
  }
  
  /// 静音来电
  Future<bool> silentCall(String phoneNumber) async {
    try {
      return await AndroidCallChannel.silentIncomingCall(phoneNumber);
    } catch (e) {
      throw Exception('Failed to silent call: $e');
    }
  }
  
  /// 重定向来电
  Future<bool> redirectCall(String phoneNumber, String redirectTo) async {
    try {
      return await AndroidCallChannel.redirectIncomingCall(phoneNumber, redirectTo);
    } catch (e) {
      throw Exception('Failed to redirect call: $e');
    }
  }
  
  /// 关闭通道
  Future<void> dispose() async {
    await _callStreamController.close();
    await _stirInfoController.close();
    await _simInfoController.close();
  }
}

/// 通话事件
class CallEvent {
  final String phoneNumber;
  final String state;
  
  CallEvent({
    required this.phoneNumber,
    required this.state,
  });
}