import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_deletion_proposal_protocol/pyro_deletion_proposal_protocol.dart';

part 'deletion_proposal_control_center.g.dart';

@Riverpod(keepAlive: true)
DeletionProposalControlCenter deletionProposalControlCenter(Ref ref) {
  return DeletionProposalControlCenter.instance;
}

/// 删除提案中枢控制中心 (DeletionProposalControlCenter)
class DeletionProposalControlCenter {
  static final DeletionProposalControlCenter instance = DeletionProposalControlCenter._();

  DeletionProposalControlCenter._();

  ProposalStorageDriver? _storageDriver;

  void registerStorageDriver(ProposalStorageDriver driver) {
    _storageDriver = driver;
    debugPrint('[DeletionProposalHub] 已挂载注册存储驱动: ${driver.runtimeType}');
  }

  ProposalStorageDriver? get storageDriver => _storageDriver;

  /// 导入云端订阅推送的删除提案 JSON 载荷
  List<ProposalEntity> importSubscriptionPayload(Map<String, dynamic> rawJson) {
    final list = rawJson['proposals'] as List? ?? [];
    final results = <ProposalEntity>[];
    for (final item in list) {
      if (item is Map<String, dynamic>) {
        final entity = ProposalEntity.fromJson(item);
        results.add(entity);
        _storageDriver?.saveProposal(entity);
      }
    }
    debugPrint('[DeletionProposalHub] 导入云端删除提案载荷: ${results.length} 条');
    return results;
  }
}
