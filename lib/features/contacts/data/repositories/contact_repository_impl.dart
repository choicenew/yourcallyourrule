import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/phone/entities/phone_entry.dart';
import 'package:yourcallyourrule/features/phone/entities/phone_entry_impl.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_repository.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';
import 'package:yourcallyourrule/features/contacts/data/datasources/local_contact_datasource.dart';

part 'contact_repository_impl.g.dart';

/// 联系人仓库提供者
@Riverpod(keepAlive: true)
ContactRepository contactRepository(Ref ref) {
  final localContactDataSource = ref.watch(localContactDataSourceProvider);
  return ContactRepositoryImpl(localContactDataSource);
}

/// 联系人仓库实现类
class ContactRepositoryImpl implements ContactRepository {
  final LocalContactDataSource _localContactDataSource;

  ContactRepositoryImpl(this._localContactDataSource);

  PhoneContactEntry fromMap(Map<String, dynamic> map) {
    return PhoneContactEntry.fromMap(map);
  }

  @override
  Future<List<PhoneContactEntry>> getAll() async {
    return await _localContactDataSource.getAll();
  }

  @override
  Future<PhoneContactEntry?> getById(String id) async {
    return await _localContactDataSource.getById(id);
  }

  @override
  Future<PhoneContactEntry> update(PhoneContactEntry entity) async {
    await _localContactDataSource.update(entity);
    return entity;
  }

  @override
  Future<void> deleteContactByUrl(String url) async {
    final contacts = await _localContactDataSource.getAll();
    final contactToDelete = contacts.firstWhere((contact) => contact.photoUrl == url, orElse: () => throw Exception('Contact not found'));
    await _localContactDataSource.delete(contactToDelete.id);
  }

  @override
  Future<bool> contactExists(PhoneNumber phoneNumber) async {
    final entry = await _localContactDataSource.getByPhoneNumber(phoneNumber.value);
    return entry != null;
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
  Future<PhoneContactEntry?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    return await _localContactDataSource.getByPhoneNumber(phoneNumber.value);
  }

