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

  /// 从数据库存储的字符串安全地创建枚举。
  /// 
  /// 如果输入字符串无法识别，会抛出异常，以暴露潜在的数据问题。
  factory ProposalStatus.fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ProposalStatus.pending;
      case 'approved':
        return ProposalStatus.approved;
      case 'rejected':
        return ProposalStatus.rejected;
      case 'expired':
        return ProposalStatus.expired;
      default:
        // 在生产环境中，我们不希望有未知状态。如果出现，应立即报错。
        throw ArgumentError('Unknown proposal status: $status');
    }
  }
}