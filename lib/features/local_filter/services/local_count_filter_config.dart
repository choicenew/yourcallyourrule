// 本地号码计数过滤配置类，用于控制基于本地计数的过滤规则

/// 本地号码计数过滤配置类，用于控制基于计数的过滤规则
class LocalCountFilterConfig {
  // 是否启用本地号码计数过滤
  bool enableLocalCountFilter;
  
  // 计数阈值，超过此值将触发相应动作
  int countThreshold;
  
  // 是否拒绝所有超过计数阈值的号码
  bool rejectExceededNumbers;
  
  // 是否允许所有未超过计数阈值的号码
  bool allowNonExceededNumbers;
  
  // 是否记录所有本地号码查询
  bool logAllLocalQueries;
  
  // 构造函数
  LocalCountFilterConfig({
    this.enableLocalCountFilter = true,
    this.countThreshold = 5,
    this.rejectExceededNumbers = true,
    this.allowNonExceededNumbers = false,
    this.logAllLocalQueries = true,
  });
  
  /// 从Map创建配置对象
  factory LocalCountFilterConfig.fromMap(Map<String, dynamic> map) {
    return LocalCountFilterConfig(
      enableLocalCountFilter: map['enableLocalCountFilter'] ?? true,
      countThreshold: map['countThreshold'] ?? 5,
      rejectExceededNumbers: map['rejectExceededNumbers'] ?? true,
      allowNonExceededNumbers: map['allowNonExceededNumbers'] ?? false,
      logAllLocalQueries: map['logAllLocalQueries'] ?? true,
    );
  }
  
  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'enableLocalCountFilter': enableLocalCountFilter,
      'countThreshold': countThreshold,
      'rejectExceededNumbers': rejectExceededNumbers,
      'allowNonExceededNumbers': allowNonExceededNumbers,
      'logAllLocalQueries': logAllLocalQueries,
    };
  }
  
  /// 创建配置副本
  LocalCountFilterConfig copyWith({
    bool? enableLocalCountFilter,
    int? countThreshold,
    bool? rejectExceededNumbers,
    bool? allowNonExceededNumbers,
    bool? logAllLocalQueries,
  }) {
    return LocalCountFilterConfig(
      enableLocalCountFilter: enableLocalCountFilter ?? this.enableLocalCountFilter,
      countThreshold: countThreshold ?? this.countThreshold,
      rejectExceededNumbers: rejectExceededNumbers ?? this.rejectExceededNumbers,
      allowNonExceededNumbers: allowNonExceededNumbers ?? this.allowNonExceededNumbers,
      logAllLocalQueries: logAllLocalQueries ?? this.logAllLocalQueries,
    );
  }
}