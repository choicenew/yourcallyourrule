import 'package:material_ui/material_ui.dart';
import 'package:live_activity_kit/live_activity_kit.dart';
import 'package:yourcallyourrule/features/common/utils/avatar_utils.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
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
  LiveNotificationPayloadBuilder();

  static Future<LiveNotificationPayload> build(
    LiveNotificationConfig config,
    CallerIdData data,
    SimInfo? simInfo,
    StirInfo? stirInfo, {
    String? securityMessage,
    bool isFraudCall = false,
  }) async {
    final String numberDisplay = data.phoneNumber;
    final String nameDisplay = data.name ?? numberDisplay;

    final String? labelText = (data.labels != null && data.labels!.isNotEmpty)
        ? ((data.labels!.first as dynamic).label ?? (data.labels!.first as dynamic).text ?? data.labels!.first.toString())
        : null;
    final ImageProvider? avatarProvider = config.avatar.visible
        ? AvatarUtils.getAvatarImage(null, labelText)
        : null;

    final String? assetPath = (avatarProvider is AssetImage) ? avatarProvider.assetName : null;
    final bool hasAvatar = assetPath != null && assetPath.isNotEmpty;

    final List<String> details = [];
    if (config.labels.visible && labelText != null && labelText.isNotEmpty) {
      details.add(labelText);
    }
    if (config.simCard.visible && simInfo?['displayName'] != null) {
      details.add(simInfo!['displayName'] as String);
    }
    if (config.carrier.visible && data.carrier != null && data.carrier!.isNotEmpty) {
      details.add(data.carrier!);
    }
    if (config.location.visible && data.region != null && data.region!.isNotEmpty) {
      details.add(data.region!);
    }
    if (config.countryName.visible && data.countryName != null && data.countryName!.isNotEmpty) {
      details.add(data.countryName!);
    }
    if (config.stir.visible && stirInfo != null && (stirInfo['isVerified'] == true)) {
      details.add('STIR Pass');
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
      if (config.stir.visible && stirInfo != null && (stirInfo['isVerified'] == true))
        LA.padding(
          LA.text(
            'STIR Pass',
            size: config.stir.fontSize,
            color: const Color(0xFF2E7D32),
          ),
          top: 4,
        ),
      if (config.securityMessage.visible && securityMessage != null)
        LA.padding(
          LA.container(
            padding: const LAInsets(top: 6, bottom: 6, left: 8, right: 8),
            background: const Color(0x22D32F2F),
            child: LA.text(
              securityMessage,
              size: 13,
              weight: FontWeight.bold,
              color: const Color(0xFFD32F2F),
            ),
          ),
          top: 6,
        ),
    ]);

    final compactLeadingNode = avatarNode;
    final compactTrailingNode = LA.text(
      isFraudCall ? 'SPAM' : (labelText ?? 'Call'),
      color: isFraudCall ? const Color(0xFFD32F2F) : const Color(0xFF4CAF50),
      weight: FontWeight.bold,
    );

    final minimalNode = isFraudCall
        ? LA.symbol('exclamationmark.shield.fill', color: const Color(0xFFD32F2F))
        : LA.symbol('phone.fill', color: const Color(0xFF4CAF50));

    final expandedLeadingNode = avatarNode;
    final expandedCenterNode = LA.column([
      if (config.name.visible)
        LA.text(
          nameDisplay,
          size: config.name.fontSize,
          weight: FontWeight.bold,
          color: isFraudCall ? const Color(0xFFD32F2F) : null,
        ),
      if (config.number.visible)
        LA.text(numberDisplay, size: config.number.fontSize),
      if (detailLine.isNotEmpty)
        LA.text(detailLine, size: 12, color: const Color(0xFF888888)),
    ]);

    final expandedBottomNode = (config.securityMessage.visible && securityMessage != null)
        ? LA.container(
            padding: const LAInsets(top: 8, bottom: 8, left: 12, right: 12),
            background: const Color(0x22D32F2F),
            child: LA.text(
              securityMessage,
              size: 13,
              weight: FontWeight.bold,
              color: const Color(0xFFD32F2F),
            ),
          )
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
