// lib/features/caller_id/services/call_handlers/kit_live_activity_handler.dart
/// [New Version / 现代版本] 基于 live_activity_kit 的原生 Live Activity 与 iOS 灵动岛 (Dynamic Island) 处理器。
library;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:live_activity_kit/live_activity_kit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/common/utils/avatar_utils.dart';
import 'package:yourcallyourrule/core/entities/call/sim_info.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/call/caller_id/services/fraud_detection_service.dart';
import 'package:yourcallyourrule/features/call/live_activities/services/live_notification_config_service.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

part 'kit_live_activity_handler.g.dart';

// --- 100% 参照原版 liveActivityHandler 架构 ---
@Riverpod(keepAlive: true)
Future<KitLiveActivityHandler> kitLiveActivityHandler(Ref ref) async {
  final configRepository = ref.watch(configRepositoryProvider);
  final configService = LiveNotificationConfigService(configRepository);

  final handler = KitLiveActivityHandler(configService: configService);
  await handler.initialize();
  return handler;
}

/// Live Activity 处理器
/// 专门负责处理 Live Activity 相关的创建、更新和结束逻辑
class KitLiveActivityHandler {
  final LiveNotificationConfigService _configService;
  final Uuid _uuid;

  String? _currentActivityId;
  StreamSubscription<String>? _deepLinkSubscription;

  /// 构造函数
  KitLiveActivityHandler({required LiveNotificationConfigService configService})
      : _configService = configService,
        _uuid = const Uuid();

  /// 初始化
  Future<void> initialize({Function(String?)? onNotificationTapped}) async {}

