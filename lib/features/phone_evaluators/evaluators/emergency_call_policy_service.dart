import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final emergencyCallPolicyServiceProvider = Provider<EmergencyCallPolicyService>((ref) {
  return EmergencyCallPolicyService();
});

/// 紧急呼叫后 30 分钟全局最高优先级放行策略 (EmergencyCallPolicy)
/// 当拨打 110/119/120/911 等求救电话后，30 分钟内无条件放行所有来电，超越任何黑名单与拦截规则
class EmergencyCallPolicyService {
  static const String _prefKeyEmergencyTimestamp = 'emergency_call_last_timestamp';
  static const int exemptionDurationMs = 30 * 60 * 1000; // 30 分钟

  static const Set<String> _emergencyNumbers = {
    '110', '119', '120', '122', '911', '112', '999', '000', '114'
  };

  int? _memoryTimestamp;

  /// 判断号码是否为紧急求助电话
  bool isEmergencyNumber(String phoneNumber) {
    final clean = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return _emergencyNumbers.contains(clean);
  }

  /// 记录紧急呼叫发生时间
  Future<void> recordEmergencyCallIfMatched(String phoneNumber) async {
    if (isEmergencyNumber(phoneNumber)) {
      final now = DateTime.now().millisecondsSinceEpoch;
      _memoryTimestamp = now;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_prefKeyEmergencyTimestamp, now);
      } catch (e) {
        debugPrint('[EmergencyCallPolicy] SharedPreferences 保存失败: $e');
      }
      debugPrint('[EmergencyCallPolicy] 检测到拨打紧急求救电话: $phoneNumber，开启 30 分钟全局无条件放行豁免期');
    }
  }

  /// 判断当前是否处于紧急呼叫后的 30 分钟无条件放行期
  Future<bool> isExempted() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_memoryTimestamp != null && (now - _memoryTimestamp!) < exemptionDurationMs) {
      return true;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastTime = prefs.getInt(_prefKeyEmergencyTimestamp);
      if (lastTime != null && (now - lastTime) < exemptionDurationMs) {
        _memoryTimestamp = lastTime;
        return true;
      }
    } catch (_) {}
    return false;
  }
}

