import 'dart:io';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config_service.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/configuration_manager.dart';

part 'call_overlay_style_security_provider.g.dart';

/// Provider for the configuration repository implementation.
@riverpod
ConfigRepository configRepository(Ref ref) {
  return SharedPreferencesConfigRepository();
}

/// Provider for the CallOverlayConfigService.
@riverpod
CallOverlayConfigService callOverlayConfigService(Ref ref) {
  return CallOverlayConfigService(ref.watch(configRepositoryProvider));
}

/// Provider for the ConfigurationManager.
@riverpod
ConfigurationManager configurationManager(Ref ref) {
  return ConfigurationManager(ref.watch(configRepositoryProvider));
}

/// The UI State Notifier.
@riverpod
class CallOverlayStyleSecurityNotifier extends _$CallOverlayStyleSecurityNotifier {

  @override
  Future<CallOverlayConfig> build() async {
    final manager = ref.read(configurationManagerProvider);
    return await manager.loadConfig();
  }

  void updateStateWith(CallOverlayConfig newConfig) {
    state = AsyncValue.data(newConfig);
  }

  void _updateState(CallOverlayConfig Function(CallOverlayConfig current) updater) {
    if (state.hasValue) {
      state = AsyncValue.data(updater(state.value!));
    }
  }

  void setWindowSize({double? width, double? height}) {
    _updateState((currentConfig) => currentConfig.copyWith(
      windowWidth: width ?? currentConfig.windowWidth,
      windowHeight: height ?? currentConfig.windowHeight,
    ));
  }

  void setBackgroundColorStart(Color color) => _updateState((c) => c.copyWith(backgroundColorStart: color));
  void setBackgroundColorEnd(Color color) => _updateState((c) => c.copyWith(backgroundColorEnd: color));
  void setTextIconLabelColor(Color color) => _updateState((c) => c.copyWith(textIconLabelColor: color));
  void setTextIconLocationColor(Color color) => _updateState((c) => c.copyWith(textIconLocationColor: color));
  void setTextIconCallTypeColor(Color color) => _updateState((c) => c.copyWith(textIconCallTypeColor: color));
  void setAvatarBorderColor(Color color) => _updateState((c) => c.copyWith(avatarBorderColor: color));
  void setTextLabelsColor(Color color) => _updateState((c) => c.copyWith(textLabelsColor: color));
  void setTextCountryNameColor(Color color) => _updateState((c) => c.copyWith(textCountryNameColor: color));
  void setTextCarrierColor(Color color) => _updateState((c) => c.copyWith(textCarrierColor: color));
  void setTextNumberTypeColor(Color color) => _updateState((c) => c.copyWith(textNumberTypeColor: color));
  void setTextNameColor(Color color) => _updateState((c) => c.copyWith(textNameColor: color));
  void setTextNumberColor(Color color) => _updateState((c) => c.copyWith(textNumberColor: color));
  void setTextCountColor(Color color) => _updateState((c) => c.copyWith(textCountColor: color));
  void setTextLocationColor(Color color) => _updateState((c) => c.copyWith(textLocationColor: color));
  void setTextStirColor(Color color) => _updateState((c) => c.copyWith(textStirColor: color));
  void setTextSimCardColor(Color color) => _updateState((c) => c.copyWith(textSimCardColor: color));
  void setAvatarSize(double size) => _updateState((c) => c.copyWith(avatarSize: size));
  void setAvatarBorderSize(double size) => _updateState((c) => c.copyWith(avatarBorderSize: size));
  void setIconSize(double size) => _updateState((c) => c.copyWith(iconSize: size));
  void setNameFontSize(double size) => _updateState((c) => c.copyWith(nameFontSize: size));
  void setCarrierFontSize(double size) => _updateState((c) => c.copyWith(carrierFontSize: size));
  void setCountryNameFontSize(double size) => _updateState((c) => c.copyWith(countryNameFontSize: size));
  void setLabelsFontSize(double size) => _updateState((c) => c.copyWith(labelsFontSize: size));
  void setCountFontSize(double size) => _updateState((c) => c.copyWith(countFontSize: size));
  void setNumberTypeFontSize(double size) => _updateState((c) => c.copyWith(numberTypeFontSize: size));
  void setNumberFontSize(double size) => _updateState((c) => c.copyWith(numberFontSize: size));
  void setLocationFontSize(double size) => _updateState((c) => c.copyWith(locationFontSize: size));
  void setStirFontSize(double size) => _updateState((c) => c.copyWith(stirFontSize: size));
  void setSimCardFontSize(double size) => _updateState((c) => c.copyWith(simCardFontSize: size));
  void updateAvatarPosition(Offset position) => _updateState((c) => c.copyWith(avatarPosition: position));
  void updateNamePosition(Offset position) => _updateState((c) => c.copyWith(namePosition: position));
  void updateCarrierPosition(Offset position) => _updateState((c) => c.copyWith(carrierPosition: position));
  void updateCountryNamePosition(Offset position) => _updateState((c) => c.copyWith(countryNamePosition: position));
  void updateLabelsPosition(Offset position) => _updateState((c) => c.copyWith(labelsPosition: position));
  void updateCountPosition(Offset position) => _updateState((c) => c.copyWith(countPosition: position));
  void updateNumberTypePosition(Offset position) => _updateState((c) => c.copyWith(numberTypePosition: position));
  void updateNumberPosition(Offset position) => _updateState((c) => c.copyWith(numberPosition: position));
  void updateLocationPosition(Offset position) => _updateState((c) => c.copyWith(locationPosition: position));
  void updateCallTypePosition(Offset position) => _updateState((c) => c.copyWith(callTypePosition: position));
  void updateSimCardPosition(Offset position) => _updateState((c) => c.copyWith(simCardPosition: position));
  void updateStirPosition(Offset position) => _updateState((c) => c.copyWith(stirPosition: position));
  void setSecurityMessageTextColor(Color color) => _updateState((c) => c.copyWith(securityMessageTextColor: color));
  void setSecurityMessageFontSize(double size) => _updateState((c) => c.copyWith(securityMessageFontSize: size));
  void setSecurityMessageContainerWidth(double width) => _updateState((c) => c.copyWith(securityMessageContainerWidth: width));
  void setSecurityMessageScrollSpeed(double speed) => _updateState((c) => c.copyWith(securityMessageScrollSpeed: speed));
  void setSecurityMessageEnabled(bool enabled) => _updateState((c) => c.copyWith(securityMessageEnabled: enabled));
  void setSecurityMessageBackgroundColor(Color color) => _updateState((c) => c.copyWith(securityMessageBackgroundColor: color));
  void setSecurityMessageHeight(double height) => _updateState((c) => c.copyWith(securityMessageHeight: height));
  void updateSecurityMessagePosition(Offset position) => _updateState((c) => c.copyWith(securityMessagePosition: position));
}
