import '../entities/contact/contact.dart';
import 'base_repository.dart';

/// 联系人仓库接口
/// 定义联系人相关的数据操作
abstract class ContactRepository extends BaseRepository<Contact> {
  /// 根据电话号码获取联系人
  Future<Contact?> getByPhoneNumber(String phoneNumber);
  
  /// 获取收藏的联系人
  Future<List<Contact>> getFavorites();
  
  /// 搜索联系人
  Future<List<Contact>> search(String query);
  
  /// 同步联系人
  Future<int> syncContacts(List<Contact> contacts);
  
  /// 获取联系人总数
  Future<int> getCount();
}