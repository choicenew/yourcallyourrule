import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/rule_repository_provider.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';


/// 规则数据状态的Notifier类
class RulesNotifier extends AsyncNotifier<List<RuleBase>> {
  late final RuleRepository _ruleRepository;

  @override
  Future<List<RuleBase>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有规则
    return _loadRules();
  }

  void _initRepository() {
    // 这里应该通过依赖注入获取仓库实例
    // 由于没有看到具体实现，这里使用一个假设的实现方式
    // 实际项目中应该替换为正确的仓库实现
    _ruleRepository = ref.read(ruleRepositoryProvider);
  }

  Future<List<RuleBase>> _loadRules() async {
    try {
      // 获取所有规则
      return await _ruleRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 导入规则
  Future<void> importRules(List<RuleBase> rules) async {
    state = const AsyncValue.loading();
    try {
      // 清除现有规则并导入新规则
      // 这里应该根据实际需求实现，可能需要合并或替换
      for (final rule in rules) {
        await _ruleRepository.saveRule(rule);
      }
      // 重新加载规则
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 添加规则
  Future<void> addRule(RuleBase rule) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.saveRule(rule);
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新规则
  Future<void> updateRule(RuleBase rule) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.updateRule(rule);
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除规则
  Future<void> deleteRule(String ruleId) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.deleteRule(ruleId);
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新规则启用状态
  Future<void> updateRuleEnabledStatus(String ruleId, bool isEnabled) async {
    state = const AsyncValue.loading();
    try {
      await _ruleRepository.updateEnabledStatus(ruleId, isEnabled);
      state = AsyncValue.data(await _loadRules());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// 使用providers.dart中定义的ruleRepositoryProvider

/// 规则数据提供者
final rulesProvider = AsyncNotifierProvider<RulesNotifier, List<RuleBase>>(() {
  return RulesNotifier();
});

// RuleRepositoryImpl已在providers.dart中定义