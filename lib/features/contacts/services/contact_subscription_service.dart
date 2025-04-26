import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yourcallyourrule/core/base/base_service.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_rule.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/services/rule_import_export_service.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/core/services/subscription_service_base.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';

class ContactSubscriptionService
    extends SubscriptionServiceBase<ContactSubscription, String> {
  final ContactSubscriptionRepository _repository;
  final RuleRepository _ruleRepository;
  final ContactRepository _contactRepository; // Add missing repository
  final RuleImportExportService _ruleImportExportService;

  ContactSubscriptionService(
    this._repository,
    this._ruleRepository,
    this._contactRepository, // Initialize new dependency
  )   : _ruleImportExportService = RuleImportExportService(_ruleRepository),
        super(_repository);

  @override
  Future<List<ContactSubscription>> getEnabledSubscriptions() async {
    final all = await _repository.getAll();
    return all.where((s) => s.isEnabled).toList();
  }

  @override
  Future<void> enableSubscription(ContactSubscription subscription) async {
    await _repository.save(subscription.copyWith(isEnabled: true));
  }

  @override
  Future<void> disableSubscription(ContactSubscription subscription) async {
    await _repository.save(subscription.copyWith(isEnabled: false));
  }

  @override
  Future<ContactSubscription> addSubscription(String name, String url,
      {bool isEnabled = true}) async {
    final newSubscription = ContactSubscription(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      url: Url.fromString(url),
      isEnabled: isEnabled,
      lastUpdated: DateTime.now(),
      autoUpdate: false,
    );
    return _repository.save(newSubscription);
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    return _repository.clearExpiredSubscriptions();
  }

  @override
  Future<bool> deleteSubscription(String id) async {
    return _repository.deleteById(id);
  }

  @override
  Future<List<ContactSubscription>> getPendingUpdateSubscriptions() async {
    return _repository.getPendingUpdateSubscriptions();
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {
    await _repository.updateLastUpdated(id, time);
  }

  @override
  Future<ContactSubscription> updateSubscription(
      ContactSubscription subscription) async {
    return _repository.save(subscription);
  }

  /// 核心规则更新方法（修正后的联系人专用逻辑） （修正类型转换）
  Future<List<ContactRule>> _updateRulesCore(
      ContactSubscription subscription) async {
    final data = await downloadFromUrl(subscription.url.toString());
    final rules = await _ruleImportExportService.parseImportData(data);

    final processedRules = rules
        .whereType<ContactRule>()
        .map((rule) =>
            rule.copyWith(isSubscribed: true, contactId: rule.contactId))
        .toList();

    await _ruleRepository.saveAll(processedRules);
    return processedRules;
  }

  /// 自动更新（带时间戳更新）
  Future<List<RuleBase>> updateRulesFromSubscription(
      ContactSubscription subscription) async {
    try {
      final result = await _updateRulesCore(subscription);
      await updateLastUpdated(subscription.id, DateTime.now());
      return result;
    } catch (e) {
      throw Exception('更新联系人订阅规则失败: $e');
    }
  }

  /// 手动更新（不带时间戳更新）
  Future<List<RuleBase>> manualUpdateRulesFromSubscription(
      ContactSubscription subscription) async {
    try {
      return await _updateRulesCore(subscription);
    } catch (e) {
      throw Exception('手动更新联系人规则失败: $e');
    }
  }

  Future<void> performAutoUpdate(ContactSubscription subscription) async {
    if (!subscription.isEnabled || !subscription.autoUpdate) return;

    await _updateContactData(subscription);
    await _repository.updateLastUpdated(subscription.id, DateTime.now());
  }

  Future<void> performManualUpdate(ContactSubscription subscription) async {
    if (!subscription.isEnabled) return;
    await _updateContactData(subscription);
  }

  Future<void> _updateContactData(ContactSubscription subscription) async {
    try {
      final data = await downloadFromUrl(subscription.url.toString());
      final contacts = await _parseContactData(data); // 修正方法名
      await _importContacts(contacts); // 添加联系人导入逻辑
    } catch (e) {
      throw Exception('数据更新失败: ${e.toString()}');
    }
  }

  // 添加联系人数据解析方法
  Future<List<Contact>> _parseContactData(String data) async {
    try {
      final jsonList = jsonDecode(data) as List<dynamic>;
      return jsonList.map((item) => Contact.fromMap(item)).toList();
    } catch (e) {
      throw FormatException('联系人数据解析失败: $e');
    }
  }

  // 添加联系人导入方法
  Future<void> _importContacts(List<Contact> contacts) async {
    final contactService = ContactService(
      _contactRepository,
    );

    await contactService.addOrUpdateContacts(contacts);
  }

  Future<List<ContactSubscription>> getAutoUpdateSubscriptions() async {
    return (await _repository.getAll())
        .where((s) => s.autoUpdate)
        .toList(); // 修正自动更新查询逻辑
  }

  Future<bool> urlExists(String url) async {
    return await getSubscriptionByUrl(url) != null;
  }

  Future<ContactSubscription?> getSubscriptionByUrl(String url) async {
    return _repository.getByUrl(url);
  }
}
