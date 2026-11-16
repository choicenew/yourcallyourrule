import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call_evaluators/evaluators/intercept_action.dart';

final labelActionConfigProvider = NotifierProvider<LabelActionConfigNotifier, Map<String, InterceptAction>>(
  LabelActionConfigNotifier.new,
);

/// 纯动态标签动作映射表配置 Notifier (零硬编码，支持任意动态标签文本)
class LabelActionConfigNotifier extends Notifier<Map<String, InterceptAction>> {
  static const String _labelActionMapKey = 'config_label_action_map';

  @override
  Map<String, InterceptAction> build() {
    _loadConfig();
    return const {};
  }

  Future<void> _loadConfig() async {
    final repository = ref.read(configRepositoryProvider);
    final configMap = await repository.getConfig(_labelActionMapKey);
    if (configMap != null && ref.mounted) {
      final resultMap = <String, InterceptAction>{};
      configMap.forEach((labelKey, actionVal) {
        if (actionVal is String) {
          final action = InterceptAction.fromString(actionVal);
          resultMap[labelKey] = action;
        }
      });
      state = Map.unmodifiable(resultMap);
    }
  }

  Future<void> setActionForLabel(String labelText, InterceptAction action) async {
    final updated = Map<String, InterceptAction>.from(state)..[labelText] = action;
    state = Map.unmodifiable(updated);
    await _save(updated);
  }

  Future<void> removeActionForLabel(String labelText) async {
    final updated = Map<String, InterceptAction>.from(state)..remove(labelText);
    state = Map.unmodifiable(updated);
    await _save(updated);
  }

  Future<void> _save(Map<String, InterceptAction> currentMap) async {
    try {
      final serializableMap = currentMap.map(
        (key, action) => MapEntry(key, action.actionName),
      );
      await ref.read(configRepositoryProvider).saveConfig(_labelActionMapKey, serializableMap);
    } catch (e) {
      debugPrint('[LabelActionConfigNotifier] 保存标签动作映射失败: $e');
    }
  }
}
