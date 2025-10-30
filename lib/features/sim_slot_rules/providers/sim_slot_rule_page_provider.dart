import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/provider/providers/predefined_label_service_provider.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';

part 'sim_slot_rule_page_provider.g.dart';

/// 页面状态模型
class SimSlotRulePageState {
  final List<SimSlotRule> rules;
  final Map<String, String> labelIdToTextMap;
  final String? selectedLabelId;
  final RuleActionType? selectedActionType;
  final String searchKeyword;

  SimSlotRulePageState({
    this.rules = const [],
    this.labelIdToTextMap = const {},
    this.selectedLabelId,
    this.selectedActionType,
    this.searchKeyword = '',
  });

  // [注释]: 过滤后的规则列表，UI将直接使用这个。
  List<SimSlotRule> get filteredRules {
    return rules.where((rule) {
      if (selectedLabelId != null && rule.labelId != selectedLabelId) return false;
      if (selectedActionType != null && rule.action.type != selectedActionType) return false;
      if (searchKeyword.isNotEmpty) {
        final keyword = searchKeyword.toLowerCase();
        final nameMatch = rule.name.toLowerCase().contains(keyword);
        final phoneMatch = rule.phoneNumber.value.toLowerCase().contains(keyword);
        if (!nameMatch && !phoneMatch) return false;
      }
      return true;
    }).toList();
  }

  SimSlotRulePageState copyWith({
    List<SimSlotRule>? rules,
    Map<String, String>? labelIdToTextMap,
    String? selectedLabelId,
    bool resetSelectedLabelId = false,
    RuleActionType? selectedActionType,
    bool resetSelectedActionType = false,
    String? searchKeyword,
  }) {
    return SimSlotRulePageState(
      rules: rules ?? this.rules,
      labelIdToTextMap: labelIdToTextMap ?? this.labelIdToTextMap,
      selectedLabelId: resetSelectedLabelId ? null : selectedLabelId ?? this.selectedLabelId,
      selectedActionType: resetSelectedActionType ? null : selectedActionType ?? this.selectedActionType,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }
}

// [注释]: 使用 .family 来接收 simSlotIndex
@riverpod
class SimSlotRulePage extends _$SimSlotRulePage {
  // [注释]: 便捷地获取 SimSlotRuleService 实例
  SimSlotRuleService get _service => ref.read(simSlotRuleServiceProvider);

  @override
  Future<SimSlotRulePageState> build(int simSlotIndex) async {
    return _loadData();
  }

  Future<SimSlotRulePageState> _loadData() async {
    final rules = await _service.getSimSlotRules(simSlotIndex);
    final predefinedLabelService = ref.read(predefinedLabelServiceProvider);
    final allLabels = await predefinedLabelService.getAllLabels();
    final labelMap = {for (var label in allLabels) label.id: label.text};
    
    return SimSlotRulePageState(rules: rules, labelIdToTextMap: labelMap);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _loadData());
  }

  Future<void> addRule(ListEntry entry, RuleAction action) async {
    await _service.addSimSlotRule(entry, simSlotIndex, action: action);
    await refresh();
  }

  Future<void> deleteRule(String ruleId) async {
    await _service.removeSimSlotRule(ruleId);
    await refresh();
  }

  Future<void> deleteSelectedRules(Set<String> ruleIds) async {
    await Future.wait(ruleIds.map((id) => _service.removeSimSlotRule(id)));
    await refresh();
  }

  Future<void> toggleRuleStatus(String ruleId, bool isEnabled) async {
    await _service.toggleRuleStatus(ruleId, isEnabled);
    await refresh();
  }

  void setSearchKeyword(String keyword) {
    state = AsyncValue.data(state.value!.copyWith(searchKeyword: keyword));
  }

  void setLabelFilter(String? labelId) {
    state = AsyncValue.data(state.value!.copyWith(selectedLabelId: labelId, resetSelectedLabelId: labelId == null));
  }
  
  void setActionFilter(RuleActionType? actionType) {
     state = AsyncValue.data(state.value!.copyWith(selectedActionType: actionType, resetSelectedActionType: actionType == null));
  }
}