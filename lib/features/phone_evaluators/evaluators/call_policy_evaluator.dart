import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:yourcallyourrule/core/coordinator/app_coordinator.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/labels/utils/predefined_labels.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

part 'call_policy_evaluator.g.dart';

@Riverpod(keepAlive: true)
CallPolicyEvaluator callPolicyEvaluator(Ref ref) {
  return const CallPolicyEvaluator();
}

/// 呼叫策略评估上下文强类型实体
class CallPolicyContext {
  final String phoneNumber;
  final int? simSlotIndex;
  final bool isTimeBlocked;
  final bool isFilterAccepted;
  final bool isEmergencyExempted;
  final bool isExpectedCallActive;
  final List<String> labels;
  final Map<String, InterceptAction> labelActionMap;
  final InterceptAction defaultInterceptAction;

  const CallPolicyContext({
    required this.phoneNumber,
    this.simSlotIndex,
    this.isTimeBlocked = false,
    this.isFilterAccepted = true,
    this.isEmergencyExempted = false,
    this.isExpectedCallActive = false,
    this.labels = const [],
    this.labelActionMap = const {},
    this.defaultInterceptAction = InterceptAction.endCall,
  });
}

/// 呼叫策略决策结果强类型实体
class CallPolicyVerdict {
  final bool shouldBlock;
  final InterceptAction? action;
  final String reason;
  final String? matchedLabel;

  const CallPolicyVerdict({
    required this.shouldBlock,
    this.action,
    required this.reason,
    this.matchedLabel,
  });

  bool get shouldAccept => !shouldBlock;
}

/// 通用呼叫策略纯决策大脑（Pure Policy Decision Brain）
/// 零硬编码、纯函数式评估
class CallPolicyEvaluator {
  const CallPolicyEvaluator();

  /// 检查标签是否匹配预定义标签库或用户自定义标签
  static bool isFraudLabel(String label, {List<String>? userCustomKeywords}) {
    final lower = label.trim().toLowerCase();
    if (userCustomKeywords != null && userCustomKeywords.isNotEmpty) {
      return userCustomKeywords.any((kw) => lower.contains(kw.toLowerCase()));
    }
    // 动态结合系统预定义标签实体库进行标准比对
    return predefinedLabelEntities.any((entity) {
      final text = entity.text.toLowerCase();
      return text.contains('scam') ||
              text.contains('fraud') ||
              text.contains('risk')
          ? lower.contains(text)
          : false;
    });
  }

  /// 综合检测来电号码与标签是否具备诈骗特征
  static bool hasFraudIndicator({
    required String phoneNumber,
    List<dynamic> labels = const [],
    List<String>? userCustomKeywords,
  }) {
    if (labels.isEmpty) {
      return false;
    }
    for (final label in labels) {
      final text = label is String ? label : (label?.toString() ?? '');
      if (isFraudLabel(text, userCustomKeywords: userCustomKeywords)) {
        return true;
      }
    }
    return false;
  }

  /// 触发诈骗警示（支持触觉反馈与通知分发）
  static Future<void> triggerFraudAlert(
    String phoneNumber, {
    dynamic coordinator,
  }) async {
    final context = AppRouter.navigatorKey.currentContext;
    if (context == null) return;

    final title =
        "⚠️ ${AppLocalizations.of(context).fraudAlertTitle} ($phoneNumber)";
    final body = AppLocalizations.of(context).securityMessage;

    dynamic appCoordinator = coordinator;
    if (appCoordinator == null) {
      try {
        appCoordinator = ProviderScope.containerOf(
          context,
          listen: false,
        ).read(appCoordinatorProvider);
      } catch (_) {}
    }

    HapticFeedback.heavyImpact();

    appCoordinator?.emit('show_system_notification', {
      'title': title,
      'body': body,
      'type': 'fraud_alert',
      'notificationId': phoneNumber.hashCode + 2,
      'payload': {'type': 'fraud_alert', 'phone': phoneNumber},
      'autoCancel': true,
      'autoCancelDelaySeconds': 10,
    });
  }

  CallPolicyVerdict evaluate(CallPolicyContext context) {
    if (context.isEmergencyExempted) {
      return const CallPolicyVerdict(
        shouldBlock: false,
        reason: 'Exempted by Emergency Call Policy (within 30 mins)',
      );
    }

    if (context.isExpectedCallActive) {
      return const CallPolicyVerdict(
        shouldBlock: false,
        reason: 'Allowed by Expected Call temporary exemption',
      );
    }

    if (context.isTimeBlocked) {
      return CallPolicyVerdict(
        shouldBlock: true,
        action: context.defaultInterceptAction,
        reason: 'Time interceptor triggered',
      );
    }

    if (!context.isFilterAccepted) {
      return CallPolicyVerdict(
        shouldBlock: true,
        action: context.defaultInterceptAction,
        reason: 'Blocked by call filter',
      );
    }

    final normalizedActionMap = <String, InterceptAction>{};
    context.labelActionMap.forEach((key, val) {
      normalizedActionMap[key.trim().toLowerCase()] = val;
    });

    for (final label in context.labels) {
      final normalizedLabel = label.trim().toLowerCase();
      if (normalizedActionMap.containsKey(normalizedLabel)) {
        final action =
            normalizedActionMap[normalizedLabel] ?? context.defaultInterceptAction;
        if (action.isAllow) {
          return CallPolicyVerdict(
            shouldBlock: false,
            action: action,
            reason: 'Allowed by label action for: $label',
            matchedLabel: label,
          );
        }
        return CallPolicyVerdict(
          shouldBlock: true,
          action: action,
          reason: 'Matched label action for: $label',
          matchedLabel: label,
        );
      }
    }

    for (final label in context.labels) {
      if (isFraudLabel(label)) {
        return CallPolicyVerdict(
          shouldBlock: true,
          action: context.defaultInterceptAction,
          reason: 'High-risk fraud label identified: $label',
          matchedLabel: label,
        );
      }
    }

    return const CallPolicyVerdict(
      shouldBlock: false,
      reason: 'Allowed by policy',
    );
  }
}
