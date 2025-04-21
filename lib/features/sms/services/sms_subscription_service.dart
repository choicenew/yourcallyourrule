// 短信订阅服务，用于处理短信黑白名单和文本规则订阅

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

import '../../../core/base/base_entity.dart';
import '../../../core/services/subscription_service_base.dart';

/// 短信订阅实体
class SmsSubscription extends BaseEntity {
  final String name;
  final String url;
  final bool enabled;
  final bool isWhitelist;
  final bool isBlacklist;
  final bool isNumberType; // 是否为号码类型（否则为文本类型）
  final DateTime lastUpdated;
  final bool autoUpdate;

  const SmsSubscription({
    required super.id,
    required this.name,
    required this.url,
    this.enabled = true,
    this.isWhitelist = false,
    this.isBlacklist = false,
    this.isNumberType = true,
    required this.lastUpdated,
    this.autoUpdate = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'enabled': enabled ? 1 : 0,
      'isWhitelist': isWhitelist ? 1 : 0,
      'isBlacklist': isBlacklist ? 1 : 0,
      'isNumberType': isNumberType ? 1 : 0,
      'lastUpdated': lastUpdated.toIso8601String(),
      'autoUpdate': autoUpdate ? 1 : 0,
    };
  }

  factory SmsSubscription.fromMap(Map<String, dynamic> map) {
    return SmsSubscription(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      enabled: map['enabled'] == 1 || map['enabled'] == true,
      isWhitelist: map['isWhitelist'] == 1 || map['isWhitelist'] == true,
      isBlacklist: map['isBlacklist'] == 1 || map['isBlacklist'] == true,
      isNumberType: map['isNumberType'] == 1 || map['isNumberType'] == true,
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated']) ?? DateTime.now()
          : DateTime.now(),
      autoUpdate: map['autoUpdate'] == 1 || map['autoUpdate'] == true,
    );
  }
}

/// 短信订阅仓库接口
abstract class SmsSubscriptionRepository {
  Future<List<SmsSubscription>> getAll();
  Future<SmsSubscription?> getById(String id);
  Future<SmsSubscription?> getByUrl(String url);
  Future<SmsSubscription> save(SmsSubscription entity);
  Future<List<SmsSubscription>> saveAll(List<SmsSubscription> entities);
  Future<bool> delete(SmsSubscription entity);
  Future<bool> deleteById(String id);
  Future<bool> deleteAll(List<SmsSubscription> entities);
  Future<bool> exists(String id);
  Future<void> updateLastUpdated(String id, DateTime time);
}

/// 短信订阅服务
/// 处理短信黑白名单和文本规则订阅功能
class SmsSubscriptionService extends SubscriptionServiceBase<SmsSubscription, String> {
  final SmsSubscriptionRepository _repository;

  SmsSubscriptionService(this._repository) : super(_repository);

