import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
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
    final contactToDelete = contacts.firstWhere((contact) => contact.url == url, orElse: () => throw Exception('Contact not found'));
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
      final updated = entry.copyWith(isFavorite: true);
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
  Future<List<PhoneContactEntry>> getAllSortedByName() async {
    final contacts = await getAll();
    contacts.sort((a, b) => a.displayName.compareTo(b.displayName));
    return contacts;
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
    return allContacts.where((c) => c.tags.contains(labelId)).toList();
  }

  @override
  Future<List<PhoneContactEntry>> getFavorites() async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.isFavorite).toList();
  }

  @override
  Future<List<PhoneContactEntry>> getRecentlyAdded(int limit) async {
    final contacts = await getAll();
    contacts.sort((a, b) => b.id.compareTo(a.id));
    return contacts.take(limit).toList();
  }

  @override
  Future<int> importContactsList(List<PhoneContactEntry> contacts) async {
    int imported = 0;
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
        imported++;
      }
    }
    return imported;
  }

  @override
  Future<bool> removeFromFavorites(String contactId) async {
    final entry = await _localContactDataSource.getById(contactId);
    if (entry != null) {
      final updated = entry.copyWith(isFavorite: false);
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
  Future<List<PhoneContactEntry>> searchByName(String name) async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.displayName.toLowerCase().contains(name.toLowerCase())).toList();
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
