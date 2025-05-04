import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/phone/phone_entry.dart';
import 'package:yourcallyourrule/core/entities/phone/phone_entry_impl.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';

import 'database_service_provider.dart';

/// 联系人仓库提供者
final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  // 返回联系人仓库实现
  return ContactRepositoryImpl(databaseService);
});

/// 联系人仓库实现类
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
      final phoneEntries = contact.phoneNumbers
          .map((p) => PhoneEntryImpl(
            id: '${contact.id}_$p',
            phoneNumber: PhoneNumber(p),
            name: contact.name,
            avatar: contact.avatar
          ))
          .toList();
      results.addAll(phoneEntries);
    }
    return results;
  }

  Future<List<PhoneEntry>> searchContactsByNumber(String number) async {
    final maps = await _databaseService.queryAll('contacts');
    List<PhoneEntry> results = [];
    for (var map in maps) {
      final contact = fromMap(map);
      for (var phoneStr in contact.phoneNumbers) {
        if (phoneStr.contains(number)) {
          // 将匹配的电话号码转换为PhoneEntry
          results.add(PhoneEntryImpl(
            id: '${contact.id}_$phoneStr',
            phoneNumber: PhoneNumber(phoneStr),
            name: contact.name,
            avatar: contact.avatar
          ));
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
          .map((p) => PhoneEntryImpl(
            id: '${contact.id}_$p',
            phoneNumber: PhoneNumber(p),
            name: contact.name,
            avatar: contact.avatar
          ))
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
      // 将联系人的电话号码转换为PhoneEntry列表
      final phoneEntries = contact.phoneNumbers
          .map((p) => PhoneEntryImpl(
            id: '${contact.id}_$p',
            phoneNumber: PhoneNumber(p),
            name: contact.name,
            avatar: contact.avatar
          ))
          .toList();
      results.addAll(phoneEntries);
    }
    return results;
  }

  @override
  Future<List<PhoneEntry>> getRecentlyAdded(int limit) async {
    final contacts = await getAll();
    // 按照ID排序，假设ID包含时间信息或者最近添加的ID较大
    contacts.sort((a, b) => b.id.compareTo(a.id));
    List<PhoneEntry> results = [];
    for (var contact in contacts.take(limit)) {
      // 将联系人的电话号码转换为PhoneEntry列表
      final phoneEntries = contact.phoneNumbers
          .map((p) => PhoneEntryImpl(
            id: '${contact.id}_$p',
            phoneNumber: PhoneNumber(p),
            name: contact.name,
            avatar: contact.avatar
          ))
          .toList();
      results.addAll(phoneEntries);
    }
    return results;
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
  
  @override
  Future<List<PhoneEntry>> getRecentlyContacted(int limit) async {
    // 由于没有联系时间信息，这里简单返回最近添加的联系人
    return getRecentlyAdded(limit);
  }
  
  @override
  Future<bool> addToFavorites(String contactId) async {
    final contact = await getById(contactId);
    if (contact == null) return false;
    
    // 假设我们在联系人中添加一个标记表示收藏
    final updatedContact = contact.copyWith(label: 'favorite');
    await update(updatedContact);
    return true;
  }
  
  @override
  Future<bool> removeFromFavorites(String contactId) async {
    final contact = await getById(contactId);
    if (contact == null) return false;
    
    // 如果当前标签是favorite，则移除
    if (contact.label == 'favorite') {
      final updatedContact = contact.copyWith(label: null);
      await update(updatedContact);
    }
    return true;
  }
  
  @override
  Future<List<PhoneEntry>> getFavorites() async {
    final maps = await _databaseService.queryWhere('contacts', 'label', 'favorite');
    List<PhoneEntry> results = [];
    for (var map in maps) {
      final contact = fromMap(map);
      final phoneEntries = contact.phoneNumbers
          .map((p) => PhoneEntryImpl(
            id: '${contact.id}_$p',
            phoneNumber: PhoneNumber(p),
            name: contact.name,
            avatar: contact.avatar
          ))
          .toList();
      results.addAll(phoneEntries);
    }
    return results;
  }
  
  @override
  Future<List<Contact>> getContactsByLabel(String labelId) async {
    final maps = await _databaseService.queryWhere('contacts', 'label', labelId);
    return maps.map((map) => fromMap(map)).toList();
  }
  
  @override
  Future<List<Contact>> getContactsByList(String listId) async {
    // 假设联系人的group字段表示所属列表
    final maps = await _databaseService.queryWhere('contacts', 'group', listId);
    return maps.map((map) => fromMap(map)).toList();
  }
  
  @override
  Future<bool> addContactToList(String contactId, String listId) async {
    final contact = await getById(contactId);
    if (contact == null) return false;
    
    final updatedContact = contact.copyWith(group: listId);
    await update(updatedContact);
    return true;
  }
  
  @override
  Future<bool> removeContactFromList(String contactId, String listId) async {
    final contact = await getById(contactId);
    if (contact == null) return false;
    
    // 只有当联系人确实在指定列表中时才移除
    if (contact.group == listId) {
      final updatedContact = contact.copyWith(group: null);
      await update(updatedContact);
    }
    return true;
  }
  
  @override
  Future<int> importContactsList(List<Contact> contacts) async {
    int count = 0;
    for (var contact in contacts) {
      // 检查联系人是否已存在
      bool exists = false;
      for (var phoneNumber in contact.phoneNumbers) {
        if (await contactExists(PhoneNumber(phoneNumber))) {
          exists = true;
          break;
        }
      }
      
      if (!exists) {
        await save(contact);
        count++;
      }
    }
    return count;
  }
  
  @override
  Future<List<Map<String, dynamic>>> exportContactsData() async {
    final contacts = await getAll();
    return contacts.map((contact) => contact.toMap()).toList();
  }
  
  @override
  Future<int> mergeDuplicates() async {
    // 简单实现：按电话号码查找重复联系人并合并
    final contacts = await getAll();
    Map<String, List<Contact>> phoneToContacts = {};
    
    // 按电话号码分组联系人
    for (var contact in contacts) {
      for (var phone in contact.phoneNumbers) {
        if (!phoneToContacts.containsKey(phone)) {
          phoneToContacts[phone] = [];
        }
        phoneToContacts[phone]!.add(contact);
      }
    }
    
    int mergedCount = 0;
    
    // 合并具有相同电话号码的联系人
    for (var phone in phoneToContacts.keys) {
      final duplicates = phoneToContacts[phone]!;
      if (duplicates.length > 1) {
        // 保留第一个联系人，删除其他重复项
        final primaryContact = duplicates.first;
        for (var i = 1; i < duplicates.length; i++) {
          await delete(duplicates[i]);
          mergedCount++;
        }
      }
    }
    
    return mergedCount;
  }
  
  @override
  Future<List<PhoneEntry>> importContacts(List<PhoneEntry> contacts) async {
    List<PhoneEntry> importedContacts = [];
    
    for (var phoneEntry in contacts) {
      // 检查是否已存在该电话号码的联系人
      if (!await contactExists(phoneEntry.phoneNumber)) {
        // 创建新联系人
        final contact = Contact(
          id: '${DateTime.now().millisecondsSinceEpoch}_${phoneEntry.id}',
          name: phoneEntry.name ?? phoneEntry.phoneNumber.value,
          phoneNumbers: [phoneEntry.phoneNumber.value],
          avatar: phoneEntry.avatar
        );
        
        await save(contact);
        importedContacts.add(phoneEntry);
      }
    }
    
    return importedContacts;
  }
  
  @override
  Future<List<PhoneEntry>> exportContacts() async {
    final contacts = await getAll();
    List<PhoneEntry> phoneEntries = [];
    
    for (var contact in contacts) {
      for (var phone in contact.phoneNumbers) {
        phoneEntries.add(PhoneEntryImpl(
          id: '${contact.id}_$phone',
          phoneNumber: PhoneNumber(phone),
          name: contact.name,
          avatar: contact.avatar
        ));
      }
    }
    
    return phoneEntries;
  }
  
  @override
  Future<void> syncWithDeviceContacts() async {
    // 此方法需要平台特定实现，这里只是一个占位符
    // 实际实现需要使用平台特定的联系人API
    return;
  }
  
  @override
  Future<int> getContactCount() async {
    return count();
  }
}