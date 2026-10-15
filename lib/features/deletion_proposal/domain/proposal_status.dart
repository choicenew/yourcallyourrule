// file: lib/features/deletion_proposal/models/proposal_status.dart

/// 定义删除提议的生命周期状态。
enum ProposalStatus {
  /// 提议正在等待社区投票。
  pending,

  /// 提议已获得足够的支持，被批准。
  approved,

  /// 提议未获得足够的支持，被拒绝。
  rejected,

  /// 提议因超时或其他原因而关闭。
  expired;

  /// 从数据库存储的字符串或动态类型安全地创建枚举（带脏数据容错防倾覆降级）
  factory ProposalStatus.fromString(dynamic status) {
    if (status == null) return ProposalStatus.pending;
    switch (status.toString().trim().toLowerCase()) {
      case 'pending':
        return ProposalStatus.pending;
      case 'approved':
        return ProposalStatus.approved;
      case 'rejected':
        return ProposalStatus.rejected;
      case 'expired':
        return ProposalStatus.expired;
      default:
        return ProposalStatus.pending;
    }
  }
}
