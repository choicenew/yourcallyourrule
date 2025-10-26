import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/basic_provider/label_mark_statistics_repository_provider.dart';



import 'package:yourcallyourrule/data/repositories/label_mark_statistics_repository.dart'; 

import 'package:yourcallyourrule/core/value_objects/phone_number.dart';

part 'deletion_proposal_statistics_service.g.dart';

/// DeletionProposalStatisticsService 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解声明 Provider，自动处理依赖注入和实例生命周期。
@riverpod
DeletionProposalStatisticsService deletionProposalStatisticsService(Ref ref) {
  // 从 Provider 获取依赖。
  final repository = ref.watch(labelMarkStatisticsRepositoryProvider);
  return DeletionProposalStatisticsService(repository);
}

/// 删除提议统计服务类
/// 负责统计用户投票次数，并提供相关的统计功能。
class DeletionProposalStatisticsService {
  final LabelMarkStatisticsRepository _repository;
  
  // 【MODIFIED】: 移除了所有单例相关的代码（_instance, factory, _internal）。
  // REASON: Riverpod 提供了更优秀的、类型安全的单例和生命周期管理机制。
  DeletionProposalStatisticsService(this._repository);
  
  // --- 以下公共接口保持不变，因为它们的逻辑是正确的 ---

  /// 获取投票计数的流。
  Stream<int> get voteCountStream => _repository.markCountStream;
  
  /// 记录一次投票。
  Future<bool> recordVote(String phoneNumber, bool support) {
    return _repository.recordMark(
      PhoneNumber.fromString(phoneNumber), 
      support ? 'support' : 'oppose'
    );
  }
  
  /// 获取当前的投票总数。
  Future<int> getVoteCount() {
    return _repository.getMarkCount();
  }
  
  /// 重置投票计数。
  Future<void> resetVoteCount() {
    return _repository.resetMarkCount();
  }
  
  /// 获取所有的投票记录。
  Future<List<dynamic>> getAllVotes() {
    return _repository.getAll();
  }
  
  // 【MODIFIED】: 移除了 dispose 方法。
  // REASON: `_repository` 的生命周期应该由其自己的 Provider (labelMarkStatisticsRepositoryProvider) 管理。
  //         这个 Service 本身是无状态的，不需要手动清理。
}