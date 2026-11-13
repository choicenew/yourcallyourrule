import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/common/utils/avatar_utils.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/scrolling_security_message.dart';
import 'package:yourcallyourrule/features/call/call_overlay/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/call/call_overlay/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallOverlayContentBuilder {
  static Widget buildCallOverlayContent({
    required BuildContext context,
    required CallerIdData callerIdData,
    required CallOverlayConfig config,
    SimInfo? simInfo,
    StirInfo? stirInfo,
    bool isDraggable = true,
    Function(Offset)? onAvatarPositionChanged,
    Function(Offset)? onCarrierPositionChanged,
    Function(Offset)? onNamePositionChanged,
    Function(Offset)? onCountryNamePositionChanged,
    Function(Offset)? onLabelsPositionChanged,
    Function(Offset)? onCountPositionChanged,
    Function(Offset)? onNumberTypePositionChanged,
    Function(Offset)? onNumberPositionChanged,
    Function(Offset)? onLocationPositionChanged,
    Function(Offset)? onStirPositionChanged,
    Function(Offset)? onCallTypePositionChanged,
    Function(Offset)? onSimCardPositionChanged,
    Function(Offset)? onSecurityMessagePositionChanged,
  }) {
    final bool isFraudulent = FraudDetectionService.checkForFraudLabels(callerIdData);

    if (isFraudulent) {
      FraudDetectionService.triggerFraudAlert(callerIdData.phoneNumber);
    }
    
    return Stack(
      children: <Widget>[
        ScrollingSecurityMessage(
          config: config,
          isDraggable: isDraggable,
          onPositionChanged: onSecurityMessagePositionChanged,
          overrideMessage: isFraudulent ? AppLocalizations.of(context).fraudAlert : null,
          overrideColor: isFraudulent ? Colors.red : null,
        ),
        
        _buildPositionedElement(
          child: _buildAvatar(callerIdData, config, isFraudulent),
          position: config.avatarPosition,
          onPositionChanged: isDraggable ? onAvatarPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.carrier ?? AppLocalizations.of(context).unknown,
            style: TextStyle(fontSize: config.carrierFontSize, color: config.textCarrierColor),
          ),
          position: config.carrierPosition,
          onPositionChanged: isDraggable ? onCarrierPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.name ?? AppLocalizations.of(context).nameUnknown,
            style: TextStyle(fontSize: config.nameFontSize, color: config.textNameColor),
          ),
          position: config.namePosition,
          onPositionChanged: isDraggable ? onNamePositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.countryName ?? AppLocalizations.of(context).unknown,
            style: TextStyle(fontSize: config.countryNameFontSize, color: config.textCountryNameColor),
          ),
          position: config.countryNamePosition,
          onPositionChanged: isDraggable ? onCountryNamePositionChanged : null,
        ),
        _buildPositionedElement(
          child: Row(
            children: [
              Icon(Icons.policy_outlined, color: config.textIconLabelColor, size: config.iconSize),
              const SizedBox(width: 5),
              Text(
                callerIdData.labels?.isNotEmpty == true
                    ? callerIdData.labels!.map((label) => LabelTranslationUtils.translatePredefinedLabel((label as dynamic).label ?? (label as dynamic).text ?? label.toString(), context)).join(', ')
                    : AppLocalizations.of(context).unknown,
                style: TextStyle(fontSize: config.labelsFontSize, color: config.textLabelsColor),
              ),
            ],
          ),
          position: config.labelsPosition,
          onPositionChanged: isDraggable ? onLabelsPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            AppLocalizations.of(context).markedByCount(0),
            style: TextStyle(fontSize: config.countFontSize, color: config.textCountColor),
          ),
          position: config.countPosition,
          onPositionChanged: isDraggable ? onCountPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            AppLocalizations.of(context).unknown,
            style: TextStyle(fontSize: config.numberTypeFontSize, color: config.textNumberTypeColor),
          ),
          position: config.numberTypePosition,
          onPositionChanged: isDraggable ? onNumberTypePositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.phoneNumber,
            style: TextStyle(fontSize: config.numberFontSize, color: config.textNumberColor),
          ),
          position: config.numberPosition,
          onPositionChanged: isDraggable ? onNumberPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Row(
            children: [
              Icon(Icons.location_on, color: config.textIconLocationColor, size: config.iconSize),
              const SizedBox(width: 5),
              Text(
                callerIdData.region ?? AppLocalizations.of(context).unknown,
                style: TextStyle(fontSize: config.locationFontSize, color: config.textLocationColor),
              ),
            ],
          ),
          position: config.locationPosition,
          onPositionChanged: isDraggable ? onLocationPositionChanged : null,
        ),
        if (stirInfo != null)
          _buildPositionedElement(
            child: Text(
              ((stirInfo as dynamic)['isVerified'] == true)
                  ? AppLocalizations.of(context).verifiedText
                  : (((stirInfo as dynamic)['isNotVerified'] == true) ? AppLocalizations.of(context).notVerifiedText : AppLocalizations.of(context).verificationFailedText),
              style: TextStyle(fontSize: config.stirFontSize, color: config.textStirColor),
            ),
            position: config.stirPosition,
            onPositionChanged: isDraggable ? onStirPositionChanged : null,
          ),
        if (simInfo != null)
          _buildPositionedElement(
            child: Icon(
              (simInfo as dynamic)['callType'] == "incoming" ? Icons.call_received : Icons.call_made,
              color: config.textIconCallTypeColor,
              size: config.iconSize,
            ),
            position: config.callTypePosition,
            onPositionChanged: isDraggable ? onCallTypePositionChanged : null,
          ),
        if (simInfo != null)
          _buildPositionedElement(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
              child: Text(
                (simInfo as dynamic)['simSlotIndex'] == 0
                        ? AppLocalizations.of(context).simSlot1((simInfo as dynamic)['countryIso'] ?? "")
                        : ((simInfo as dynamic)['simSlotIndex'] != null
                            ? AppLocalizations.of(context).simSlot2((simInfo as dynamic)['countryIso'] ?? "")
                            : AppLocalizations.of(context).unknown),
                style: TextStyle(fontSize: config.simCardFontSize, color: config.textSimCardColor),
              ),
            ),
            position: config.simCardPosition,
            onPositionChanged: isDraggable ? onSimCardPositionChanged : null,
          ),
      ],
    );
  }

  static Widget buildCallerIdContent({
    required BuildContext context,
    required CallerIdData callerIdData,
    required CallOverlayConfig config,
    SimInfo? simInfo,
    StirInfo? stirInfo,
    bool isDraggable = true,
    Function(Offset)? onAvatarPositionChanged,
    Function(Offset)? onCarrierPositionChanged,
    Function(Offset)? onNamePositionChanged,
    Function(Offset)? onCountryNamePositionChanged,
    Function(Offset)? onLabelsPositionChanged,
    Function(Offset)? onCountPositionChanged,
    Function(Offset)? onNumberTypePositionChanged,
    Function(Offset)? onNumberPositionChanged,
    Function(Offset)? onLocationPositionChanged,
    Function(Offset)? onStirPositionChanged,
    Function(Offset)? onCallTypePositionChanged,
    Function(Offset)? onSimCardPositionChanged,
    Function(Offset)? onSecurityMessagePositionChanged,
  }) => buildCallOverlayContent(
    context: context,
    callerIdData: callerIdData,
    config: config,
    simInfo: simInfo,
    stirInfo: stirInfo,
    isDraggable: isDraggable,
    onAvatarPositionChanged: onAvatarPositionChanged,
    onCarrierPositionChanged: onCarrierPositionChanged,
    onNamePositionChanged: onNamePositionChanged,
    onCountryNamePositionChanged: onCountryNamePositionChanged,
    onLabelsPositionChanged: onLabelsPositionChanged,
    onCountPositionChanged: onCountPositionChanged,
    onNumberTypePositionChanged: onNumberTypePositionChanged,
    onNumberPositionChanged: onNumberPositionChanged,
    onLocationPositionChanged: onLocationPositionChanged,
    onStirPositionChanged: onStirPositionChanged,
    onCallTypePositionChanged: onCallTypePositionChanged,
    onSimCardPositionChanged: onSimCardPositionChanged,
    onSecurityMessagePositionChanged: onSecurityMessagePositionChanged,
  );

  static Widget _buildAvatar(CallerIdData callerIdData, CallOverlayConfig config, bool isFraudulent) {
    final borderColor = isFraudulent ? Colors.red : config.avatarBorderColor;
    final String? labelText = callerIdData.labels?.isNotEmpty == true 
        ? ((callerIdData.labels!.first as dynamic).label ?? (callerIdData.labels!.first as dynamic).text ?? callerIdData.labels!.first.toString())
        : null;
    
    return CircleAvatar(
      radius: config.avatarBorderSize / 2,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: config.avatarSize / 2,
        backgroundImage: AvatarUtils.getAvatarImage(null, labelText),
        child: AvatarUtils.getAvatarImage(null, labelText) == null
             ? Text(AvatarUtils.getAvatarInitial(callerIdData.name ?? labelText))
            : null,
      ),
    );
  }

  static Widget _buildPositionedElement({
    required Widget child,
    required Offset position,
    Function(Offset)? onPositionChanged,
  }) {
    if (onPositionChanged != null) {
      return Positioned(
        left: position.dx,
        top: position.dy,
        child: GestureDetector(
          onPanUpdate: (details) {
            onPositionChanged(Offset(
              position.dx + details.delta.dx,
              position.dy + details.delta.dy,
            ));
          },
          child: child,
        ),
      );
    }
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: child,
    );
  }
}
