import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';

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
  final List<String> labels;
  final Map<String, InterceptAction> labelActionMap;
  final InterceptAction defaultInterceptAction;

  const CallPolicyContext({
    required this.phoneNumber,
    this.simSlotIndex,
    this.isTimeBlocked = false,
    this.isFilterAccepted = true,
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

  CallPolicyVerdict evaluate(CallPolicyContext context) {
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
        return CallPolicyVerdict(
          shouldBlock: true,
          action: action,
          reason: 'Matched label action for: $label',
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
