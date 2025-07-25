import 'package:yourcallyourrule/core/entities/rule/allowed_blocked_rule.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_adapter.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';

/// AllowedBlockedRule规则导入导出适配器
/// 用于将RuleImportExportService适配为ImportExportService<AllowedBlockedRule, String>
class AllowedBlockedRuleImportExportAdapter extends RuleImportExportAdapter<AllowedBlockedRule> {
  AllowedBlockedRuleImportExportAdapter(super.service);
}