  @override
  Future<List<SmsSubscription>> getEnabledSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.enabled).toList();
  }

  /// 获取白名单订阅
  Future<List<SmsSubscription>> getWhitelistSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isWhitelist).toList();
  }

  /// 获取黑名单订阅
  Future<List<SmsSubscription>> getBlacklistSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isBlacklist).toList();
  }

  /// 获取号码类型订阅
  Future<List<SmsSubscription>> getNumberTypeSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isNumberType).toList();
  }

  /// 获取文本类型订阅
  Future<List<SmsSubscription>> getTextTypeSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => !subscription.isNumberType).toList();
  }

  @override
  Future<void> enableSubscription(SmsSubscription subscription) async {
    subscription = SmsSubscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      enabled: true,
      isWhitelist: subscription.isWhitelist,
      isBlacklist: subscription.isBlacklist,
      isNumberType: subscription.isNumberType,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    await save(subscription);
  }

  @override
  Future<void> disableSubscription(SmsSubscription subscription) async {
    subscription = SmsSubscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      enabled: false,
      isWhitelist: subscription.isWhitelist,
      isBlacklist: subscription.isBlacklist,
      isNumberType: subscription.isNumberType,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    await save(subscription);
  }

  @override
  Future<bool> urlExists(String url) async {
    return await getSubscriptionByUrl(url) != null;
  }

  @override
  Future<SmsSubscription?> getSubscriptionByUrl(String url) async {
    return await _repository.getByUrl(url);
  }

  /// 添加白名单订阅
  Future<SmsSubscription> addWhitelistSubscription(SmsSubscription subscription, {bool isNumberType = true}) async {
    subscription = SmsSubscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      enabled: subscription.enabled,
      isWhitelist: true,
      isBlacklist: false,
      isNumberType: isNumberType,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    return await save(subscription);
  }

  /// 添加黑名单订阅
  Future<SmsSubscription> addBlacklistSubscription(SmsSubscription subscription, {bool isNumberType = true}) async {
    subscription = SmsSubscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      enabled: subscription.enabled,
      isWhitelist: false,
      isBlacklist: true,
      isNumberType: isNumberType,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    return await save(subscription);
  }

  @override
  Future<void> autoUpdateSubscription(SmsSubscription subscription) async {
    if (!subscription.enabled) return;

    // 实现自动更新逻辑
    await manualUpdateSubscription(subscription);

    // 更新最后更新时间
    await _repository.updateLastUpdated(subscription.id, DateTime.now());
  }

  @override
  Future<void> manualUpdateSubscription(SmsSubscription subscription) async {
    if (!subscription.enabled) return;

    // 实现手动更新逻辑
    try {
      final data = await fetchData(subscription.url);
      final parsedData = parseData(data, subscription.url);
      
      // 这里应该根据订阅类型调用相应的短信黑白名单或文本规则服务进行导入
      // 由于依赖于具体实现，这里只是占位
      
      // 更新最后更新时间
      await _repository.updateLastUpdated(subscription.id, DateTime.now());
    } catch (e) {
      throw Exception('Failed to update SMS subscription: $e');
    }
  }

  @override
  Future<void> importSubscriptionsFromUrl(String url) async {
    try {
      final data = await fetchData(url);
      final parsedData = parseData(data, url);
      
      for (final item in parsedData) {
        final subscription = SmsSubscription.fromMap(item);
        await save(subscription);
      }
    } catch (e) {
      throw Exception('Failed to import SMS subscriptions from URL: $e');
    }
  }

  @override
  Future<void> importSubscriptionsFromLocalFile(String filePath) async {
    try {
      final data = await File(filePath).readAsString();
      final parsedData = parseData(data, filePath);
      
      for (final item in parsedData) {
        final subscription = SmsSubscription.fromMap(item);
        await save(subscription);
      }
    } catch (e) {
      throw Exception('Failed to import SMS subscriptions from file: $e');
    }
  }

  @override
  Future<void> exportSubscriptionsToCsv(List<SmsSubscription> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/sms_subscriptions_$dateStr.csv';

    final csvData = _generateCsvData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  @override
  Future<void> exportSubscriptionsToJson(List<SmsSubscription> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/sms_subscriptions_$dateStr.json';

    final jsonData = _generateJsonData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  String _generateCsvData(List<SmsSubscription> subscriptions) {
    return const ListToCsvConverter().convert([
      // 表头
      ['id', 'name', 'url', 'enabled', 'isWhitelist', 'isBlacklist', 'isNumberType', 'lastUpdated', 'autoUpdate'],
      // 数据行
      ...subscriptions.map((subscription) => [
        subscription.id,
        subscription.name,
        subscription.url,
        subscription.enabled ? '1' : '0',
        subscription.isWhitelist ? '1' : '0',
        subscription.isBlacklist ? '1' : '0',
        subscription.isNumberType ? '1' : '0',
        subscription.lastUpdated.toIso8601String(),
        subscription.autoUpdate ? '1' : '0'
      ])
    ]);
  }

  String _generateJsonData(List<SmsSubscription> subscriptions) {
    final listOfMaps = subscriptions.map((subscription) => subscription.toMap()).toList();
    return jsonEncode(listOfMaps);
  }

  @override
  List<Map<String, dynamic>> parseCsvData(String data) {
    final csvList = const CsvToListConverter().convert(data);
    // 跳过表头行
    return csvList.skip(1).map((parts) {
      return {
        'id': parts.isNotEmpty ? parts[0].toString() : null,
        'name': parts.length > 1 ? parts[1].toString() : null,
        'url': parts.length > 2 ? parts[2].toString() : null,
        'enabled': parts.length > 3 && parts[3].toString() == '1',
        'isWhitelist': parts.length > 4 && parts[4].toString() == '1',
        'isBlacklist': parts.length > 5 && parts[5].toString() == '1',
        'isNumberType': parts.length > 6 && parts[6].toString() == '1',
        'lastUpdated': parts.length > 7 ? parts[7].toString() : DateTime.now().toIso8601String(),
        'autoUpdate': parts.length > 8 && parts[8].toString() == '1',
      };
    }).toList();
  }

  @override
  List<Map<String, dynamic>> parseTxtData(String data) {
    final lines = data.split('\n');
    return lines.map((line) {
      final parts = line.split(',');
      return {
        'id': parts.isNotEmpty ? parts[0].toString() : null,
        'name': parts.length > 1 ? parts[1].toString() : null,
        'url': parts.length > 2 ? parts[2].toString() : null,
        'enabled': parts.length > 3 && parts[3].toString() == '1',
        'isWhitelist': parts.length > 4 && parts[4].toString() == '1',
        'isBlacklist': parts.length > 5 && parts[5].toString() == '1',
        'isNumberType': parts.length > 6 && parts[6].toString() == '1',
        'lastUpdated': parts.length > 7 ? parts[7].toString() : DateTime.now().toIso8601String(),
        'autoUpdate': parts.length > 8 && parts[8].toString() == '1',
      };
    }).toList();
  }
}