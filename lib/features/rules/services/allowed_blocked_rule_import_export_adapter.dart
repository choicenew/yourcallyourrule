import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_adapter.dart';

/// AllowedBlockedRule规则导入导出适配�?
/// 用于将RuleImportExportService适配为ImportExportService<AllowedBlockedRule, String>
class AllowedBlockedRuleImportExportAdapter extends RuleImportExportAdapter<AllowedBlockedRule> {
  AllowedBlockedRuleImportExportAdapter(super.service);
}