import 'package:riverpod_annotation/riverpod_annotation.dart';

// 【MODIFIED】: 引入了新的 Repository Provider
import 'package:yourcallyourrule/features/deletion_proposal/providers/proposal_repository_provider.dart';

import 'package:yourcallyourrule/features/deletion_proposal/services/deletion_proposal_service.dart';

part 'deletion_proposal_service_provider.g.dart';

/// DeletionProposalService 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解，并从 `proposalRepositoryProvider` 获取依赖。
/// 这使得依赖关系更加清晰和可测试。
@riverpod
DeletionProposalService deletionProposalService(Ref ref) {
  final proposalRepository = ref.watch(proposalRepositoryProvider);
  final service = DeletionProposalService(
    proposalRepository: proposalRepository,
  );
  
  // Riverpod 3.0 中，如果 Service 不需要特殊的清理逻辑，可以不写 onDispose。
  // 如果需要，可以像这样添加：
  // ref.onDispose(() => service.dispose());
  
  return service;
}