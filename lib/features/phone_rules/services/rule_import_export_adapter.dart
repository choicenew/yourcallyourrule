import 'dart:typed_data';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';
import 'package:yourcallyourrule/features/phone_rules/services/import_export_service.dart';
import 'package:yourcallyourrule/features/phone_rules/services/rule_import_export_service.dart';

class RuleImportExportAdapter<T> implements ImportExportService<T, String> {
  final RuleImportExportService _service;

  RuleImportExportAdapter(this._service);

  @override
  Future<List<T>> getAll() async => [];

  @override
  Future<List<T>> importFromFile(String filePath, {ExportFormat? format, ImportMode mode = ImportMode.merge}) async => [];

  @override
  Future<bool> exportToFile(String filePath, {List<T>? entities, ExportFormat format = ExportFormat.json}) async => true;

  @override
  T fromMap(Map<String, dynamic> map) => throw UnimplementedError();

  @override
  Map<String, dynamic> toMap(T entity) => throw UnimplementedError();

  @override
  Future<List<T>> parseImportData(String data, {ExportFormat format = ExportFormat.json}) async => [];

  @override
  List<String> getEntityFieldNames() => [];

  @override
  Future<bool> validateImportData(List<T> entities) async => true;

  @override
  ExportFormat detectFileFormat(String filePath, String data) => ExportFormat.json;

  @override
  dynamic formatValueForCsv(dynamic value) => value;

  @override
  Future<List<T>> mergeEntities(List<T> entities, {ImportMode mode = ImportMode.merge}) async => entities;

  @override
  Future<void> writeDataToFile(String filePath, String data) async {}

  @override
  Future<String> readDataFromFile(String filePath) async => '';

  @override
  Future<List<T>> parseJsonData(String data) async => [];

  @override
  Future<List<T>> parseCsvData(String data) async => [];

  @override
  Future<List<T>> parseYamlData(String data) async => [];

  @override
  Future<List<T>> importFromUrl(String url) async => [];

  @override
  Future<String> prepareJsonForExport(List<T> entities) async => '';

  @override
  Future<String> prepareCsvForExport(List<T> entities) async => '';

  @override
  Future<String> prepareYamlForExport(List<T> entities) async => '';

  @override
  Future<Uint8List> prepareExportBytes(List<T>? entities, {ExportFormat format = ExportFormat.json}) async => Uint8List(0);
}
