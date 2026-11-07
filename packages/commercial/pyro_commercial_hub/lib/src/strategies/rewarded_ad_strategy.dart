/// 激励广告转化策略接口
abstract class RewardedAdStrategy {
  /// 获得奖励所需的视频观看次数
  int get requiredAdCount;

  /// 奖励持续的天数
  int get rewardDays;

  /// 当达到奖励门槛时计算新的到期时间
  DateTime calculateExpiryDate(DateTime? currentExpiryDate) {
    final now = DateTime.now();
    final baseTime = (currentExpiryDate != null && currentExpiryDate.isAfter(now))
        ? currentExpiryDate
        : now;
    return baseTime.add(Duration(days: rewardDays));
  }
}

/// 默认看 5 次广告换 1 天 VIP 特权策略
class DefaultFiveAdVipStrategy extends RewardedAdStrategy {
  @override
  final int requiredAdCount;

  @override
  final int rewardDays;

  DefaultFiveAdVipStrategy({
    this.requiredAdCount = 5,
    this.rewardDays = 1,
  });
}
