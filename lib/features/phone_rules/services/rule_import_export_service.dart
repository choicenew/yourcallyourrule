import 'dart:convert';
import 'dart:isolate';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';
import 'package:pyro_phone_rules_protocol/pyro_phone_rules_protocol.dart';

import 'package:yourcallyourrule/features/phone_rules/repositories/rule_repository.dart';
import 'import_export_service.dart';

/// 规则导入导出服务
class RuleImportExportService extends ImportExportService<PhoneRuleEntity, String> {
  RuleImportExportService(RuleRepository super.repository);

  RuleRepository get ruleRepository => repository as RuleRepository;

  @override
  Map<String, dynamic> toJson(PhoneRuleEntity entity) => entity.toMap();

  @override
  PhoneRuleEntity fromJson(Map<String, dynamic> json) => PhoneRuleEntity.fromMap(json);

  @override
  Future<String> prepareJsonForExport(List<PhoneRuleEntity> entities) async {
    final dataList = entities.map((e) => e.toMap()).toList();
    return jsonEncode(dataList);
  }

  @override
  Future<List<PhoneRuleEntity>> parseJsonData(String jsonString) async {
    try {
      final rawMaps = await Isolate.run(() {
        final jsonData = jsonDecode(jsonString);
        if (jsonData is List) {
          return List<Map<String, dynamic>>.from(
            jsonData.map((e) => Map<String, dynamic>.from(e as Map)),
          );
        } else if (jsonData is Map) {
          return [Map<String, dynamic>.from(jsonData)];
        } else {
          throw const FormatException('JSON格式错误: 预期列表或映射');
        }
      });

      final rules = <PhoneRuleEntity>[];
      for (final rawMap in rawMaps) {
        final map = Map<String, dynamic>.from(rawMap);
        try {
          rules.add(PhoneRuleEntity.fromMap(map));
        } catch (e) {
          debugPrint('[RuleImportExportService] Skipping invalid rule item: $e, map: $map');
        }
      }

      return rules;
    } catch (e) {
      throw FormatException('$e');
    }
  }

  @override
  Future<List<PhoneRuleEntity>> parseCsvData(String csvString) async {
    try {
      final rows = await Isolate.run(() {
        bool isTabSeparated = csvString.contains('\t');
        return isTabSeparated
            ? const CsvDecoder(fieldDelimiter: '\t').convert(csvString)
            : const CsvDecoder().convert(csvString);
      });

      if (rows.isEmpty) return [];

      final headers = rows.first.map((e) => e.toString()).toList();
      final rules = <PhoneRuleEntity>[];

      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length != headers.length) continue;

        final map = <String, dynamic>{};
        for (var j = 0; j < headers.length; j++) {
          map[headers[j]] = row[j];
        }

        try {
          rules.add(PhoneRuleEntity.fromMap(map));
        } catch (_) {
          continue;
        }
      }

      return rules;
    } catch (e) {
      throw FormatException('CSV解析错误: $e');
    }
  }

  @override
  Future<List<PhoneRuleEntity>> parseYamlData(String yamlString) async {
    try {
      final yamlDocs = loadYamlDocuments(yamlString);
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

      return maps.map((map) => PhoneRuleEntity.fromMap(map)).toList();
    } catch (e) {
      throw FormatException('YAML解析错误: $e');
    }
  }

  Future<List<PhoneRuleEntity>> importFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        return await parseImportData(data, format: ExportFormat.json);
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  PhoneRuleEntity fromMap(Map<String, dynamic> map) {
    return PhoneRuleEntity.fromMap(map);
  }

  @override
  Future<bool> validateImportData(List<PhoneRuleEntity> entities) async {
    for (final rule in entities) {
      if (rule.name.isEmpty) return false;
    }
    return true;
  }
}

Map<String, dynamic> _convertYamlMapToMap(YamlMap yamlMap) {
  final Map<String, dynamic> result = {};
  for (final entry in yamlMap.entries) {
    final key = entry.key.toString();
    final value = entry.value;
    if (value is YamlMap) {
      result[key] = _convertYamlMapToMap(value);
    } else if (value is YamlList) {
      result[key] = _convertYamlListToList(value);
    } else {
      result[key] = value;
    }
  }
  return result;
}

List<dynamic> _convertYamlListToList(YamlList yamlList) {
  return yamlList.map((item) {
    if (item is YamlMap) {
      return _convertYamlMapToMap(item);
    } else if (item is YamlList) {
      return _convertYamlListToList(item);
    } else {
      return item;
    }
  }).toList();
}
