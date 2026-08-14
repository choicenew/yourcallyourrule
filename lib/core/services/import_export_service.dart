// 导入导出服务基类，用于处理数据的导入和导出功能

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:yaml/yaml.dart';

import '../base/base_entity.dart';
import '../base/base_service.dart';

/// 导入导出服务基类
/// [T] 是实体类型
/// [ID] 是实体ID类型，默认为String
abstract class ImportExportService<T extends BaseEntity, ID>
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
  /// [filePath] 导出文件路径
  /// [entities] 要导出的实体列表，如果为null则导出所有实体
  /// [format] 导出格式，默认为JSON
  Future<bool> exportToFile(String filePath,
      {List<T>? entities, ExportFormat format = ExportFormat.json}) async {
    try {
      final bytes = await prepareExportBytes(entities, format: format);
      final file = File(filePath);
      await file.writeAsBytes(bytes);
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

      // 验证导入的数据
      if (!await validateImportData(entities)) {
        throw const FormatException('导入数据验证失败');
      }

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
      try {
        final existing = await getById(entity.id as ID);
        if (existing != null) {
          // 更新已存在的实体
          final updated = await update(entity);
          result.add(updated);
        } else {
          // 添加新实体
          final saved = await save(entity);
          result.add(saved);
        }
      } catch (e) {
        // 处理单个实体导入错误，继续处理下一个
        continue;
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
    return const CsvEncoder().convert(rows);
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
    try {
      switch (format) {
        case ExportFormat.json:
          return await parseJsonData(data);
        case ExportFormat.csv:
          return await parseCsvData(data);
        case ExportFormat.yaml:
          return await parseYamlData(data);
      }
    } catch (e) {
      // 尝试自动检测格式并解析
      if (data.trim().startsWith('{') || data.trim().startsWith('[')) {
        return await parseJsonData(data);
      } else if (data.trim().startsWith('---')) {
        return await parseYamlData(data);
      } else if (data.contains(',')) {
        return await parseCsvData(data);
      }
      throw FormatException('无法解析导入数据: $e');
    }
  }

  /// 解析JSON数据
  Future<List<T>> parseJsonData(String data) async {
    try {
      final jsonData = jsonDecode(data);
      List<Map<String, dynamic>> maps;
      
      if (jsonData is List) {
        maps = List<Map<String, dynamic>>.from(jsonData);
      } else if (jsonData is Map) {
        maps = [Map<String, dynamic>.from(jsonData)];
      } else {
        throw const FormatException('JSON格式错误: 预期列表或映射');
      }
      
      return maps.map((map) => fromMap(map)).toList();
    } catch (e) {
      throw FormatException('JSON解析错误: $e');
    }
  }

  /// 解析CSV数据
  Future<List<T>> parseCsvData(String data) async {
    try {
      final rows = const CsvDecoder().convert(data);
      if (rows.isEmpty) {
        return [];
      }
      
      // 第一行作为标题
      final headers = rows.first.map((e) => e.toString()).toList();
      
      // 转换数据行为实体
      final entities = <T>[];
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length != headers.length) {
          continue; // 跳过格式不匹配的行
        }
        
        final map = <String, dynamic>{};
        for (var j = 0; j < headers.length; j++) {
          map[headers[j]] = _convertCsvValue(row[j]);
        }
        
        entities.add(fromMap(map));
      }
      
      return entities;
    } catch (e) {
      throw FormatException('CSV解析错误: $e');
    }
  }

  /// 转换CSV值为适当的类型
  dynamic _convertCsvValue(dynamic value) {
    if (value == null) return null;
    if (value == '') return null;
    
    // 尝试转换为数字
    final numValue = num.tryParse(value.toString());
    if (numValue != null) return numValue;
    
    // 尝试转换为布尔值
    final lowerValue = value.toString().toLowerCase();
    if (lowerValue == 'true') return true;
    if (lowerValue == 'false') return false;
    if (lowerValue == '1') return true;
    if (lowerValue == '0') return false;
    
    // 尝试转换为日期
    try {
      return DateTime.parse(value.toString());
    } catch (_) {}
    
    // 默认返回字符串
    return value.toString();
  }

  /// 解析YAML数据
  Future<List<T>> parseYamlData(String data) async {
    try {
      final yamlDocs = loadYamlDocuments(data);
      final List<Map<String, dynamic>> maps = [];

      for (var doc in yamlDocs) {
        final yamlContent = doc.contents;
        if (yamlContent is YamlMap) {
          maps.add(_convertYamlMapToMap(yamlContent));
        } else if (yamlContent is YamlList) {
          for (var item in yamlContent.nodes) {
            if (item is YamlMap) {
              maps.add(_convertYamlMapToMap(item));
            }
          }
        }
      }

      return maps.map((map) => fromMap(map)).toList();
    } catch (e) {
      throw FormatException('YAML解析错误: $e');
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
    // 先根据文件扩展名判断
    if (filePath.toLowerCase().endsWith('.csv')) {
      return ExportFormat.csv;
    } else if (filePath.toLowerCase().endsWith('.yaml') ||
        filePath.toLowerCase().endsWith('.yml')) {
      return ExportFormat.yaml;
    } else if (filePath.toLowerCase().endsWith('.json')) {
      return ExportFormat.json;
    }
    
    // 如果文件扩展名不明确，尝试根据内容判断
    if (data.trim().startsWith('{') || data.trim().startsWith('[')) {
      return ExportFormat.json;
    } else if (data.trim().startsWith('---')) {
      return ExportFormat.yaml;
    } else if (data.contains(',')) {
      return ExportFormat.csv;
    }
    
    // 默认为JSON
    return ExportFormat.json;
  }

  /// 获取实体字段名列表
  List<String> getEntityFieldNames();

  /// 格式化值用于CSV导出
  dynamic formatValueForCsv(dynamic value) {
    if (value == null) return '';
    if (value is bool) return value ? 1 : 0;
    if (value is DateTime) return value.toIso8601String();
    if (value is List) return value.join(';');
    if (value is Map) return jsonEncode(value);
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
    if (value is DateTime) return '"${value.toIso8601String()}"';
    if (value is List) {
      if (value.isEmpty) return '[]';
      return '\n${value.map((v) => '  - ${_formatYamlValue(v)}').join('\n')}';
    }
    if (value is Map) {
      if (value.isEmpty) return '{}';
      return '\n${value.entries.map((e) => 
        '  ${e.key}: ${_formatYamlValue(e.value)}').join('\n')}';
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
        // 尝试转换特殊类型
        if (value is String) {
          // 尝试解析为日期
          try {
            final date = DateTime.parse(value);
            result[key] = date;
            continue;
          } catch (_) {}
          
          // 尝试解析为布尔值
          if (value.toLowerCase() == 'true') {
            result[key] = true;
            continue;
          }
          if (value.toLowerCase() == 'false') {
            result[key] = false;
            continue;
          }
          
          // 尝试解析为数字
          final numValue = num.tryParse(value);
          if (numValue != null) {
            result[key] = numValue;
            continue;
          }
        }
        
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
