/// 诈骗提醒的配置数据类
/// 包含了所有用户可以自定义的设置
class FraudAlertConfig {
  /// 是否启用诈骗提醒功能
  final bool isEnabled;
  /// 是否在提醒时启用震动
  final bool isVibrationEnabled;
  /// 【新增】: 是否在一段时间后自动取消提醒通知
  final bool isAutoCancelEnabled;
  /// 【新增】: 自动取消通知的延迟时间（单位：秒）
  final int autoCancelDelaySeconds;

  /// 构造函数，提供所有字段的默认值
  const FraudAlertConfig({
    this.isEnabled = true,
    this.isVibrationEnabled = true,
    this.isAutoCancelEnabled = true,
    this.autoCancelDelaySeconds = 10,
  });

  /// copyWith 方法，用于创建状态的不可变副本
  FraudAlertConfig copyWith({
    bool? isEnabled,
    bool? isVibrationEnabled,
    bool? isAutoCancelEnabled,
    int? autoCancelDelaySeconds,
  }) {
    return FraudAlertConfig(
      isEnabled: isEnabled ?? this.isEnabled,
      isVibrationEnabled: isVibrationEnabled ?? this.isVibrationEnabled,
      isAutoCancelEnabled: isAutoCancelEnabled ?? this.isAutoCancelEnabled,
      autoCancelDelaySeconds: autoCancelDelaySeconds ?? this.autoCancelDelaySeconds,
    );
  }

  /// 从 Json (Map) 创建对象的工厂方法
  factory FraudAlertConfig.fromJson(Map<String, dynamic> json) {
    return FraudAlertConfig(
      isEnabled: json['isEnabled'] as bool? ?? true,
      isVibrationEnabled: json['isVibrationEnabled'] as bool? ?? true,
      isAutoCancelEnabled: json['isAutoCancelEnabled'] as bool? ?? true,
      autoCancelDelaySeconds: json['autoCancelDelaySeconds'] as int? ?? 10,
    );
  }

  /// 将对象转换为 Json (Map) 的方法
  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'isVibrationEnabled': isVibrationEnabled,
      'isAutoCancelEnabled': isAutoCancelEnabled,
      'autoCancelDelaySeconds': autoCancelDelaySeconds,
    };
  }
}