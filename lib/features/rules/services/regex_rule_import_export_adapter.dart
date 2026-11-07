import 'package:yourcallyourrule/core/entities/rule/regex_rule.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_adapter.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';

/// RegexRule规则导入导出适配器
/// 用于将RuleImportExportService适配为ImportExportService<RegexRule, String>
class RegexRuleImportExportAdapter extends RuleImportExportAdapter<RegexRule> {
  RegexRuleImportExportAdapter(super.service);
}