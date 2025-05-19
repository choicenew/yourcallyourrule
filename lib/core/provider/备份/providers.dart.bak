import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/entities/list/list_entry.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/core/entities/phone/phone_entry.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';
import 'package:yourcallyourrule/core/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/core/repositories/location_repository.dart';
import 'package:yourcallyourrule/core/repositories/plugin_repository.dart';
import 'package:yourcallyourrule/core/repositories/rule_repository.dart';
import 'package:yourcallyourrule/core/repositories/sms_subscription_repository.dart';
import 'package:yourcallyourrule/core/repositories/subscription_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_priority.dart';
import 'package:yourcallyourrule/data/database/database_manager.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database_manager.dart';
import 'package:yourcallyourrule/core/provider/labels_provider.dart';
import 'package:yourcallyourrule/core/provider/lists_provider.dart';

// Export all providers
export 'rules_provider.dart';
export 'call_logs_provider.dart';
export 'contacts_provider.dart';
export 'labels_provider.dart';
export 'lists_provider.dart';
export 'locations_provider.dart';
export 'plugins_provider.dart';
export 'sms_subscriptions_provider.dart';
export 'contact_subscriptions_provider.dart';
export 'subscriptions_provider.dart';

/// Database service provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

/// Rule repository provider
final ruleRepositoryProvider = Provider<RuleRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return rule repository implementation
  return RuleRepositoryImpl(databaseService);
});

/// Call log repository provider
final callLogRepositoryProvider = Provider<CallLogRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return call log repository implementation
  return CallLogRepositoryImpl(databaseService);
});

/// Contact repository provider
final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return contact repository implementation
  return ContactRepositoryImpl(databaseService);
});

/// Location repository provider
final locationRepositoryProvider = Provider<LocationRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return location repository implementation
  return LocationRepositoryImpl(databaseService);
});

/// Plugin repository provider
final pluginRepositoryProvider = Provider<PluginRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return plugin repository implementation
  return PluginRepositoryImpl(databaseService);
});

/// SMS subscription repository provider
final smsSubscriptionRepositoryProvider =
    Provider<SmsSubscriptionRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return SMS subscription repository implementation
  return SmsSubscriptionRepositoryImpl(databaseService);
});

/// Contact subscription repository provider
final contactSubscriptionRepositoryProvider =
    Provider<ContactSubscriptionRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return contact subscription repository implementation
  return ContactSubscriptionRepositoryImpl(databaseService);
});

/// Subscription repository provider
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return subscription repository implementation
  return SubscriptionRepositoryImpl(databaseService);
});

/// Label repository provider
final labelRepositoryProvider = Provider<LabelRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return label repository implementation
  return LabelRepositoryImpl(databaseService);
});

// Label repository implementation class
class LabelRepositoryImpl implements LabelRepository {
  final DatabaseService _databaseService;

  LabelRepositoryImpl(this._databaseService);

