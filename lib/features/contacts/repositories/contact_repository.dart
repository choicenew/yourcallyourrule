import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

/// 联系人仓库接口，定义统一的 PhoneContactEntry CRUD 管道
abstract class ContactRepository {
  Future<List<PhoneContactEntry>> getAll();
  Future<PhoneContactEntry?> getById(String id);
  Future<PhoneContactEntry> save(PhoneContactEntry entity);
  Future<PhoneContactEntry> update(PhoneContactEntry entity);
  Future<bool> deleteById(String id);
  Future<bool> delete(PhoneContactEntry entity);
  Future<bool> deleteAll(List<PhoneContactEntry> entities);
  Future<int> count();

  Future<void> deleteContactByUrl(String url);
  Future<bool> contactExists(PhoneNumber phoneNumber);
  Future<bool> contactExistsAny(List<PhoneNumber> phoneNumbers);
  Future<PhoneContactEntry?> findContactByPhoneNumber(PhoneNumber phoneNumber);
  Future<void> deleteContact(PhoneNumber phoneNumber);
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers);
  Future<void> updateContact(PhoneContactEntry contact);
  Future<void> addContact(PhoneContactEntry contact);

  Future<List<PhoneContactEntry>> getAllContacts();
  Future<PhoneContactEntry?> getContactByPhone(PhoneNumber phoneNumber);
  Future<List<PhoneContactEntry>> searchByName(String name);
  Future<List<PhoneContactEntry>> getAllSortedByName();
  Future<List<PhoneContactEntry>> getRecentlyAdded(int limit);
  Future<bool> addToFavorites(String contactId);
  Future<bool> removeFromFavorites(String contactId);
  Future<List<PhoneContactEntry>> getFavorites();
  
  /// 根据标签获取联系人
  Future<List<PhoneContactEntry>> getContactsByLabel(String labelId);
  
  /// 批量导入联系人
  Future<int> importContactsList(List<PhoneContactEntry> contacts);
  
  /// 导出联系人数据
  Future<List<Map<String, dynamic>>> exportContactsData();
  
  Future<void> syncWithDeviceContacts();
  Future<int> getContactCount();
}