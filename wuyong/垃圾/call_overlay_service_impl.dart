import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart' as overlay;

import '../../lib/domain/entities/call/caller_id_datanew.dart';
import '../../lib clean architecture 架构/domain/entities/call/stir_info.dart';
import '../../lib clean architecture 架构/domain/entities/call/sim_info.dart';
import '../../lib clean architecture 架构/infrastructure/services/base_service_impl.dart';

/// 来电悬浮窗服务实现
/// 负责显示来电信息悬浮窗
class CallOverlayServiceImpl extends BaseServiceImpl {
  OverlayPosition? _storedPosition;
  bool _isInitialized = false;
  
  /// 初始化悬浮窗服务
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // 检查悬浮窗权限
    final hasPermission = await FlutterOverlayWindow.isPermissionGranted();
    if (!hasPermission) {
      logOperation('悬浮窗权限未授予');
      return;
    }
    
    _isInitialized = true;
    logOperation('悬浮窗服务初始化完成');
  }
  
  /// 显示来电悬浮窗
  Future<void> showCallerIdOverlay({
    required CallerIdData callerIdData,
    StirInfo? stirInfo,
    SimInfo? simInfo,
    required CallerIdStyleProvider styleProvider,
  }) async {
    if (!_isInitialized) await initialize();
    
    // 获取当前悬浮窗位置，如果悬浮窗处于激活状态
    if (await FlutterOverlayWindow.isActive()) {
      _storedPosition = await FlutterOverlayWindow.getOverlayPosition();
    } else {
      // 如果悬浮窗未激活，则初始化位置或使用默认位置
      _storedPosition = _storedPosition ?? const OverlayPosition(0, 0);
    }
    
    // 传递来电数据
    await _shareCallerIdData(callerIdData);
    
    // 传递STIR信息
    if (stirInfo != null) {
      await _shareStirInfo(stirInfo);
    }
    
    // 传递SIM卡信息
    if (simInfo != null) {
      await _shareSimInfo(simInfo);
    }
    
    // 传递样式配置
    await _shareStyleConfiguration(styleProvider);
    
    // 如果悬浮窗未激活，则显示悬浮窗并设置初始位置
    if (!(await FlutterOverlayWindow.isActive())) {
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "来电",
        overlayContent: "${callerIdData.name ?? callerIdData.phoneNumber}",
        alignment: OverlayAlignment.center,
        flag: OverlayFlag.defaultFlag,
        visibility: overlay.NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.auto,
        height: (styleProvider.windowHeight * (styleProvider.pixelRatio ?? 3.0)).toInt(),
        width: (styleProvider.windowWidth * (styleProvider.pixelRatio ?? 3.0)).toInt(),
        startPosition: _storedPosition!,
      );
      
      logOperation('显示来电悬浮窗', details: callerIdData.phoneNumber);
    }
  }
  
  /// 关闭来电悬浮窗
  Future<void> closeOverlay() async {
    if (await FlutterOverlayWindow.isActive()) {
      await FlutterOverlayWindow.closeOverlay();
      logOperation('关闭来电悬浮窗');
    }
  }
  
  /// 传递来电数据到悬浮窗
  Future<void> _shareCallerIdData(CallerIdData callerIdData) async {
    final dataToSend = {
      "configType": "callerIdData",
      ...callerIdData.toJson(),
    };
    
    await FlutterOverlayWindow.shareData(dataToSend);
  }
  
  /// 传递STIR信息到悬浮窗
  Future<void> _shareStirInfo(StirInfo stirInfo) async {
    await FlutterOverlayWindow.shareData({
      "configType": "stirInfo",
      ...stirInfo.toJson(),
    });
  }
  
  /// 传递SIM卡信息到悬浮窗
  Future<void> _shareSimInfo(SimInfo simInfo) async {
    await FlutterOverlayWindow.shareData({
      "configType": "simInfo",
      ...simInfo.toJson(),
    });
  }
  
  /// 传递样式配置到悬浮窗
  Future<void> _shareStyleConfiguration(CallerIdStyleProvider styleProvider) async {
    final styleProviderData = styleProvider.toJson();
    
    final dataToSend = {
      "configType": "callerIdStyle",
      ...styleProviderData,
    };
    
    await FlutterOverlayWindow.shareData(dataToSend);
  }
  
  /// 释放资源
  Future<void> dispose() async {
    await closeOverlay();
    _isInitialized = false;
    logOperation('释放悬浮窗服务资源');
  }
}

/// 以下是必要的辅助类，实际使用时应该从正确的导入路径引入
class CallerIdStyleProvider {
  final double windowWidth;
  final double windowHeight;
  final double? pixelRatio;
  
  CallerIdStyleProvider({
    this.windowWidth = 300,
    this.windowHeight = 200,
    this.pixelRatio,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'windowWidth': windowWidth,
      'windowHeight': windowHeight,
      'pixelRatio': pixelRatio,
    };
  }
}