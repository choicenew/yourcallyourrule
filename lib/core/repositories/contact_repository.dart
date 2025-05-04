// 联系人仓库接口，用于处理联系人数据的存储和检索

import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';

import '../entities/phone/phone_entry.dart';
import '../value_objects/phone_number.dart';

/// 联系人仓库接口
abstract class ContactRepository extends BaseRepository<Contact, String> {
  // 添加缺失的方法声明
  Future<void> deleteContactByUrl(String url);

  // 修改参数类型为PhoneNumber
  Future<bool> contactExists(PhoneNumber phoneNumber);
  Future<bool> contactExistsAny(List<PhoneNumber> phoneNumbers);
  Future<Contact?> findContactByPhoneNumber(PhoneNumber phoneNumber);
  Future<void> deleteContact(PhoneNumber phoneNumber);
  Future<void> deleteContacts(List<PhoneNumber> phoneNumbers);
  Future<void> updateContact(Contact contact);
  Future<void> addContact(Contact contact);

  Future<List<Contact>> getAllContacts();
  Future<Contact?> getContactByPhone(PhoneNumber phoneNumber);
  Future<List<PhoneEntry>> searchByName(String name);
  Future<List<PhoneEntry>> getAllSortedByName();
  Future<List<PhoneEntry>> getRecentlyAdded(int limit);
  Future<List<PhoneEntry>> getRecentlyContacted(int limit);
  Future<bool> addToFavorites(String contactId);
  Future<bool> removeFromFavorites(String contactId);
  Future<List<PhoneEntry>> getFavorites();
  
  /// 根据标签获取联系人
  Future<List<Contact>> getContactsByLabel(String labelId);
  
  /// 根据列表获取联系人
  Future<List<Contact>> getContactsByList(String listId);
  
  /// 添加联系人到列表
  Future<bool> addContactToList(String contactId, String listId);
  
  /// 从列表中移除联系人
  Future<bool> removeContactFromList(String contactId, String listId);
  
  /// 批量导入联系人
  Future<int> importContactsList(List<Contact> contacts);
  
  /// 导出联系人
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