// 导入导出服务基类，用于处理数据的导入和导出功能

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:yaml/yaml.dart';

import '../base/base_service.dart';

/// 导入导出服务基类
/// [T] 是实体类型
/// [ID] 是实体ID类型，默认为String
abstract class ImportExportService<T, ID>
    extends BaseService<T, ID> {
  const ImportExportService(super.repository);

  /// 准备导出数据字节
  Future<Uint8List> prepareExportBytes(List<T>? entities, {ExportFormat format = ExportFormat.json}) async {
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

    return Uint8List.fromList(utf8.encode(exportData));
  }

  /// 导出数据到文件
  Future<bool> exportToFile(
    String filePath, {
    List<T>? entities,
    ExportFormat format = ExportFormat.json,
  }) async {
    try {
      final file = File(filePath);
      final bytes = await prepareExportBytes(entities, format: format);
      await file.writeAsBytes(bytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 准备JSON导出数据
  Future<String> prepareJsonForExport(List<T> entities) async {
    final listMap = entities.map((e) => toJson(e)).toList();
    return const JsonEncoder.withIndent('  ').convert(listMap);
  }

  /// 准备CSV导出数据
  Future<String> prepareCsvForExport(List<T> entities) async {
    if (entities.isEmpty) return '';
    final listMap = entities.map((e) => toJson(e)).toList();
    final headers = listMap.first.keys.toList();
    final rows = <List<dynamic>>[headers];

    for (final map in listMap) {
      rows.add(headers.map((h) => map[h]).toList());
    }

    return const ListToCsvConverter().convert(rows);
  }

  /// 准备YAML导出数据
  Future<String> prepareYamlForExport(List<T> entities) async {
    final listMap = entities.map((e) => toJson(e)).toList();
    return _mapToYaml(listMap);
  }

  /// 从文件导入数据
  Future<List<T>> importFromFile(
    String filePath, {
    ImportMode mode = ImportMode.merge,
    ExportFormat? format,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('文件不存在: $filePath');
      }

      final content = await file.readAsString();
      final detectedFormat = format ?? _detectFormat(filePath, content);
      return parseImportData(content, format: detectedFormat);
    } catch (e) {
      rethrow;
    }
  }

  /// 解析导入数据
  Future<List<T>> parseImportData(
    String data, {
    ExportFormat format = ExportFormat.json,
  }) async {
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
  Future<List<T>> parseJsonData(String jsonString) async {
    final decoded = jsonDecode(jsonString);
    if (decoded is! List) {
      throw Exception('无效的JSON数据格式：应该是一个JSON数组');
    }

    final entities = <T>[];
    for (final item in decoded) {
      if (item is Map<String, dynamic>) {
        try {
          entities.add(fromJson(item));
        } catch (_) {}
      }
    }
    return entities;
  }

  /// 解析CSV数据
  Future<List<T>> parseCsvData(String csvString) async {
    final rows = const CsvToListConverter().convert(csvString);
    if (rows.isEmpty) return [];

    final headers = rows.first.map((e) => e.toString()).toList();
    final entities = <T>[];

    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length != headers.length) continue;

      final map = <String, dynamic>{};
      for (var j = 0; j < headers.length; j++) {
        map[headers[j]] = row[j];
      }

      try {
        entities.add(fromJson(map));
      } catch (_) {}
    }
    return entities;
  }

  /// 解析YAML数据
  Future<List<T>> parseYamlData(String yamlString) async {
    final yaml = loadYaml(yamlString);
    if (yaml is! YamlList) {
      throw Exception('无效的YAML数据格式：应该是一个YAML数组');
    }

    final entities = <T>[];
    for (final item in yaml) {
      if (item is YamlMap) {
        final map = Map<String, dynamic>.from(item);
        try {
          entities.add(fromJson(map));
        } catch (_) {}
      }
    }
    return entities;
  }

  /// 转换实体为JSON映射
  Map<String, dynamic> toJson(T entity);

  /// 从JSON映射创建实体
  T fromJson(Map<String, dynamic> json);

  /// 自动检测文件格式
  ExportFormat _detectFormat(String filePath, String content) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'json':
        return ExportFormat.json;
      case 'csv':
        return ExportFormat.csv;
      case 'yaml':
      case 'yml':
        return ExportFormat.yaml;
      default:
        try {
          jsonDecode(content);
          return ExportFormat.json;
        } catch (_) {
          return ExportFormat.csv;
        }
    }
  }

  /// 映射转换为YAML字符串
  String _mapToYaml(dynamic map, {int indent = 0}) {
    final indentStr = ' ' * indent;
    final buffer = StringBuffer();

    if (map is Map) {
      for (final entry in map.entries) {
        if (entry.value is Map || entry.value is List) {
          buffer.writeln('$indentStr${entry.key}:');
          buffer.write(_mapToYaml(entry.value, indent: indent + 2));
        } else {
          buffer.writeln('$indentStr${entry.key}: ${_formatYamlValue(entry.value)}');
        }
      }
    } else if (map is List) {
      for (final item in map) {
        if (item is Map) {
          final entries = item.entries.toList();
          if (entries.isNotEmpty) {
            final first = entries.first;
            buffer.writeln('$indentStr- ${first.key}: ${_formatYamlValue(first.value)}');
            for (var i = 1; i < entries.length; i++) {
              final entry = entries[i];
              if (entry.value is Map || entry.value is List) {
                buffer.writeln('$indentStr  ${entry.key}:');
                buffer.write(_mapToYaml(entry.value, indent: indent + 4));
              } else {
                buffer.writeln('$indentStr  ${entry.key}: ${_formatYamlValue(entry.value)}');
              }
            }
          }
        } else {
          buffer.writeln('$indentStr- ${_formatYamlValue(item)}');
        }
      }
    }

    return buffer.toString();
  }

  /// 格式化YAML值
  String _formatYamlValue(dynamic value) {
    if (value == null) return 'null';
    if (value is String) return '"$value"';
    return value.toString();
  }
}

/// 导出格式枚举
enum ExportFormat {
  json,
  csv,
  yaml,
}

/// 导入模式枚举
enum ImportMode {
  merge,
  overwrite,
}
