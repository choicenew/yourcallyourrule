import 'package:flutter/foundation.dart';
import '../../../application/usecases/rule/add_rule.dart';
import '../../../application/usecases/rule/delete_rule.dart';
import '../../../application/usecases/rule/update_rule.dart';
import '../../../application/usecases/rule/get_rules.dart';
import '../../../application/usecases/rule/match_rule.dart';
import '../../../application/usecases/rule/import_rules.dart';
import '../../../application/usecases/rule/export_rules.dart';
import '../../../domain/entities/rule/rule_base.dart';
import '../base/base_provider.dart';

/// 规则Provider
/// 负责管理规则相关的状态
class RuleProvider extends BaseProvider {
  final AddRule _addRule;
  final DeleteRule _deleteRule;
  final UpdateRule _updateRule;
  final GetRules _getRules;
  final MatchRule _matchRule;
  final ImportRules _importRules;
  final ExportRules _exportRules;

  List<RuleBase> _rules = [];
  RuleBase? _selectedRule;

  /// 构造函数
  RuleProvider({
    required AddRule addRule,
    required DeleteRule deleteRule,
    required UpdateRule updateRule,
    required GetRules getRules,
    required MatchRule matchRule,
    required ImportRules importRules,
    required ExportRules exportRules,
  }) : _addRule = addRule,
       _deleteRule = deleteRule,
       _updateRule = updateRule,
       _getRules = getRules,
       _matchRule = matchRule,
       _importRules = importRules,
       _exportRules = exportRules;

  /// 获取所有规则
  List<RuleBase> get rules => _rules;

  /// 获取选中的规则
  RuleBase? get selectedRule => _selectedRule;

  /// 设置选中的规则
  void selectRule(RuleBase? rule) {
    _selectedRule = rule;
    notifyListeners();
  }

  /// 加载所有规则
  Future<void> loadRules() async {
    setLoading(true);
    clearError();

    try {
      final result = await _getRules.execute();
      result.fold(
        (failure) => setError(failure.message),
        (rules) {
          _rules = rules;
          notifyListeners();
        },
      );
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  /// 添加规则
  Future<void> addRule(RuleBase rule) async {
    setLoading(true);
    clearError();

    try {
      final result = await _addRule.execute(rule);
      result.fold(
        (failure) => setError(failure.message),
        (_) => loadRules(),
      );
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }

  /// 更新规则
  Future<void> updateRule(RuleBase rule) async {
    setLoading(true);
    clearError();

    try {
      final result = await _updateRule.execute(rule);
      result.fold(
        (failure) => setError(failure.message),
        (_) => loadRules(),
      );
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }

  /// 删除规则
  Future<void> deleteRule(String ruleId) async {
    setLoading(true);
    clearError();

    try {
      final result = await _deleteRule.execute(ruleId);
      result.fold(
        (failure) => setError(failure.message),
        (_) => loadRules(),
      );
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }

  /// 匹配规则
  Future<RuleBase?> matchRuleForNumber(String phoneNumber) async {
    clearError();

    try {
      final result = await _matchRule.execute(phoneNumber);
      return result.fold(
        (failure) {
          setError(failure.message);
          return null;
        },
        (rule) => rule,
      );
    } catch (e) {
      setError(e.toString());
      return null;
    }
  }

  /// 导入规则
  Future<void> importRules(String filePath) async {
    setLoading(true);
    clearError();

    try {
      final result = await _importRules.execute(filePath);
      result.fold(
        (failure) => setError(failure.message),
        (_) => loadRules(),
      );
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }

  /// 导出规则
  Future<void> exportRules(String filePath) async {
    setLoading(true);
    clearError();

    try {
      final result = await _exportRules.execute(filePath);
      result.fold(
        (failure) => setError(failure.message),
        (_) {
          setLoading(false);
        },
      );
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }
}