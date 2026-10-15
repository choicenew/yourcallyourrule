/// 来电挂断/拦截动作枚举
enum InterceptAction {
  /// 立即挂断
  endCall,

  /// 接听后立即挂断
  answerThenHangup,

  /// 静音且不接听
  silenceNoAnswer;

  /// 从 SharedPreferences 或 JSON 安全解析枚举
  factory InterceptAction.fromString(dynamic raw) {
    if (raw == null) return InterceptAction.endCall;
    final str = raw.toString().trim();
    switch (str) {
      case 'answerThenHangup':
        return InterceptAction.answerThenHangup;
      case 'silenceNoAnswer':
        return InterceptAction.silenceNoAnswer;
      case 'endCall':
      default:
        return InterceptAction.endCall;
    }
  }

  /// 转换回存储字符串
  String toRawString() {
    return name;
  }
}
