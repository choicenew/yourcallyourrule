import 'package:flutter/foundation.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';

/// 真实内存级系统联系人读取驱动 (MemoryPhoneContactReaderDriver)
class MemoryPhoneContactReaderDriver implements PhoneContactReaderDriver {
  final Map<String, PhoneContactEntry> _contacts = {};

  MemoryPhoneContactReaderDriver();

  @override
  Future<bool> isContact(String phoneNumber) async {
    return _contacts.values.any((c) => c.phoneNumbers.contains(phoneNumber));
  }

  @override
  Future<List<PhoneContactEntry>> getAllContacts() async {
    return _contacts.values.toList();
  }

  void addContact(PhoneContactEntry entry) {
    _contacts[entry.id] = entry;
    debugPrint('[MemoryContactsDriver] 录入联系人白名单: ${entry.displayName}');
  }
}
