import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_repository.dart';
import 'package:yourcallyourrule/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:yourcallyourrule/features/contacts/data/models/contact_model.dart';

/// 联系人数据状态的 Notifier
class ContactsNotifier extends AsyncNotifier<List<Contact>> {
  late final ContactRepository _contactRepository;

  @override
  Future<List<Contact>> build() async {
    _initRepository();
    return _loadContacts();
  }

  void _initRepository() {
    _contactRepository = ref.read(contactRepositoryProvider);
  }

  Future<List<Contact>> _loadContacts() async {
    try {
      return await _contactRepository.getAll();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return [];
    }
  }

  /// 添加联系人
  Future<void> addContact(Contact contact) async {
    state = const AsyncValue.loading();
    try {
      await _contactRepository.save(contact);
      state = AsyncValue.data(await _loadContacts());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 更新联系人
  Future<void> updateContact(Contact contact) async {
    state = const AsyncValue.loading();
    try {
      await _contactRepository.update(contact);
      state = AsyncValue.data(await _loadContacts());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 删除联系人
  Future<void> deleteContact(String contactId) async {
    state = const AsyncValue.loading();
    try {
      await _contactRepository.deleteById(contactId);
      state = AsyncValue.data(await _loadContacts());
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

/// 联系人数据提供者
final contactsProvider = AsyncNotifierProvider<ContactsNotifier, List<Contact>>(() {
  return ContactsNotifier();
});