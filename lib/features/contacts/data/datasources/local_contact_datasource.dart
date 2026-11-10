import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/contacts/data/datasources/contact_storage_driver.dart';

part 'local_contact_datasource.g.dart';

@Riverpod(keepAlive: true)
LocalContactDataSource localContactDataSource(Ref ref) {
  final driver = ref.watch(contactStorageDriverProvider);
  return LocalContactDataSource(driver);
}

class LocalContactDataSource {
  final ContactStorageDriver _driver;

  LocalContactDataSource(this._driver);

  Future<List<PhoneContactEntry>> getAll() async {
    final list = await _driver.queryAll();
    return list.map((m) => PhoneContactEntry.fromMap(m)).toList();
  }

  Future<PhoneContactEntry?> getById(String id) async {
    final map = await _driver.queryById(id);
    return map != null ? PhoneContactEntry.fromMap(map) : null;
  }

  Future<PhoneContactEntry?> getByPhoneNumber(String phoneNumber) async {
    final map = await _driver.queryByPhoneNumber(phoneNumber);
    return map != null ? PhoneContactEntry.fromMap(map) : null;
  }

  Future<String> insert(PhoneContactEntry contact) async {
    await _driver.insert(contact.toMap());
    return contact.id;
  }

  Future<int> update(PhoneContactEntry contact) async {
    await _driver.update(contact.id, contact.toMap());
    return 1;
  }

  Future<int> delete(String id) async {
    await _driver.delete(id);
    return 1;
  }

  Future<List<String>> insertAll(List<PhoneContactEntry> contacts) async {
    final ids = <String>[];
    for (final contact in contacts) {
      await _driver.insert(contact.toMap());
      ids.add(contact.id);
    }
    return ids;
  }

  Future<int> updateAll(List<PhoneContactEntry> contacts) async {
    for (final contact in contacts) {
      await _driver.update(contact.id, contact.toMap());
    }
    return contacts.length;
  }

  Future<int> deleteAll(List<String> ids) async {
    for (final id in ids) {
      await _driver.delete(id);
    }
    return ids.length;
  }

  Future<void> clear() async {
    final all = await getAll();
    await deleteAll(all.map((c) => c.id).toList());
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

  Future<int> count() async {
    return await _driver.count();
  }
}
