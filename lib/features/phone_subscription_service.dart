// 电话规则订阅服务，用于处理电话黑白名单订阅

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

import '../core/entities/subscription/subscription.dart';
import '../core/repositories/subscription_repository.dart';
import '../core/services/subscription_service_base.dart';

/// 电话规则订阅服务
/// 处理电话黑白名单的订阅功能
class PhoneSubscriptionService extends SubscriptionServiceBase<Subscription, String> {
  final SubscriptionRepository _repository;

  PhoneSubscriptionService(this._repository) : super(_repository);

  @override
  Future<List<Subscription>> getEnabledSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isEnabled).toList();
  }

  /// 获取白名单订阅
  Future<List<Subscription>> getWhitelistSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isWhitelist).toList();
  }

  /// 获取黑名单订阅
  Future<List<Subscription>> getBlacklistSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isBlacklist).toList();
  }

  @override
  Future<void> enableSubscription(Subscription subscription) async {
    subscription = Subscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      isEnabled: true,
      isWhitelist: subscription.isWhitelist,
      isBlacklist: subscription.isBlacklist,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    await save(subscription);
  }

  @override
  Future<void> disableSubscription(Subscription subscription) async {
    subscription = Subscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      isEnabled: false,
      isWhitelist: subscription.isWhitelist,
      isBlacklist: subscription.isBlacklist,
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
  Future<Subscription?> getSubscriptionByUrl(String url) async {
    return await _repository.getByUrl(url);
  }

  /// 添加白名单订阅
  Future<Subscription> addWhitelistSubscription(Subscription subscription) async {
    subscription = Subscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      isEnabled: subscription.isEnabled,
      isWhitelist: true,
      isBlacklist: false,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    return await save(subscription);
  }

  /// 添加黑名单订阅
  Future<Subscription> addBlacklistSubscription(Subscription subscription) async {
    subscription = Subscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      isEnabled: subscription.isEnabled,
      isWhitelist: false,
      isBlacklist: true,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    return await save(subscription);
  }

  @override
  Future<void> autoUpdateSubscription(Subscription subscription) async {
    if (!subscription.isEnabled) return;

    // 实现自动更新逻辑
    // 根据订阅类型调用相应的导入服务
    await manualUpdateSubscription(subscription);

    // 更新最后更新时间
    await _repository.updateLastUpdated(subscription.id, DateTime.now());
  }

  @override
  Future<void> manualUpdateSubscription(Subscription subscription) async {
    if (!subscription.isEnabled) return;

    // 实现手动更新逻辑
    // 根据订阅类型调用相应的导入服务
    try {
      final data = await fetchData(subscription.url.toString());
      final parsedData = parseData(data, subscription.url.toString());
      
      // 这里应该调用相应的黑白名单服务进行导入
      // 由于依赖于具体实现，这里只是占位
      // 实际实现时需要注入相应的服务
      
      // 更新最后更新时间
      await _repository.updateLastUpdated(subscription.id, DateTime.now());
    } catch (e) {
      // 处理错误
      throw Exception('Failed to update subscription: $e');
    }
  }

  @override
  Future<void> importSubscriptionsFromUrl(String url) async {
    try {
      final data = await fetchData(url);
      final parsedData = parseData(data, url);
      
      // 处理解析后的数据，创建订阅实体并保存
      for (final item in parsedData) {
        final subscription = Subscription.fromMap(item);
        await save(subscription);
      }
    } catch (e) {
      throw Exception('Failed to import subscriptions from URL: $e');
    }
  }

  @override
  Future<void> importSubscriptionsFromLocalFile(String filePath) async {
    try {
      final data = await File(filePath).readAsString();
      final parsedData = parseData(data, filePath);
      
      // 处理解析后的数据，创建订阅实体并保存
      for (final item in parsedData) {
        final subscription = Subscription.fromMap(item);
        await save(subscription);
      }
    } catch (e) {
      throw Exception('Failed to import subscriptions from file: $e');
    }
  }

  @override
  Future<void> exportSubscriptionsToCsv(List<Subscription> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/phone_subscriptions_$dateStr.csv';

    final csvData = _generateCsvData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  @override
  Future<void> exportSubscriptionsToJson(List<Subscription> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/phone_subscriptions_$dateStr.json';

    final jsonData = _generateJsonData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  String _generateCsvData(List<Subscription> subscriptions) {
    return const ListToCsvConverter().convert([
      // 表头
      ['id', 'name', 'url', 'isEnabled', 'isWhitelist', 'isBlacklist', 'lastUpdated', 'autoUpdate'],
      // 数据行
      ...subscriptions.map((subscription) => [
        subscription.id,
        subscription.name,
        subscription.url.toString(),
        subscription.isEnabled ? '1' : '0',
        subscription.isWhitelist ? '1' : '0',
        subscription.isBlacklist ? '1' : '0',
        subscription.lastUpdated.toIso8601String(),
        subscription.autoUpdate ? '1' : '0'
      ])
    ]);
  }

  String _generateJsonData(List<Subscription> subscriptions) {
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
        'isEnabled': parts.length > 3 && parts[3].toString() == '1',
        'isWhitelist': parts.length > 4 && parts[4].toString() == '1',
        'isBlacklist': parts.length > 5 && parts[5].toString() == '1',
        'lastUpdated': parts.length > 6 ? parts[6].toString() : DateTime.now().toIso8601String(),
        'autoUpdate': parts.length > 7 && parts[7].toString() == '1',
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
        'isEnabled': parts.length > 3 && parts[3].toString() == '1',
        'isWhitelist': parts.length > 4 && parts[4].toString() == '1',
        'isBlacklist': parts.length > 5 && parts[5].toString() == '1',
        'lastUpdated': parts.length > 6 ? parts[6].toString() : DateTime.now().toIso8601String(),
        'autoUpdate': parts.length > 7 && parts[7].toString() == '1',
      };
    }).toList();
  }
}