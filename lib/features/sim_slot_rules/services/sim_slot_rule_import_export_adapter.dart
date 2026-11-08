import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_adapter.dart';

/// SimSlotRule规则导入导出适配�?
/// 用于将RuleImportExportService适配为ImportExportService<SimSlotRule, String>
class SimSlotRuleImportExportAdapter extends RuleImportExportAdapter<SimSlotRule> {
  SimSlotRuleImportExportAdapter(super.service);
}