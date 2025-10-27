import 'package:riverpod_annotation/riverpod_annotation.dart';

// 引入您项目中真实存在的 DeletionProposalStatisticsService Provider
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_statistics_service.dart';

part 'vote_count_provider.g.dart';

/// 一个专门用于提供用户总投票数流的 StreamProvider。
///
/// 【MODIFIED】: 这是一个全新的、之前被遗漏的 Provider。
/// REASON: 这是 Riverpod 中处理流数据的最佳实践，它将流的监听和状态管理
///         封装在一个独立的、可复用的 Provider 中。
@riverpod
Stream<int> voteCountStream(Ref ref) {
  // 1. `watch` 统计服务，当服务本身或其依赖变化时，可以重建这个流。
  final statisticsService = ref.watch(deletionProposalStatisticsServiceProvider);
  
  // 2. 返回服务中定义的 `voteCountStream`。
  return statisticsService.voteCountStream;
}