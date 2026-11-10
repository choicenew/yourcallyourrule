import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';

abstract class ContactSubscriptionRepository {
  Future<List<PhoneSubscriptionPayload>> getAll();
  Future<PhoneSubscriptionPayload?> getById(String id);
  Future<PhoneSubscriptionPayload> save(PhoneSubscriptionPayload entity);
  Future<PhoneSubscriptionPayload> update(PhoneSubscriptionPayload entity);
  Future<bool> deleteById(String id);
  Future<bool> delete(PhoneSubscriptionPayload entity);
  Future<bool> deleteAll(List<PhoneSubscriptionPayload> entities);
  Future<int> count();

  Future<PhoneSubscriptionPayload?> getByUrl(String url);
}
