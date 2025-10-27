import 'package:yourcallyourrule/features/deletion_proposal/domain/proposal_status.dart';

/// 定义排序的类型
enum ProposalSortType {
  /// 按创建时间（从新到旧）
  newest,
  /// 按创建时间（从旧到新）
  oldest,
  /// 按提议热度（从高到低）
  mostPopular,
  /// 按提议热度（从低到高）
  leastPopular,
}

/// 统一管理提议列表的筛选和排序选项
class ProposalListOptions {
  /// 筛选：提议状态 (e.g., pending, approved)
  final ProposalStatus? status;
  /// 筛选：风险等级 (e.g., 'Verified', 'High')
  final String? riskLevel;
  /// 筛选：只显示由所有者验证的提议
  final bool? onlyVerifiedOwner;
  /// 排序：列表的排序方式
  final ProposalSortType sortType;

  const ProposalListOptions({
    this.status,
    this.riskLevel,
    this.onlyVerifiedOwner,
    this.sortType = ProposalSortType.newest, // 默认按最新排序
  });

  /// 创建一个清除了所有筛选条件的实例
  ProposalListOptions clearFilters() {
    return ProposalListOptions(
      sortType: sortType, // 保留当前的排序方式
    );
  }

  /// 创建一个带有更新状态的副本
  ProposalListOptions copyWith({
    ProposalStatus? status,
    String? riskLevel,
    bool? onlyVerifiedOwner,
    ProposalSortType? sortType,
  }) {
    return ProposalListOptions(
      status: status ?? this.status,
      riskLevel: riskLevel ?? this.riskLevel,
      onlyVerifiedOwner: onlyVerifiedOwner ?? this.onlyVerifiedOwner,
      sortType: sortType ?? this.sortType,
    );
  }
  
  /// 检查当前是否有任何筛选条件被激活
  bool get hasActiveFilters => status != null || riskLevel != null || onlyVerifiedOwner != null;
}