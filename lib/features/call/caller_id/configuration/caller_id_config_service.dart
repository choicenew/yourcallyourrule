// lib/features/call/caller_id/configuration/caller_id_config_service.dart

import 'dart:ui';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart'; 
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';

/// 来电显示配置服务
class CallerIdConfigService {
  final String _configKey = 'config_caller_id';
  final ConfigRepository _configRepository;

  CallerIdConfigService(this._configRepository);

  /// 保存配置到仓库
  Future<void> saveConfig(CallerIdConfig config) async {
    await _configRepository.saveConfig(_configKey, config.toMap());
  }

  /// 从仓库加载配置
  Future<CallerIdConfig?> loadConfig() async {
    final configMap = await _configRepository.getConfig(_configKey);
    return configMap != null ? CallerIdConfig.fromMap(configMap) : null;
  }

  /// 更新配置
  Future<void> updateConfig(CallerIdConfig newConfig) async {
    await saveConfig(newConfig);
  }

  /// 初始化默认配置 (已更新为全新设计的专业布局)
  Future<CallerIdConfig> initializeDefault() async {
    const defaultConfig = CallerIdConfig(
      // --- 专业深色主题 ---
      // 使用深蓝色渐变，提供优秀的可读性
      backgroundColorStart: Color(0xFF1A237E), // 深靛蓝
      backgroundColorEnd: Color(0xFF283593),   // 较亮的靛蓝

      // --- 文本颜色 (高对比度) ---
      // 所有主要文本都使用白色，确保在深色背景上清晰可见
      textNameColor: Color(0xFFFFFFFF),
      textNumberColor: Color(0xFFE0E0E0), // 稍暗的白色，区分主次
      textLocationColor: Color(0xFFB0BEC5), // 蓝灰色，用于次要信息
      textCarrierColor: Color(0xFFB0BEC5),
      textCountryNameColor: Color(0xFFB0BEC5),
      textLabelsColor: Color(0xFFFFC107), // 琥珀色，用于警告/标签
      textCountColor: Color(0xFFB0BEC5),
      textNumberTypeColor: Color(0xFFB0BEC5),
      textStirColor: Color(0xFF66BB6A), // 柔和的绿色，用于“已验证”
      textSimCardColor: Color(0xFFCFD8DC), // 浅蓝灰色

      // --- 图标与边框颜色 ---
      textIconLabelColor: Color(0xFFFFC107), // 与标签文本颜色匹配
      textIconLocationColor: Color(0xFFB0BEC5), // 与位置文本颜色匹配
      textIconCallTypeColor: Color(0xFFFFFFFF),
      avatarBorderColor: Color(0xFFFFFFFF), // 干净的白色边框

      // --- 字体大小 (信息层级) ---
      nameFontSize: 22.0,          // 姓名最大，最重要
      numberFontSize: 18.0,        // 号码次之
      locationFontSize: 14.0,      // 次要信息
      carrierFontSize: 14.0,
      countryNameFontSize: 14.0,
      labelsFontSize: 14.0,
      countFontSize: 14.0,
      numberTypeFontSize: 14.0,    // 统一了次要信息字体大小
      stirFontSize: 12.0,          // 状态信息最小
      simCardFontSize: 12.0,

      // --- 布局与定位 (有组织的层级结构) ---
      // 左侧头像，右侧信息，所有元素对齐
      avatarPosition: Offset(15, 30),

      // 主要信息区 (头像右侧)
      namePosition: Offset(95, 35),
      numberPosition: Offset(95, 65),
      locationPosition: Offset(95, 95),
      
      // 次要信息区 (主要信息下方)
      labelsPosition: Offset(20, 155),
      countPosition: Offset(150, 155),
      numberTypePosition: Offset(20, 180),
      carrierPosition: Offset(95, 115),
      countryNamePosition: Offset(95, 135), // 调整位置避免重叠

      // 右上角状态区
      callTypePosition: Offset(340, 25),
      simCardPosition: Offset(270, 25),
      stirPosition: Offset(270, 50),

      // --- 滚动安全信息 (底部) ---
      securityMessagePosition: Offset(10, 205),
      securityMessageTextColor: Color(0xFFFFFFFF),
      securityMessageFontSize: 14.0,
      securityMessageContainerWidth: 360.0, // 宽度适应窗口
      securityMessageScrollSpeed: 30.0,
      securityMessageEnabled: true,
      securityMessageBackgroundColor: Color(0x99000000), // 半透明黑色
      securityMessageHeight: 25.0,

      // --- 窗口与图标尺寸 ---
      windowWidth: 380,
      windowHeight: 235,
      avatarSize: 60,
      avatarBorderSize: 64, // 比头像大一点，形成 2px 边框
      iconSize: 16.0,
    );
    await saveConfig(defaultConfig);
    return defaultConfig;
  }

  // 在现有类中新增
  Future<void> resetToDefault() async {
    await initializeDefault();
  }
}