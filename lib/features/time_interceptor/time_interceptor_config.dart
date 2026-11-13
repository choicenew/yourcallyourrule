// 这个文件只负责定义 TimeInterceptorConfig 数据模型

class TimeInterceptorConfig {
  final Duration duration;
  final bool shouldIntercept;

  // 请注意：为了让状态更新更可靠，建议将成员变量设为 final
  // 这使得 TimeInterceptorConfig 成为一个不可变对象 (immutable object)
  // 所有的修改都必须通过 copyWith 创建新实例，这是状态管理的最佳实践。

  const TimeInterceptorConfig({
    this.duration = const Duration(minutes: 30),
    this.shouldIntercept = true,
  });

  // 新增copyWith方法
  TimeInterceptorConfig copyWith({
    Duration? duration,
    bool? shouldIntercept,
  }) {
    return TimeInterceptorConfig(
      duration: duration ?? this.duration,
      shouldIntercept: shouldIntercept ?? this.shouldIntercept,
    );
  }

  factory TimeInterceptorConfig.fromMap(Map<String, dynamic> map) {
    return TimeInterceptorConfig(
      duration: Duration(minutes: map['config_durationMinutes'] ?? 30),
      shouldIntercept: map['config_shouldIntercept'] ?? true,
    );
  }

  Map<String, dynamic> toMap() => {
        'config_durationMinutes': duration.inMinutes,
        'config_shouldIntercept': shouldIntercept,
      };
}