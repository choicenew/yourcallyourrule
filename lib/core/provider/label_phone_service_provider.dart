import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/repositories/label_phone_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/labels/services/mark_phone_service.dart';

// 引入相关提供者
import 'basic_provider/label_phone_repository_provider.dart';
import 'predefined_labels_provider.dart';


/// 电话标签数据状态的Notifier类
class LabelPhoneNotifier extends AsyncNotifier<List<LabelPhoneEntry>> {
  late final LabelPhoneRepository _labelPhoneRepository;

  @override
  Future<List<LabelPhoneEntry>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有标签
    return _loadLabels();
  }

  void _initRepository() {
    // 获取仓库实例
    _labelPhoneRepository = ref.read(labelPhoneRepositoryProvider);
  }

  Future<List<LabelPhoneEntry>> _loadLabels() async {
    try {
      // 获取所有标签
      return await _labelPhoneRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加标签
  Future<void> addLabel(LabelPhoneEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.save(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新标签
  Future<void> updateLabel(LabelPhoneEntry label) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.update(label);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除标签
  Future<void> deleteLabel(String labelId) async {
    state = const AsyncValue.loading();
    try {
      await _labelPhoneRepository.deleteById(labelId);
      state = AsyncValue.data(await _loadLabels());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
  /// 获取启用的标签
  Future<List<LabelPhoneEntry>> getEnabledLabels() async {
    try {
      return await _labelPhoneRepository.getAllEnabled();
    } catch (e) {
      return [];
    }
  }
  
  /// 根据类型获取标签
  Future<List<LabelPhoneEntry>> getLabelsByType(String type) async {
    try {
      return await _labelPhoneRepository.getByType(type);
    } catch (e) {
      return [];
    }
  }
  
  /// 根据电话号码获取标签
  Future<LabelPhoneEntry?> getLabelByPhoneNumber(String phoneNumber) async {
    try {
      return await _labelPhoneRepository.getByPhoneNumber(phoneNumber);
    } catch (e) {
      return null;
    }
  }
  
  /// 根据标签ID获取所有关联的电话标签
  Future<List<LabelPhoneEntry>> getLabelsByLabelId(String labelId) async {
    try {
      return await _labelPhoneRepository.getByLabelId(labelId);
    } catch (e) {
      return [];
    }
  }
}

/// 电话标签数据提供者
final labelPhonesProvider = AsyncNotifierProvider<LabelPhoneNotifier, List<LabelPhoneEntry>>(() {
  return LabelPhoneNotifier();
});

/// 电话号码标签服务提供者
/// 负责提供LabelPhoneService实例，用于管理电话号码与标签ID的关联
final labelPhoneServiceProvider = Provider<LabelPhoneService>((ref) {
  // 获取规则仓库
  final ruleRepository = ref.watch(ruleRepositoryProvider);
  // 获取预定义标签服务
  final predefinedLabelService = ref.watch(predefinedLabelServiceProvider);
  
  // 返回电话号码标签服务实例
  return LabelPhoneService(ruleRepository, predefinedLabelService);
});

/// 根据电话号码获取标签的提供者
final labelPhoneByNumberProvider = FutureProvider.family<dynamic, String>((ref, phoneNumber) async {
  final labelPhoneService = ref.watch(labelPhoneServiceProvider);
  final phoneNumberObj = PhoneNumber.fromString(phoneNumber);
  return await labelPhoneService.getLabelByPhoneNumber(phoneNumberObj);
});

/// 根据电话号码获取标签实体的提供者
final labelPhoneEntryByNumberProvider = FutureProvider.family<LabelPhoneEntry?, String>((ref, phoneNumber) async {
  final notifier = ref.watch(labelPhonesProvider.notifier);
  return await notifier.getLabelByPhoneNumber(phoneNumber);
});

/// 根据标签ID获取所有标记的提供者
final labelPhonesByLabelIdProvider = FutureProvider.family<List<dynamic>, String>((ref, labelId) async {
  final labelPhoneService = ref.watch(labelPhoneServiceProvider);
  return await labelPhoneService.getMarksByLabelId(labelId);
});

/// 获取标记视图模型的提供者
final labelPhoneViewModelProvider = FutureProvider.family<dynamic, dynamic>((ref, entry) async {
  final labelPhoneService = ref.watch(labelPhoneServiceProvider);
  return await labelPhoneService.getMarkViewModel(entry);
});