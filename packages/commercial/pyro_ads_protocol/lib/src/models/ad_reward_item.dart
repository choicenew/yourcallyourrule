/// 激励广告奖励回调数据模型
class MagmaRewardItem {
  final num amount;
  final String type;

  const MagmaRewardItem(this.amount, this.type);

  @override
  String toString() => 'MagmaRewardItem(type: $type, amount: $amount)';
}
