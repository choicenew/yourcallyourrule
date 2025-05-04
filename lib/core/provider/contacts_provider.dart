import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/repositories/contact_repository.dart';
import 'providers.dart';

/// 联系人数据状态的Notifier类
class ContactsNotifier extends AsyncNotifier<List<Contact>> {
  late final ContactRepository _contactRepository;

  @override
  Future<List<Contact>> build() async {
    // 初始化仓库
    _initRepository();
    // 加载所有联系人
    return _loadContacts();
  }

  void _initRepository() {
    // 获取仓库实例
    _contactRepository = ref.read(contactRepositoryProvider);
  }

  Future<List<Contact>> _loadContacts() async {
    try {
      // 获取所有联系人
      return await _contactRepository.getAll();
    } catch (e) {
      // 错误处理
      state = AsyncValue.error(e, StackTrace.current);
      return [];
    }
  }

  /// 添加联系人
  Future<void> addContact(Contact contact) async {
    state = const AsyncValue.loading();
    try {
      await _contactRepository.save(contact);
      state = AsyncValue.data(await _loadContacts());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 更新联系人
  Future<void> updateContact(Contact contact) async {
    state = const AsyncValue.loading();
    try {
      await _contactRepository.update(contact);
      state = AsyncValue.data(await _loadContacts());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// 删除联系人
  Future<void> deleteContact(String contactId) async {
    state = const AsyncValue.loading();
    try {
      // 使用deleteById方法，它接受String类型的ID
      await _contactRepository.deleteById(contactId);
      state = AsyncValue.data(await _loadContacts());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

/// 联系人数据提供者
final contactsProvider = AsyncNotifierProvider<ContactsNotifier, List<Contact>>(() {
  return ContactsNotifier();
});