// lib/features/call/live_activities/services/notification_payload_builder.dart

import 'package:flutter/material.dart';
import 'package:live_activity_kit/live_activity_kit.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';

class LiveNotificationPayload {
  final LANode lockScreen;
  final LANode compactLeading;
  final LANode compactTrailing;
  final LANode minimal;
  final LANode expandedLeading;
  final LANode expandedCenter;
  final LANode? expandedBottom;

  const LiveNotificationPayload({
    required this.lockScreen,
    required this.compactLeading,
    required this.compactTrailing,
    required this.minimal,
    required this.expandedLeading,
    required this.expandedCenter,
    this.expandedBottom,
  });
}

class LiveNotificationPayloadBuilder {
  /// 将配置和真实数据转换为 LiveActivityKit 的节点 Bundle
  static Future<LiveNotificationPayload> build(
    LiveNotificationConfig config,
    CallerIdData data,
    SimInfo? simInfo,
    StirInfo? stirInfo, {
    String? securityMessage,
    bool isFraudCall = false,
  }) async {
    final String numberDisplay = data.phoneNumber.value;
    final String nameDisplay = data.name ?? numberDisplay;

    final String? labelText = (data.labels != null && data.labels!.isNotEmpty)
        ? data.labels!.first.label
        : null;
    final ImageProvider? avatarProvider = config.avatar.visible
        ? AvatarUtils.getAvatarImage(data.avatar, labelText)
        : null;

    final String? assetPath = (avatarProvider is AssetImage) ? avatarProvider.assetName : null;
    final bool hasAvatar = assetPath != null && assetPath.isNotEmpty;

    final List<String> details = [];
    if (config.carrier.visible && data.carrier != null && data.carrier!.isNotEmpty) {
      details.add(data.carrier!);
    }
    if (config.location.visible && data.region != null && data.region!.isNotEmpty) {
      details.add(data.region!);
    }
    if (config.countryName.visible && data.countryName != null && data.countryName!.isNotEmpty) {
      details.add(data.countryName!);
    }
    if (config.simCard.visible && simInfo?.displayName != null && simInfo!.displayName!.isNotEmpty) {
      details.add(simInfo.displayName!);
    }
    final String detailLine = details.join(' · ');

    final avatarNode = hasAvatar
        ? LA.asset(assetPath, width: 44, height: 44, cornerRadius: 22)
        : LA.symbol(
            'person.crop.circle.fill',
            size: 40,
            color: isFraudCall
                ? const Color(0xFFD32F2F)
                : AvatarUtils.getColorFromName(nameDisplay),
          );

    final lockScreenNode = LA.column([
      LA.row([
        avatarNode,
        LA.spacer(minLength: 10),
        LA.column([
          if (config.name.visible)
            LA.text(
              nameDisplay,
              size: config.name.fontSize,
              weight: FontWeight.bold,
              color: isFraudCall ? const Color(0xFFD32F2F) : null,
            ),
          if (config.number.visible)
            LA.text(numberDisplay, size: config.number.fontSize),
        ]),
      ]),
      if (detailLine.isNotEmpty)
        LA.padding(
          LA.text(detailLine, size: 12, color: const Color(0xFF888888)),
          top: 4,
        ),
      if (config.stir.visible && stirInfo != null)
        LA.padding(
          LA.text(
            stirInfo.isVerified ? '🛡️ Verified' : 'Not Verified',
            size: config.stir.fontSize,
            color: stirInfo.isVerified
                ? const Color(0xFF2E7D32)
                : const Color(0xFF888888),
          ),
          top: 4,
        ),
      if (config.securityMessage.visible && securityMessage != null)
        LA.padding(
          LA.container(
            padding: const LAInsets(top: 6, bottom: 6, left: 8, right: 8),
            background: const Color(0x22D32F2F),
            cornerRadius: 6,
            child: LA.text(
              securityMessage,
              size: config.securityMessage.fontSize,
              color: const Color(0xFFD32F2F),
            ),
          ),
          top: 6,
        ),
    ]);

    final compactLeadingNode = hasAvatar
        ? LA.asset(assetPath, width: 20, height: 20, cornerRadius: 10)
        : LA.symbol(
            'phone.fill',
            color: isFraudCall
                ? const Color(0xFFD32F2F)
                : AvatarUtils.getColorFromName(nameDisplay),
          );
    final compactTrailingNode = LA.text(
      nameDisplay,
      size: 12,
      weight: FontWeight.bold,
    );
    final minimalNode = LA.symbol(
      'phone.fill',
      color: isFraudCall
          ? const Color(0xFFD32F2F)
          : AvatarUtils.getColorFromName(nameDisplay),
    );
    final expandedLeadingNode = hasAvatar
        ? LA.asset(assetPath, width: 40, height: 40, cornerRadius: 20)
        : LA.symbol(
            'person.crop.circle.fill',
            size: 36,
            color: isFraudCall
                ? const Color(0xFFD32F2F)
                : AvatarUtils.getColorFromName(nameDisplay),
          );
    final expandedCenterNode = LA.column([
      if (config.name.visible)
        LA.text(nameDisplay, size: 15, weight: FontWeight.bold),
      if (config.number.visible)
        LA.text(numberDisplay, size: 13),
      if (detailLine.isNotEmpty)
        LA.text(detailLine, size: 11),
    ]);
    final expandedBottomNode = (config.securityMessage.visible && securityMessage != null)
        ? LA.text(securityMessage, size: 12, color: const Color(0xFFD32F2F))
        : null;

    return LiveNotificationPayload(
      lockScreen: lockScreenNode,
      compactLeading: compactLeadingNode,
      compactTrailing: compactTrailingNode,
      minimal: minimalNode,
      expandedLeading: expandedLeadingNode,
      expandedCenter: expandedCenterNode,
      expandedBottom: expandedBottomNode,
    );
  }
}