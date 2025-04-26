// 订阅仓库接口，专注数据库操作
import 'package:yourcallyourrule/core/repositories/base_repository.dart';


import '../entities/subscription/subscription.dart';

// 补充方法参数校验
abstract class SubscriptionRepository extends BaseRepository<Subscription, String> {
  // 批量更新订阅状态
  Future<int> batchUpdateStatus(List<String> ids, bool isEnabled) {
    // 添加参数校验
    if (ids.isEmpty) throw ArgumentError("IDs不能为空");
    return _batchUpdateStatus(ids, isEnabled);
  }

  // 实际实现方法（示例）
  Future<int> _batchUpdateStatus(List<String> ids, bool isEnabled);


// 根据URL查询订阅
Future<Subscription?> getByUrl(String url);

// 更新最后更新时间
Future<void> updateLastUpdated(String id, DateTime time);

// 获取所有待更新订阅
Future<List<Subscription>> getPendingUpdateSubscriptions();

// 清除过期订阅（超过30天未更新）
Future<int> clearExpiredSubscriptions();
}