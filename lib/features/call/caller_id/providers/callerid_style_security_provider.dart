// lib/core/provider/providers/callerid_style_security_provider.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config_service.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/configuration_manager.dart';

part 'callerid_style_security_provider.g.dart';

/// Provider for the configuration repository implementation.
@riverpod
ConfigRepository configRepository(Ref ref) {
  return SharedPreferencesConfigRepository();
}

/// Provider for the CallerIdConfigService.
@riverpod
CallerIdConfigService callerIdConfigService(Ref ref) {
  return CallerIdConfigService(ref.watch(configRepositoryProvider));
}

/// Provider for the ConfigurationManager.
/// 这使得我们的业务逻辑层可以在整个应用中被轻松访问。
@riverpod
ConfigurationManager configurationManager(Ref ref) {
  return ConfigurationManager(ref.watch(configRepositoryProvider));
}

/// The UI State Notifier.
/// 它的唯一职责是持有当前的UI状态(CallerIdConfig)，并响应UI的实时调整。
/// 它不包含任何保存、加载等业务逻辑。
@riverpod
class CallerIdStyleSecurityNotifier extends _$CallerIdStyleSecurityNotifier {
  
  /// `build` 方法负责提供初始状态。
  /// 它通过调用 `ConfigurationManager` 来完成这个任务。
  @override
  Future<CallerIdConfig> build() async {
    // 从 Provider 中读取 ConfigurationManager 实例来加载初始数据
    final manager = ref.read(configurationManagerProvider);
    return await manager.loadConfig();
  }

  /// 提供一个公开的方法，允许外部(例如UI层在执行完业务逻辑后)用一个新的配置对象来更新当前状态。
  void updateStateWith(CallerIdConfig newConfig) {
    state = AsyncValue.data(newConfig);
  }

  /// 私有辅助方法，用于处理实时的、不可变的UI状态更新。
  void _updateState(CallerIdConfig Function(CallerIdConfig current) updater) {
    if (state.hasValue) {
      state = AsyncValue.data(updater(state.value!));
    }
  }

  // --- 所有用于UI实时调整的 set... 方法都保持不变 ---
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
  void setWindowSize(double width, double height) => _updateState((c) => c.copyWith(windowWidth: width, windowHeight: height));
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