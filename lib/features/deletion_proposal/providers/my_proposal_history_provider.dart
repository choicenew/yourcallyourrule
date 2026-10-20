import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/data/database/sync/device_id_service.dart';

import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/repositories/proposal_repository_impl.dart';

part 'my_proposal_history_provider.g.dart';

@riverpod
Future<List<MyProposalHistoryItem>> myProposalHistory(Ref ref) async {
  // 1. 获取设备 ID
  final deviceId = await ref.watch(deviceIdServiceProvider).getDeviceId();
  
  // 2. 获取 Repository
  final repo = ref.watch(proposalRepositoryProvider);
  
  // 3. 执行查询
  return repo.getMyProposalHistory(deviceId);
}