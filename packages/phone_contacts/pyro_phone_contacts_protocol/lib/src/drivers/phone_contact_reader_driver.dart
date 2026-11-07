import 'package:pyro_phone_contacts_protocol/src/models/phone_contact_entry.dart';

/// 系统联系人读取 Driver 抽象接口契约 (PhoneContactReaderDriver)
abstract class PhoneContactReaderDriver {
  Future<bool> isContact(String phoneNumber);
  Future<List<PhoneContactEntry>> getAllContacts();
}
