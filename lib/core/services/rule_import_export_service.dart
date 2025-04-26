import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
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

  @override
  Future<List<RuleBase>> parseCsvData(String data) async {
    try {
      final rows = const CsvToListConverter().convert(data);
      if (rows.isEmpty) {
        return [];
      }
      
      // 第一行作为标题
      final headers = rows.first.map((e) => e.toString()).toList();
      
      // 转换数据行为规则实体
      final rules = <RuleBase>[];
      
      for (var i = 1; i < rows.length; i++) {
        final row = rows[i];
        if (row.length != headers.length) {
          continue; // 跳过格式不匹配的行
        }
        
        final map = <String, dynamic>{};
        for (var j = 0; j < headers.length; j++) {
          map[headers[j]] = _convertCsvValue(row[j]);
        }
        
        try {
          final rule = fromMap(map);
          rules.add(rule);
        } catch (e) {
          // 记录错误但继续处理其他行
          continue;
        }
      }
      
      return rules;
    } catch (e) {
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

  /// 从URL导入规则
  Future<List<RuleBase>> importFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        // 自动检测格式并解析
        final format = detectFileFormat('', data);
        final rules = await parseImportData(data, format: format);
        return await saveAll(rules);
      } else {
        throw Exception('获取URL数据失败: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('从URL导入失败: $e');
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