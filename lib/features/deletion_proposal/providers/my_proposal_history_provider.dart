import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/device/providers/device_management_provider.dart';

import 'package:yourcallyourrule/features/deletion_proposal/models/proposal_history_item.dart';
import 'package:yourcallyourrule/features/deletion_proposal/data/repositories/proposal_repository_impl.dart';

part 'my_proposal_history_provider.g.dart';

@riverpod
Future<List<MyProposalHistoryItem>> myProposalHistory(Ref ref) async {
  // 1. 获取设备 ID
  final deviceId = await ref.watch(deviceManagementServiceProvider).getCurrentDeviceId();
  
  // 2. 获取 Repository
  final repo = ref.watch(proposalRepositoryProvider);
  
  // 3. 执行查询
  return repo.getMyProposalHistory(deviceId);
}