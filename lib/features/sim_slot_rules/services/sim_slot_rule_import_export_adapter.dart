import 'package:yourcallyourrule/core/entities/rule/sim_slot_rule.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_adapter.dart';

/// SimSlotRule规则导入导出适配器
/// 用于将RuleImportExportService适配为ImportExportService<SimSlotRule, String>
class SimSlotRuleImportExportAdapter extends RuleImportExportAdapter<SimSlotRule> {
  SimSlotRuleImportExportAdapter(super.service);
}