/// 社区提议统计强类型实体类 (ProposalStatistics Entity)
/// 消除 `Map<String, int>` 弱类型字符串索引，符合清洁架构规范
class ProposalStatistics {
  final int totalPending;
  final int highRisk;
  final int mediumRisk;
  final int lowRisk;

  const ProposalStatistics({
    this.totalPending = 0,
    this.highRisk = 0,
    this.mediumRisk = 0,
    this.lowRisk = 0,
  });

  factory ProposalStatistics.fromMap(Map<String, int>? map) {
    if (map == null) return const ProposalStatistics();
    return ProposalStatistics(
      totalPending: map['totalPending'] ?? 0,
      highRisk: map['highRisk'] ?? 0,
      mediumRisk: map['mediumRisk'] ?? 0,
      lowRisk: map['lowRisk'] ?? 0,
    );
  }
}
