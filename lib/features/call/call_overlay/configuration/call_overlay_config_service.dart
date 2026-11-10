import 'dart:ui';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';

/// 通话悬浮窗配置服务
class CallOverlayConfigService {
  final String _configKey = 'config_caller_id';
  final ConfigRepository _configRepository;

  CallOverlayConfigService(this._configRepository);

  Future<void> saveConfig(CallOverlayConfig config) async {
    await _configRepository.saveConfig(_configKey, config.toMap());
  }

  Future<CallOverlayConfig?> loadConfig() async {
    final configMap = await _configRepository.getConfig(_configKey);
    return configMap != null ? CallOverlayConfig.fromMap(configMap) : null;
  }

  Future<void> updateConfig(CallOverlayConfig newConfig) async {
    await saveConfig(newConfig);
  }

  Future<CallOverlayConfig> initializeDefault() async {
    const defaultConfig = CallOverlayConfig(
      backgroundColorStart: Color(0xFF1A237E),
      backgroundColorEnd: Color(0xFF283593),

      textNameColor: Color(0xFFFFFFFF),
      textNumberColor: Color(0xFFE0E0E0),
      textLocationColor: Color(0xFFB0BEC5),
      textCarrierColor: Color(0xFFB0BEC5),
      textCountryNameColor: Color(0xFFB0BEC5),
      textLabelsColor: Color(0xFFFFC107),
      textCountColor: Color(0xFFB0BEC5),
      textNumberTypeColor: Color(0xFFB0BEC5),
      textStirColor: Color(0xFF66BB6A),
      textSimCardColor: Color(0xFFCFD8DC),

      textIconLabelColor: Color(0xFFFFC107),
      textIconLocationColor: Color(0xFFB0BEC5),
      textIconCallTypeColor: Color(0xFFFFFFFF),
      avatarBorderColor: Color(0xFFFFFFFF),

      nameFontSize: 22.0,
      numberFontSize: 18.0,
      locationFontSize: 14.0,
      carrierFontSize: 14.0,
      countryNameFontSize: 14.0,
      labelsFontSize: 14.0,
      countFontSize: 14.0,
      numberTypeFontSize: 14.0,
      stirFontSize: 12.0,
      simCardFontSize: 12.0,

      avatarPosition: Offset(15, 30),

      namePosition: Offset(95, 35),
      numberPosition: Offset(95, 65),
      locationPosition: Offset(95, 95),

      labelsPosition: Offset(20, 155),
      countPosition: Offset(150, 155),
      numberTypePosition: Offset(20, 180),
      carrierPosition: Offset(95, 115),
      countryNamePosition: Offset(95, 135),

      callTypePosition: Offset(340, 25),
      simCardPosition: Offset(270, 25),
      stirPosition: Offset(270, 50),

      securityMessagePosition: Offset(10, 205),
      securityMessageTextColor: Color(0xFFFFFFFF),
      securityMessageFontSize: 14.0,
      securityMessageContainerWidth: 360.0,
      securityMessageScrollSpeed: 30.0,
      securityMessageEnabled: true,
      securityMessageBackgroundColor: Color(0x99000000),
      securityMessageHeight: 25.0,

      windowWidth: 380,
      windowHeight: 235,
      avatarSize: 60,
      avatarBorderSize: 64,
      iconSize: 16.0,
    );
    await saveConfig(defaultConfig);
    return defaultConfig;
  }

  Future<void> resetToDefault() async {
    await initializeDefault();
  }
}
