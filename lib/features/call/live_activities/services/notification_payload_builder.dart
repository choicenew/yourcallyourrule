// lib/features/call/live_activities/services/live_notification_payload_builder.dart

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:live_updates/models/custom_view_data.dart';

import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';

Color _colorStringToColor(String colorStr) {
  try {
    String hex = colorStr.toUpperCase().replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  } catch (_) {
    return const Color(0xFFFFFFFF);
  }
}

class LiveNotificationPayloadBuilder {
  /// 将配置和真实数据转换为 LiveUpdates 的 viewData Map
  static Future<Map<String, CustomViewData>> build(
    LiveNotificationConfig config,
    CallerIdData data,
    SimInfo? simInfo,
    StirInfo? stirInfo,
    {String? securityMessage}
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
      simInfo?.callType == 'incoming'
          ? 'assets/icons/call_received.png'
          : 'assets/icons/call_made.png',
    );

    final Map<String, CustomViewData> viewData = {};

    // Avatar
    if (config.avatar.visible) {
      viewData['avatar_image'] = ImageViewData(
        imageBytes: avatarBytes,
        width: config.avatar.size,
        height: config.avatar.size,
        position: Offset(config.avatar.position.x, config.avatar.position.y),
      );
    }

    // Name
    if (config.name.visible) {
      viewData['caller_name_text'] = TextViewData(
        text: data.name ?? 'Unknown',
        textColor: _colorStringToColor(config.name.color),
        textSize: config.name.fontSize,
        position: Offset(config.name.position.x, config.name.position.y),
      );
    }

    // Number
    if (config.number.visible) {
      viewData['caller_number_text'] = TextViewData(
        text: data.phoneNumber.value,
        textColor: _colorStringToColor(config.number.color),
        textSize: config.number.fontSize,
        position: Offset(config.number.position.x, config.number.position.y),
      );
    }

    // Location
    if (config.location.visible) {
      viewData['location_text'] = TextViewData(
        text: data.region ?? '',
        textColor: _colorStringToColor(config.location.color),
        textSize: config.location.fontSize,
        position: Offset(config.location.position.x, config.location.position.y),
      );
    }

    // Carrier
    if (config.carrier.visible) {
      viewData['carrier_text'] = TextViewData(
        text: data.carrier ?? '',
        textColor: _colorStringToColor(config.carrier.color),
        textSize: config.carrier.fontSize,
        position: Offset(config.carrier.position.x, config.carrier.position.y),
      );
    }

    // Country name
    if (config.countryName.visible) {
      viewData['country_name_text'] = TextViewData(
        text: data.countryName ?? '',
        textColor: _colorStringToColor(config.countryName.color),
        textSize: config.countryName.fontSize,
        position: Offset(config.countryName.position.x, config.countryName.position.y),
      );
    }

    // Labels
    if (config.labels.visible) {
      viewData['labels_text'] = TextViewData(
        text: data.labels?.map((l) => l.label).join(', ') ?? '',
        textColor: _colorStringToColor(config.labels.color),
        textSize: config.labels.fontSize,
        position: Offset(config.labels.position.x, config.labels.position.y),
      );
    }

    // Count
    if (config.count.visible) {
      viewData['count_text'] = TextViewData(
        text: 'Marked by ${data.count}',
        textColor: _colorStringToColor(config.count.color),
        textSize: config.count.fontSize,
        position: Offset(config.count.position.x, config.count.position.y),
      );
    }

    // Number type
    if (config.numberType.visible) {
      viewData['number_type_text'] = TextViewData(
        text: data.numberType.name,
        textColor: _colorStringToColor(config.numberType.color),
        textSize: config.numberType.fontSize,
        position: Offset(config.numberType.position.x, config.numberType.position.y),
      );
    }

    // STIR/SHAKEN
    if (config.stir.visible && stirInfo != null) {
      viewData['stir_text'] = TextViewData(
        text: stirInfo.isVerified ? 'Verified' : 'Not Verified',
        textColor: _colorStringToColor(config.stir.color),
        textSize: config.stir.fontSize,
        position: Offset(config.stir.position.x, config.stir.position.y),
      );
    }

    // SIM Card
    if (config.simCard.visible && simInfo != null) {
      viewData['sim_card_text'] = TextViewData(
        text: simInfo.displayName ?? '',
        textColor: _colorStringToColor(config.simCard.color),
        textSize: config.simCard.fontSize,
        position: Offset(config.simCard.position.x, config.simCard.position.y),
      );
    }

    // Call type icon
    if (config.callType.visible) {
      viewData['call_type_image'] = ImageViewData(
        imageBytes: callTypeIconBytes,
        width: config.callType.size,
        height: config.callType.size,
        position: Offset(config.callType.position.x, config.callType.position.y),
      );
    }

    // Security message
    if (config.securityMessage.visible) {
      viewData['security_message_text'] = TextViewData(
        text: securityMessage ?? 'Security Alert: Potential fraud detected.',
        textColor: _colorStringToColor(config.securityMessage.color),
        textSize: config.securityMessage.fontSize,
        position: Offset(
          config.securityMessage.position.x,
          config.securityMessage.position.y,
        ),
      );
    }

    return viewData;
  }
}