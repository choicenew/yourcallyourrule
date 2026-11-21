import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'emergency_call_policy_service.g.dart';

@Riverpod(keepAlive: true)
EmergencyCallPolicyService emergencyCallPolicyService(Ref ref) {
  final service = EmergencyCallPolicyService();
  service.init();
  return service;
}

/// 紧急呼叫后 30 分钟全局最高优先级放行策略 (EmergencyCallPolicy)
/// 当拨打紧急求救电话后，30 分钟内无条件放行所有来电，超越任何黑名单与拦截规则
class EmergencyCallPolicyService {
  static const String _prefKeyEmergencyTimestamp = 'emergency_call_last_timestamp';
  static const String _assetConfigPath = 'assets/emergency_numbers.json';

  final Set<String> _emergencyNumbers = {};
  final Set<String> _customNumbers = {};
  bool isPolicyEnabled = true;
  int exemptionDurationMinutes = 30;
  bool _isConfigLoaded = false;
  Completer<void>? _loadCompleter;
  int? _memoryTimestamp;

  int get exemptionDurationMs => exemptionDurationMinutes * 60 * 1000;

  List<String> get presetNumbers => _emergencyNumbers.toList();

  void updateConfig({
    bool? enabled,
    int? durationMinutes,
    List<String>? customNumbers,
  }) {
    if (enabled != null) isPolicyEnabled = enabled;
    if (durationMinutes != null) exemptionDurationMinutes = durationMinutes;
    if (customNumbers != null) {
      _customNumbers.clear();
      for (final n in customNumbers) {
        final clean = n.replaceAll(RegExp(r'[^0-9]'), '');
        if (clean.isNotEmpty) {
          _customNumbers.add(clean);
        }
      }
    }
  }

  /// 初始化并从 JSON 资源文件加载全球紧急求救号码库
  Future<void> init() async {
    if (_isConfigLoaded) return;
    if (_loadCompleter != null) return _loadCompleter!.future;

    _loadCompleter = Completer<void>();
    try {
      final jsonString = await rootBundle.loadString(_assetConfigPath);
      final Map<String, dynamic> data = jsonDecode(jsonString);

      if (data.containsKey('global_numbers') && data['global_numbers'] is List) {
        for (final item in data['global_numbers']) {
          _emergencyNumbers.add(item.toString().trim());
        }
      }

      if (data.containsKey('country_emergency_numbers') && data['country_emergency_numbers'] is Map) {
        final Map<String, dynamic> countries = data['country_emergency_numbers'];
        for (final numbers in countries.values) {
          if (numbers is List) {
            for (final n in numbers) {
              _emergencyNumbers.add(n.toString().trim());
            }
          }
        }
      }
      _isConfigLoaded = true;
      debugPrint('🚨 [EmergencyCallPolicy] 成功从 $_assetConfigPath 加载 ${_emergencyNumbers.length} 个紧急求助号码');
    } catch (e) {
      debugPrint('⚠️ [EmergencyCallPolicy] 加载紧急号码配置失败: $e');
    } finally {
      if (!_loadCompleter!.isCompleted) {
        _loadCompleter!.complete();
      }
    }
  }

  /// 确保配置文件已加载
  Future<void> _ensureLoaded() async {
    if (!_isConfigLoaded) {
      await init();
    }
  }

  /// 异步判断号码是否为紧急求助电话 (内置 + 自定义)
  Future<bool> isEmergencyNumber(String phoneNumber) async {
    await _ensureLoaded();
    final clean = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return _emergencyNumbers.contains(clean) || _customNumbers.contains(clean);
  }

  /// 同步判断号码（如果已预加载）
  bool isEmergencyNumberSync(String phoneNumber) {
    final clean = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return _emergencyNumbers.contains(clean) || _customNumbers.contains(clean);
  }

  /// 记录紧急呼叫发生时间
  Future<void> recordEmergencyCallIfMatched(String phoneNumber) async {
    if (!isPolicyEnabled) return;
    final matched = await isEmergencyNumber(phoneNumber);
    if (matched) {
      final now = DateTime.now().millisecondsSinceEpoch;
      _memoryTimestamp = now;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_prefKeyEmergencyTimestamp, now);
      } catch (e) {
        debugPrint('[EmergencyCallPolicy] SharedPreferences 保存失败: $e');
      }
      debugPrint('[EmergencyCallPolicy] 检测到拨打紧急求救电话: $phoneNumber，开启 $exemptionDurationMinutes 分钟全局无条件放行豁免期');
    }
  }

  /// 判断当前是否处于紧急呼叫后的无条件放行期
  Future<bool> isExempted() async {
    if (!isPolicyEnabled) return false;
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

  /// 获取当前剩余豁免秒数
  Future<int?> getRemainingExemptionSeconds() async {
    if (!isPolicyEnabled) return null;
    final now = DateTime.now().millisecondsSinceEpoch;
    int? lastTime = _memoryTimestamp;
    if (lastTime == null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        lastTime = prefs.getInt(_prefKeyEmergencyTimestamp);
      } catch (_) {}
    }
    if (lastTime != null) {
      final diff = now - lastTime;
      if (diff < exemptionDurationMs) {
        return ((exemptionDurationMs - diff) / 1000).ceil();
      }
    }
    return null;
  }
}
