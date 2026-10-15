/// 通知类型强类型枚举
enum NotificationCategory {
  /// 通话历史记录
  callHistory,

  /// 欺诈预警
  fraudAlert,

  /// 已拦截通话
  blockedCall,

  /// STIR/SHAKEN 验真结果
  stirResult,

  /// 删除提议
  deletionProposal,

  /// 未知类型
  unknown;

  /// 从字符串安全解析枚举
  factory NotificationCategory.fromString(String raw) {
    switch (raw.trim().toLowerCase()) {
      case 'call_history':
        return NotificationCategory.callHistory;
      case 'fraud_alert':
        return NotificationCategory.fraudAlert;
      case 'blocked_call':
        return NotificationCategory.blockedCall;
      case 'stir_result':
        return NotificationCategory.stirResult;
      case 'deletion_proposal':
        return NotificationCategory.deletionProposal;
      default:
        return NotificationCategory.unknown;
    }
  }

  /// 转换为原始存储字符串
  String toRawString() {
    switch (this) {
      case NotificationCategory.callHistory:
        return 'call_history';
      case NotificationCategory.fraudAlert:
        return 'fraud_alert';
      case NotificationCategory.blockedCall:
        return 'blocked_call';
      case NotificationCategory.stirResult:
        return 'stir_result';
      case NotificationCategory.deletionProposal:
        return 'deletion_proposal';
      case NotificationCategory.unknown:
        return 'unknown';
    }
  }
}
