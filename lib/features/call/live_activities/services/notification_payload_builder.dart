// lib/features/call/live_activities/services/live_notification_payload_builder.dart

import 'dart:typed_data';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';


// 辅助函数，将 #AARRGGBB 格式的字符串转为 Android 兼容的 int
int _colorStringToInt(String colorStr) {
  try {
    String hex = colorStr.toUpperCase().replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    if (hex.length == 8) {
      return int.parse(hex, radix: 16);
    }
  } catch (e) {
    // 捕获异常并返回默认值
  }
  return 0xFFFFFFFF; // 默认白色
}

class LiveNotificationPayloadBuilder {

  /// 将配置和真实数据转换为插件所需的 Map
  static Future<Map<String, dynamic>> build(
      LiveNotificationConfig config, 
      CallerIdData data,
      SimInfo? simInfo,
      StirInfo? stirInfo
  ) async {
    
    Future<Uint8List> _getAssetBytes(String? path) async {
      if (path == null || path.isEmpty || path.startsWith('http')) return Uint8List(0);
      try {
        final byteData = await rootBundle.load(path);
        return byteData.buffer.asUint8List();
      } catch (e) {
        return Uint8List(0);
      }
    }

    final avatarBytes = await _getAssetBytes(data.avatar);
    final callTypeIconBytes = await _getAssetBytes(
      simInfo?.callType == "incoming" 
          ? 'assets/icons/call_received.png' // 确保你有这个图标资源
          : 'assets/icons/call_made.png'
    );
    
    final payload = <String, dynamic>{};

    // --- 全局设置 ---
    payload['backgroundColor'] = _colorStringToInt(config.globalSettings.backgroundColor);

    // --- 元素配置 (逐一映射) ---
    if (config.avatar.visible) {
      payload.addAll({
        'avatarImage': avatarBytes,
        'avatarX': config.avatar.position.x,
        'avatarY': config.avatar.position.y,
        'avatarSize': config.avatar.size,
        'avatarBorderWidth': config.avatar.borderWidth,
        'avatarBorderColor': _colorStringToInt(config.avatar.borderColor),
      });
    }

    if (config.name.visible) {
      payload.addAll({
        'nameText': data.name ?? 'Unknown',
        'nameX': config.name.position.x,
        'nameY': config.name.position.y,
        'nameColor': _colorStringToInt(config.name.color),
        'nameFontSize': config.name.fontSize,
      });
    }
    
    if (config.number.visible) {
      payload.addAll({
        'numberText': data.phoneNumber.value,
        'numberX': config.number.position.x,
        'numberY': config.number.position.y,
        'numberColor': _colorStringToInt(config.number.color),
        'numberFontSize': config.number.fontSize,
      });
    }

    if (config.location.visible) {
      payload.addAll({
        'locationText': data.region ?? '',
        'locationX': config.location.position.x,
        'locationY': config.location.position.y,
        'locationColor': _colorStringToInt(config.location.color),
        'locationFontSize': config.location.fontSize,
      });
    }
    
    if (config.carrier.visible) {
      payload.addAll({
        'carrierText': data.carrier ?? '',
        'carrierX': config.carrier.position.x,
        'carrierY': config.carrier.position.y,
        'carrierColor': _colorStringToInt(config.carrier.color),
        'carrierFontSize': config.carrier.fontSize,
      });
    }

    if (config.countryName.visible) {
      payload.addAll({
        'countryNameText': data.countryName ?? '',
        'countryNameX': config.countryName.position.x,
        'countryNameY': config.countryName.position.y,
        'countryNameColor': _colorStringToInt(config.countryName.color),
        'countryNameFontSize': config.countryName.fontSize,
      });
    }

    if (config.labels.visible) {
      payload.addAll({
        'labelsText': data.labels?.map((l) => l.label).join(', ') ?? '',
        'labelsX': config.labels.position.x,
        'labelsY': config.labels.position.y,
        'labelsColor': _colorStringToInt(config.labels.color),
        'labelsFontSize': config.labels.fontSize,
      });
    }

    if (config.count.visible) {
      payload.addAll({
        'countText': 'Marked by ${data.count}',
        'countX': config.count.position.x,
        'countY': config.count.position.y,
        'countColor': _colorStringToInt(config.count.color),
        'countFontSize': config.count.fontSize,
      });
    }

    if (config.numberType.visible) {
      payload.addAll({
        'numberTypeText': data.numberType.name,
        'numberTypeX': config.numberType.position.x,
        'numberTypeY': config.numberType.position.y,
        'numberTypeColor': _colorStringToInt(config.numberType.color),
        'numberTypeFontSize': config.numberType.fontSize,
      });
    }

    if (config.stir.visible && stirInfo != null) {
      payload.addAll({
        'stirText': stirInfo.isVerified ? 'Verified' : 'Not Verified',
        'stirX': config.stir.position.x,
        'stirY': config.stir.position.y,
        'stirColor': _colorStringToInt(config.stir.color),
        'stirFontSize': config.stir.fontSize,
      });
    }
    
    if (config.simCard.visible && simInfo != null) {
      payload.addAll({
        'simCardText': simInfo.displayName ?? '',
        'simCardX': config.simCard.position.x,
        'simCardY': config.simCard.position.y,
        'simCardColor': _colorStringToInt(config.simCard.color),
        'simCardFontSize': config.simCard.fontSize,
      });
    }

    if (config.callType.visible) {
        payload.addAll({
            'callTypeImage': callTypeIconBytes,
            'callTypeX': config.callType.position.x,
            'callTypeY': config.callType.position.y,
            'callTypeSize': config.callType.size,
            'callTypeColor': _colorStringToInt(config.callType.color), // 原生端可以对图标进行着色
        });
    }

    if (config.securityMessage.visible) {
      payload.addAll({
        'securityMessageText': 'Security Alert: Potential fraud detected.',
        'securityMessageX': config.securityMessage.position.x,
        'securityMessageY': config.securityMessage.position.y,
        'securityMessageColor': _colorStringToInt(config.securityMessage.color),
        'securityMessageFontSize': config.securityMessage.fontSize,
        'securityMessageBackgroundColor': _colorStringToInt(config.securityMessage.backgroundColor),
        'securityMessageHeight': config.securityMessage.height,
        'securityMessageContainerWidth': config.securityMessage.containerWidth,
      });
    }

    return payload;
  }
}