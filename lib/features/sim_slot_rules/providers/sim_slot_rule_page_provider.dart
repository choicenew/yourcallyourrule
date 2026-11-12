import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/labels/services/predefined_label_service.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/sim_slot_rules/services/sim_slot_rule_service.dart';

part 'sim_slot_rule_page_provider.g.dart';

class SimSlotRulePageState {
  final List<SimSlotRuleEntity> rules;
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

  List<SimSlotRuleEntity> get filteredRules {
    return rules.where((rule) {
      if (selectedLabelId != null && rule.labelId != selectedLabelId) return false;
      if (selectedActionType != null && rule.action.actionName != selectedActionType?.name) return false;
      if (searchKeyword.isNotEmpty) {
        final keyword = searchKeyword.toLowerCase();
        final phoneMatch = rule.phoneNumber.toLowerCase().contains(keyword);
        if (!phoneMatch) return false;
      }
      return true;
    }).toList();
  }

  SimSlotRulePageState copyWith({
    List<SimSlotRuleEntity>? rules,
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

@riverpod
class SimSlotRulePage extends _$SimSlotRulePage {
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

  Future<void> addRule(dynamic entry, RuleAction action) async {
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
