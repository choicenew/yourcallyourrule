
/// 定义“我的提议”的具体状态
enum MyProposalStatus {
  waitingForSync, // 还在本地 Pending 队列
  underReview,    // 服务器处理中 (Active 表)
  approved,       // 成功删除 (Active没了 & RemoteNumber没了)
  rejected,       // 被驳回 (Active没了 & RemoteNumber还在)
}

class MyProposalHistoryItem {
  final String phoneNumber;
  final DateTime submissionTime;
  final MyProposalStatus status;
  
  // 来自服务器的反馈信息 (仅在 underReview 时有效)
  final String? highestRiskLevel;
  final int currentVotes;
  final int verifiedOwnerCount;

  MyProposalHistoryItem({
    required this.phoneNumber,
    required this.submissionTime,
    required this.status,
    this.highestRiskLevel,
    this.currentVotes = 0,
    this.verifiedOwnerCount = 0,
  });
}