import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_adapter.dart';
import 'package:yourcallyourrule/features/rules/services/rule_import_export_service.dart';

/// PhoneRule规则导入导出适配�?
/// 用于将RuleImportExportService适配为ImportExportService<PhoneRule, String>
class PhoneRuleImportExportAdapter extends RuleImportExportAdapter<PhoneRule> {
  PhoneRuleImportExportAdapter(super.service);
}