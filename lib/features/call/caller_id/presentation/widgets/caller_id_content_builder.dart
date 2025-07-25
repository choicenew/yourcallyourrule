import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/provider/providers/security_message_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/core/extensions/phone_number_type_extension.dart';
import 'package:yourcallyourrule/features/call/caller_id/providers/caller_id_style_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/presentation/widgets/scrolling_security_message.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service_new.dart';
import 'package:yourcallyourrule/features/call/caller_id/utils/label_translation_utils.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示内容构建器
/// 提供共享的来电显示UI构建功能，减少代码重复
class CallerIdContentBuilder {
  /// 构建来电显示内容
  static Widget buildCallerIdContent({
    required BuildContext context,
    required CallerIdData callerIdData,
    required CallerIdStyleProvider styleProvider,
    SimInfo? simInfo,
    StirInfo? stirInfo,
    bool isDraggable = true,
  }) {
    // 检查是否包含诈骗相关标签
    final bool isFraudulent = FraudDetectionService.checkForFraudLabels(callerIdData);
    
    return Stack(
      children: <Widget>[
        // Scrolling security message with fraud warning if needed
        Consumer(builder: (context, ref, _) {
          // 如果是诈骗电话，设置警告消息
          if (isFraudulent) {
            // 获取 SecurityMessageProvider 实例
            final securityMessageState = ref.read(securityMessageProvider);
            // 设置诈骗警告消息（使用国际化字符串）
            securityMessageState.setMessage(AppLocalizations.of(context)!.fraudAlert);
            securityMessageState.setTextColor(Colors.red);
            securityMessageState.setEnabled(true);
            
            // 增强反诈骗提醒 - 添加震动和闪烁效果
            FraudDetectionService.triggerFraudAlertDialog(callerIdData.phoneNumber.value);
          }
          return ScrollingSecurityMessage(isDraggable: isDraggable);
        }),
        // 头像
        _buildPositionedElement(
          child: _buildAvatar(callerIdData, styleProvider),
          position: styleProvider.avatarPosition,
          onPositionChanged: isDraggable ? styleProvider.updateAvatarPosition : null,
        ),
        // 运营商
        _buildPositionedElement(
          child: Text(
            callerIdData.carrier ?? AppLocalizations.of(context)!.unknown,
            style: TextStyle(
              fontSize: styleProvider.carrierFontSize,
              color: styleProvider.textCarrierColor,
            ),
          ),
          position: styleProvider.carrierPosition,
          onPositionChanged: isDraggable ? styleProvider.updateCarrierPosition : null,
        ),
        // 名称
        _buildPositionedElement(
          child: Text(
            callerIdData.name == null
                ? AppLocalizations.of(context)!.nameUnknown
                : AppLocalizations.of(context)!.nameWithValue(callerIdData.name!),
            style: TextStyle(
              fontSize: styleProvider.nameFontSize,
              color: styleProvider.textNameColor,
            ),
          ),
          position: styleProvider.namePosition,
          onPositionChanged: isDraggable ? styleProvider.updateNamePosition : null,
        ),
        // 国家名称
        _buildPositionedElement(
          child: Text(
            callerIdData.countryName ?? AppLocalizations.of(context)!.unknown,
            style: TextStyle(
              fontSize: styleProvider.countryNameFontSize,
              color: styleProvider.textCountryNameColor,
            ),
          ),
          position: styleProvider.countryNamePosition,
          onPositionChanged: isDraggable ? styleProvider.updateCountryNamePosition : null,
        ),
        // 标签
        _buildPositionedElement(
          child: Row(
            children: [
              Icon(Icons.policy_outlined,
                  color: styleProvider.textIconLabelColor,
                  size: styleProvider.iconSize),
              const SizedBox(width: 5),
              Text(
                callerIdData.labels?.isNotEmpty == true
                    ? callerIdData.labels!
                        .map((label) => LabelTranslationUtils.translatePredefinedLabel(label.label, context))
                        .join(', ')
                    : AppLocalizations.of(context)!.unknown,
                style: TextStyle(
                  fontSize: styleProvider.labelsFontSize,
                  color: styleProvider.textLabelsColor,
                ),
              ),
            ],
          ),
          position: styleProvider.labelsPosition,
          onPositionChanged: isDraggable ? styleProvider.updateLabelsPosition : null,
        ),
        // 计数
        _buildPositionedElement(
          child: Text(
            AppLocalizations.of(context)!.markedByCount(callerIdData.count),
            style: TextStyle(
              fontSize: styleProvider.countFontSize,
              color: styleProvider.textCountColor,
            ),
          ),
          position: styleProvider.countPosition,
          onPositionChanged: isDraggable ? styleProvider.updateCountPosition : null,
        ),
        // 号码类型
        _buildPositionedElement(
          child: Text(
            callerIdData.numberType.translated(context),
            style: TextStyle(
              fontSize: styleProvider.numberTypeFontSize,
              color: styleProvider.textNumberTypeColor,
            ),
          ),
          position: styleProvider.numberTypePosition,
          onPositionChanged: isDraggable ? styleProvider.updateNumberTypePosition : null,
        ),
        // 电话号码
        _buildPositionedElement(
          child: Text(
            callerIdData.phoneNumber.value,
            style: TextStyle(
              fontSize: styleProvider.numberFontSize,
              color: styleProvider.textNumberColor,
            ),
          ),
          position: styleProvider.numberPosition,
          onPositionChanged: isDraggable ? styleProvider.updateNumberPosition : null,
        ),
        // 地理位置
        _buildPositionedElement(
          child: Row(
            children: [
              Icon(Icons.location_on,
                  color: styleProvider.textIconLocationColor,
                  size: styleProvider.iconSize),
              const SizedBox(width: 5),
              Text(
                callerIdData.region ?? AppLocalizations.of(context)!.unknown,
                style: TextStyle(
                  fontSize: styleProvider.locationFontSize,
                  color: styleProvider.textLocationColor,
                ),
              ),
            ],
          ),
          position: styleProvider.locationPosition,
          onPositionChanged: isDraggable ? styleProvider.updateLocationPosition : null,
        ),
        // STIR/SHAKEN验证状态
        if (stirInfo != null)
          _buildPositionedElement(
            child: Text(
              stirInfo.isVerified
                  ? AppLocalizations.of(context)!.verifiedText
                  : (stirInfo.isNotVerified ? AppLocalizations.of(context)!.notVerifiedText : AppLocalizations.of(context)!.verificationFailedText),
              style: TextStyle(
                fontSize: styleProvider.stirFontSize,
                color: styleProvider.textStirColor,
              ),
            ),
            position: styleProvider.stirPosition,
            onPositionChanged: isDraggable ? styleProvider.updateStirPosition : null,
          ),
        // 通话类型
        if (simInfo != null)
          _buildPositionedElement(
            child: Row(
              children: [
                Icon(
                  simInfo.callType == "incoming"
                      ? Icons.call_received
                      : Icons.call_made,
                  color: styleProvider.textIconCallTypeColor,
                  size: styleProvider.iconSize,
                ),
                const SizedBox(width: 5),
              ],
            ),
            position: styleProvider.callTypePosition,
            onPositionChanged: isDraggable ? styleProvider.updateCallTypePosition : null,
          ),
        // SIM卡信息
        if (simInfo != null)
          _buildPositionedElement(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
              child: Row(
                children: [
                  Text(
                    simInfo.simSlotIndex == 0
                        ? AppLocalizations.of(context)!.simSlot1(simInfo.countryIso ?? "")
                        : (simInfo.simSlotIndex != null
                            ? AppLocalizations.of(context)!.simSlot2(simInfo.countryIso ?? "")
                            : AppLocalizations.of(context)!.unknown),
                    style: TextStyle(
                      fontSize: styleProvider.simCardFontSize,
                      color: styleProvider.textSimCardColor,
                    ),
                  ),
                ],
              ),
            ),
            position: styleProvider.simCardPosition,
            onPositionChanged: isDraggable ? styleProvider.updateSimCardPosition : null,
          ),
      ],
    );
  }

  /// 构建头像
  static Widget _buildAvatar(CallerIdData callerIdData, CallerIdStyleProvider styleProvider) {
    // 检查是否包含诈骗相关标签
    final bool isFraudulent = FraudDetectionService.checkForFraudLabels(callerIdData);
    
    // 如果是诈骗电话，使用红色边框并添加闪烁效果
    if (isFraudulent) {
      return _buildFlashingAvatar(callerIdData, styleProvider);
    }
    
    // 正常显示头像
    return CircleAvatar(
      radius: styleProvider.avatarBorderSize / 2,
      backgroundColor: styleProvider.avatarBorderColor,
      child: CircleAvatar(
        radius: styleProvider.avatarSize / 2,
        backgroundImage: _getAvatarImage(callerIdData),
      ),
    );
  }
  
  // 诈骗检测逻辑已移至 FraudDetectionService
  
  /// 构建闪烁头像
  static Widget _buildFlashingAvatar(CallerIdData callerIdData, CallerIdStyleProvider styleProvider) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return CircleAvatar(
          radius: styleProvider.avatarBorderSize / 2,
          backgroundColor: Colors.red.withOpacity(value),
          child: CircleAvatar(
            radius: styleProvider.avatarSize / 2,
            backgroundImage: _getAvatarImage(callerIdData),
          ),
        );
      },
      onEnd: () {
        // 动画结束后反向播放，实现闪烁效果
        styleProvider.setAvatarBorderColor(
          styleProvider.avatarBorderColor == Colors.red ? 
          const Color.fromARGB(255, 76, 175, 80) : Colors.red
        );
      },
    );
  }

  /// 获取头像图片
  static ImageProvider _getAvatarImage(CallerIdData callerIdData) {
    if (callerIdData.avatar != null && callerIdData.avatar!.isNotEmpty) {
      // 如果是URL链接，则使用NetworkImage
      if (callerIdData.avatar!.startsWith('http')) {
        return NetworkImage(callerIdData.avatar!);
      } else {
        // 如果是本地资源路径，则使用AssetImage
        return AssetImage(callerIdData.avatar!);
      }
    } else {
      // 否则使用标签构建本地资源路径
      final label = callerIdData.labels?.isNotEmpty == true 
          ? callerIdData.labels!.first.label 
          : 'Unknown';
      return AssetImage('assets/avatars/$label.png');
    }
  }

  /// 构建定位元素
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
              onPanUpdate: (details) {
                onPositionChanged(position + details.delta);
              },
              child: child,
            )
          : child,
    );
  }

  /// 构建覆盖层容器
  static Widget buildOverlayContainer({
    required CallerIdStyleProvider styleProvider,
    required Widget child,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: styleProvider.windowWidth,
        height: styleProvider.windowHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(6.0, 1),
            end: const Alignment(-1, 6.0),
            colors: [
              styleProvider.backgroundColorStart,
              styleProvider.backgroundColorEnd,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }
}