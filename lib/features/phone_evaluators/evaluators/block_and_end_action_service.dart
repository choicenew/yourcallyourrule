import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:floating_window_android/floating_window_android.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository_impl.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

/// 挂断并拉黑二合一动作服务 (BlockAndEndActionService)
class BlockAndEndActionService {
  static const MethodChannel _endCallChannel = MethodChannel('com.yours.yourcallyourrule/end_call');
  static final Uuid _uuid = const Uuid();

  /// 将指定号码快速写入本地黑名单规则
  static Future<bool> blockPhoneNumber(String phoneNumber, {String? name}) async {
    final cleanPhone = phoneNumber.trim();
    if (cleanPhone.isEmpty) return false;

    try {
      final repo = RuleRepositoryImpl(LocalDatabase());
      final allRules = await repo.getAll();
      final existing = allRules.where((r) => r.phoneNumber == cleanPhone).firstOrNull;

      if (existing != null) {
        final updated = existing.copyWith(
          actionType: PhoneRuleEntity.actionBlock,
          isEnabled: true,
          name: (name != null && name.isNotEmpty) ? name : existing.name,
        );
        await repo.updateRule(updated);
      } else {
        final newRule = PhoneRuleEntity(
          id: _uuid.v4(),
          name: (name != null && name.isNotEmpty) ? name : cleanPhone,
          phoneNumber: cleanPhone,
          actionType: PhoneRuleEntity.actionBlock,
          isEnabled: true,
        );
        await repo.saveRule(newRule);
      }
      debugPrint('🚫 [BlockAndEndActionService] Number blocked: $cleanPhone');
      return true;
    } catch (e, st) {
      debugPrint('❌ [BlockAndEndActionService] Failed to block $cleanPhone: $e\n$st');
      return false;
    }
  }

  /// 立即结束当前通话 (调用原生 TelecomManager.endCall)
  static Future<void> endCurrentCall() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        await _endCallChannel.invokeMethod('endCurrentCall');
        debugPrint('📞 [BlockAndEndActionService] Invoked endCurrentCall');
      }
    } catch (e) {
      debugPrint('⚠️ [BlockAndEndActionService] Error invoking endCurrentCall: $e');
    }
  }

  /// 通话中/响铃中“挂断并拉黑”二合一动作
  static Future<void> blockAndEndCurrentCall(String phoneNumber, {String? name}) async {
    await blockPhoneNumber(phoneNumber, name: name);
    await endCurrentCall();

    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        await FloatingWindowAndroid.closeOverlay();
      } catch (_) {}
    }
  }
}

