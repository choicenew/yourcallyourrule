import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

part 'outbound_blocked_labels_provider.g.dart';

/// 去电/外呼重定向与防诈标签拦截集合配置 Notifier
@Riverpod(keepAlive: true)
class OutboundBlockedLabels extends _$OutboundBlockedLabels {
  static const String _outboundBlockedLabelsKey = 'config_outbound_blocked_labels';

  @override
  Set<String> build() {
    _loadConfig();
    return const {};
  }

  Future<void> _loadConfig() async {
    final repository = ref.read(configRepositoryProvider);
    final configMap = await repository.getConfig(_outboundBlockedLabelsKey);
    if (configMap != null && ref.mounted) {
      final list = configMap['labels'];
      if (list is List) {
        state = Set.unmodifiable(list.map((e) => e.toString()));
      }
    }
  }

  Future<void> toggleLabel(String labelText) async {
    final updated = Set<String>.from(state);
    if (updated.contains(labelText)) {
      updated.remove(labelText);
    } else {
      updated.add(labelText);
    }
    state = Set.unmodifiable(updated);
    await _save(updated);
  }

  Future<void> addLabel(String labelText) async {
    final updated = Set<String>.from(state)..add(labelText);
    state = Set.unmodifiable(updated);
    await _save(updated);
  }

  Future<void> removeLabel(String labelText) async {
    final updated = Set<String>.from(state)..remove(labelText);
    state = Set.unmodifiable(updated);
    await _save(updated);
  }

  Future<void> _save(Set<String> currentLabels) async {
    try {
      await ref.read(configRepositoryProvider).saveConfig(_outboundBlockedLabelsKey, {
        'labels': currentLabels.toList(),
      });
    } catch (e) {
      debugPrint('[OutboundBlockedLabelsNotifier] 保存外呼拦截标签失败: $e');
    }
  }
}

