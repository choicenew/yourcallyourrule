import 'dart:convert';
import 'dart:isolate';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_repository.dart';
import 'package:yourcallyourrule/features/contacts/data/repositories/contact_repository_impl.dart';
import 'package:yourcallyourrule/features/contacts/repositories/contact_subscription_repository.dart';
import 'package:yourcallyourrule/features/contacts/data/repositories/contact_subscription_repository_impl.dart';
import 'package:yourcallyourrule/features/contacts/services/contact_service.dart';

part 'contact_subscription_service.g.dart';

/// ContactSubscriptionService Riverpod Provider
@Riverpod(keepAlive: true)
ContactSubscriptionService contactSubscriptionService(Ref ref) {
  final contactSubscriptionRepository = ref.watch(contactSubscriptionRepositoryProvider);
  final contactRepository = ref.watch(contactRepositoryProvider);

  return ContactSubscriptionService(
    contactSubscriptionRepository,
    contactRepository,
  );
}

class ContactSubscriptionService {
  final ContactSubscriptionRepository _repository;
  final ContactRepository _contactRepository;
  final Uuid _uuid = const Uuid();

  ContactSubscriptionService(
    this._repository,
    this._contactRepository,
  );

  Future<List<PhoneSubscriptionPayload>> getAll() async {
    return await _repository.getAll();
  }

  Future<List<PhoneSubscriptionPayload>> getEnabledSubscriptions() async {
    final all = await _repository.getAll();
    return all.where((s) => (s.rawJsonMap['isEnabled'] as bool? ?? true)).toList();
  }

  Future<void> enableSubscription(PhoneSubscriptionPayload subscription) async {
    final updatedMap = Map<String, dynamic>.from(subscription.rawJsonMap);
    updatedMap['isEnabled'] = true;
    await _repository.save(subscription.copyWith(rawJsonMap: updatedMap));
  }

  Future<void> disableSubscription(PhoneSubscriptionPayload subscription) async {
    final updatedMap = Map<String, dynamic>.from(subscription.rawJsonMap);
    updatedMap['isEnabled'] = false;
    await _repository.save(subscription.copyWith(rawJsonMap: updatedMap));
  }

  Future<PhoneSubscriptionPayload> addSubscription(String name, String url, {bool isEnabled = true}) async {
    final payloadId = _uuid.v4();
    final newSubscription = PhoneSubscriptionPayload(
      payloadId: payloadId,
      kind: PhoneSubscriptionKind.phoneRules,
      rawJsonMap: {
        'id': payloadId,
        'name': name,
        'url': url,
        'isEnabled': isEnabled,
      },
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
    return await _repository.save(newSubscription);
  }

  Future<bool> deleteSubscription(String id) async {
    return await _repository.deleteById(id);
  }

  Future<void> performManualUpdate(PhoneSubscriptionPayload subscription) async {
    final isEnabled = subscription.rawJsonMap['isEnabled'] as bool? ?? true;
    if (!isEnabled) return;
    await _updateContactData(subscription);
  }

  Future<void> _updateContactData(PhoneSubscriptionPayload subscription) async {
    try {
      final url = subscription.rawJsonMap['url'] as String? ?? '';
      final contacts = await _parseContactData(url);
      await _importContacts(contacts);
    } catch (e) {
      throw Exception('数据更新失败: ${e.toString()}');
    }
  }

  Future<List<PhoneContactEntry>> _parseContactData(String data) async {
    try {
      return await Isolate.run(() {
        final jsonList = jsonDecode(data) as List<dynamic>;
        return jsonList.map((item) => PhoneContactEntry.fromMap(item as Map<String, dynamic>)).toList();
      });
    } catch (e) {
      throw FormatException('联系人数据解析失败: $e');
    }
  }

  Future<void> _importContacts(List<PhoneContactEntry> contacts) async {
    final contactService = ContactService(_contactRepository);
    await contactService.addOrUpdateContacts(contacts);
  }
}
