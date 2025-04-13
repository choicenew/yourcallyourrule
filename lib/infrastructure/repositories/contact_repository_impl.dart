import '../../domain/entities/contact/contact.dart';
import '../../domain/repositories/contact_repository.dart';
import '../../domain/value_objects/phone_number.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/local/database/dao/contact_dao.dart';
import 'base_repository_impl.dart';

/// 联系人仓库实现
/// 实现联系人仓库接口，提供联系人相关的数据操作
class ContactRepositoryImpl extends BaseRepositoryImpl<Contact, ContactDao> implements ContactRepository {
  ContactRepositoryImpl(AppDatabase database)
      : super(database, database.contactDao);
  
  @override
  Future<List<Contact>> searchContacts(String query) async {
    return await dao.search(query);
  }
  
  @override
  Future<Contact?> getByPhoneNumber(String phoneNumberValue) async {
    try {
      final phoneNumber = PhoneNumber(phoneNumberValue);
      return await dao.getByPhoneNumber(phoneNumber.normalized);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<Contact>> getFavorites() async {
    return await dao.getFavorites();
  }
  
  @override
  Future<void> syncContacts(List<Contact> contacts) async {
    // 使用事务确保同步操作的原子性
    await database.database.then((db) async {
      await db.transaction((txn) async {
        // 获取现有联系人
        final existingContacts = await getAll();
        final existingIds = existingContacts.map((c) => c.id).toSet();
        
        // 添加或更新联系人
        for (final contact in contacts) {
          if (existingIds.contains(contact.id)) {
            await update(contact);
          } else {
            await add(contact);
          }
        }
      });
    });
  }
  
  @override
  Future<void> toggleFavorite(String id) async {
    final contact = await getById(id);
    if (contact != null) {
      final updatedContact = contact.copyWith(isFavorite: !contact.isFavorite);
      await update(updatedContact);
    }
  }
}