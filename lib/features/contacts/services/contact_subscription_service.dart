// 联系人订阅服务，用于处理联系人订阅

import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

import '../lib/core/base/base_entity.dart';
import '../lib/core/services/subscription_service_base.dart';

/// 联系人订阅实体
class ContactSubscription extends BaseEntity {
  final String name;
  final String url;
  final bool enabled;
  final DateTime lastUpdated;
  final bool autoUpdate;

  const ContactSubscription({
    required super.id,
    required this.name,
    required this.url,
    this.enabled = true,
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
      'lastUpdated': lastUpdated.toIso8601String(),
      'autoUpdate': autoUpdate ? 1 : 0,
    };
  }

  factory ContactSubscription.fromMap(Map<String, dynamic> map) {
    return ContactSubscription(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      enabled: map['enabled'] == 1 || map['enabled'] == true,
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated']) ?? DateTime.now()
          : DateTime.now(),
      autoUpdate: map['autoUpdate'] == 1 || map['autoUpdate'] == true,
    );
  }
}

/// 联系人订阅仓库接口
abstract class ContactSubscriptionRepository {
  Future<List<ContactSubscription>> getAll();
  Future<ContactSubscription?> getById(String id);
  Future<ContactSubscription?> getByUrl(String url);
  Future<ContactSubscription> save(ContactSubscription entity);
  Future<List<ContactSubscription>> saveAll(List<ContactSubscription> entities);
  Future<bool> delete(ContactSubscription entity);
  Future<bool> deleteById(String id);
  Future<bool> deleteAll(List<ContactSubscription> entities);
  Future<bool> exists(String id);
  Future<void> updateLastUpdated(String id, DateTime time);
}

/// 联系人订阅服务
/// 处理联系人订阅功能
class ContactSubscriptionService extends SubscriptionServiceBase<ContactSubscription, String> {
  final ContactSubscriptionRepository _repository;

  ContactSubscriptionService(this._repository) : super(_repository);

  @override
  Future<List<ContactSubscription>> getEnabledSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.enabled).toList();
  }

  @override
  Future<void> enableSubscription(ContactSubscription subscription) async {
    subscription = ContactSubscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      enabled: true,
      lastUpdated: subscription.lastUpdated,
      autoUpdate: subscription.autoUpdate,
    );
    await save(subscription);
  }

  @override
  Future<void> disableSubscription(ContactSubscription subscription) async {
    subscription = ContactSubscription(
      id: subscription.id,
      name: subscription.name,
      url: subscription.url,
      enabled: false,
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
  Future<ContactSubscription?> getSubscriptionByUrl(String url) async {
    return await _repository.getByUrl(url);
  }

  @override
  Future<void> autoUpdateSubscription(ContactSubscription subscription) async {
    if (!subscription.enabled) return;

    // 实现自动更新逻辑
    await manualUpdateSubscription(subscription);

    // 更新最后更新时间
    await _repository.updateLastUpdated(subscription.id, DateTime.now());
  }

  @override
  Future<void> manualUpdateSubscription(ContactSubscription subscription) async {
    if (!subscription.enabled) return;

    // 实现手动更新逻辑
    try {
      final data = await fetchData(subscription.url);
      final parsedData = parseData(data, subscription.url);
      
      // 这里应该调用联系人服务进行导入
      // 由于依赖于具体实现，这里只是占位
      
      // 更新最后更新时间
      await _repository.updateLastUpdated(subscription.id, DateTime.now());
    } catch (e) {
      throw Exception('Failed to update contact subscription: $e');
    }
  }

  @override
  Future<void> importSubscriptionsFromUrl(String url) async {
    try {
      final data = await fetchData(url);
      final parsedData = parseData(data, url);
      
      for (final item in parsedData) {
        final subscription = ContactSubscription.fromMap(item);
        await save(subscription);
      }
    } catch (e) {
      throw Exception('Failed to import contact subscriptions from URL: $e');
    }
  }

  @override
  Future<void> importSubscriptionsFromLocalFile(String filePath) async {
    try {
      final data = await File(filePath).readAsString();
      final parsedData = parseData(data, filePath);
      
      for (final item in parsedData) {
        final subscription = ContactSubscription.fromMap(item);
        await save(subscription);
      }
    } catch (e) {
      throw Exception('Failed to import contact subscriptions from file: $e');
    }
  }

  @override
  Future<void> exportSubscriptionsToCsv(List<ContactSubscription> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/contact_subscriptions_$dateStr.csv';

    final csvData = _generateCsvData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(csvData);
  }

  @override
  Future<void> exportSubscriptionsToJson(List<ContactSubscription> subscriptions, String directoryPath) async {
    final now = DateTime.now();
    final dateStr = now.toString().split(' ')[0];
    final filePath = '$directoryPath/contact_subscriptions_$dateStr.json';

    final jsonData = _generateJsonData(subscriptions);

    final file = File(filePath);
    await file.writeAsString(jsonData);
  }

  String _generateCsvData(List<ContactSubscription> subscriptions) {
    return const ListToCsvConverter().convert([
      // 表头
      ['id', 'name', 'url', 'enabled', 'lastUpdated', 'autoUpdate'],
      // 数据行
      ...subscriptions.map((subscription) => [
        subscription.id,
        subscription.name,
        subscription.url,
        subscription.enabled ? '1' : '0',
        subscription.lastUpdated.toIso8601String(),
        subscription.autoUpdate ? '1' : '0'
      ])
    ]);
  }

  String _generateJsonData(List<ContactSubscription> subscriptions) {
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
        'lastUpdated': parts.length > 4 ? parts[4].toString() : DateTime.now().toIso8601String(),
        'autoUpdate': parts.length > 5 && parts[5].toString() == '1',
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
        'lastUpdated': parts.length > 4 ? parts[4].toString() : DateTime.now().toIso8601String(),
        'autoUpdate': parts.length > 5 && parts[5].toString() == '1',
      };
    }).toList();
  }
}