import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'providers.dart';

/// 标签仓库接口
abstract class LabelRepository extends BaseRepository<LabelEntry, String> {
  /// 根据名称获取标签
  Future<LabelEntry?> getByName(String name);
  
  /// 根据类型获取标签
  Future<List<LabelEntry>> getByType(String type);
  
  /// 检查标签名称是否已存在
  Future<bool> nameExists(String name);
  
  /// 获取所有启用的标签
  Future<List<LabelEntry>> getAllEnabled();
}

/// 标签数据状态的Notifier类
class LabelsNotifier extends AsyncNotifier<List<LabelEntry>> {
  late final LabelRepository _labelRepository;

  @override
  Future<List<LabelEntry>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有标签
    return _loadLabels();
  }

  void _initRepository() {
    // 获取仓库实例
    _labelRepository = ref.read(labelRepositoryProvider);
  }

  Future<List<LabelEntry>> _loadLabels() async {
    try {
      // 获取所有标签
      return await _labelRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加标签
  Future<void> addLabel(LabelEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelRepository.save(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新标签
  Future<void> updateLabel(LabelEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelRepository.update(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除标签
  Future<void> deleteLabel(String labelId) async {
    state = const AsyncValue.loading();
    try {
      await _labelRepository.deleteById(labelId);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 获取启用的标签
  Future<List<LabelEntry>> getEnabledLabels() async {
    try {
      return await _labelRepository.getAllEnabled();
    } catch (e) {
      return [];
    }
  }
  
  /// 根据类型获取标签
  Future<List<LabelEntry>> getLabelsByType(String type) async {
    try {
      return await _labelRepository.getByType(type);
    } catch (e) {
      return [];
    }
  }
}

/// 标签数据提供者
final labelsProvider = AsyncNotifierProvider<LabelsNotifier, List<LabelEntry>>(() {
  return LabelsNotifier();
});