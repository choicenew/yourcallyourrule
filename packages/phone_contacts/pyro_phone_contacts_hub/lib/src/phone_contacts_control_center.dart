import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';

part 'phone_contacts_control_center.g.dart';

@Riverpod(keepAlive: true)
PhoneContactsControlCenter phoneContactsControlCenter(Ref ref) {
  return PhoneContactsControlCenter.instance;
}

/// 联系人中枢控制中心 (PhoneContactsControlCenter)
class PhoneContactsControlCenter {
  static final PhoneContactsControlCenter instance = PhoneContactsControlCenter._();

  PhoneContactsControlCenter._();

  PhoneContactReaderDriver? _readerDriver;

  void registerReaderDriver(PhoneContactReaderDriver driver) {
    _readerDriver = driver;
    debugPrint('[PhoneContactsHub] 已挂载注册联系人读取驱动: ${driver.runtimeType}');
  }

  PhoneContactReaderDriver? get readerDriver => _readerDriver;

  Future<bool> isContact(String phoneNumber) async {
    return await _readerDriver?.isContact(phoneNumber) ?? false;
  }

  Future<List<PhoneContactEntry>> getAllContacts() async {
    return await _readerDriver?.getAllContacts() ?? [];
  }
}
