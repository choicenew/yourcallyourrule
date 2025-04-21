// 订阅服务基类，用于处理各种类型的订阅功能

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:yaml/yaml.dart';

import '../base/base_entity.dart';
import '../base/base_service.dart';
import '../repositories/base_repository.dart';

/// 订阅服务基类
/// [T] 是订阅实体类型
/// [ID] 是实体ID类型
abstract class SubscriptionServiceBase<T extends BaseEntity, ID> extends BaseService<T, ID> {
  const SubscriptionServiceBase(super.repository);

  /// 获取所有启用的订阅
  Future<List<T>> getEnabledSubscriptions();
  
  /// 添加订阅
  Future<T> addSubscription(T subscription) => save(subscription);

  /// 编辑订阅
  Future<T> editSubscription(T subscription) => save(subscription);

  /// 删除订阅
  Future<bool> deleteSubscription(T subscription) => delete(subscription);

  /// 删除订阅（通过ID）
  Future<bool> deleteSubscriptionById(ID id) => deleteById(id);

  /// 启用订阅
  Future<void> enableSubscription(T subscription);

  /// 禁用订阅
  Future<void> disableSubscription(T subscription);

  /// 检查URL是否已存在
  Future<bool> urlExists(String url);

  /// 根据URL获取订阅
  Future<T?> getSubscriptionByUrl(String url);

  /// 自动更新订阅
  Future<void> autoUpdateSubscription(T subscription);

  /// 手动更新订阅
  Future<void> manualUpdateSubscription(T subscription);

  /// 从URL导入订阅
  Future<void> importSubscriptionsFromUrl(String url);

  /// 从本地文件导入订阅
  Future<void> importSubscriptionsFromLocalFile(String filePath);

  /// 导出订阅到CSV
  Future<void> exportSubscriptionsToCsv(List<T> subscriptions, String directoryPath);

  /// 导出订阅到JSON
  Future<void> exportSubscriptionsToJson(List<T> subscriptions, String directoryPath);

  /// 从URL获取数据
  Future<String> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data from $url: ${response.statusCode}');
    }
  }

  /// 解析数据（根据文件类型）
  List<Map<String, dynamic>> parseData(String data, String source) {
    if (source.endsWith('.csv')) return parseCsvData(data);
    if (source.endsWith('.json')) return parseJsonData(data);
    if (source.endsWith('.txt')) return parseTxtData(data);
    if (source.endsWith('.yaml') || source.endsWith('.yml')) return parseYamlData(data);
    throw UnsupportedError('Unsupported file format: $source');
  }

  /// 解析CSV数据
  List<Map<String, dynamic>> parseCsvData(String data);

  /// 解析JSON数据
  List<Map<String, dynamic>> parseJsonData(String data) {
    final jsonData = jsonDecode(data);
    if (jsonData is List) {
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw const FormatException('Unexpected JSON format: expected a list');
    }
  }

  /// 解析TXT数据
  List<Map<String, dynamic>> parseTxtData(String data);

  /// 解析YAML数据
  List<Map<String, dynamic>> parseYamlData(String data) {
    final yamlData = loadYaml(data);
    if (yamlData is List) {
      return List<Map<String, dynamic>>.from(
        yamlData.map((item) => Map<String, dynamic>.from(item)),
      );
    } else {
      throw const FormatException('Unexpected YAML format: expected a list');
    }
  }
}