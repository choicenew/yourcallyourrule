import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:yaml/yaml.dart';
import 'package:plugindemo/core/base/base_entity.dart';
import 'package:plugindemo/core/repositories/base_repository.dart';

class UniversalImportExportService<T extends BaseEntity> {
  final BaseRepository<T, String> _repository;

  UniversalImportExportService(this._repository);

  Future<List<T>> importFromFile(String path) async {
    final rawData = await _readFileData(path);
    final entities = _parseData(rawData, path);
    return await _repository.saveAll(entities);
  }

  Future<bool> exportToFile(String path, List<T> entities) async {
    final exportData = _formatForExport(entities, path);
    return await _writeFileData(path, exportData);
  }

  Future<String> _readFileData(String path) async {
    try {
      final file = File(path);
      return await file.readAsString();
    } catch (e) {
      throw IOException('文件读取失败: $e');
    }
  }

  Future<bool> _writeFileData(String path, String data) async {
    try {
      final file = File(path);
      await file.writeAsString(data);
      return true;
    } catch (e) {
      throw IOException('文件写入失败: $e');
    }
  }

  List<T> _parseData(String data, String path) {
    final format = _detectFileFormat(path, data);
    
    switch (format) {
      case FileFormat.json:
        return _parseJsonData(data);
      case FileFormat.csv:
        return _parseCsvData(data);
      case FileFormat.yaml:
        return _parseYamlData(data);
      default:
        throw FormatException('不支持的格式: $format');
    }
  }

  FileFormat _detectFileFormat(String path, String data) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'json':
        return FileFormat.json;
      case 'csv':
        return FileFormat.csv;
      case 'yaml':
      case 'yml':
        return FileFormat.yaml;
      default:
        if (data.trim().startsWith('{') || data.trim().startsWith('[')) {
          return FileFormat.json;
        } else if (data.contains(',')) {
          return FileFormat.csv;
        } else if (data.trim().startsWith('---')) {
          return FileFormat.yaml;
        }
        throw const FormatException('无法检测文件格式');
    }
  }

  List<T> _parseJsonData(String data) {
    final jsonList = jsonDecode(data) as List;
    return jsonList.map((json) {
      return _repository.fromMap(json as Map<String, dynamic>); // Line 83 corrected
    }).toList();
  }

  List<T> _parseCsvData(String data) {
    final csv = const CsvToListConverter().convert(data);
    final headers = csv.first.map((e) => e.toString()).toList();
    
    return csv.skip(1).map((row) {
      final map = <String, dynamic>{};
      for (var i = 0; i < headers.length; i++) {
        map[headers[i]] = _parseCsvValue(row[i]);
      }
      return _repository.fromMap(map); // Line 96 corrected
    }).toList();
  }

  List<T> _parseYamlData(String data) {
    final docs = loadYamlDocuments(data);
    return docs.map((doc) {
      return _repository.fromMap(_convertYamlNode(doc.contents)); // Line 103 corrected
    }).toList();
  }

  dynamic _parseCsvValue(dynamic value) {
    if (value == null || value.toString().isEmpty) return null;
    final strVal = value.toString();
    
    if (strVal == 'true') return true;
    if (strVal == 'false') return false;
    if (num.tryParse(strVal) != null) return num.parse(strVal);
    
    return strVal;
  }

  Map<String, dynamic> _convertYamlNode(YamlNode node) {
    if (node is YamlMap) {
      return node.nodes.map((key, value) {
        return MapEntry(
          (key as YamlScalar).value.toString(),
          _convertYamlNode(value)
        );
      });
    } else if (node is YamlList) {
      return { '_list': node.nodes.map(_convertYamlNode).toList() };
    } else if (node is YamlScalar) {
      return { '_value': node.value };
    }
    throw const FormatException('未知的YAML节点类型');
  }

  String _formatForExport(List<T> entities, String path) {
    final format = _detectFileFormat(path, '');
    
    switch (format) {
      case FileFormat.json:
        return jsonEncode(entities.map((e) => e.toMap()).toList());
      case FileFormat.csv:
        return _formatCsv(entities);
      case FileFormat.yaml:
        return _formatYaml(entities);
      default:
        throw const FormatException('不支持的导出格式');
    }
  }

  String _formatCsv(List<T> entities) {
    final fieldNames = _getEntityFieldNames(entities);
    final rows = [fieldNames];
    
    for (final entity in entities) {
      final map = entity.toMap();
      rows.add(fieldNames.map((field) => map[field]?.toString() ?? '').toList());
    }
    
    return const ListToCsvConverter().convert(rows);
  }

  String _formatYaml(List<T> entities) {
    return entities.map((e) {
      final map = e.toMap();
      return map.entries.map((entry) => '${entry.key}: ${entry.value}').join('\n');
    }).join('\n---\n');
  }

  List<String> _getEntityFieldNames(List<T> entities) {
    if (entities.isEmpty) return [];
    final sample = entities.first.toMap();
    return sample.keys.toList();
  }
}

enum FileFormat { json, csv, yaml }
class IOException implements Exception {
  final String message;
  const IOException(this.message);
}