import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart'; // 【关键修改点】导入新的Config
import 'package:yourcallyourrule/features/call/caller_id/core/extensions/phone_number_type_extension.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/scrolling_security_message.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/call/caller_id/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CallerIdContentBuilder {
  // 【关键修改点】: 整个方法签名和实现都已更新
  static Widget buildCallerIdContent({
    required BuildContext context,
    required CallerIdData callerIdData,
    required CallerIdConfig config, // 接收统一的 config 对象
    SimInfo? simInfo,
    StirInfo? stirInfo,
    bool isDraggable = true,
    // 为每个可拖动元素添加回调函数
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

    // 【修改点】: 诈骗提醒现在直接修改传入的config，但这在不可变状态下是不好的。
    // 更好的做法是在Notifier层面处理。这里的逻辑暂时简化，以编译通过为先。
    // 在实际应用中，应通过Notifier方法来设置安全消息。
    if (isFraudulent) {
      FraudDetectionService.triggerFraudAlert(callerIdData.phoneNumber.value);
    }
    
    return Stack(
      children: <Widget>[
        // 安全消息现在直接从 config 获取数据
        ScrollingSecurityMessage(
          config: config,
          isDraggable: isDraggable,
          onPositionChanged: onSecurityMessagePositionChanged,
          // 如果是诈骗，强制显示红色警告信息
          overrideMessage: isFraudulent ? AppLocalizations.of(context)!.fraudAlert : null,
          overrideColor: isFraudulent ? Colors.red : null,
        ),
        
        // 所有元素现在都从 config 对象读取它们的样式和位置
        _buildPositionedElement(
          child: _buildAvatar(callerIdData, config, isFraudulent),
          position: config.avatarPosition,
          onPositionChanged: isDraggable ? onAvatarPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.carrier ?? AppLocalizations.of(context)!.unknown,
            style: TextStyle(fontSize: config.carrierFontSize, color: config.textCarrierColor),
          ),
          position: config.carrierPosition,
          onPositionChanged: isDraggable ? onCarrierPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.name ?? AppLocalizations.of(context)!.nameUnknown,
            style: TextStyle(fontSize: config.nameFontSize, color: config.textNameColor),
          ),
          position: config.namePosition,
          onPositionChanged: isDraggable ? onNamePositionChanged : null,
        ),
        // ... 对所有其他元素重复此模式 ...
        _buildPositionedElement(
          child: Text(
            callerIdData.countryName ?? AppLocalizations.of(context)!.unknown,
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
                    ? callerIdData.labels!.map((label) => LabelTranslationUtils.translatePredefinedLabel(label.label, context)).join(', ')
                    : AppLocalizations.of(context)!.unknown,
                style: TextStyle(fontSize: config.labelsFontSize, color: config.textLabelsColor),
              ),
            ],
          ),
          position: config.labelsPosition,
          onPositionChanged: isDraggable ? onLabelsPositionChanged : null,
        ),
         _buildPositionedElement(
          child: Text(
            AppLocalizations.of(context)!.markedByCount(callerIdData.count),
            style: TextStyle(fontSize: config.countFontSize, color: config.textCountColor),
          ),
          position: config.countPosition,
          onPositionChanged: isDraggable ? onCountPositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.numberType.translated(context),
            style: TextStyle(fontSize: config.numberTypeFontSize, color: config.textNumberTypeColor),
          ),
          position: config.numberTypePosition,
          onPositionChanged: isDraggable ? onNumberTypePositionChanged : null,
        ),
        _buildPositionedElement(
          child: Text(
            callerIdData.phoneNumber.value,
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
                callerIdData.region ?? AppLocalizations.of(context)!.unknown,
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
              stirInfo.isVerified
                  ? AppLocalizations.of(context)!.verifiedText
                  : (stirInfo.isNotVerified ? AppLocalizations.of(context)!.notVerifiedText : AppLocalizations.of(context)!.verificationFailedText),
              style: TextStyle(fontSize: config.stirFontSize, color: config.textStirColor),
            ),
            position: config.stirPosition,
            onPositionChanged: isDraggable ? onStirPositionChanged : null,
          ),
        if (simInfo != null)
          _buildPositionedElement(
            child: Icon(
              simInfo.callType == "incoming" ? Icons.call_received : Icons.call_made,
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
                color: Colors.white..withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
              child: Text(
                 simInfo.simSlotIndex == 0
                        ? AppLocalizations.of(context)!.simSlot1(simInfo.countryIso ?? "")
                        : (simInfo.simSlotIndex != null
                            ? AppLocalizations.of(context)!.simSlot2(simInfo.countryIso ?? "")
                            : AppLocalizations.of(context)!.unknown),
                style: TextStyle(fontSize: config.simCardFontSize, color: config.textSimCardColor),
              ),
            ),
            position: config.simCardPosition,
            onPositionChanged: isDraggable ? onSimCardPositionChanged : null,
          ),
      ],
    );
  }

  static Widget _buildAvatar(CallerIdData callerIdData, CallerIdConfig config, bool isFraudulent) {
    // 诈骗电话使用红色边框
    final borderColor = isFraudulent ? Colors.red : config.avatarBorderColor;
    // 从 callerIdData 中提取用于 AvatarUtils 的标签文本
    final String? labelText = callerIdData.labels?.isNotEmpty == true 
        ? callerIdData.labels!.first.label 
        : null;
    
    return CircleAvatar(
      radius: config.avatarBorderSize / 2,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: config.avatarSize / 2,
        // 调用 AvatarUtils 中的静态方法来获取 ImageProvider
        backgroundImage: AvatarUtils.getAvatarImage(callerIdData.avatar, labelText),
        // 如果你还想在没有图片时显示首字母，可以这样做：
        child: AvatarUtils.getAvatarImage(callerIdData.avatar, labelText) == null
             ? Text(AvatarUtils.getAvatarInitial(callerIdData.name ?? labelText))
            : null,
      ),
    );
  }
  
  static ImageProvider _getAvatarImage(CallerIdData callerIdData) {
    if (callerIdData.avatar != null && callerIdData.avatar!.isNotEmpty) {
      return callerIdData.avatar!.startsWith('http')
          ? NetworkImage(callerIdData.avatar!)
          : AssetImage(callerIdData.avatar!);
    } else {
      final label = callerIdData.labels?.isNotEmpty == true ? callerIdData.labels!.first.label : 'Unknown';
      return AssetImage('assets/avatars/$label.png');
    }
  }

  static Widget _buildPositionedElement({
    required Widget child,
    required Offset position,
    Function(Offset)? onPositionChanged,
  }) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: onPositionChanged != null
          ? GestureDetector(
              onPanUpdate: (details) => onPositionChanged(position + details.delta),
              child: child,
            )
          : child,
    );
  }

  // 【关键修改点】: 接收统一的 config 对象
  static Widget buildOverlayContainer({
    required CallerIdConfig config,
    required Widget child,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: config.windowWidth,
        height: config.windowHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(6.0, 1),
            end: const Alignment(-1, 6.0),
            colors: [config.backgroundColorStart, config.backgroundColorEnd],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}