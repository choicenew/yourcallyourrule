import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';

part 'phone_rules_subscription_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneRulesSubscriptionControlCenter phoneRulesSubscriptionControlCenter(Ref ref) {
  return PhoneRulesSubscriptionControlCenter.instance;
}

typedef PhoneSubscriptionCallback = Future<bool> Function(PhoneSubscriptionPayload payload);

/// 电话规则与状态词典在线订阅中枢 (PhoneRulesSubscriptionControlCenter)
class PhoneRulesSubscriptionControlCenter {
  static final PhoneRulesSubscriptionControlCenter instance = PhoneRulesSubscriptionControlCenter._();

  PhoneRulesSubscriptionControlCenter._();

  PhoneSubscriptionClientDriver? _clientDriver;
  final Map<String, List<PhoneSubscriptionCallback>> _registeredCallbacks = {};

  void registerClientDriver(PhoneSubscriptionClientDriver driver) {
    _clientDriver = driver;
    debugPrint('[PhoneSubscriptionHub] 已挂载注册 HTTP 网络驱动: ${driver.runtimeType}');
  }

  PhoneSubscriptionClientDriver? get clientDriver => _clientDriver;

  void registerCallback({
    required PhoneSubscriptionKind kind,
    required PhoneSubscriptionCallback onPayloadReceived,
  }) {
    final list = _registeredCallbacks.putIfAbsent(kind.id, () => []);
    list.add(onPayloadReceived);
    debugPrint('[PhoneSubscriptionHub] 已挂载注册云端电话订阅回调: ${kind.id}');
  }

  Future<bool> dispatchPayload(PhoneSubscriptionPayload payload) async {
    final callbacks = _registeredCallbacks[payload.kind.id] ?? [];
    bool success = true;
    for (final callback in callbacks) {
      final res = await callback(payload);
      if (!res) success = false;
    }
    debugPrint('[PhoneSubscriptionHub] 分发电话订阅载荷完成: ${payload.kind.id}, 匹配回调: ${callbacks.length} 个');
    return success;
  }
}
