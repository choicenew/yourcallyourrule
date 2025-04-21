// 联系人仓库接口，用于处理联系人数据的存储和检索

import 'package:yourcallyourrule/core/repositories/base_repository.dart';

import '../entities/phone/phone_entry.dart';
import '../value_objects/phone_number.dart';

/// 联系人仓库接口
abstract class ContactRepository extends BaseRepository<PhoneEntry, String> {
  /// 根据电话号码获取联系人
  Future<PhoneEntry?> getByPhoneNumber(PhoneNumber phoneNumber);
  
  /// 根据名称搜索联系人
  Future<List<PhoneEntry>> searchByName(String name);
  
  /// 获取所有联系人（按名称排序）
  Future<List<PhoneEntry>> getAllSortedByName();
  
  /// 获取最近添加的联系人
  Future<List<PhoneEntry>> getRecentlyAdded(int limit);
  
  /// 获取最近联系的联系人
  Future<List<PhoneEntry>> getRecentlyContacted(int limit);
  
  /// 添加联系人到收藏夹
  Future<bool> addToFavorites(String contactId);
  
  /// 从收藏夹移除联系人
  Future<bool> removeFromFavorites(String contactId);
  
  /// 获取收藏的联系人
  Future<List<PhoneEntry>> getFavorites();
  
  /// 导入联系人
  Future<List<PhoneEntry>> importContacts(List<PhoneEntry> contacts);
  
  /// 导出联系人
  Future<List<PhoneEntry>> exportContacts();
  
  /// 同步联系人（与设备通讯录同步）
  Future<void> syncWithDeviceContacts();
  
  /// 获取联系人总数
  Future<int> getContactCount();
}