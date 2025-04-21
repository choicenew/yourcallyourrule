import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

import '../../base/base_entity.dart';
import '../../entities/rule/rule_base.dart';
import '../../repositories/rule_repository.dart';
import '../import_export_service.dart';

/// 规则导入导出服务
/// 提供规则数据的导入导出功能
class RuleImportExportService extends ImportExportService<RuleBase, String> {
  RuleImportExportService(RuleRepository super.repository);

  @override
  Future<String> prepareDataForExport(List<RuleBase> entities) async {
    final dataList = entities.map((e) => e.toMap()).toList();
    return jsonEncode(dataList);
  }

  @override
  Future<List<RuleBase>> parseImportData(String data) async {
    try {
      // 增强格式检测逻辑
      if (data.trim().startsWith('---')) { // YAML文档分隔符
        return _parseYamlData(data);
      } else if (data.trim().startsWith('[') || data.trim().startsWith('{')) {
        return _parseJsonData(data);
      } else if (data.contains(',')) {
        return _parseCsvData(data);
      } else {
        throw const FormatException('不支持的数据格式');
      }
    } catch (e) {
      throw FormatException('解析导入数据失败: $e');
    }
  }




















  @override
  Future<void> writeDataToFile(String filePath, String data) async {
    final file = File(filePath);
    await file.writeAsString(data);
  }

  @override
  Future<String> readDataFromFile(String filePath) async {
    final file = File(filePath);
    return await file.readAsString();
  }

  /// 从URL导入规则
  Future<List<RuleBase>> importFromUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        final rules = await parseImportData(data);
        return await saveAll(rules);
      } else {
        throw Exception('获取URL数据失败: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('从URL导入失败: $e');
    }
  }

  // 解析JSON数据
  List<RuleBase> _parseJsonData(String data) {
    final List<dynamic> jsonList = jsonDecode(data);
    final repository = this.repository as RuleRepository;
    return jsonList.map((json) => repository.createRuleFromMap(json)).toList();
  }

  // 解析CSV数据
  List<RuleBase> _parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    final repository = this.repository as RuleRepository;
    
    // 假设第一行是标题
    final headers = csvList.isNotEmpty ? csvList[0] : [];
    
    return csvList.skip(1).map((row) {
      final map = <String, dynamic>{};
      for (int i = 0; i < headers.length && i < row.length; i++) {
        map[headers[i].toString()] = row[i];
      }
      return repository.createRuleFromMap(map);
    }).toList();
  }

  // 新增YAML解析方法
  List<RuleBase> _parseYamlData(String data) {
    final yamlDocs = loadYamlDocuments(data);
    final repository = this.repository as RuleRepository;
    
    return yamlDocs.map((doc) {
      final yamlMap = doc.contents.value as YamlMap;
      return repository.createRuleFromMap(_convertYamlMap(yamlMap));
    }).toList();
  }

  // 转换YAML结构
  Map<String, dynamic> _convertYamlMap(YamlMap yamlMap) {
    final map = <String, dynamic>{};
    yamlMap.nodes.forEach((key, value) {
      map[key.toString()] = _convertYamlValue(value);
    });
    return map;
  }

  // 新增YAML值转换方法
  dynamic _convertYamlValue(YamlNode node) {
    if (node is YamlMap) {
      return _convertYamlMap(node);
    } else if (node is YamlList) {
      return node.nodes.map(_convertYamlValue).toList();
    } else if (node is YamlScalar) {
      // 处理特殊类型转换
      final value = node.value;
      if (value is String) {
        // 尝试解析为DateTime
        try {
          return DateTime.parse(value);
        } catch (_) {}
        // 尝试解析为bool
        if (value.toLowerCase() == 'true') return true;
        if (value.toLowerCase() == 'false') return false;
        // 尝试解析为数字
        final numValue = num.tryParse(value);
        return numValue ?? value;
      }
      return value;
    }
    return node.toString();
  }

}