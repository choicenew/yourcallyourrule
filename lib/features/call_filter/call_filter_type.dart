/// 通话过滤器类型枚举（彻底取代任何字符串标识）
enum CallFilterType {
  /// SIM 卡专属规则
  simSlotRule,

  /// 基础黑白名单与正则规则
  basicRule,

  /// 本地频次标记规则
  localCount,

  /// 云端号码库标记规则
  remoteNumber,
}
