
abstract class SubscriptionServiceBase<T, ID> {
  Future<List<T>> getEnabledSubscriptions();
  Future<void> enableSubscription(T subscription);
  Future<void> disableSubscription(T subscription);
  Future<bool> checkNeedUpdate(T subscription);
  Future<List<T>> updateSubscription(T subscription);
}
