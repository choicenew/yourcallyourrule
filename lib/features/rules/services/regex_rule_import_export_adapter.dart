import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_adapter.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_service.dart';

/// RegexRule规则导入导出适配�?
/// 用于将RuleImportExportService适配为ImportExportService<RegexRule, String>
class RegexRuleImportExportAdapter extends RuleImportExportAdapter<RegexRule> {
  RegexRuleImportExportAdapter(super.service);
}