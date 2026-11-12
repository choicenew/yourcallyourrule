import 'package:yourcallyourrule/features/phone_rules/services/import_export_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_import_export_service.dart';

class RuleImportExportAdapter<T> extends ImportExportService<T, String> {
  final RuleImportExportService _service;

  RuleImportExportAdapter(this._service) : super(_service);

  @override
  Map<String, dynamic> toJson(T entity) {
    if (entity is Map<String, dynamic>) return entity;
    return (entity as dynamic).toMap() as Map<String, dynamic>;
  }

  @override
  T fromJson(Map<String, dynamic> json) {
    return json as T;
  }
}
