import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/repositories/base_repository.dart';

abstract class ContactSubscriptionRepository extends BaseRepository<ContactSubscription, String> {
  // 批量更新订阅状态（带参数校验）
  Future<int> batchUpdateStatus(List<String> ids, bool isEnabled) {
    if (ids.isEmpty) throw ArgumentError("IDs不能为空");
    return _batchUpdateStatus(ids, isEnabled);
  }
  
  Future<int> _batchUpdateStatus(List<String> ids, bool isEnabled);

  // 根据URL查询订阅
  Future<ContactSubscription?> getByUrl(String url);
  
  // 继承通用方法
  Future<void> updateLastUpdated(String id, DateTime time);
  
  Future<List<ContactSubscription>> getPendingUpdateSubscriptions();
  
  Future<int> clearExpiredSubscriptions();
  
  // 联系人订阅特有方法
  Future<List<ContactSubscription>> getByContactName(String name);
}