  @override
  Future<bool> deleteById(String id) async {
    try {
      await _localContactDataSource.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> addToFavorites(String contactId) async {
    final entry = await _localContactDataSource.getById(contactId);
    if (entry != null) {
      final updated = entry.copyWith(isStarred: true);
      await _localContactDataSource.update(updated);
      return true;
    }
    return false;
  }

  @override
  Future<int> count() async {
    return await _localContactDataSource.count();
  }

  @override
  Future<bool> delete(PhoneContactEntry entity) async {
    try {
      await _localContactDataSource.delete(entity.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAll(List<PhoneContactEntry> entities) async {
    try {
      for (final entity in entities) {
        await _localContactDataSource.delete(entity.id);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteContact(PhoneNumber phoneNumber) async {
    final contact = await findContactByPhoneNumber(phoneNumber);
    if (contact != null) {
      await _localContactDataSource.delete(contact.id);
    }
  }

  @override
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers) async {
    for (final phone in phoneNumbers) {
      await deleteContact(phone);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> exportContactsData() async {
    final contacts = await _localContactDataSource.getAll();
    return contacts.map((contact) => contact.toMap()).toList();
  }

  @override
  Future<List<PhoneContactEntry>> getAllContacts() async {
    return await _localContactDataSource.getAll();
  }

  @override
  Future<List<PhoneEntry>> getAllSortedByName() async {
    final contacts = await getAll();
    contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    List<PhoneEntry> results = [];
    for (var contact in contacts) {
      final phoneEntries = contact.phoneNumbers
          .map((p) => PhoneEntryImpl(
            id: '${contact.id}_$p',
            phoneNumber: PhoneNumber(p),
            name: contact.displayName,
            avatar: contact.photoUrl
          ))
          .toList();
      results.addAll(phoneEntries);
    }
    return results;
  }

  @override
  Future<PhoneContactEntry?> getContactByPhone(PhoneNumber phoneNumber) {
    return findContactByPhoneNumber(phoneNumber);
  }

  @override
  Future<int> getContactCount() {
    return count();
  }

  @override
  Future<List<PhoneContactEntry>> getContactsByLabel(String labelId) async {
    final allContacts = await getAllContacts();
    return allContacts;
  }

  @override
  Future<List<PhoneContactEntry>> getContactsByList(String listId) async {
    return await getAllContacts();
  }

  @override
  Future<List<PhoneEntry>> getFavorites() async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.isStarred).map((e) => PhoneEntryImpl.fromContact(e)).toList();
  }

  @override
  Future<List<PhoneEntry>> getRecentlyAdded(int limit) async {
    final contacts = await getAll();
    contacts.sort((a, b) => b.id.compareTo(a.id));
    List<PhoneEntry> results = [];
    for (var contact in contacts.take(limit)) {
      final phoneEntries = contact.phoneNumbers
          .map((p) => PhoneEntryImpl(
            id: '${contact.id}_$p',
            phoneNumber: PhoneNumber(p),
            name: contact.displayName,
            avatar: contact.photoUrl
          ))
          .toList();
      results.addAll(phoneEntries);
    }
    return results;
  }

  @override
  Future<List<PhoneEntry>> getRecentlyContacted(int limit) async {
    return getRecentlyAdded(limit);
  }

  @override
  Future<List<PhoneEntry>> importContacts(List<PhoneEntry> contacts) async {
    List<PhoneEntry> importedContacts = [];
    for (var phoneEntry in contacts) {
      if (!await contactExists(phoneEntry.phoneNumber)) {
        final contact = PhoneContactEntry(
          id: '${DateTime.now().millisecondsSinceEpoch}_${phoneEntry.id}',
          displayName: phoneEntry.name ?? phoneEntry.phoneNumber.value,
          phoneNumbers: [phoneEntry.phoneNumber.value],
          photoUrl: phoneEntry.avatar
        );
        await save(contact);
        importedContacts.add(phoneEntry);
      }
    }
    return importedContacts;
  }

  @override
  Future<int> importContactsList(List<PhoneContactEntry> contacts) async {
    int count = 0;
    for (var contact in contacts) {
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
  Future<int> mergeDuplicates() async {
    final contacts = await getAll();
    Map<String, List<PhoneContactEntry>> phoneToContacts = {};
    for (var contact in contacts) {
      for (var phone in contact.phoneNumbers) {
        if (!phoneToContacts.containsKey(phone)) {
          phoneToContacts[phone] = [];
        }
        phoneToContacts[phone]!.add(contact);
      }
    }
    int mergedCount = 0;
    for (var phone in phoneToContacts.keys) {
      final duplicates = phoneToContacts[phone]!;
      if (duplicates.length > 1) {
        for (var i = 1; i < duplicates.length; i++) {
          await delete(duplicates[i]);
          mergedCount++;
        }
      }
    }
    return mergedCount;
  }

  @override
  Future<bool> removeFromFavorites(String contactId) async {
    final entry = await _localContactDataSource.getById(contactId);
    if (entry != null) {
      final updated = entry.copyWith(isStarred: false);
      await _localContactDataSource.update(updated);
      return true;
    }
    return false;
  }

  @override
  Future<PhoneContactEntry> save(PhoneContactEntry entity) async {
    await _localContactDataSource.insert(entity);
    return entity;
  }

  @override
  Future<List<PhoneContactEntry>> saveAll(List<PhoneContactEntry> entities) async {
    final List<PhoneContactEntry> savedEntities = [];
    for (final entity in entities) {
      await save(entity);
      savedEntities.add(entity);
    }
    return savedEntities;
  }

  @override
  Future<List<PhoneEntry>> searchByName(String name) async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.displayName.toLowerCase().contains(name.toLowerCase())).map((e) => PhoneEntryImpl.fromContact(e)).toList();
  }

  @override
  Future<bool> addContactToList(String contactId, String listId) async {
    return true;
  }

  @override
  Future<bool> removeContactFromList(String contactId, String listId) async {
    return true;
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
          name: contact.displayName,
          avatar: contact.photoUrl
        ));
      }
    }
    return phoneEntries;
  }

  @override
  Future<void> syncWithDeviceContacts() async {
    return;
  }

  @override
  Future<void> addContact(PhoneContactEntry contact) async {
    await save(contact);
  }

  @override
  Future<void> updateContact(PhoneContactEntry contact) async {
    await update(contact);
  }
}