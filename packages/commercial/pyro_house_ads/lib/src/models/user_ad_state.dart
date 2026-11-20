/// 用户广告生命周期状态 (用于动态调整内购与交叉导流的展示偏好)
enum UserAdState {
  /// 新用户 (优先展示温和内容与主产品 VIP 促销)
  newUser,

  /// 活跃用户 (按权重正常轮播 VIP 与兄弟 App 导流)
  active,

  /// 流失风险用户 (强推 VIP 挽留或高权重核心 App 交叉导流)
  churnRisk,
}
