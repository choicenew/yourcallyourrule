import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/repositories/predefined_label_repository.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';

import 'basic_provider/predefined_label_repository_provider.dart';


/// 预定义标签服务提供者
final predefinedLabelServiceProvider = Provider<PredefinedLabelService>((ref) {
  final repository = ref.watch(predefinedLabelRepositoryProvider);
  return PredefinedLabelService(repository);
});


/// 预定义标签数据状态的Notifier类
class PredefinedLabelsNotifier extends AsyncNotifier<List<PredefinedLabel>> {
  late final PredefinedLabelRepository _repository;

  @override
  Future<List<PredefinedLabel>> build() async {
    _repository = ref.read(predefinedLabelRepositoryProvider);
    return _loadLabels();
  }

  Future<List<PredefinedLabel>> _loadLabels() async {
    try {
      return await _repository.getAll();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加标签
  Future<void> addLabel(PredefinedLabel label) async {
    state = const AsyncValue.loading();
    try {
      await _repository.save(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新标签
  Future<void> updateLabel(PredefinedLabel label) async {
    state = const AsyncValue.loading();
    try {
      await _repository.update(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除标签
  Future<void> deleteLabel(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.delete(id);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 批量添加预定义标签
  Future<void> addPredefinedLabels(List<Map<String, dynamic>> predefinedLabels) async {
    state = const AsyncValue.loading();
    try {
      final service = ref.read(predefinedLabelServiceProvider);
      await service.insertPredefinedLabels(predefinedLabels);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 根据ID获取标签
  Future<PredefinedLabel?> getLabelById(String id) async {
    try {
      return await _repository.getById(id);
    } catch (e) {
      return null;
    }
  }
  
  /// 根据文本搜索标签
  Future<List<PredefinedLabel>> searchLabelsByText(String text) async {
    try {
      return await _repository.getByText(text);
    } catch (e) {
      return [];
    }
  }
}

/// 预定义标签数据提供者
final predefinedLabelsProvider = AsyncNotifierProvider<PredefinedLabelsNotifier, List<PredefinedLabel>>(() {
  return PredefinedLabelsNotifier();
});

/// 根据ID获取预定义标签的提供者
final predefinedLabelByIdProvider = FutureProvider.family<PredefinedLabel?, String>((ref, id) async {
  final notifier = ref.watch(predefinedLabelsProvider.notifier);
  return await notifier.getLabelById(id);
});