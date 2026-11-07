import 'package:yourcallyourrule/core/entities/rule/phone_rule.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_adapter.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';

/// PhoneRule规则导入导出适配器
/// 用于将RuleImportExportService适配为ImportExportService<PhoneRule, String>
class PhoneRuleImportExportAdapter extends RuleImportExportAdapter<PhoneRule> {
  PhoneRuleImportExportAdapter(super.service);
}