import 'dart:convert';
import 'dart:isolate';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:yaml/yaml.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

import '../entities/rule/rule_base.dart';
import '../repositories/rule_repository.dart';
import 'import_export_service.dart';

/// 规则导入导出服务
/// 提供规则数据的导入导出功能，自动处理规则实体的导入导出
class RuleImportExportService extends ImportExportService<RuleBase, String> {
  RuleImportExportService(RuleRepository super.repository);

  /// 获取规则仓库实例
  RuleRepository get ruleRepository => repository as RuleRepository;

  @override
  Future<String> prepareJsonForExport(List<RuleBase> entities) async {
    final dataList = entities.map((e) => e.toMap()).toList();
    return jsonEncode(dataList);
  }

  @override
  Future<List<RuleBase>> parseJsonData(String data) async {
    try {
      // 1. 在后台 Isolate（副线程）中去解码大容量 JSON 文本与粗加工 Map 列表，绝不占用 UI 渲染主线程
      final rawMaps = await Isolate.run(() {
        final jsonData = jsonDecode(data);
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
      
      final rules = <RuleBase>[];
      for (final rawMap in rawMaps) {
        final map = Map<String, dynamic>.from(rawMap);
        
        // --- 1. 规范化 isEnabled 字段 (解决 int 无法强转 bool 的错误) ---
        final rawEnabled = map['isEnabled'] ?? map['is_enabled'];
        if (rawEnabled is int) {
          map['isEnabled'] = rawEnabled == 1;
        } else if (rawEnabled is String) {
          map['isEnabled'] = rawEnabled.toLowerCase() == 'true' || rawEnabled == '1';
        } else if (rawEnabled is bool) {
          map['isEnabled'] = rawEnabled;
        } else {
          map['isEnabled'] = true;
        }
        
        // --- 2. 规范化 ruleType 字段 ---
        map['ruleType'] = map['ruleType'] ?? map['rule_type'] ?? 'phone_rule';
        
        // --- 3. 规范化 phoneNumber 字段 ---
        map['phoneNumber'] = map['phoneNumber'] ?? map['phone_number'] ?? map['pattern'] ?? '';
        
        // --- 4. 规范化 id, name, labelId, action 字段为 String ---
        map['id'] = map['id']?.toString() ?? const Uuid().v4();
        map['name'] = map['name']?.toString() ?? 'Imported Rule';
        map['labelId'] = map['labelId']?.toString() ?? map['label_id']?.toString() ?? 'default';
        map['action'] = map['action']?.toString() ?? 'block';
        
        try {
          rules.add(fromMap(map));
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
  Future<List<RuleBase>> parseCsvData(String data) async {
    try {
      // 1. 在后台 Isolate（副线程）中进行 CSV 文本转义解码
      final rows = await Isolate.run(() {
        bool isTabSeparated = data.contains('\t');
        return isTabSeparated 
            ? const CsvDecoder(fieldDelimiter: '\t').convert(data)
            : const CsvDecoder().convert(data);
      });
          
      if (rows.isEmpty) {
        debugPrint('[RuleImportExportService] CSV parsing: No rows found in data');
        return [];
      }
      
      // 第一行作为标题
      final headers = rows.first.map((e) => e.toString()).toList();
      debugPrint('[RuleImportExportService] CSV headers: ${headers.join(", ")}');
      
      // 转换数据行为规则实体
      final rules = <RuleBase>[];
      
      // 检查必需的字段是否存在
      final requiredFields = ['name', 'phoneNumber', 'labelId', 'action'];
      final missingFields = requiredFields.where((field) => !headers.contains(field)).toList();
      if (missingFields.isNotEmpty) {
        debugPrint('[RuleImportExportService] Missing required fields: ${missingFields.join(", ")}');
        throw FormatException('CSV缺少必需字段: ${missingFields.join(", ")}');
      }
      
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length != headers.length) {
          debugPrint('[RuleImportExportService] Skipping row $i: Column count mismatch. Expected ${headers.length}, got ${row.length}');
          continue; // 跳过格式不匹配的行
        }
        
        final map = <String, dynamic>{};
        for (var j = 0; j < headers.length; j++) {
          map[headers[j]] = row[j];
        }

        // --- Data Cleaning and Type Conversion Stage ---
        
        // Handle ID: ensure it's a string, generate if missing.
        if (!headers.contains('id') || (map['id'] == null || map['id'].toString().isEmpty)) {
          map['id'] = const Uuid().v4();
        } else {
          map['id'] = map['id'].toString();
        }

        // Convert numeric fields from String to int
        final intFields = ['priority', 'count'];
        for (final field in intFields) {
          final value = map[field];
          map[field] = (value is int) ? value : (int.tryParse(value?.toString() ?? '0') ?? 0);
        }

        // Convert boolean fields (as int)
        final boolFieldsAsInt = ['isEnabled', 'isSubscribed'];
        for (final field in boolFieldsAsInt) {
          final value = map[field];
          if (value is bool) {
            map[field] = value ? 1 : 0;
          } else if (value is int) {
            // Do nothing, already correct type
          } else {
            final strValue = value?.toString().toLowerCase();
            if (strValue == 'true' || strValue == '1') {
              map[field] = 1;
            } else {
              map[field] = 0;
            }
          }
        }
        
        // Ensure required string fields are strings
        final stringFields = ['name', 'action', 'phoneNumber', 'labelId'];
        for (final field in stringFields) {
          map[field] = map[field]?.toString() ?? '';
        }

        // Provide defaults for empty required fields
        if ((map['name'] as String).isEmpty) map['name'] = 'Imported Rule $i';
        if ((map['action'] as String).isEmpty) map['action'] = 'none';
        if ((map['labelId'] as String).isEmpty) map['labelId'] = 'default';

        // Skip row if phone number is empty
        if ((map['phoneNumber'] as String).isEmpty) {
          debugPrint('[RuleImportExportService] Skipping row $i: phoneNumber is empty');
          continue;
        }

        // Ensure nullable fields are correct type
        map['avatar'] = map['avatar']?.toString();
        map['ruleType'] = map['ruleType']?.toString() ?? 'phone_rule';

        try {
          final rule = fromMap(map);
          rules.add(rule);
          debugPrint('[RuleImportExportService] Successfully parsed rule: ${rule.name}');
        } catch (e) {
          debugPrint('[RuleImportExportService] Error parsing row $i: $e, data: $map');
          continue;
        }
      }
      
      debugPrint('[RuleImportExportService] Total rules parsed: ${rules.length}');
      return rules;
    } catch (e) {
      debugPrint('[RuleImportExportService] CSV parsing error: $e');
      throw FormatException('CSV解析错误: $e');
    }
  }

  @override
  Future<List<RuleBase>> parseYamlData(String data) async {
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

  /// 从URL导入规则（在后台 Isolate 中进行耗时的数据解析，彻底解除对主 UI 线程的占用）
  Future<List<RuleBase>> importFromUrl(String url) async {
    try {
      debugPrint('[RuleImportExportService] >>> Importing from URL: $url');
      final response = await http.get(Uri.parse(url));
      debugPrint('[RuleImportExportService] <<< Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.body;
        debugPrint('[RuleImportExportService] ... Data downloaded (${data.length} bytes)');
        // 自动检测格式
        final format = detectFileFormat('', data);
        debugPrint('[RuleImportExportService] ... Detected format: $format');
        
        // 关键性能优化：在独立的后台 Isolate 中执行复杂的字符串与 JSON 解析，绝不占用/卡顿主 UI 线程！
        final rules = await Isolate.run(() async {
          return await parseImportData(data, format: format);
        });
        
        debugPrint('[RuleImportExportService] <<< Parsed ${rules.length} rules from URL data.');
        return rules;
      } else {
        debugPrint('[RuleImportExportService] !!! ERROR: Failed to fetch data from URL. Status code: ${response.statusCode}');
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('[RuleImportExportService] !!! ERROR: Error during import from URL: $e');
      rethrow;
    }
  }

  @override
  List<String> getEntityFieldNames() {
    // 动态获取字段名，避免硬编码
    // 创建一个示例实体并获取其所有字段
    final sampleEntity = ruleRepository.createEmptyRule();
    final map = sampleEntity.toMap();
    return map.keys.toList();
  }

  @override
  RuleBase fromMap(Map<String, dynamic> map) {
    return ruleRepository.createRuleFromMap(map);
  }

  @override
  Future<bool> validateImportData(List<RuleBase> entities) async {
    // 规则特定的验证逻辑
    for (final rule in entities) {
      if (rule.name.isEmpty) {
        return false; // 规则名称不能为空
      }
      
      // 获取规则的Map表示进行验证
      final map = rule.toMap();
      
      // 验证规则字段的完整性和有效性
      if (!map.containsKey('id') || !map.containsKey('name') || !map.containsKey('priority')) {
        return false;
      }
      
      // 验证动作类型是否有效
      if (map.containsKey('action')) {
        try {
          RuleAction.fromString(map['action'].toString());
        } catch (_) {
          return false;
        }
      }
      // 可以添加更多验证逻辑
    }
    return true;
  }
}

// 将YAML映射转换为普通Map
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

// 将YAML列表转换为普通List
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