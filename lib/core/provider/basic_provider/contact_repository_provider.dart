import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/phone/phone_entry.dart';
import 'package:yourcallyourrule/core/entities/phone/phone_entry_impl.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/data/datasources/local/local_contact_datasource.dart';
import 'package:yourcallyourrule/data/models/contact_model.dart';

import '../datasource/local_contact_datasource_provider.dart';

/// 联系人仓库提供者
final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  final localContactDataSource = ref.watch(localContactDataSourceProvider);
  // 返回联系人仓库实现
  return ContactRepositoryImpl(localContactDataSource);
});

/// 联系人仓库实现类
class ContactRepositoryImpl implements ContactRepository {
  final LocalContactDataSource _localContactDataSource;

  ContactRepositoryImpl(this._localContactDataSource);

  @override
  Contact fromMap(Map<String, dynamic> map) {
    return _toEntity(ContactModel.fromMap(map));
  }

  @override
  Future<List<Contact>> getAll() async {
    final contactModels = await _localContactDataSource.getAll();
    return contactModels.map(_toEntity).toList();
  }

  @override
  Future<Contact?> getById(String id) async {
    final model = await _localContactDataSource.getById(id);
    if (model != null) {
      return _toEntity(model);
    }
    return null;
  }

  @override
  Future<Contact> update(Contact entity) async {
    final model = _toModel(entity);
    await _localContactDataSource.update(model);
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
    final contactModel = await _localContactDataSource.getByPhoneNumber(phoneNumber.value);
    return contactModel != null;
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
    final contactModel = await _localContactDataSource.getByPhoneNumber(phoneNumber.value);
    return contactModel != null ? _toEntity(contactModel) : null;
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

  Contact _toEntity(ContactModel model) {
    return Contact(
      id: model.id,
      name: model.name,
      phoneNumbers: model.phoneNumbers, // Directly use the list
      email: null, // email is not in ContactModel
      labelIds: model.labelIds,
      avatar: model.avatar,
      website: null, // website is not in ContactModel
      group: null, // group is not in ContactModel
      url: model.url,
      isFavorite: model.isFavorite,
    );
  }

  ContactModel _toModel(Contact entity) {
    return ContactModel(
      id: entity.id,
      name: entity.name,
      phoneNumbers: entity.phoneNumbers, // Directly use the list
      labelIds: entity.labelIds,
      avatar: entity.avatar,
     
      isFavorite: entity.isFavorite,
     
      url: entity.url,
    );
  }



  @override
  Future<bool> addToFavorites(String contactId) async {
    final contactModel = await _localContactDataSource.getById(contactId);
    if (contactModel != null) {
      final updatedContact = contactModel.copyWith(isFavorite: true);
      await _localContactDataSource.update(updatedContact);
      return true;
    }
    return false;
  }

  @override
  Future<int> count() async {
    return await _localContactDataSource.count();
  }

  @override
  Future<bool> delete(Contact entity) async {
    try {
      await _localContactDataSource.delete(entity.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAll(List<Contact> entities) async {
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
  Future<bool> exists(String id) async {
    final contact = await _localContactDataSource.getById(id);
    return contact != null;
  }

  @override
  Future<List<Contact>> findAll() {
    return getAllContacts();
  }

  @override
  Future<Contact?> findById(String id) async {
    final model = await _localContactDataSource.getById(id);
    if (model != null) {
      return _toEntity(model);
    }
    return null;
  }

  @override
  Future<List<Contact>> getAllContacts() async {
    final contactModels = await _localContactDataSource.getAll();
    return contactModels.map(_toEntity).toList();
  }

  @override
  Future<List<PhoneEntry>> getAllSortedByName() async {
    final contacts = await getAll();
    contacts.sort((a, b) => a.name.compareTo(b.name));
    List<PhoneEntry> results = [];
    for (var contact in contacts) {
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
  Future<Contact?> getContactByPhone(PhoneNumber phoneNumber) {
    return findContactByPhoneNumber(phoneNumber);
  }

  @override
  Future<int> getContactCount() {
    return count();
  }

  @override
  Future<List<Contact>> getContactsByLabel(String labelId) async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.labelIds?.contains(labelId) ?? false).toList();
  }

  @override
  Future<List<Contact>> getContactsByList(String listId) async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.group == listId).toList();
  }

  @override
  Future<List<PhoneEntry>> getFavorites() async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.isFavorite).map((e) => PhoneEntryImpl.fromContact(e)).toList();
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
            name: contact.name,
            avatar: contact.avatar
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
  Future<int> importContactsList(List<Contact> contacts) async {
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
    Map<String, List<Contact>> phoneToContacts = {};
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
  Future<bool> removeFromFavorites(String contactId) async {
    final contactModel = await _localContactDataSource.getById(contactId);
    if (contactModel != null) {
      final updatedContact = contactModel.copyWith(isFavorite: false);
      await _localContactDataSource.update(updatedContact);
      return true;
    }
    return false;
  }

  @override
  Future<Contact> save(Contact entity) async {
    final model = _toModel(entity);
    await _localContactDataSource.insert(model);
    return entity;
  }

  @override
  Future<List<Contact>> saveAll(List<Contact> entities) async {
    final List<Contact> savedEntities = [];
    for (final entity in entities) {
      await save(entity);
      savedEntities.add(entity);
    }
    return savedEntities;
  }

  @override
  Future<List<PhoneEntry>> searchByName(String name) async {
    final allContacts = await getAllContacts();
    return allContacts.where((c) => c.name.toLowerCase().contains(name.toLowerCase())).map((e) => PhoneEntryImpl.fromContact(e)).toList();
  }

  @override
  Future<bool> addContactToList(String contactId, String listId) {
    // Assuming listId is a labelId
    return _addOrRemoveLabel(contactId, listId, true);
  }

  @override
  Future<bool> removeContactFromList(String contactId, String listId) {
    // Assuming listId is a labelId
    return _addOrRemoveLabel(contactId, listId, false);
  }

  Future<bool> _addOrRemoveLabel(String contactId, String labelId, bool isAdding) async {
    final contactModel = await _localContactDataSource.getById(contactId);
    if (contactModel != null) {
      final labelIds = contactModel.labelIds?.toList() ?? [];
      if (isAdding) {
        if (!labelIds.contains(labelId)) {
          labelIds.add(labelId);
        }
      } else {
        labelIds.remove(labelId);
      }
      final updatedContact = contactModel.copyWith(labelIds: labelIds);
      await _localContactDataSource.update(updatedContact);
      return true;
    }
    return false;
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
    // This method requires a platform-specific implementation.
    // For now, it's a placeholder.
    return;
  }

  @override
  Future<void> addContact(Contact contact) async {
    await save(contact);
  }

  @override
  Future<void> updateContact(Contact contact) async {
    await update(contact);
  }
}
