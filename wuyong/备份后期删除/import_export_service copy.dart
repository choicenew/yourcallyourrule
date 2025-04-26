// 导入导出服务基类，用于处理数据的导入和导出功能

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

import 'package:yaml/yaml.dart';

import '../../lib/core/base/base_entity.dart';
import '../../lib/core/base/base_service.dart';

/// 导入导出服务基类
/// [T] 是实体类型
/// [ID] 是实体ID类型，默认为String
abstract class ImportExportService<T extends BaseEntity, ID>
    extends BaseService<T, ID> {
  const ImportExportService(super.repository);

  /// 导出数据到文件
  /// [filePath] 导出文件路径
  /// [entities] 要导出的实体列表，如果为null则导出所有实体
  /// [format] 导出格式，默认为JSON
  Future<bool> exportToFile(String filePath,
      {List<T>? entities, ExportFormat format = ExportFormat.json}) async {
    try {
      final dataToExport = entities ?? await getAll();
      String exportData;

      switch (format) {
        case ExportFormat.json:
          exportData = await prepareJsonForExport(dataToExport);
          break;
        case ExportFormat.csv:
          exportData = await prepareCsvForExport(dataToExport);
          break;
        case ExportFormat.yaml:
          exportData = await prepareYamlForExport(dataToExport);
          break;
      }

      await writeDataToFile(filePath, exportData);
      return true;
    } catch (e) {
      // 处理导出错误
      return false;
    }
  }

  /// 从文件导入数据
  /// [filePath] 导入文件路径
  /// [mode] 导入模式，默认为合并模式
  /// [format] 导入格式，默认自动检测
  Future<List<T>> importFromFile(String filePath,
      {ImportMode mode = ImportMode.merge, ExportFormat? format}) async {
    try {
      final fileData = await readDataFromFile(filePath);
      final detectedFormat = format ?? detectFileFormat(filePath, fileData);
      final entities = await parseImportData(fileData, format: detectedFormat);

      switch (mode) {
        case ImportMode.overwrite:
          // 如果选择覆盖，先删除所有现有数据
          final existingEntities = await getAll();
          await deleteAll(existingEntities);
          return await saveAll(entities);

        case ImportMode.merge:
          // 合并模式：更新已存在的，添加新的
          return await mergeEntities(entities);
      }
    } catch (e) {
      // 处理导入错误
      return [];
    }
  }

  /// 合并实体方法
  /// 更新已存在的实体，添加新的实体
  Future<List<T>> mergeEntities(List<T> entities) async {
    final result = <T>[];
    for (final entity in entities) {
      final existing = await getById(entity.id as ID);
      if (existing != null) {
        // 更新已存在的实体
        await update(entity);
        result.add(entity);
      } else {
        // 添加新实体
        final saved = await save(entity);
        result.add(saved);
      }
    }
    return result;
  }

  /// 准备JSON数据用于导出
  Future<String> prepareJsonForExport(List<T> entities) async {
    final List<Map<String, dynamic>> dataList =
        entities.map((e) => e.toMap()).toList();
    return jsonEncode(dataList);
  }

  /// 准备CSV数据用于导出
  Future<String> prepareCsvForExport(List<T> entities) async {
    // 获取所有字段名
    final fieldNames = getEntityFieldNames();

    // 创建CSV行
    List<List<dynamic>> rows = [];

    // 添加表头
    rows.add(fieldNames);

    // 添加数据行
    for (var entity in entities) {
      final map = entity.toMap();
      final row =
          fieldNames.map((field) => formatValueForCsv(map[field])).toList();
      rows.add(row);
    }

    // 转换为CSV字符串
    return const ListToCsvConverter().convert(rows);
  }

  /// 准备YAML数据用于导出
  Future<String> prepareYamlForExport(List<T> entities) async {
    final List<Map<String, dynamic>> dataList =
        entities.map((e) => e.toMap()).toList();
    // 使用yaml库将数据转换为YAML格式
    final yamlString = dataList.map((map) {
      return map.entries
          .map((e) => '${e.key}: ${_formatYamlValue(e.value)}')
          .join('\n');
    }).join('\n---\n');

    return yamlString;
  }

  /// 解析导入的数据
  /// [data] 导入的数据字符串
  /// [format] 数据格式
  Future<List<T>> parseImportData(String data,
      {ExportFormat format = ExportFormat.json}) async {
    switch (format) {
      case ExportFormat.json:
        return parseJsonData(data);
      case ExportFormat.csv:
        return parseCsvData(data);
      case ExportFormat.yaml:
        return parseYamlData(data);
    }
  }

  /// 解析JSON数据
  Future<List<T>> parseJsonData(String data);

  /// 解析CSV数据
  Future<List<T>> parseCsvData(String data);

  /// 解析YAML数据
  Future<List<T>> parseYamlData(String data) async {
    try {
      final yamlDocs = loadYamlDocuments(data);
      final List<Map<String, dynamic>> maps = [];

      for (var doc in yamlDocs) {
        final yamlMap = doc.contents.value as YamlMap;
        maps.add(_convertYamlMapToMap(yamlMap));
      }

      return maps.map((map) => fromMap(map)).toList();
    } catch (e) {
      // 处理解析错误
      return [];
    }
  }

  /// 将数据写入文件
  Future<void> writeDataToFile(String filePath, String data) async {
    final file = File(filePath);
    await file.writeAsString(data);
  }

  /// 从文件读取数据
  Future<String> readDataFromFile(String filePath) async {
    final file = File(filePath);
    return await file.readAsString();
  }

  /// 检测文件格式
  ExportFormat detectFileFormat(String filePath, String data) {
    if (filePath.toLowerCase().endsWith('.csv')) {
      return ExportFormat.csv;
    } else if (filePath.toLowerCase().endsWith('.yaml') ||
        filePath.toLowerCase().endsWith('.yml')) {
      return ExportFormat.yaml;
    } else {
      // 默认为JSON
      return ExportFormat.json;
    }
  }

  /// 获取实体字段名列表
  List<String> getEntityFieldNames();

  /// 格式化值用于CSV导出
  dynamic formatValueForCsv(dynamic value) {
    if (value == null) return '';
    if (value is bool) return value ? 1 : 0;
    return value.toString();
  }

  /// 验证导入的数据
  Future<bool> validateImportData(List<T> entities) async {
    // 默认实现，不进行验证
    return true;
  }

  /// 从Map创建实体
  T fromMap(Map<String, dynamic> map);

  /// 格式化YAML值
  String _formatYamlValue(dynamic value) {
    if (value == null) return 'null';
    if (value is String) return '"$value"';
    if (value is List) {
      return value.map((v) => '- ${_formatYamlValue(v)}').join('\n');
    }
    return value.toString();
  }

  /// 将YamlMap转换为普通Map
  Map<String, dynamic> _convertYamlMapToMap(YamlMap yamlMap) {
    final result = <String, dynamic>{};
    for (var entry in yamlMap.entries) {
      final key = entry.key.toString();
      final value = entry.value;

      if (value is YamlMap) {
        result[key] = _convertYamlMapToMap(value);
      } else if (value is YamlList) {
        result[key] = value.map((item) {
          if (item is YamlMap) return _convertYamlMapToMap(item);
          return item;
        }).toList();
      } else {
        result[key] = value;
      }
    }
    return result;
  }
}

/// 导出格式枚举
enum ExportFormat { json, csv, yaml }

/// 导入模式枚举
enum ImportMode {
  merge, // 合并模式：更新已存在的，添加新的
  overwrite // 覆盖模式：删除所有现有数据后导入新数据
}