  /// 显示或更新来电信息 Live Activity
  Future<void> showCallerIdActivity({
    required CallerIdData callerIdData,
    required SimInfo? simInfo,
    required StirInfo? stirInfo,
  }) async {
    try {
      final context = AppRouter.navigatorKey.currentContext;
      final String numberDisplay = callerIdData.phoneNumber.value;
      final String simSuffix =
          simInfo == null ? '' : '-SIM${simInfo.simSlotIndex! + 1}';
      final bool isFraudCall = FraudDetectionService.checkForFraudLabels(
        callerIdData,
      );

      final String finalTitle = () {
        if (context != null) {
          if (isFraudCall) {
            return "⚠️ ${AppLocalizations.of(context).fraudAlertTitle} ($numberDisplay)$simSuffix";
          } else {
            return "${AppLocalizations.of(context).callerIdNotificationTitle} ($numberDisplay)$simSuffix";
          }
        }
        return "Incoming Call ($numberDisplay)$simSuffix";
      }();

      final String securityMessageText = () {
        if (context != null) {
          return AppLocalizations.of(context).securityMessage;
        }
        return 'Do not trust any phone calls. Always verify customer service numbers independently. Never share passwords, verification codes, card numbers, or personal information.';
      }();

      final config = await _configService.loadConfigOrDefault();
      final String nameDisplay = callerIdData.name ?? finalTitle;

      // --- 统一将头像栅格化为二进制字节流，保证 Android & iOS 100% 正常渲染 ---
      final String? labelText = (callerIdData.labels != null && callerIdData.labels!.isNotEmpty)
          ? callerIdData.labels!.first.label
          : null;
      final Uint8List? avatarBytes = config.avatar.visible
          ? await _getAvatarBytes(
              callerIdData: callerIdData,
              labelText: labelText,
              nameDisplay: nameDisplay,
              isFraudCall: isFraudCall,
            )
          : null;

      final String stirText = () {
        final bool isVerified = stirInfo != null && stirInfo.isVerified;
        if (context != null) {
          return isVerified
              ? AppLocalizations.of(context)!.stirVerified
              : AppLocalizations.of(context)!.stirUnverified;
        }
        return isVerified ? '🛡️ Verified' : 'Not Verified';
      }();

      // 提取详情信息 (包含运营商、地区、国家、SIM卡、号码类型与标记计数)
      final List<String> details = [];
      if (config.carrier.visible && callerIdData.carrier != null && callerIdData.carrier!.isNotEmpty) {
        details.add(callerIdData.carrier!);
      }
      if (config.location.visible && callerIdData.region != null && callerIdData.region!.isNotEmpty) {
        details.add(callerIdData.region!);
      }
      if (config.countryName.visible && callerIdData.countryName != null && callerIdData.countryName!.isNotEmpty) {
        details.add(callerIdData.countryName!);
      }
      if (config.numberType.visible && callerIdData.numberType != PhoneNumberType.unknown) {
        details.add(callerIdData.numberType.name);
      }
      if (config.count.visible && callerIdData.count > 0) {
        final String countDisplay = context != null
            ? AppLocalizations.of(context)!.markedCountDisplay(callerIdData.count)
            : 'Marked: ${callerIdData.count}';
        details.add(countDisplay);
      }
      if (config.simCard.visible && simInfo?.displayName != null && simInfo!.displayName!.isNotEmpty) {
        details.add(simInfo.displayName!);
      }
      final String detailLine = details.join(' · ');

      final activityId = _currentActivityId ?? _uuid.v4();
      final String deepLinkPayload = isFraudCall ? '/fraud-alert-settings' : '/call-history';
      final String? base64Avatar = avatarBytes != null ? base64Encode(avatarBytes) : null;

      // 构建头像节点
      final avatarNode = base64Avatar != null
          ? LAImage(
              source: LAImageSource.asset,
              value: base64Avatar,
              width: 44,
              height: 44,
              cornerRadius: 22,
            )
          : LA.symbol(
              'person.crop.circle.fill',
              size: 40,
              color: isFraudCall
                  ? const Color(0xFFD32F2F)
                  : AvatarUtils.getColorFromName(nameDisplay),
            );

      // 锁屏大卡片 & Android 实时通知
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
        if (config.labels.visible && labelText != null && labelText.isNotEmpty)
          LA.padding(
            LA.container(
              padding: const LAInsets(top: 2, bottom: 2, left: 6, right: 6),
              background: isFraudCall ? const Color(0xFFD32F2F) : const Color(0xFF455A64),
              cornerRadius: 4,
              child: LA.text(
                labelText,
                size: config.labels.fontSize,
                color: Colors.white,
              ),
            ),
            top: 4,
          ),
        if (config.stir.visible)
          LA.padding(
            LA.text(
              stirText,
              size: config.stir.fontSize,
              color: (stirInfo != null && stirInfo.isVerified)
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFF888888),
            ),
            top: 4,
          ),
        if (config.securityMessage.visible)
          LA.padding(
            LA.container(
              padding: const LAInsets(top: 6, bottom: 6, left: 8, right: 8),
              background: isFraudCall ? const Color(0x22D32F2F) : const Color(0x11000000),
              cornerRadius: 6,
              child: LA.text(
                securityMessageText,
                size: config.securityMessage.fontSize,
                color: isFraudCall ? const Color(0xFFD32F2F) : const Color(0xFF555555),
              ),
            ),
            top: 6,
          ),
      ]);

      // 灵动岛各形态
      final compactLeadingNode = base64Avatar != null
          ? LAImage(
              source: LAImageSource.asset,
              value: base64Avatar,
              width: 20,
              height: 20,
              cornerRadius: 10,
            )
          : LA.symbol(
              'phone.fill',
              color: isFraudCall
                  ? const Color(0xFFD32F2F)
                  : AvatarUtils.getColorFromName(nameDisplay),
            );
      final compactTrailingNode = LA.text(
        labelText ?? nameDisplay,
        size: 12,
        weight: FontWeight.bold,
      );
      final minimalNode = LA.symbol(
        'phone.fill',
        color: isFraudCall
            ? const Color(0xFFD32F2F)
            : AvatarUtils.getColorFromName(nameDisplay),
      );
      final expandedLeadingNode = base64Avatar != null
          ? LAImage(
              source: LAImageSource.asset,
              value: base64Avatar,
              width: 40,
              height: 40,
              cornerRadius: 20,
            )
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
      final expandedBottomNode = (config.securityMessage.visible && isFraudCall)
          ? LA.text(securityMessageText, size: 12, color: const Color(0xFFD32F2F))
          : null;

      if (_currentActivityId != null) {
        try {
          await LiveActivity.update(
            id: activityId,
            deepLink: deepLinkPayload,
            alert: LiveActivityAlert(
              title: nameDisplay,
              body: numberDisplay,
            ),
            lockScreen: lockScreenNode,
            compactLeading: compactLeadingNode,
            compactTrailing: compactTrailingNode,
            minimal: minimalNode,
            expandedLeading: expandedLeadingNode,
            expandedCenter: expandedCenterNode,
            expandedBottom: expandedBottomNode,
          );
        } catch (_) {
          await LiveActivity.show(
            id: activityId,
            deepLink: deepLinkPayload,
            alert: LiveActivityAlert(
              title: nameDisplay,
              body: numberDisplay,
            ),
            lockScreen: lockScreenNode,
            compactLeading: compactLeadingNode,
            compactTrailing: compactTrailingNode,
            minimal: minimalNode,
            expandedLeading: expandedLeadingNode,
            expandedCenter: expandedCenterNode,
            expandedBottom: expandedBottomNode,
          );
        }
      } else {
        await LiveActivity.show(
          id: activityId,
          deepLink: deepLinkPayload,
          alert: LiveActivityAlert(
            title: nameDisplay,
            body: numberDisplay,
          ),
          lockScreen: lockScreenNode,
          compactLeading: compactLeadingNode,
          compactTrailing: compactTrailingNode,
          minimal: minimalNode,
          expandedLeading: expandedLeadingNode,
          expandedCenter: expandedCenterNode,
          expandedBottom: expandedBottomNode,
        );
        _currentActivityId = activityId;
        _startListeningDeepLinks();
      }
    } catch (e) {
      debugPrint('Failed to show/update Live Activity: $e');
    }
  }

  /// 统一将头像 Asset 资源直接读取为 PNG 字节流（零 GPU 依赖，100% 线程安全）
  Future<Uint8List?> _getAvatarBytes({
    required CallerIdData callerIdData,
    required String? labelText,
    required String nameDisplay,
    required bool isFraudCall,
  }) async {
    try {
      final provider = AvatarUtils.getAvatarImage(callerIdData.avatar, labelText);
      if (provider is AssetImage) {
        try {
          final data = await rootBundle.load(provider.assetName);
          return data.buffer.asUint8List();
        } catch (_) {}
      }

      // 保底读取默认未知联系人头像
      final fallbackData = await rootBundle.load('assets/avatars/Unknown.png');
      return fallbackData.buffer.asUint8List();
    } catch (e) {
      debugPrint('KitLiveActivityHandler: _getAvatarBytes error: $e');
      return null;
    }
  }

  /// 结束当前的 Live Activity 并立即释放事件通道
  Future<void> endActivity() async {
    if (_currentActivityId != null) {
      try {
        await LiveActivity.end(id: _currentActivityId!);
        _currentActivityId = null;
      } catch (e) {
        debugPrint('Failed to end Live Activity: $e');
        _currentActivityId = null;
      } finally {
        await _deepLinkSubscription?.cancel();
        _deepLinkSubscription = null;
      }
    }
  }

  /// 按需监听 DeepLink 事件
  void _startListeningDeepLinks() {
    _deepLinkSubscription?.cancel();
    _deepLinkSubscription = LiveActivity.deepLinks.listen(
      (payload) {
        _handleDeepLinkNavigation(payload);
      },
      onError: (e) {
        debugPrint('KitLiveActivityHandler: DeepLink error: $e');
      },
    );
  }

  /// 处理通知点击后的路由导航
  void _handleDeepLinkNavigation(String payload) {
    if (payload.isEmpty) return;
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) {
      debugPrint('KitLiveActivityHandler: Navigation context is null.');
      return;
    }

    debugPrint('KitLiveActivityHandler: Navigating with payload: $payload');
    try {
      if (payload.contains('call-history') ||
          payload.contains('call_history') ||
          payload.contains('fraud_alert') ||
          payload.contains('fraud-alert') ||
          payload.contains('blocked_call') ||
          payload.contains('stir_result')) {
        GoRouter.of(context).goNamed(AppRouter.callHistory);
      } else if (payload.contains('deletion_proposal') || payload.contains('deletion-proposal')) {
        GoRouter.of(context).goNamed(AppRouter.deletionProposal);
      } else {
        debugPrint('KitLiveActivityHandler: Unknown payload: $payload');
      }
    } catch (e) {
      debugPrint('KitLiveActivityHandler: Navigation error: $e');
    }
  }
}
