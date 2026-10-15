/// 通话统计周期强类型枚举
enum StatisticPeriod {
  /// 本周 (7 天)
  week,

  /// 本月 (30 天)
  month,

  /// 本年 (365 天)
  year;

  /// 从字符串安全创建枚举
  factory StatisticPeriod.fromString(String raw) {
    switch (raw.trim().toLowerCase()) {
      case 'month':
        return StatisticPeriod.month;
      case 'year':
        return StatisticPeriod.year;
      case 'week':
      default:
        return StatisticPeriod.week;
    }
  }
}
