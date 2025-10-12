// lib/features/call/live_activities/providers/live_notification_config_provider.dart

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/live_notification_config_manager.dart';



part 'live_notification_config_provider.g.dart';

@riverpod
LiveNotificationConfigManager liveNotificationConfigManager(Ref ref) {
  return LiveNotificationConfigManager(ref.watch(configRepositoryProvider));
}

@Riverpod(keepAlive: true)
class LiveNotificationConfigNotifier extends _$LiveNotificationConfigNotifier {
  
  @override
  Future<LiveNotificationConfig> build() async {
    final manager = ref.read(liveNotificationConfigManagerProvider);
    return await manager.loadConfig();
  }

  void _updateState(LiveNotificationConfig Function(LiveNotificationConfig current) updater) {
    if (state.hasValue) {
      state = AsyncValue.data(updater(state.value!));
    }
  }
  
  void updateStateWith(LiveNotificationConfig newConfig) {
    state = AsyncValue.data(newConfig);
  }
  
  Future<void> resetToDefaults() async {
    final manager = ref.read(liveNotificationConfigManagerProvider);
    final defaultConfig = await manager.resetToDefault();
    state = AsyncValue.data(defaultConfig);
  }

  void updateElementVisibility(String element, bool isVisible) {
    _updateState((config) {
      switch (element) {
        case 'avatar': return config.copyWith(avatar: config.avatar.copyWith(visible: isVisible));
        case 'name': return config.copyWith(name: config.name.copyWith(visible: isVisible));
        case 'number': return config.copyWith(number: config.number.copyWith(visible: isVisible));
        case 'location': return config.copyWith(location: config.location.copyWith(visible: isVisible));
        case 'carrier': return config.copyWith(carrier: config.carrier.copyWith(visible: isVisible));
        case 'countryName': return config.copyWith(countryName: config.countryName.copyWith(visible: isVisible));
        case 'labels': return config.copyWith(labels: config.labels.copyWith(visible: isVisible));
        case 'count': return config.copyWith(count: config.count.copyWith(visible: isVisible));
        case 'numberType': return config.copyWith(numberType: config.numberType.copyWith(visible: isVisible));
        case 'stir': return config.copyWith(stir: config.stir.copyWith(visible: isVisible));
        case 'simCard': return config.copyWith(simCard: config.simCard.copyWith(visible: isVisible));
        case 'callType': return config.copyWith(callType: config.callType.copyWith(visible: isVisible));
        case 'securityMessage': return config.copyWith(securityMessage: config.securityMessage.copyWith(visible: isVisible));
        default: return config;
      }
    });
  }

  void updateTextStyle(String element, {String? color, double? fontSize}) {
    _updateState((config) {
      LiveTextConfig textConfig;
      switch (element) {
        case 'name': textConfig = config.name; break;
        case 'number': textConfig = config.number; break;
        case 'location': textConfig = config.location; break;
        case 'carrier': textConfig = config.carrier; break;
        case 'countryName': textConfig = config.countryName; break;
        case 'labels': textConfig = config.labels; break;
        case 'count': textConfig = config.count; break;
        case 'numberType': textConfig = config.numberType; break;
        case 'stir': textConfig = config.stir; break;
        case 'simCard': textConfig = config.simCard; break;
        default: return config;
      }

      final newTextConfig = textConfig.copyWith(
        color: color ?? textConfig.color,
        fontSize: fontSize ?? textConfig.fontSize,
      );

      switch (element) {
        case 'name': return config.copyWith(name: newTextConfig);
        case 'number': return config.copyWith(number: newTextConfig);
        case 'location': return config.copyWith(location: newTextConfig);
        case 'carrier': return config.copyWith(carrier: newTextConfig);
        case 'countryName': return config.copyWith(countryName: newTextConfig);
        case 'labels': return config.copyWith(labels: newTextConfig);
        case 'count': return config.copyWith(count: newTextConfig);
        case 'numberType': return config.copyWith(numberType: newTextConfig);
        case 'stir': return config.copyWith(stir: newTextConfig);
        case 'simCard': return config.copyWith(simCard: newTextConfig);
        default: return config;
      }
    });
  }
  
  void updateAvatarConfig({double? size, double? borderWidth, String? borderColor}) {
    _updateState((config) => config.copyWith(
      avatar: config.avatar.copyWith(
        size: size ?? config.avatar.size,
        borderWidth: borderWidth ?? config.avatar.borderWidth,
        borderColor: borderColor ?? config.avatar.borderColor,
      ),
    ));
  }

  void updateIconConfig({double? size, String? color}) {
      _updateState((config) => config.copyWith(
          callType: config.callType.copyWith(
              size: size ?? config.callType.size,
              color: color ?? config.callType.color,
          )
      ));
  }

  void updateElementPosition(String element, Offset newPosition) {
    _updateState((config) {
      final newPosConfig = LivePositionConfig(x: newPosition.dx, y: newPosition.dy);
      switch (element) {
        case 'avatar': return config.copyWith(avatar: config.avatar.copyWith(position: newPosConfig));
        case 'name': return config.copyWith(name: config.name.copyWith(position: newPosConfig));
        case 'number': return config.copyWith(number: config.number.copyWith(position: newPosConfig));
        case 'location': return config.copyWith(location: config.location.copyWith(position: newPosConfig));
        case 'carrier': return config.copyWith(carrier: config.carrier.copyWith(position: newPosConfig));
        case 'countryName': return config.copyWith(countryName: config.countryName.copyWith(position: newPosConfig));
        case 'labels': return config.copyWith(labels: config.labels.copyWith(position: newPosConfig));
        case 'count': return config.copyWith(count: config.count.copyWith(position: newPosConfig));
        case 'numberType': return config.copyWith(numberType: config.numberType.copyWith(position: newPosConfig));
        case 'stir': return config.copyWith(stir: config.stir.copyWith(position: newPosConfig));
        case 'simCard': return config.copyWith(simCard: config.simCard.copyWith(position: newPosConfig));
        case 'callType': return config.copyWith(callType: config.callType.copyWith(position: newPosConfig));
        case 'securityMessage': return config.copyWith(securityMessage: config.securityMessage.copyWith(position: newPosConfig));
        default: return config;
      }
    });
  }
}