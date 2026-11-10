import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_repository.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

part 'contact_repository_impl.g.dart';

@Riverpod(keepAlive: true)
ContactRepository contactRepository(Ref ref) {
  final db = ref.watch(localDatabaseProvider);
  return ContactRepositoryImpl(db);
}

class ContactRepositoryImpl implements ContactRepository {
  final LocalDatabase _db;
  final Uuid _uuid = const Uuid();

  ContactRepositoryImpl(this._db);

  ContactsCompanion _toCompanion(PhoneContactEntry contact) {
    final id = contact.id.isEmpty ? _uuid.v4() : contact.id;
    return ContactsCompanion.insert(
      id: id,
      phoneNumber: contact.phoneNumbers.isNotEmpty ? contact.phoneNumbers.first : '',
      name: contact.displayName,
      avatar: Value(contact.photoUrl),
      isFavorite: Value(contact.isStarred ? 1 : 0),
      lastUpdated: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<List<PhoneContactEntry>> getAll() async {
    final rows = await _db.select(_db.contacts).get();
    return rows.map((row) => PhoneContactEntry.fromMap(row.toJson())).toList();
  }

  @override
  Future<PhoneContactEntry?> getById(String id) async {
    final row = await (_db.select(_db.contacts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? PhoneContactEntry.fromMap(row.toJson()) : null;
  }

  @override
  Future<PhoneContactEntry> save(PhoneContactEntry entity) async {
    await _db.into(_db.contacts).insertOnConflictUpdate(_toCompanion(entity));
    return entity;
  }

  @override
  Future<PhoneContactEntry> update(PhoneContactEntry entity) async {
    await save(entity);
    return entity;
  }

  @override
  Future<bool> delete(PhoneContactEntry entity) async {
    return await deleteById(entity.id);
  }

  @override
  Future<bool> deleteById(String id) async {
    final count = await (_db.delete(_db.contacts)..where((tbl) => tbl.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<bool> deleteAll(List<PhoneContactEntry> entities) async {
    for (var entity in entities) {
      await deleteById(entity.id);
    }
    return true;
  }

  Future<List<PhoneContactEntry>> saveAll(List<PhoneContactEntry> entities) async {
    for (var entity in entities) {
      await save(entity);
    }
    return entities;
  }

  Future<bool> exists(String id) async {
    final entity = await getById(id);
    return entity != null;
  }

  @override
  Future<int> count() async {
    final list = await getAll();
    return list.length;
  }

  @override
  Future<bool> addToFavorites(String contactId) async {
    final entry = await getById(contactId);
    if (entry != null) {
      await save(entry.copyWith(isStarred: true));
      return true;
    }
    return false;
  }

  @override
  Future<bool> removeFromFavorites(String contactId) async {
    final entry = await getById(contactId);
    if (entry != null) {
      await save(entry.copyWith(isStarred: false));
      return true;
    }
    return false;
  }

  @override
  Future<bool> contactExists(PhoneNumber phoneNumber) async {
    final entry = await findContactByPhoneNumber(phoneNumber);
    return entry != null;
  }

  @override
  Future<bool> contactExistsAny(List<PhoneNumber> phoneNumbers) async {
    for (var phone in phoneNumbers) {
      if (await contactExists(phone)) return true;
    }
    return false;
  }

  @override
  Future<PhoneContactEntry?> findContactByPhoneNumber(PhoneNumber phoneNumber) async {
    final row = await (_db.select(_db.contacts)..where((tbl) => tbl.phoneNumber.equals(phoneNumber.value))).getSingleOrNull();
    return row != null ? PhoneContactEntry.fromMap(row.toJson()) : null;
  }

  @override
  Future<void> deleteContact(PhoneNumber phoneNumber) async {
    final contact = await findContactByPhoneNumber(phoneNumber);
    if (contact != null) {
      await deleteById(contact.id);
    }
  }

  @override
  Future<void> deleteContactByUrl(String url) async {
    final list = await getAll();
    final match = list.firstWhere((c) => c.photoUrl == url, orElse: () => throw Exception('Contact not found'));
    await deleteById(match.id);
  }

  @override
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers) async {
    for (var phone in phoneNumbers) {
      await deleteContact(phone);
    }
  }

  @override
  Future<List<Map<String, dynamic>>> exportContactsData() async {
    final list = await getAll();
    return list.map((c) => c.toMap()).toList();
  }

  @override
  Future<List<PhoneContactEntry>> getAllContacts() async {
    return await getAll();
  }

  @override
  Future<List<PhoneContactEntry>> getAllSortedByName() async {
    final list = await getAll();
    list.sort((a, b) => a.displayName.compareTo(b.displayName));
    return list;
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
    return await getAll();
  }

  @override
  Future<List<PhoneContactEntry>> getFavorites() async {
    final list = await getAll();
    return list.where((c) => c.isStarred).toList();
  }

  @override
  Future<List<PhoneContactEntry>> getRecentlyAdded(int limit) async {
    final list = await getAll();
    return list.take(limit).toList();
  }

  @override
  Future<int> importContactsList(List<PhoneContactEntry> contacts) async {
    int imported = 0;
    for (var contact in contacts) {
      await save(contact);
      imported++;
    }
    return imported;
  }

  @override
  Future<List<PhoneContactEntry>> searchByName(String name) async {
    final list = await getAll();
    return list.where((c) => c.displayName.toLowerCase().contains(name.toLowerCase())).toList();
  }

  @override
  Future<void> syncWithDeviceContacts() async {}

  @override
  Future<void> addContact(PhoneContactEntry contact) async {
    await save(contact);
  }

  @override
  Future<void> updateContact(PhoneContactEntry contact) async {
    await save(contact);
  }
}
