import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/data/repositories/call/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_filter/enhanced_composite_filter_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/sim_slot_rule_service.dart';
import 'package:yourcallyourrule/features/call/call_filter/presentation/widgets/sim_slot_rule_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// SIM卡槽位规则管理页面
/// 用于管理每个SIM卡槽位的过滤规则
class SimSlotRulePage extends StatefulWidget {
  final SimSlotRuleService simSlotRuleService;
  final EnhancedCompositeFilterService enhancedCompositeFilterService;
  final ConfigRepository configRepository;
  final RuleRepository ruleRepository;
  final int simSlotIndex;

  const SimSlotRulePage({
    super.key,
    required this.simSlotRuleService,
    required this.enhancedCompositeFilterService,
    required this.configRepository,
    required this.ruleRepository,
    required this.simSlotIndex,
  });

  @override
  SimSlotRulePageState createState() => SimSlotRulePageState();
}

class SimSlotRulePageState extends State<SimSlotRulePage> {
  // 过滤器配置
  Map<String, bool> filterEnabledMap = {};
  List<Map<String, dynamic>> _simSlotRules = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 加载数据
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 加载该SIM卡槽位的过滤器启用状态
      await _loadFilterEnabledStatus();
      
      // 加载该SIM卡槽位的规则列表
      await _loadSimSlotRules();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dataLoadFailure(e))),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 加载过滤器启用状态
  Future<void> _loadFilterEnabledStatus() async {
    // 获取所有过滤器的类名
    final filterNames = [
      'LocalCountFilterService',
      'RemoteNumberFilterService',
      'CallFilterService',
    ];

    // 检查每个过滤器在当前SIM卡槽位的启用状态
    for (var filterName in filterNames) {
      final isEnabled = widget.enhancedCompositeFilterService
          .isFilterEnabledForSimSlot(widget.simSlotIndex, filterName);
      filterEnabledMap[filterName] = isEnabled;
    }
  }

  /// 加载SIM卡槽位规则
  Future<void> _loadSimSlotRules() async {
    final rules = await widget.simSlotRuleService.getSimSlotRules(widget.simSlotIndex);
    _simSlotRules = rules.map((rule) => rule.toMap()).toList();
  }

  /// 切换过滤器启用状态
  Future<void> _toggleFilterEnabled(String filterName, bool isEnabled) async {
    setState(() {
      filterEnabledMap[filterName] = isEnabled;
    });

    if (isEnabled) {
      await widget.enhancedCompositeFilterService
          .enableFilterForSimSlot(widget.simSlotIndex, filterName);
    } else {
      await widget.enhancedCompositeFilterService
          .disableFilterForSimSlot(widget.simSlotIndex, filterName);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.filterToggleStatus(isEnabled ? AppLocalizations.of(context)!.enabled : AppLocalizations.of(context)!.disabled, filterName))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.simSlotTitle(widget.simSlotIndex + 1)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SimSlotRuleWidget(
              simSlotRuleService: widget.simSlotRuleService,
              enhancedCompositeFilterService: widget.enhancedCompositeFilterService,
              simSlotIndex: widget.simSlotIndex,
              filterEnabledMap: filterEnabledMap,
              simSlotRules: _simSlotRules,
              onToggleFilterEnabled: _toggleFilterEnabled,
              onAddSimSlotRule: (phoneNumber, name, labelId) async {
                try {
                  await widget.simSlotRuleService.addSimSlotRule(
                    phoneNumber,
                    widget.simSlotIndex,
                    name: name,
                    labelId: labelId ?? '',
                  );
                  
                  // 重新加载规则列表
                  await _loadSimSlotRules();
                  setState(() {});
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.ruleAddedSuccess)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.ruleAddFailure(e))),
                  );
                }
              },
              onDeleteSimSlotRule: (phoneNumber) async {
                try {
                  await widget.simSlotRuleService.removeSimSlotRule(phoneNumber);
                  
                  // 重新加载规则列表
                  await _loadSimSlotRules();
                  setState(() {});
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.ruleDeletedSuccess)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.ruleDeleteFailure(e))),
                  );
                }
              },
            ),
    );
  }
}