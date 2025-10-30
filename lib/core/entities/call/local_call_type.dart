import 'package:flutter/foundation.dart';

/// 定义所有我们应用本地使用的通话记录类型。
/// 使用 "Local" 前缀以避免与第三方库的通用命名（如 CallType）发生冲突。
enum LocalCallType {
  /// 已接听的来电
  incoming,

  /// 未接来电
  missed,

  /// 已拨出的去电
  outgoing,

  /// 被应用规则拒接的来电
  rejected,

  /// 被应用规则拦截（接听后挂断）的来电
  blocked,

  /// 被应用规则静音的来电
  silenced,

  /// 未知的拦截类型（作为备用）
  unknownIntercept,

  /// 语音信箱（未来扩展）
  voicemail,

  /// 未知类型
  unknown;

  /// 从字符串转换为枚举
  static LocalCallType fromString(String value) {
    return LocalCallType.values.firstWhere(
      (e) => e.name == value,
      orElse: () {
        debugPrint("Unknown LocalCallType value: $value, defaulting to unknown.");
        return LocalCallType.unknown;
      },
    );
  }
}