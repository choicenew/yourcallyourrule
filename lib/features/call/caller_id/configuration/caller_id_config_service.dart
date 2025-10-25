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

  /// 初始化默认配置
  Future<CallerIdConfig> initializeDefault() async {
    // 注意：这里需要补充您在 CallerIdConfig 中新增的字段的默认值
    const defaultConfig = CallerIdConfig(
      backgroundColorStart: Color(0xFFF0A10F),
      backgroundColorEnd: Color(0xFFF5961B),
      textNameColor: Color(0x00FFFFFF),
      textNumberColor: Color(0x00FFFFFF),
      textLocationColor: Color(0x00FFFFFF),
      textCarrierColor: Color(0x00FFFFFF),
      textCountryNameColor: Color(0x00FFFFFF),
      textLabelsColor: Color(0xFF64B5F6),
      textCountColor: Color(0xFF64B5F6),
      textNumberTypeColor: Color(0xFFBBDEFB),
      textIconLabelColor: Color(0xFF2196F3),
      textIconLocationColor: Color(0xFF21F375),
      textIconCallTypeColor: Color(0xFF21F375),
      avatarBorderColor: Color(0xFFFFFFFF),
      textStirColor: Color(0xFF4CAF50),
      textSimCardColor: Color(0xFF9E9E9E),
      nameFontSize: 24.0,
      numberFontSize: 18.0,
      locationFontSize: 14.0,
      carrierFontSize: 16.0,
      countryNameFontSize: 16.0,
      labelsFontSize: 14.0,
      countFontSize: 14.0,
      numberTypeFontSize: 12.0,
      stirFontSize: 12.0,
      simCardFontSize: 12.0,
      avatarPosition: Offset(20, 40),
      namePosition: Offset(120, 40),
      carrierPosition: Offset(20, 80),
      countryNamePosition: Offset(20, 110),
      labelsPosition: Offset(20, 140),
      countPosition: Offset(20, 170),
      numberTypePosition: Offset(50, 150),
      numberPosition: Offset(120, 80),
      locationPosition: Offset(120, 110),
      callTypePosition: Offset(300, 40),
      simCardPosition: Offset(300, 70),
      stirPosition: Offset(300, 100),
      securityMessagePosition: Offset(10, 190),
      securityMessageTextColor: Color(0xFFFFFFFF),
      securityMessageFontSize: 14.0,
      securityMessageContainerWidth: 300.0,
      securityMessageScrollSpeed: 20.0,
      securityMessageEnabled: true,
      securityMessageBackgroundColor: Color(0xB0515151), // 半透明黑色
      securityMessageHeight: 30.0,
      // 补充的默认值
      windowWidth: 380,
      windowHeight: 235,
      avatarSize: 60,
      avatarBorderSize: 61,
      iconSize: 20,
    );
    await saveConfig(defaultConfig);
    return defaultConfig;
  }

  // 在现有类中新增
  Future<void> resetToDefault() async {
    await initializeDefault();
  }
}