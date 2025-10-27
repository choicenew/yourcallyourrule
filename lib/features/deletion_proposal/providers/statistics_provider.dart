import 'package:riverpod_annotation/riverpod_annotation.dart';

// 引入所有必要的 Provider 和 Service
import 'package:yourcallyourrule/features/deletion_proposal/providers/deletion_proposal_service_provider.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_statistics_service.dart';

part 'statistics_provider.g.dart';

/// 一个【专属】的 FutureProvider，只负责异步获取“提议统计”数据。
///
/// 它与 `deletionProposalProvider` 完全解耦。
/// `autoDispose` 意味着当没有任何 Widget 监听它时，它会自动销毁，节省资源。
/// 再次被监听时，它会自动重新获取数据。
@riverpod
Future<Map<String, int>> proposalStatistics(Ref ref) {
  final service = ref.watch(deletionProposalServiceProvider);
  return service.getProposalStatistics();
}

/// 一个【专属】的 StreamProvider，只负责提供“用户投票总数”的流。
///
/// 它与 `deletionProposalProvider` 完全解耦。
@riverpod
Stream<int> userVoteCountStream(Ref ref) {
  final service = ref.watch(deletionProposalStatisticsServiceProvider);
  return service.voteCountStream;
}