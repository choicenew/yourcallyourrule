import 'package:yourcallyourrule/core/base/base_entity.dart';

import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';
import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';

/// 通用规则导入导出适配器基类
/// 用于将RuleImportExportService适配为特定规则类型的ImportExportService
/// [T] 是具体的规则类型，必须继承自RuleBase
class RuleImportExportAdapter<T extends RuleBase> implements ImportExportService<T, String> {
  final RuleImportExportService _service;

  RuleImportExportAdapter(this._service);

  @override
  Future<List<T>> getAll() async {
    final rules = await _service.getAll();
    return rules.whereType<T>().toList();
  }

  @override
  Future<List<T>> importFromFile(String filePath, {ExportFormat? format, ImportMode mode = ImportMode.merge}) async {
    final rules = await _service.importFromFile(filePath, format: format, mode: mode);
    return rules.whereType<T>().toList();
  }

  @override
  Future<bool> exportToFile(String filePath, {List<T>? entities, ExportFormat format = ExportFormat.json}) async {
    return await _service.exportToFile(filePath, entities: entities, format: format);
  }

  @override
  BaseRepository<T, String> get repository {
    // 这里需要进行类型转换，将BaseRepository<RuleBase, String>转换为BaseRepository<T, String>
    // 由于Dart的泛型是固定的，这里使用as进行类型转换
    // 实际上底层仓库操作的是RuleBase对象，但我们在适配器中确保只处理T类型的对象
    return _service.repository as BaseRepository<T, String>;
  }

  // 实现BaseService的方法
  @override
  Future<bool> delete(T entity) => _service.delete(entity);

  @override
  Future<bool> deleteAll(List<T> entities) => _service.deleteAll(entities);

  @override
  Future<bool> deleteById(String id) => _service.deleteById(id);

  @override
  Future<bool> exists(String id) => _service.exists(id);

  @override
  Future<T?> getById(String id) async {
    final rule = await _service.getById(id);
    return rule is T ? rule : null;
  }

  @override
  Future<T> save(T entity) async {
    final rule = await _service.save(entity);
    if (rule is T) {
      return rule;
    }
    throw const FormatException('保存的规则类型不匹配');
  }

  @override
  Future<List<T>> saveAll(List<T> entities) async {
    final rules = await _service.saveAll(entities);
    final typedRules = rules.whereType<T>().toList();
    if (typedRules.length != entities.length) {
      throw const FormatException('部分规则保存失败或类型不匹配');
    }
    return typedRules;
  }

  @override
  Future<T> update(T entity) async {
    final rule = await _service.update(entity);
    if (rule is T) {
      return rule;
    }
    throw const FormatException('更新的规则类型不匹配');
  }

  // 实现ImportExportService的其他方法
  @override
  List<String> getEntityFieldNames() => _service.getEntityFieldNames();

  @override
  T fromMap(Map<String, dynamic> map) {
    final rule = _service.fromMap(map);
    if (rule is T) {
      return rule;
    }
    throw FormatException('无法将Map转换为${T.toString()}');
  }

  @override
  Future<bool> validateImportData(List<T> entities) => _service.validateImportData(entities);
  
  @override
  Future<List<T>> parseImportData(String data, {ExportFormat format = ExportFormat.json}) async {
    final rules = await _service.parseImportData(data, format: format);
    return rules.whereType<T>().toList();
  }

  Future<String> prepareDataForExport(List<T> entities, {ExportFormat format = ExportFormat.json}) async {
    switch (format) {
      case ExportFormat.json:
        return await prepareJsonForExport(entities);
      case ExportFormat.csv:
        return await prepareCsvForExport(entities);
      case ExportFormat.yaml:
        return await prepareYamlForExport(entities);
    }
  }

  @override
  ExportFormat detectFileFormat(String filePath, String data) {
    return _service.detectFileFormat(filePath, data);
  }

  @override
  dynamic formatValueForCsv(dynamic value) {
    return _service.formatValueForCsv(value);
  }

  @override
  Future<List<T>> mergeEntities(List<T> entities, {ImportMode mode = ImportMode.merge}) async {
    final rules = await _service.mergeEntities(entities);
    return rules.whereType<T>().toList();
  }

  @override
  Future<void> writeDataToFile(String filePath, String data) async {
    await _service.writeDataToFile(filePath, data);
  }

  @override
  Future<String> readDataFromFile(String filePath) async {
    return await _service.readDataFromFile(filePath);
  }

  @override
  Future<List<T>> parseJsonData(String data) async {
    final rules = await _service.parseJsonData(data);
    return rules.whereType<T>().toList();
  }

  @override
  Future<List<T>> parseCsvData(String data) async {
    final rules = await _service.parseCsvData(data);
    return rules.whereType<T>().toList();
  }

  @override
  Future<List<T>> parseYamlData(String data) async {
    final rules = await _service.parseYamlData(data);
    return rules.whereType<T>().toList();
  }

  @override
  Future<List<T>> importFromUrl(String url) async {
    final rules = await _service.importFromUrl(url);
    return rules.whereType<T>().toList();
  }

  @override
  Future<String> prepareJsonForExport(List<T> entities) async {
    return await _service.prepareJsonForExport(entities);
  }

  @override
  Future<String> prepareCsvForExport(List<T> entities) async {
    return await _service.prepareCsvForExport(entities);
  }

  @override
  Future<String> prepareYamlForExport(List<T> entities) async {
    return await _service.prepareYamlForExport(entities);
  }
}