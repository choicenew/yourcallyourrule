import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/contacts/data/models/contact_model.dart';
import 'package:yourcallyourrule/features/phone/entities/phone_entry.dart';
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
  Future<List<PhoneEntry>> searchByName(String name);
  Future<List<PhoneEntry>> getAllSortedByName();
  Future<List<PhoneEntry>> getRecentlyAdded(int limit);
  Future<List<PhoneEntry>> getRecentlyContacted(int limit);
  Future<bool> addToFavorites(String contactId);
  Future<bool> removeFromFavorites(String contactId);
  Future<List<PhoneEntry>> getFavorites();
  
  /// 根据标签获取联系人
  Future<List<PhoneContactEntry>> getContactsByLabel(String labelId);
  
  /// 根据列表获取联系人
  Future<List<PhoneContactEntry>> getContactsByList(String listId);
  
  /// 添加联系人到列表
  Future<bool> addContactToList(String contactId, String listId);
  
  /// 从列表中移除联系人
  Future<bool> removeContactFromList(String contactId, String listId);
  
  /// 批量导入联系人
  Future<int> importContactsList(List<PhoneContactEntry> contacts);
  
  /// 导出联系人数据
  Future<List<Map<String, dynamic>>> exportContactsData();
  
  /// 合并重复联系人
  Future<int> mergeDuplicates();

  /// 批量导入联系人（电话条目）
  Future<List<PhoneEntry>> importContacts(List<PhoneEntry> contacts);
  
  /// 导出联系人（电话条目）
  Future<List<PhoneEntry>> exportContacts();
  Future<void> syncWithDeviceContacts();
  Future<int> getContactCount();
}