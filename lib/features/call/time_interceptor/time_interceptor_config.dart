

class TimeInterceptorConfig {
  // 默认30分钟配置（可修改）
  Duration duration;
  bool shouldIntercept;

  TimeInterceptorConfig({
    this.duration = const Duration(minutes: 30), // 默认值在此设置
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
      duration: Duration(minutes: map['durationMinutes'] ?? 30),
      shouldIntercept: map['shouldIntercept'] ?? true,
    );
  }

  Map<String, dynamic> toMap() => {
    'durationMinutes': duration.inMinutes,
    'shouldIntercept': shouldIntercept,
  };
}