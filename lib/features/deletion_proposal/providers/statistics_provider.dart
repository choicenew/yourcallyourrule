import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_service.dart';

part 'statistics_provider.g.dart';

@riverpod
Future<Map<String, int>> proposalStatistics(Ref ref) {
  final service = ref.watch(deletionProposalServiceProvider);
  return service.getProposalStatistics();
}

@riverpod
Stream<int> userVoteCountStream(Ref ref) {
  return Stream.value(0);
}
