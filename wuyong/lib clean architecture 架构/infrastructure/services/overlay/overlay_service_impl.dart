import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/caller/caller_id_data.dart';
import '../../../domain/entities/caller/stir_info.dart';
import '../../../domain/entities/caller/sim_info.dart';
import '../../../domain/entities/config/caller_id_config.dart';
import '../../../domain/services/overlay_service.dart';
import '../base_service_impl.dart';

/// 悬浮窗服务实现
class OverlayServiceImpl extends BaseServiceImpl implements OverlayService {
  final SharedPreferences _preferences;
  
  OverlayServiceImpl(this._preferences);
  
  @override
  Future<void> showCallerIdOverlay(CallerIdData callerIdData, StirInfo? stirInfo, SimInfo? simInfo) async {
    // 检查悬浮窗权限
    final hasPermission = await checkOverlayPermission();
    if (!hasPermission) {
      await requestOverlayPermission();
      return;
    }
    
    // 准备数据
    final dataToSend = {
      "dataType": "callerIdData",
      "phoneNumber": callerIdData.phoneNumber.value,
      "name": callerIdData.name,
      "location": callerIdData.location,
      "carrier": callerIdData.carrier,
      "countryName": callerIdData.countryName,
      "label": callerIdData.label,
      "isBlocked": callerIdData.isBlocked,
      "isSpam": callerIdData.isSpam,
      "matchedRuleId": callerIdData.matchedRuleId,
      "matchedRuleType": callerIdData.matchedRuleType,
    };
    
    // 添加STIR信息
    if (stirInfo != null) {
      dataToSend["stirInfo"] = {
        "isVerified": stirInfo.isVerified,
        "isNotVerified": stirInfo.isNotVerified,
        "isFailed": stirInfo.isFailed,
        "phoneNumber": stirInfo.phoneNumber,
      };
    }
    
    // 添加SIM信息
    if (simInfo != null) {
      dataToSend["simInfo"] = {
        "simSlot": simInfo.simSlot,
        "simId": simInfo.simId,
        "carrierName": simInfo.carrierName,
        "phoneNumber": simInfo.phoneNumber,
      };
    }
    
    // 检查悬浮窗是否已经打开
    final isOverlayActive = await FlutterOverlayWindow.isActive();
    
    if (!isOverlayActive) {
      // 打开悬浮窗
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "来电显示",
        overlayContent: "来电: ${callerIdData.phoneNumber.value}",
        flag: OverlayFlag.defaultFlag,
        alignment: OverlayAlignment.topCenter,
        visibility: NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.auto,
      );
    }
    
    // 发送数据到悬浮窗
    await FlutterOverlayWindow.shareData(dataToSend);
  }
  
  @override
  Future<void> closeOverlay() async {
    final isOverlayActive = await FlutterOverlayWindow.isActive();
    if (isOverlayActive) {
      await FlutterOverlayWindow.closeOverlay();
    }
  }
  
  @override
  Future<void> updateOverlayPosition(double x, double y) async {
    await _preferences.setDouble('overlay_position_x', x);
    await _preferences.setDouble('overlay_position_y', y);
    
    // 如果悬浮窗已打开，更新位置
    final isOverlayActive = await FlutterOverlayWindow.isActive();
    if (isOverlayActive) {
      await FlutterOverlayWindow.updatePosition(x.toInt(), y.toInt());
    }
  }
  
  @override
  Future<bool> checkOverlayPermission() async {
    return await FlutterOverlayWindow.isPermissionGranted();
  }
  
  @override
  Future<bool> requestOverlayPermission() async {
    return await FlutterOverlayWindow.requestPermission();
  }
  
  @override
  Future<void> updateOverlayStyle(CallerIdConfig config) async {
    final styleData = {
      "configType": "callerIdStyle",
      ...config.toMap(),
    };
    
    await FlutterOverlayWindow.shareData(styleData);
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
}