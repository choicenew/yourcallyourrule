// 订阅服务基类，用于处理应用内订阅功能

// 订阅服务基类，专注URL订阅管理
import '../base/base_service.dart';
import '../entities/subscription.dart';
import '../repositories/subscription_repository.dart';

// 新增方法实现
abstract class SubscriptionService extends BaseService<Subscription, String> {
  @override
  SubscriptionRepository get repository => super.repository as SubscriptionRepository;

  const SubscriptionService(SubscriptionRepository super.repository);

  // 获取所有启用订阅
  Future<List<Subscription>> getEnabledSubscriptions();
  
  // 根据类型获取订阅（黑/白名单）
  Future<List<Subscription>> getSubscriptionsByType(bool isWhitelist);
  
  // 添加或更新订阅
  @override
  Future<Subscription> save(Subscription entity);
  
  // 切换订阅启用状态
  Future<void> toggleSubscription(String id, bool enabled);
  
  // 强制立即更新订阅
  Future<void> forceUpdateSubscription(String id);
  
  // 获取最后更新时间
  Future<DateTime> getLastUpdateTime(String id);
  
  // 添加批量操作支持
  Future<int> batchToggleSubscriptions(List<String> ids, bool enabled) {
    return repository.batchUpdateStatus(ids, enabled);
  }

  // 新增URL检查方法
  Future<bool> existsByUrl(String url) async {
    try {
      return await repository.getByUrl(url) != null;
    } catch (e) {
      return false;
    }
  }
}




















