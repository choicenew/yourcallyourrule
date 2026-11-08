import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/data/database/database_service.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';
import 'package:yourcallyourrule/features/contacts/data/models/contact_model.dart';

part 'local_contact_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalContactDataSource localContactDataSource(Ref ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return databaseService.localContactDataSource;
}

class LocalContactDataSource {
  final LocalDatabase _database;

  LocalContactDataSource(this._database);

  Future<List<PhoneContactEntry>> getAll() async {
    final data = await _database.select(_database.contacts).get();
    return data.map(ContactModelMapper.fromData).toList();
  }

  Future<PhoneContactEntry?> getById(String id) async {
    final data = await (_database.select(_database.contacts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return data != null ? ContactModelMapper.fromData(data) : null;
  }

  Future<String> insert(PhoneContactEntry contact) async {
    final id = contact.id.isEmpty ? const Uuid().v4() : contact.id;
    final companion = ContactModelMapper.toCompanion(contact).copyWith(id: Value(id));
    await _database.into(_database.contacts).insert(companion, mode: InsertMode.replace);
    return id;
  }

  Future<int> update(PhoneContactEntry contact) async {
    return await (_database.update(_database.contacts)..where((tbl) => tbl.id.equals(contact.id))).write(ContactModelMapper.toCompanion(contact));
  }

  Future<int> delete(String id) async {
    return await (_database.delete(_database.contacts)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<String>> insertAll(List<PhoneContactEntry> contacts) async {
    final ids = <String>[];
    await _database.batch((batch) {
      for (final contact in contacts) {
        final id = contact.id.isEmpty ? const Uuid().v4() : contact.id;
        ids.add(id);
        final companion = ContactModelMapper.toCompanion(contact).copyWith(id: Value(id));
        batch.insert(_database.contacts, companion, mode: InsertMode.replace);
      }
    });
    return ids;
  }

  Future<int> updateAll(List<PhoneContactEntry> contacts) async {
    await _database.batch((batch) {
      for (final contact in contacts) {
        batch.update(
          _database.contacts,
          ContactModelMapper.toCompanion(contact),
          where: (tbl) => tbl.id.equals(contact.id),
        );
      }
    });
    return contacts.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    if (ids.isEmpty) return 0;
    return await (_database.delete(_database.contacts)..where((tbl) => tbl.id.isIn(ids))).go();
  }

  Future<void> clear() async {
    await _database.delete(_database.contacts).go();
  }

  Future<String> exportData() async {
    final contacts = await getAll();
    return jsonEncode(contacts.map((contact) => contact.toMap()).toList());
  }

  Future<bool> importData(String data) async {
    try {
      final List<dynamic> contactMaps = jsonDecode(data) as List<dynamic>;
      final contacts = contactMaps.map((map) => PhoneContactEntry.fromMap(map as Map<String, dynamic>)).toList();
      await insertAll(contacts);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<PhoneContactEntry?> getByPhoneNumber(String phoneNumber) async {
    final allContacts = await getAll();
    for (final contact in allContacts) {
      if (contact.phoneNumbers.contains(phoneNumber)) {
        return contact;
      }
    }
    return null;
  }

  Future<int> count() async {
    final expression = countAll();
    final query = _database.selectOnly(_database.contacts)..addColumns([expression]);
    final result = await query.map((row) => row.read(expression)).getSingle();
    return result ?? 0;
  }
}