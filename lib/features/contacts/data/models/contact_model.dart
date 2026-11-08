import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/data/database/local/local_database.dart';

/// 自动可生成的映射器工具 (Entity <-> Drift Companion/Data)
abstract class ContactModelMapper {
  static PhoneContactEntry fromData(ContactData data) {
    return PhoneContactEntry(
      id: data.id,
      displayName: data.name,
      phoneNumbers: (jsonDecode(data.phoneNumber) as List<dynamic>).cast<String>(),
      photoUrl: data.avatar,
      isStarred: data.isFavorite == 1,
    );
  }

  static ContactsCompanion toCompanion(PhoneContactEntry entry) {
    return ContactsCompanion(
      id: Value(entry.id),
      name: Value(entry.displayName),
      phoneNumber: Value(jsonEncode(entry.phoneNumbers)),
      avatar: Value(entry.photoUrl),
      isFavorite: Value(entry.isStarred ? 1 : 0),
      lastUpdated: Value(DateTime.now().toIso8601String()),
    );
  }
}