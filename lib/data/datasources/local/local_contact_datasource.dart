import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/data/models/contact_model.dart';

import '../../database/local/local_database.dart';
import '../datasource_interface.dart';

class LocalContactDataSource implements LocalDataSource<ContactModel> {
  final LocalDatabase _database;

  LocalContactDataSource(this._database);

  ContactModel _fromData(ContactData data) {
    return ContactModel(
      id: data.id,
      name: data.name,
      phoneNumbers: (jsonDecode(data.phoneNumber) as List<dynamic>).cast<String>(),
      avatar: data.avatar,
      labelIds: data.labelIds != null ? (jsonDecode(data.labelIds!) as List<dynamic>).cast<String>() : null,
      isFavorite: data.isFavorite == 1,
      // The following fields are not in ContactData, so they will be null or default.
      // You might need to adjust your model or database schema if these are required.
      email: null, 
      website: null,
      group: null,
      url: data.url,
    );
  }

  ContactsCompanion _toCompanion(ContactModel contact) {
    return ContactsCompanion(
      id: Value(contact.id),
      name: Value(contact.name),
      phoneNumber: Value(jsonEncode(contact.phoneNumbers)),
      avatar: Value(contact.avatar),
      labelIds: Value(contact.labelIds != null ? jsonEncode(contact.labelIds) : null),
      isFavorite: Value(contact.isFavorite ? 1 : 0),
      url: Value(contact.url),
      lastUpdated: Value(DateTime.now().toIso8601String()), // Assuming lastUpdated should be set on every write
    );
  }

  @override
  Future<List<ContactModel>> getAll() async {
    final data = await _database.select(_database.contacts).get();
    return data.map(_fromData).toList();
  }

  @override
  Future<ContactModel?> getById(String id) async {
    final data = await (_database.select(_database.contacts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? _fromData(data) : null;
  }

  @override
  Future<String> insert(ContactModel contact) async {
    final id = contact.id.isEmpty ? const Uuid().v4() : contact.id;
    final companion = _toCompanion(contact).copyWith(id: Value(id));
    await _database.into(_database.contacts).insert(companion, mode: InsertMode.replace);
    return id;
  }

  @override
  Future<int> update(ContactModel contact) async {
    return await (_database.update(_database.contacts)..where((tbl) => tbl.id.equals(contact.id))).write(_toCompanion(contact));
  }

  @override
  Future<int> delete(String id) async {
    return await (_database.delete(_database.contacts)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<List<String>> insertAll(List<ContactModel> contacts) async {
    final ids = <String>[];
    await _database.batch((batch) {
      for (final contact in contacts) {
        final id = contact.id.isEmpty ? const Uuid().v4() : contact.id;
        ids.add(id);
        final companion = _toCompanion(contact).copyWith(id: Value(id));
        batch.insert(_database.contacts, companion, mode: InsertMode.replace);
      }
    });
    return ids;
  }

  @override
  Future<int> updateAll(List<ContactModel> contacts) async {
    await _database.batch((batch) {
      for (final contact in contacts) {
        batch.update(
          _database.contacts,
          _toCompanion(contact),
          where: (tbl) => tbl.id.equals(contact.id),
        );
      }
    });
    return contacts.length;
  }

  @override
  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.contacts)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  @override
  Future<void> clear() async {
    await _database.delete(_database.contacts).go();
  }

  @override
  Future<String> exportData() async {
    final contacts = await getAll();
    return jsonEncode(contacts.map((contact) => contact.toMap()).toList());
  }

  @override
  Future<bool> importData(String data) async {
    try {
      final List<dynamic> contactMaps = jsonDecode(data) as List<dynamic>;
      final contacts = contactMaps.map((map) => ContactModel.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(contacts);
      return true;
    } catch (e) {
      print('Error importing contact data: $e');
      return false;
    }
  }

  // =======================================================================
  // Custom Queries
  // =======================================================================

  Future<ContactModel?> getByPhoneNumber(String phoneNumber) async {
    // In Drift, we can't use LIKE on a JSON string as reliably as in sqflite for this purpose.
    // A more robust way is to fetch all and filter in Dart, or use a custom query.
    // For simplicity and correctness, let's filter in Dart.
    // This can be inefficient for large datasets.
    final allContacts = await getAll();
    for (final contact in allContacts) {
      if (contact.phoneNumbers.contains(phoneNumber)) {
        return contact;
      }
    }
    return null;
    
    // Alternative with custom query (might be better for performance)
    /*
    final escapedPhoneNumber = jsonEncode(phoneNumber); // '"1234567890"'
    final query = customSelect(
      'SELECT * FROM contacts WHERE json_extract(phone_numbers, '$') LIKE ?',
      variables: [Variable.withString('%$escapedPhoneNumber%')],
      readsFrom: {contacts},
    );
    final result = await query.getSingleOrNull();
    return result != null ? _fromData(ContactData.fromData(result.data)) : null;
    */
  }

  Future<int> count() async {
    final expression = countAll();
    final query = _database.selectOnly(_database.contacts)..addColumns([expression]);
    final result = await query.map((row) => row.read(expression)).getSingle();
    return result ?? 0; // 确保返回非空 int
  }
}