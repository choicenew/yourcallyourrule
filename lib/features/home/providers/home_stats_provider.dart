import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/call/call_history/services/call_log_service.dart';

import 'package:yourcallyourrule/features/rules/services/rule_management_service.dart';
import '../models/home_stats_model.dart';
import '../services/home_stats_service.dart';

class HomeStatsProvider extends ChangeNotifier {
  final HomeStatsService _service = HomeStatsService();
  final CallLogService _callLogService;
  final RuleManagementService _ruleManagementService;
  
  HomeStats _stats = HomeStats.empty();
  bool _isLoading = false;
  String? _error;

  HomeStatsProvider(this._callLogService, this._ruleManagementService);

  HomeStats get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadHomeStats() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // 初始化通话记录服务
      await _callLogService.initialize();
      
      // 获取通话记录和规则数据
      final List<CallLog> callLogs = await _callLogService.getRecentLogs();
      final List<RuleBase> blockRules = await _ruleManagementService.getAllRulesByActionType(RuleActionType.block);
      final List<RuleBase> allowRules = await _ruleManagementService.getAllRulesByActionType(RuleActionType.allow);
      final List<RuleBase> silenceRules = await _ruleManagementService.getAllRulesByActionType(RuleActionType.silence);
      final List<RuleBase> noneRules = await _ruleManagementService.getAllRulesByActionType(RuleActionType.none);
      
      final List<RuleBase> allRules = [...blockRules, ...allowRules, ...silenceRules, ...noneRules];
      
      // 使用真实数据获取统计信息
      _stats = await _service.getHomeStats(callLogs, allRules);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}