  @override
  Future<List<LabelEntry>> getAll() async {
    final maps = await _databaseService.queryAll('labels');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<LabelEntry?> getById(String id) async {
    final map = await _databaseService.queryById('labels', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<LabelEntry> save(LabelEntry entity) async {
    await _databaseService.insert('labels', entity.toMap());
    return entity;
  }

  @override
  Future<LabelEntry> update(LabelEntry entity) async {
    await _databaseService.update('labels', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(LabelEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('labels', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<LabelEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<LabelEntry>> saveAll(List<LabelEntry> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final labels = await getAll();
    return labels.length;
  }

  @override
  LabelEntry fromMap(Map<String, dynamic> map) {
    return LabelEntry.fromMap(map);
  }

  @override
  Future<LabelEntry?> getByName(String name) async {
    final maps = await _databaseService.queryWhere('labels', 'name', name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<List<LabelEntry>> getByType(String type) async {
    final maps = await _databaseService.queryWhere('labels', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<bool> nameExists(String name) async {
    final label = await getByName(name);
    return label != null;
  }

  @override
  Future<List<LabelEntry>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('labels', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }
}

/// List repository provider
final listRepositoryProvider = Provider<ListRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // Return list repository implementation
  return ListRepositoryImpl(databaseService);
});

// List repository implementation class
class ListRepositoryImpl implements ListRepository {
  final DatabaseService _databaseService;

  ListRepositoryImpl(this._databaseService);

  @override
  Future<List<ListEntry>> getAll() async {
    final maps = await _databaseService.queryAll('lists');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<ListEntry?> getById(String id) async {
    final map = await _databaseService.queryById('lists', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<ListEntry> save(ListEntry entity) async {
    await _databaseService.insert('lists', entity.toMap());
    return entity;
  }

  @override
  Future<ListEntry> update(ListEntry entity) async {
    // ListEntry没有id属性，使用phoneNumber作为唯一标识
    await _databaseService.update(
        'lists', entity.phoneNumber.value, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(ListEntry entity) async {
    // ListEntry没有id属性，使用phoneNumber作为唯一标识
    return await deleteById(entity.phoneNumber.value);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('lists', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<ListEntry> entities) async {
    for (var entity in entities) {
      // ListEntry没有id属性，使用phoneNumber作为唯一标识
      await deleteById(entity.phoneNumber.value);
    }
    return true;
  }

  @override
  Future<List<ListEntry>> saveAll(List<ListEntry> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final lists = await getAll();
    return lists.length;
  }

  @override
  ListEntry fromMap(Map<String, dynamic> map) {
    return ListEntry.fromMap(map);
  }

  @override
  Future<ListEntry?> getByName(String name) async {
    final maps = await _databaseService.queryWhere('lists', 'name', name);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<List<ListEntry>> getByType(String type) async {
    final maps = await _databaseService.queryWhere('lists', 'type', type);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<bool> nameExists(String name) async {
    final list = await getByName(name);
    return list != null;
  }

  @override
  Future<List<ListEntry>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('lists', 'isEnabled', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<ListEntry>> getUserCreatedLists() async {
    final maps =
        await _databaseService.queryWhere('lists', 'isUserCreated', true);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<List<ListEntry>> getSystemLists() async {
    final maps =
        await _databaseService.queryWhere('lists', 'isUserCreated', false);
    return maps.map((map) => fromMap(map)).toList();
  }
}

// Repository implementation classes

class RuleRepositoryImpl implements RuleRepository {
  final DatabaseService _databaseService;

  RuleRepositoryImpl(this._databaseService);

  @override
  RuleBase createEmptyRule() {
    throw UnimplementedError();
  }

  @override
  RuleBase createRuleFromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRule(String ruleId) async {
    await deleteById(ruleId);
  }

  @override
  Future<List<RuleBase>> getAllByType(String type) async {
    final maps = await _databaseService.queryWhere('rules', 'type', type);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<List<RuleBase>> getAllDisabled() async {
    final maps = await _databaseService.queryWhere('rules', 'isEnabled', false);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<List<RuleBase>> getAllEnabled() async {
    final maps = await _databaseService.queryWhere('rules', 'isEnabled', true);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<List<RuleBase>> getAll() async {
    final maps = await _databaseService.queryAll('rules');
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<RuleBase?> getById(String id) async {
    final map = await _databaseService.queryById('rules', id);
    if (map == null) return null;
    return createRuleFromMap(map);
  }

  @override
  Future<RuleBase?> getRuleById(String ruleId) async {
    return getById(ruleId);
  }

  @override
  Future<List<RuleBase>> getRulesByType(String type) async {
    return getAllByType(type);
  }

  @override
  Future<RuleBase> save(RuleBase entity) async {
    await _databaseService.insert('rules', entity.toMap());
    return entity;
  }

  @override
  Future<void> saveRule(RuleBase rule) async {
    await save(rule);
  }

  @override
  Future<List<RuleBase>> searchByName(String name) async {
    final maps = await _databaseService.queryLike('rules', 'name', name);
    return maps.map((map) => createRuleFromMap(map)).toList();
  }

  @override
  Future<RuleBase> update(RuleBase entity) async {
    await _databaseService.update('rules', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<void> updateRule(RuleBase rule) async {
    await update(rule);
  }

  @override
  Future<RuleBase> updateEnabledStatus(String id, bool isEnabled) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found');
    }
    // Use copyWith method to create a new rule object instead of directly modifying final fields
    final updatedRule = rule.copyWith(isEnabled: isEnabled);
    await update(updatedRule);
    return updatedRule;
  }

  @override
  Future<RuleBase> updatePriority(String id, int priority) async {
    final rule = await getById(id);
    if (rule == null) {
      throw Exception('Rule not found');
    }
    // Use copyWith method to create a new rule object instead of directly modifying final fields
    final updatedRule = rule.copyWith(priority: RulePriority.fromInt(priority));
    await update(updatedRule);
    return updatedRule;
  }

  @override
  Future<bool> delete(RuleBase entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('rules', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<RuleBase> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<RuleBase>> saveAll(List<RuleBase> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final rules = await getAll();
    return rules.length;
  }

  @override
  RuleBase fromMap(Map<String, dynamic> map) {
    return createRuleFromMap(map);
  }
}

class CallLogRepositoryImpl implements CallLogRepository {
  final DatabaseService _databaseService;

  CallLogRepositoryImpl(this._databaseService);

  @override
  Future<List<CallLog>> getAll() async {
    final maps = await _databaseService.queryAll('call_logs');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<CallLog?> getById(String id) async {
    final map = await _databaseService.queryById('call_logs', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<CallLog> save(CallLog entity) async {
    await _databaseService.insert('call_logs', entity.toMap());
    return entity;
  }

  @override
  Future<CallLog> update(CallLog entity) async {
    await _databaseService.update('call_logs', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(CallLog entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('call_logs', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<CallLog> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<CallLog>> saveAll(List<CallLog> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final logs = await getAll();
    return logs.length;
  }

  @override
  CallLog fromMap(Map<String, dynamic> map) {
    return CallLog.fromMap(map);
  }

  @override
  Future<List<CallLog>> getRecentLogs() async {
    // Implementation of getting recent call logs
    final logs = await getAll();
    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return logs.take(20).toList(); // Return the most recent 20 records
  }

  @override
  Future<List<CallLog>> getLogsByPhoneNumber(String phoneNumber) async {
    // Implementation of filtering call logs by phone number
    final logs = await getAll();
    return logs.where((log) => log.number == phoneNumber).toList();
  }

  @override
  Stream<List<CallLog>> watchLogs() {
    // Watch for call log changes
    // Use database change monitoring mechanism
    return _databaseService
        .watchTable('call_logs')
        .map((maps) => maps.map((map) => fromMap(map)).toList());
  }

  @override
  Future<int> deleteLogsByDateRange(
      DateTime startDate, DateTime endDate) async {
    // 实现删除指定日期范围内的通话记录的逻辑
    final logs = await getLogsByDateRange(startDate, endDate);
    for (var log in logs) {
      await delete(log);
    }
    return logs.length;
  }

  @override
  Future<List<CallLog>> getLogsByDateRange(
      DateTime startDate, DateTime endDate) async {
    // 实现获取指定日期范围内的通话记录的逻辑
    final logs = await getAll();
    return logs
        .where((log) =>
            log.timestamp.isAfter(startDate) && log.timestamp.isBefore(endDate))
        .toList();
  }

  @override
  Future<List<CallLog>> getUnreadLogs() async {
    // 获取最近的未读通话记录
    // 由于CallLog没有isRead字段，我们使用最近的通话记录作为未读记录
    final logs = await getRecentLogs();
    // 这里可以根据实际业务需求进一步筛选
    return logs.take(10).toList();
  }

  @override
  Future<void> markAsRead(String logId) async {
    // 实现标记通话记录为已读的逻辑
    final log = await getById(logId);
    if (log != null) {
      final map = log.toMap();
      map['isRead'] = true;
      await _databaseService.update('call_logs', logId, map);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    // 实现批量标记通话记录为已读的逻辑
    final logs = await getUnreadLogs();
    for (var log in logs) {
      await markAsRead(log.id);
    }
  }

  @override
  Future<void> refreshLogs() async {
    // 刷新通话记录
    // 从系统获取最新通话记录
    // 这里需要实现与系统通话记录同步的逻辑
    // 暂时返回空实现
    return;
  }

  @override
  Future<void> addLog(CallLog log) async {
    await save(log);
  }
}

class ContactRepositoryImpl implements ContactRepository {
  final DatabaseService _databaseService;

  ContactRepositoryImpl(this._databaseService);

  @override
  Future<void> deleteContactByUrl(String url) async {
    final maps = await _databaseService.queryWhere('contacts', 'url', url);
    if (maps.isNotEmpty) {
      final contactId = maps.first['id'] as String;
      await deleteById(contactId);
    }
  }

  @override
  Future<bool> contactExists(PhoneNumber phoneNumber) async {
    final contact = await findContactByPhoneNumber(phoneNumber);
    return contact != null;
  }

  @override
  Future<bool> contactExistsAny(List<PhoneNumber> phoneNumbers) async {
    for (var phoneNumber in phoneNumbers) {
      if (await contactExists(phoneNumber)) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<Contact?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await getContactByPhone(phoneNumber);
  }

  @override
  Future<void> deleteContact(PhoneNumber phoneNumber) async {
    final contact = await findContactByPhoneNumber(phoneNumber);
    if (contact != null) {
      await delete(contact);
    }
  }

  @override
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers) async {
    for (var phoneNumber in phoneNumbers) {
      await deleteContact(phoneNumber);
    }
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await update(contact);
  }

  @override
  Future<void> addContact(Contact contact) async {
    await save(contact);
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    return await getAll();
  }

  @override
  Future<Contact?> getContactByPhone(PhoneNumber phoneNumber) async {
    final maps = await _databaseService.queryAll('contacts');
    for (var map in maps) {
      final contact = fromMap(map);
      for (var phoneStr in contact.phoneNumbers) {
        if (phoneStr == phoneNumber.value) {
          return contact;
        }
      }
    }
    return null;
  }

  @override
  Future<List<PhoneEntry>> searchByName(String name) async {
    final maps = await _databaseService.queryLike('contacts', 'name', name);
    List<PhoneEntry> results = [];
    for (var map in maps) {
      final contact = fromMap(map);
      results.addAll(contact.phones);
    }
    return results;
  }

  @override
  Future<List<PhoneEntry>> searchContactsByNumber(String number) async {
    final maps = await _databaseService.queryAll('contacts');
    List<Contact> results = [];
    for (var map in maps) {
      final contact = fromMap(map);
      for (var phoneStr in contact.phoneNumbers) {
        if (phoneStr.contains(number)) {
          results.add(contact);
          break;
        }
      }
    }
    return results;
  }

  @override
  Future<List<PhoneEntry>> searchByNumber(String number) async {
    final maps =
        await _databaseService.queryLike('contacts', 'phoneNumbers', number);
    List<PhoneEntry> results = [];
    for (var map in maps) {
      final contact = fromMap(map);
      // 将phoneNumbers转换为PhoneEntry列表
      final phoneEntries = contact.phoneNumbers
          .map((p) => PhoneEntry(phoneNumber: PhoneNumber(p)))
          .toList();
      results.addAll(phoneEntries);
    }
    return results;
  }

  @override
  Future<List<PhoneEntry>> getAllSortedByName() async {
    final contacts = await getAll();
    contacts.sort((a, b) => a.name.compareTo(b.name));
    List<PhoneEntry> results = [];
    for (var contact in contacts) {
      results.addAll(contact.phones);
    }
    return results;
  }

  @override
  Future<List<PhoneEntry>> getRecentlyAdded(int limit) async {
    final contacts = await getAll();
    contacts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    List<PhoneEntry> results = [];
    for (var contact in contacts.take(limit)) {
      results.addAll(contact.phones);
    }
    return results;
  }

  @override
  Future<List<PhoneEntry>> getRecentlyContacted(int limit) async {
    // 这里需要与通话记录关联，获取最近联系的联系人
    final callLogs = await _databaseService.queryAll('call_logs');
    callLogs.sort(
        (a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int));

    Set<String> recentNumbers = {};
    List<PhoneEntry> results = [];

    for (var log in callLogs) {
      final number = log['number'] as String;
      if (!recentNumbers.contains(number)) {
        recentNumbers.add(number);
        final phoneNumber = PhoneNumber(number);
        final contact = await getContactByPhone(phoneNumber);
        if (contact != null) {
          for (var phone in contact.phones) {
            if (phone.phoneNumber.value == number) {
              results.add(phone);
              break;
            }
          }
        }
      }

      if (results.length >= limit) break;
    }

    return results;
  }

  @override
  Future<bool> addToFavorites(String contactId) async {
    final contact = await getById(contactId);
    if (contact != null) {
      final updatedContact = contact.copyWith(label: 'favorite');
      await update(updatedContact);
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeFromFavorites(String contactId) async {
    final contact = await getById(contactId);
    if (contact != null) {
      final updatedContact = contact.copyWith(label: null);
      await update(updatedContact);
      return true;
    }
    return false;
  }

  @override
  Future<List<PhoneEntry>> getFavorites() async {
    final maps =
        await _databaseService.queryWhere('contacts', 'label', 'favorite');
    List<PhoneEntry> results = [];
    for (var map in maps) {
      final contact = fromMap(map);
      results.addAll(contact.phones);
    }
    return results;
  }

  @override
  Future<List<Contact>> getContactsByLabel(String labelId) async {
    final maps = await _databaseService.queryWhere(
        'contacts_labels', 'labelId', labelId);
    List<Contact> contacts = [];
    for (var map in maps) {
      final contactId = map['contactId'] as String;
      final contact = await getById(contactId);
      if (contact != null) {
        contacts.add(contact);
      }
    }
    return contacts;
  }

  @override
  Future<List<Contact>> getContactsByList(String listId) async {
    final maps =
        await _databaseService.queryWhere('contacts_lists', 'listId', listId);
    List<Contact> contacts = [];
    for (var map in maps) {
      final contactId = map['contactId'] as String;
      final contact = await getById(contactId);
      if (contact != null) {
        contacts.add(contact);
      }
    }
    return contacts;
  }

  @override
  Future<int> importContactsList(List<Contact> contacts) async {
    int count = 0;
    for (var contact in contacts) {
      await save(contact);
      count++;
    }
    return count;
  }

  @override
  Future<List<Map<String, dynamic>>> exportContactsData() async {
    final contacts = await getAll();
    return contacts.map((contact) => contact.toMap()).toList();
  }

  @override
  Future<List<PhoneEntry>> importContacts(List<PhoneEntry> contacts) async {
    List<PhoneEntry> savedEntries = [];
    for (var entry in contacts) {
      final exists = await contactExists(entry.phoneNumber);
      if (!exists) {
        final contact = Contact(
          id: entry.id,
          name: entry.name,
          phoneNumbers: [entry.phoneNumber.value],
        );
        await save(contact);
        savedEntries.add(entry);
      }
    }
    return savedEntries;
  }

  @override
  Future<List<PhoneEntry>> exportContacts() async {
    final contacts = await getAll();
    List<PhoneEntry> results = [];
    for (var contact in contacts) {
      results.addAll(contact.phones);
    }
    return results;
  }

  @override
  Future<void> syncWithDeviceContacts() async {
    // 与设备联系人同步的实现
    // 这里需要调用平台特定的API获取设备联系人
    // 暂时返回空实现
    return;
  }

  @override
  Future<int> getContactCount() async {
    return await count();
  }

  @override
  Future<bool> addContactToList(String contactId, String listId) async {
    try {
      await _databaseService.insert('contacts_lists', {
        'contactId': contactId,
        'listId': listId,
        'addedAt': DateTime.now().millisecondsSinceEpoch
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> removeContactFromList(String contactId, String listId) async {
    try {
      await _databaseService.deleteWhere(
          'contacts_lists', {'contactId': contactId, 'listId': listId});
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<int> mergeDuplicates() async {
    // 获取所有联系人
    final contacts = await getAll();

    // 按电话号码分组
    final Map<String, List<Contact>> contactsByPhone = {};
    for (var contact in contacts) {
      for (var phone in contact.phones) {
        final phoneNumber = phone.phoneNumber.value;
        if (!contactsByPhone.containsKey(phoneNumber)) {
          contactsByPhone[phoneNumber] = [];
        }
        contactsByPhone[phoneNumber]!.add(contact);
      }
    }

    // 合并重复联系人
    int mergedCount = 0;
    for (var phoneNumber in contactsByPhone.keys) {
      final duplicates = contactsByPhone[phoneNumber]!;
      if (duplicates.length > 1) {
        // 保留第一个联系人，删除其他重复联系人
        final primaryContact = duplicates.first;
        for (int i = 1; i < duplicates.length; i++) {
          await delete(duplicates[i]);
          mergedCount++;
        }
      }
    }

    return mergedCount;
  }

  @override
  Future<List<Contact>> getAll() async {
    final maps = await _databaseService.queryAll('contacts');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<Contact?> getById(String id) async {
    final map = await _databaseService.queryById('contacts', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<Contact> save(Contact entity) async {
    await _databaseService.insert('contacts', entity.toMap());
    return entity;
  }

  @override
  Future<Contact> update(Contact entity) async {
    await _databaseService.update('contacts', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(Contact entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('contacts', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<Contact> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<Contact>> saveAll(List<Contact> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final contacts = await getAll();
    return contacts.length;
  }

  @override
  Contact fromMap(Map<String, dynamic> map) {
    return Contact.fromMap(map);
  }

  // 实现ContactRepository接口中的其他方法
  @override
  Future<void> deleteContactByUrl(String url) async {
    // 实现根据URL删除联系人的逻辑
    final contacts = await getAll();
    final contact =
        contacts.firstWhere((c) => c.url == url, orElse: () => null as Contact);
    await delete(contact);
  }

  @override
  Future<int> importContactsList(List<Contact> contacts) async {
    // 实现批量导入联系人的逻辑
    int count = 0;
    for (var contact in contacts) {
      await save(contact);
      count++;
    }
    return count;
  }

  @override
  Future<List<Map<String, dynamic>>> exportContactsData() async {
    // 实现导出联系人数据的逻辑
    final contacts = await getAll();
    return contacts.map((contact) => contact.toMap()).toList();
  }

  @override
  Future<bool> contactExists(PhoneNumber phoneNumber) async {
    // 实现检查联系人是否存在的逻辑
    final contacts = await getAll();
    return contacts.any((c) => c.phoneNumbers.contains(phoneNumber.value));
  }

  @override
  Future<bool> contactExistsAny(List<PhoneNumber> phoneNumbers) async {
    // 实现检查任意联系人是否存在的逻辑
    for (var phoneNumber in phoneNumbers) {
      if (await contactExists(phoneNumber)) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<Contact?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    final contacts = await getAll();
    return contacts.firstWhere(
        (c) => c.phoneNumbers.contains(phoneNumber.value),
        orElse: () => null as Contact);
  }

  @override
  Future<void> deleteContact(PhoneNumber phoneNumber) async {
    // 实现根据电话号码删除联系人的逻辑
    final contact = await findContactByPhoneNumber(phoneNumber);
    if (contact != null) {
      await delete(contact);
    }
  }

  @override
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers) async {
    // 实现删除多个电话号码对应联系人的逻辑
    for (var number in phoneNumbers) {
      await deleteContact(number);
    }
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await update(contact);
  }

  @override
  Future<void> addContact(Contact contact) async {
    await save(contact);
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    return await getAll();
  }

  @override
  Future<Contact?> getContactByPhone(PhoneNumber phoneNumber) async {
    return await findContactByPhoneNumber(phoneNumber);
  }

  @override
  Future<List<PhoneEntry>> searchByName(String name) async {
    // 实现根据名称搜索联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<List<PhoneEntry>> getAllSortedByName() async {
    // 实现按名称排序获取所有联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<List<PhoneEntry>> getRecentlyAdded(int limit) async {
    // 实现获取最近添加的联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<List<PhoneEntry>> getRecentlyContacted(int limit) async {
    // 实现获取最近联系的联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<bool> addToFavorites(String contactId) async {
    // 实现添加联系人到收藏夹的逻辑
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFromFavorites(String contactId) async {
    // 实现从收藏夹移除联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<List<PhoneEntry>> getFavorites() async {
    // 实现获取收藏夹联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<List<PhoneEntry>> importContacts(List<PhoneEntry> contacts) async {
    // 实现导入联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<List<PhoneEntry>> exportContacts() async {
    // 实现导出联系人的逻辑
    throw UnimplementedError();
  }

  @override
  Future<void> syncWithDeviceContacts() async {
    // 实现与设备联系人同步的逻辑
    throw UnimplementedError();
  }

  @override
  Future<int> getContactCount() async {
    return await count();
  }
}

class LocationRepositoryImpl implements LocationRepository {
  final DatabaseService _databaseService;

  LocationRepositoryImpl(this._databaseService);

  @override
  Future<List<LocationEntry>> getAll() async {
    final maps = await _databaseService.queryAll('locations');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<LocationEntry?> getById(String id) async {
    final map = await _databaseService.queryById('locations', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<LocationEntry> save(LocationEntry entity) async {
    await _databaseService.insert('locations', entity.toMap());
    return entity;
  }

  @override
  Future<LocationEntry> update(LocationEntry entity) async {
    await _databaseService.update('locations', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(LocationEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('locations', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<LocationEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<LocationEntry>> saveAll(List<LocationEntry> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final locations = await getAll();
    return locations.length;
  }

  @override
  LocationEntry fromMap(Map<String, dynamic> map) {
    return LocationEntry.fromMap(map);
  }

  @override
  Future<LocationEntry?> getByPhoneNumber(String phone) async {
    final maps =
        await _databaseService.queryWhere('locations', 'phoneNumber', phone);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<List<LocationEntry>> getLocationsByRegion(String region) async {
    final maps =
        await _databaseService.queryWhere('locations', 'region', region);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<void> saveLocation(LocationEntry entry) async {
    await save(entry);
  }
}

class PluginRepositoryImpl implements PluginRepository {
  final DatabaseService _databaseService;

  PluginRepositoryImpl(this._databaseService);

  @override
  Future<void> updateVersion(String id, String version) async {
    final plugin = await getById(id);
    if (plugin != null) {
      final updatedPlugin = plugin.copyWith(version: version);
      await update(updatedPlugin);
    }
  }

  @override
  Future<List<PluginEntry>> getEnabled() async {
    final maps = await _databaseService.queryWhere('plugins', 'isEnabled', 1);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<void> setEnabled(String id, bool enabled) async {
    await updateEnabledStatus(id, enabled);
  }

  @override
  Future<void> updateAutoUpdate(String id, bool isAutoUpdate) async {
    await updateAutoUpdateStatus(id, isAutoUpdate);
  }

  @override
  Future<List<PluginEntry>> getAllSorted(
      {String? orderBy, bool ascending = true}) async {
    final plugins = await getAll();
    if (orderBy != null) {
      plugins.sort((a, b) {
        dynamic valueA;
        dynamic valueB;

        switch (orderBy) {
          case 'name':
            valueA = a.name;
            valueB = b.name;
            break;
          case 'pluginOrder':
            valueA = a.pluginOrder;
            valueB = b.pluginOrder;
            break;
          default:
            valueA = a.id;
            valueB = b.id;
        }

        int comparison = valueA.compareTo(valueB);
        return ascending ? comparison : -comparison;
      });
    }
    return plugins;
  }

  @override
  Future<List<PluginEntry>> getAllEnabledSortedByOrder() async {
    final plugins = await getEnabled();
    plugins.sort((a, b) => a.pluginOrder.compareTo(b.pluginOrder));
    return plugins;
  }

  @override
  Future<List<PluginEntry>> getAllDisabled() async {
    final maps = await _databaseService.queryWhere('plugins', 'isEnabled', 0);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<int> getNextPluginOrder() async {
    final plugins = await getAll();
    if (plugins.isEmpty) return 0;

    int maxOrder =
        plugins.map((p) => p.pluginOrder).reduce((a, b) => a > b ? a : b);
    return maxOrder + 1;
  }

  @override
  Future<List<PluginEntry>> getAll() async {
    final maps = await _databaseService.queryAll('plugins');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<PluginEntry?> getById(String id) async {
    final map = await _databaseService.queryById('plugins', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<PluginEntry> save(PluginEntry entity) async {
    await _databaseService.insert('plugins', entity.toMap());
    return entity;
  }

  @override
  Future<PluginEntry> update(PluginEntry entity) async {
    await _databaseService.update('plugins', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(PluginEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('plugins', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<PluginEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<PluginEntry>> saveAll(List<PluginEntry> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final plugins = await getAll();
    return plugins.length;
  }

  @override
  PluginEntry fromMap(Map<String, dynamic> map) {
    return PluginEntry.fromMap(map);
  }

  @override
  Future<PluginEntry?> getByUrl(String url) async {
    final maps = await _databaseService.queryWhere('plugins', 'url', url);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<List<PluginEntry>> searchByName(String name) async {
    final maps = await _databaseService.queryLike('plugins', 'name', name);
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<PluginEntry?> updateEnabledStatus(String id, bool isEnabled) async {
    final plugin = await getById(id);
    if (plugin == null) return null;

    final updatedPlugin = plugin.copyWith(isEnabled: isEnabled);
    await update(updatedPlugin);
    return updatedPlugin;
  }

  @override
  Future<PluginEntry?> updatePluginOrder(String id, int pluginOrder) async {
    final plugin = await getById(id);
    if (plugin == null) return null;

    final updatedPlugin = plugin.copyWith(pluginOrder: pluginOrder);
    await update(updatedPlugin);
    return updatedPlugin;
  }

  @override
  Future<PluginEntry?> updateAutoUpdateStatus(
      String id, bool isAutoUpdate) async {
    final plugin = await getById(id);
    if (plugin == null) return null;

    final updatedPlugin = plugin.copyWith(isAutoUpdate: isAutoUpdate);
    await update(updatedPlugin);
    return updatedPlugin;
  }
}

class SmsSubscriptionRepositoryImpl implements SmsSubscriptionRepository {
  final DatabaseService _databaseService;

  SmsSubscriptionRepositoryImpl(this._databaseService);

  @override
  Future<int> batchUpdateSmsStatus(List<String> ids, bool isEnabled) async {
    int count = 0;
    for (var id in ids) {
      final subscription = await getById(id);
      if (subscription != null) {
        final updatedSubscription = subscription.copyWith(isEnabled: isEnabled);
        await update(updatedSubscription);
        count++;
      }
    }
    return count;
  }

  @override
  Future<SmsSubscription?> getByPhoneNumber(String number) async {
    final maps = await _databaseService.queryWhere(
        'sms_subscriptions', 'phoneNumber', number);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {
    final subscription = await getById(id);
    if (subscription != null) {
      final updated = subscription.copyWith(lastUpdated: time);
      await update(updated);
    }
  }

  @override
  Future<List<SmsSubscription>> getPendingUpdateSubscriptions() async {
    final subscriptions = await getAll();
    return subscriptions
        .where((s) =>
            s.autoUpdate &&
            s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    final subscriptions = await getAll();
    final expired = subscriptions
        .where((s) =>
            s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 30))))
        .toList();

    for (var subscription in expired) {
      await deleteById(subscription.id);
    }

    return expired.length;
  }
}

class ContactSubscriptionRepositoryImpl
    implements ContactSubscriptionRepository {
  final DatabaseService _databaseService;

  ContactSubscriptionRepositoryImpl(this._databaseService);

  @override
  Future<int> batchUpdateStatus(List<String> ids, bool isEnabled) async {
    int count = 0;
    for (var id in ids) {
      final subscription = await getById(id);
      if (subscription != null) {
        final updatedSubscription = subscription.copyWith(isEnabled: isEnabled);
        await update(updatedSubscription);
        count++;
      }
    }
    return count;
  }

  @override
  Future<ContactSubscription?> getByUrl(String url) async {
    final maps =
        await _databaseService.queryWhere('contact_subscriptions', 'url', url);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {
    final subscription = await getById(id);
    if (subscription != null) {
      final updated = subscription.copyWith(lastUpdated: time);
      await update(updated);
    }
  }

  @override
  Future<List<ContactSubscription>> getPendingUpdateSubscriptions() async {
    final subscriptions = await getAll();
    return subscriptions
        .where((s) =>
            s.autoUpdate &&
            s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    final subscriptions = await getAll();
    final expired = subscriptions
        .where((s) =>
            s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 30))))
        .toList();

    for (var subscription in expired) {
      await deleteById(subscription.id);
    }

    return expired.length;
  }

  @override
  Future<List<ContactSubscription>> getAll() async {
    final maps = await _databaseService.queryAll('contact_subscriptions');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<ContactSubscription?> getById(String id) async {
    final map = await _databaseService.queryById('contact_subscriptions', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<ContactSubscription> save(ContactSubscription entity) async {
    await _databaseService.insert('contact_subscriptions', entity.toMap());
    return entity;
  }

  @override
  Future<ContactSubscription> update(ContactSubscription entity) async {
    await _databaseService.update(
        'contact_subscriptions', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(ContactSubscription entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('contact_subscriptions', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<ContactSubscription> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<ContactSubscription>> saveAll(
      List<ContactSubscription> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final subscriptions = await getAll();
    return subscriptions.length;
  }

  @override
  ContactSubscription fromMap(Map<String, dynamic> map) {
    return ContactSubscription.fromMap(map);
  }
}

class ContactSubscriptionRepositoryImpl
    implements ContactSubscriptionRepository {
  final DatabaseService _databaseService;

  ContactSubscriptionRepositoryImpl(this._databaseService);

  @override
  Future<int> batchUpdateStatus(List<String> ids, bool isEnabled) async {
    int count = 0;
    for (var id in ids) {
      final subscription = await getById(id);
      if (subscription != null) {
        final updatedSubscription = subscription.copyWith(isEnabled: isEnabled);
        await update(updatedSubscription);
        count++;
      }
    }
    return count;
  }

  @override
  Future<ContactSubscription?> getByUrl(String url) async {
    final maps =
        await _databaseService.queryWhere('contact_subscriptions', 'url', url);
    if (maps.isEmpty) return null;
    return fromMap(maps.first);
  }

  @override
  Future<void> updateLastUpdated(String id, DateTime time) async {
    final subscription = await getById(id);
    if (subscription != null) {
      final updated = subscription.copyWith(lastUpdated: time);
      await update(updated);
    }
  }

  @override
  Future<List<ContactSubscription>> getPendingUpdateSubscriptions() async {
    final subscriptions = await getAll();
    return subscriptions
        .where((s) =>
            s.autoUpdate &&
            s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  Future<int> clearExpiredSubscriptions() async {
    final subscriptions = await getAll();
    final expired = subscriptions
        .where((s) =>
            s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 30))))
        .toList();

    for (var subscription in expired) {
      await deleteById(subscription.id);
    }

    return expired.length;
  }

  @override
  Future<List<ContactSubscription>> getAll() async {
    final maps = await _databaseService.queryAll('contact_subscriptions');
    return maps.map((map) => fromMap(map)).toList();
  }

  @override
  Future<ContactSubscription?> getById(String id) async {
    final map = await _databaseService.queryById('contact_subscriptions', id);
    if (map == null) return null;
    return fromMap(map);
  }

  @override
  Future<ContactSubscription> save(ContactSubscription entity) async {
    await _databaseService.insert('contact_subscriptions', entity.toMap());
    return entity;
  }

  @override
  Future<ContactSubscription> update(ContactSubscription entity) async {
    await _databaseService.update(
        'contact_subscriptions', entity.id, entity.toMap());
    return entity;
  }

  @override
  Future<bool> delete(ContactSubscription entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    await _databaseService.delete('contact_subscriptions', id);
    return true;
  }

  @override
  Future<bool> deleteAll(List<ContactSubscription> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  @override
  Future<List<ContactSubscription>> saveAll(
      List<ContactSubscription> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  @override
  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final subscriptions = await getAll();
    return subscriptions.length;
  }

  @override
  ContactSubscription fromMap(Map<String, dynamic> map) {
    return ContactSubscription.fromMap(map);
  }


@override
Future<List<ContactSubscription>> getByContactName(String name) async {
  // Implementation of getting subscriptions by contact name
  final subscriptions = await getAll();
  return subscriptions.where((s) => s.name.contains(name)).toList();
}

@override
Future<void> updateLastUpdated(String id, DateTime time) async {
  final subscription = await getById(id);
  if (subscription != null) {
    final updated = subscription.copyWith(lastUpdated: time);
    await update(updated);
  }
}

@override
Future<List<ContactSubscription>> getPendingUpdateSubscriptions() async {
  final subscriptions = await getAll();
  return subscriptions
      .where((s) =>
          s.autoUpdate &&
          s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 7))))
      .toList();
}

@override
Future<int> clearExpiredSubscriptions() async {
  final subscriptions = await getAll();
  final expired = subscriptions
      .where((s) =>
          s.lastUpdated.isBefore(DateTime.now().subtract(Duration(days: 30))))
      .toList();

  for (var subscription in expired) {
    await deleteById(subscription.id);
  }

  return expired.length;
}

@override
Future<List<ContactSubscription>> getAll() async {
  final maps = await _databaseService.queryAll('contact_subscriptions');
  return maps.map((map) => fromMap(map)).toList();
}

@override
Future<ContactSubscription?> getById(String id) async {
  final map = await _databaseService.queryById('contact_subscriptions', id);
  if (map == null) return null;
  return fromMap(map);
}

@override
Future<ContactSubscription> save(ContactSubscription entity) async {
  await _databaseService.insert('contact_subscriptions', entity.toMap());
  return entity;
}

@override
Future<ContactSubscription> update(ContactSubscription entity) async {
  await _databaseService.update(
      'contact_subscriptions', entity.id, entity.toMap());
  return entity;
}

@override
Future<bool> delete(ContactSubscription entity) async {
  return await deleteById(entity.id);
}

@override
Future<bool> deleteById(String id) async {
  await _databaseService.delete('contact_subscriptions', id);
  return true;
}

@override
Future<bool> deleteAll(List<ContactSubscription> entities) async {
  for (var entity in entities) {
    await deleteById(entity.id);
  }
  return true;
}

@override
Future<List<ContactSubscription>> saveAll(
    List<ContactSubscription> entities) async {
  for (var entity in entities) {
    await save(entity);
  }
  return entities;
}

@override
Future<bool> exists(String id) async {
  final entity = await getById(id);
  return entity != null;
}

@override
Future<int> count() async {
  final subscriptions = await getAll();
  return subscriptions.length;
}

@override
ContactSubscription fromMap(Map<String, dynamic> map) {
  return ContactSubscription.fromMap(map);
}
}