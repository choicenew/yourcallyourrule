import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/core/base/base_service.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';


import 'package:yourcallyourrule/core/services/import_export_service.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/core/services/subscription_service_base.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';

class ContactSubscriptionService extends SubscriptionServiceBase<ContactSubscription, String> {
  final ContactSubscriptionRepository _repository;
  final RuleRepository _ruleRepository;
  final RuleImportExportService _ruleImportExportService;

  ContactSubscriptionService(
    this._repository,
    this._ruleRepository,
  ) : _ruleImportExportService = RuleImportExportService(_ruleRepository),
      super(_repository);

  @override
  Future<List<ContactSubscription>> getEnabledSubscriptions() async {
    final allSubscriptions = await getAll();
    return allSubscriptions.where((subscription) => subscription.isEnabled).toList();
  }

  @override
  Future<void> enableSubscription(ContactSubscription subscription) async {
    subscription = subscription.copyWith(isEnabled: true);
    await save(subscription);
  }

  @override
  Future<void> disableSubscription(ContactSubscription subscription) async {
    subscription = subscription.copyWith(isEnabled: false);
    await save(subscription);
  }

  @override
  Future<ContactSubscription> addSubscription(String name, String url, {bool isEnabled = true}) async {
    final subscription = ContactSubscription(
      id: '',
      name: name,
      url: Url.fromString(url),
      isEnabled: isEnabled,
      lastUpdated: DateTime.now(),
      autoUpdate: false,
    );
    return await save(subscription);
  }

  Future<List<RuleBase>> _updateRulesCore(ContactSubscription subscription) async {
    final data = await downloadFromUrl(subscription.url.toString());
    final rules = await _ruleImportExportService.parseImportData(data);
    
    final processedRules = rules.map((rule) => rule.copyWith(
      isSubscribed: true
    )).toList();
    
    await _ruleRepository.saveAll(processedRules);
    return processedRules;
  }

  Future<List<RuleBase>> updateRulesFromSubscription(ContactSubscription subscription) async {
    try {
      final result = await _updateRulesCore(subscription);
      await updateLastUpdated(subscription.id, DateTime.now());
      return result;
    } catch (e) {
      throw Exception('更新订阅规则失败: $e');
    }
  }

  Future<List<RuleBase>> manualUpdateRulesFromSubscription(ContactSubscription subscription) async {
    try {
      return await _updateRulesCore(subscription);
    } catch (e) {
      throw Exception('手动更新规则失败: $e');
    }
  }

  Future<void> autoUpdateSubscription(ContactSubscription subscription) async {
    if (!subscription.isEnabled || !subscription.autoUpdate) return;
    
    await _updateSubscriptionCore(subscription);
    await _repository.updateLastUpdated(subscription.id, DateTime.now());
  }

  Future<void> manualUpdateSubscription(ContactSubscription subscription) async {
    if (!subscription.isEnabled) return;
    await _updateSubscriptionCore(subscription);
  }

  Future<void> _updateSubscriptionCore(ContactSubscription subscription) async {
    try {
      final data = await fetchData(subscription.url);
      final parsedData = await parseData(data, subscription.url);
      
      // 实际联系人导入逻辑
      // ...
    } catch (e) {
      throw Exception('订阅更新失败: $e');
    }
  }

  Future<List<ContactSubscription>> getEnabledSubscriptions() async {
    return await _repository.getAllEnabled();
  }

  Future<List<ContactSubscription>> getAutoUpdateSubscriptions() async {
    return await _repository.getAllAutoUpdate();
  }

  Future<bool> urlExists(String url) async {
    return await getSubscriptionByUrl(url) != null;
  }

  Future<ContactSubscription?> getSubscriptionByUrl(String url) async {
    return await _repository.getByUrl(url);
  }

  Future<void> autoUpdateSubscription(String id) async {
    final subscription = await _repository.getRuleById(id) as ContactSubscription?;
    if (subscription == null || !subscription.isEnabled) return;

    // 实现自动更新逻辑
    await manualUpdateSubscription(id);

    // 更新最后更新时间
    await _repository.updateLastUpdated(id, DateTime.now());
  }

  Future<void> manualUpdateSubscription(String id) async {
    final subscription = await _repository.getRuleById(id) as ContactSubscription?;
    if (subscription == null || !subscription.isEnabled) return;

    // 实现手动更新逻辑
    try {
      final data = await fetchData(subscription.url);
      final parsedData = await parseData(data, subscription.url);
      
      // 这里应该调用联系人服务进行导入
      // 由于依赖于具体实现，这里只是占位
      
      // 更新最后更新时间
      await _repository.updateLastUpdated(id, DateTime.now());
    } catch (e) {
      throw Exception('更新联系人订阅失败: $e');
    }
  }

  Future<List<RuleBase>> importSubscriptionsFromUrl(String url, {ImportMode mode = ImportMode.merge}) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = response.body;
        // 使用通用导入服务解析数据
        final format = _importExportService.detectFileFormat('', data);
        final rules = await _importExportService.parseImportData(data, format: format);
        
        // 根据模式保存规则
        if (mode == ImportMode.overwrite) {
          // 删除所有现有订阅
          final existingRules = await _repository.getAll();
          await _repository.deleteAll(existingRules);
        }
        
        return await _repository.saveAll(rules);
      } else {
        throw Exception('获取URL数据失败: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('从URL导入联系人订阅失败: $e');
    }
  }

  Future<List<RuleBase>> importSubscriptionsFromFile(String filePath, {ImportMode mode = ImportMode.merge}) async {
    return await _importExportService.importFromFile(filePath, mode: mode);
  }

  Future<bool> exportSubscriptionsToCsv(String filePath) async {
    final subscriptions = await _repository.getAll();
    return await _importExportService.exportToFile(filePath, entities: subscriptions);
  }

  Future<bool> exportSubscriptionsToJson(String filePath) async {
    final subscriptions = await _repository.getAll();
    return await _importExportService.exportToFile(filePath, entities: subscriptions);
  }

  Future<String> fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('获取数据失败: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> parseData(String data, String source) async {
    // 检测数据格式并解析
    final format = _importExportService.detectFileFormat(source, data);
    final rules = await _importExportService.parseImportData(data, format: format);
    
    // 转换为Map列表
    return rules.map((rule) => rule.toMap()).toList();
  }
}