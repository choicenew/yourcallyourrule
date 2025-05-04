import 'package:flutter/services.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';

import 'base_call_handler.dart';


/// SIM卡信息处理器
/// 负责处理与SIM卡信息相关的方法调用
class SimCallHandler extends BaseCallHandler {
  SimInfo? simInfo;
  final Function(SimInfo) _onSimInfoUpdated;

  SimCallHandler(this._onSimInfoUpdated);

  @override
  dynamic handleMethodCall(MethodCall call) {
    switch (call.method) {
      case "onSimInitializationComplete":
        return _handleInitializationComplete();
      case "onSimInfo":
        return _handleSimInfo(
          call.arguments['carrierName'] as String?,
          call.arguments['displayName'] as String?,
          call.arguments['iccId'] as String?,
          call.arguments['countryIso'] as String?,
          call.arguments['incomingPhoneNumber'] as String?,
          call.arguments['simSlotIndex'] as int?,
          call.arguments['subscriptionId'] as int?,
          call.arguments['mccString'] as String?,
          call.arguments['mncString'] as String?,
          call.arguments['simPhoneNumber'] as String?,
          call.arguments['callType'] as String?,
        );
      default:
        throw UnimplementedError('未实现的方法: ${call.method}');
    }
  }

  /// 处理初始化完成
  void _handleInitializationComplete() {
    // 初始化完成后的处理逻辑
  }

  /// 处理SIM卡信息
  void _handleSimInfo(
    String? carrierName,
    String? displayName,
    String? iccId,
    String? countryIso,
    String? phoneNumber,
    int? simSlotIndex,
    int? subscriptionId,
    String? mccString,
    String? mncString,
    String? simPhoneNumber,
    String? callType,
  ) {
    simInfo = SimInfo(
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

    // 通知监听器
    _onSimInfoUpdated(simInfo!);
  }

  /// 获取当前SIM卡信息
  SimInfo? getSimInfo() {
    return simInfo;
  }

  /// 获取指定号码的SIM卡信息
  SimInfo? getSimInfoForNumber(String phoneNumber) {
    if (simInfo != null && simInfo?.phoneNumber == phoneNumber) {
      return simInfo;
    }
    return null;
  }
}