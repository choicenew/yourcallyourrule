// 远程号码过滤配置类，用于控制远程号码过滤规则的应用逻辑

/// 远程号码过滤配置类，用于控制基于计数的过滤规则
class RemoteNumberFilterConfig {
  // 是否启用远程号码过滤
  bool enableRemoteNumberFilter;
  
  // 计数阈值，超过此值将触发相应动作
  int countThreshold;
  
  // 是否拒绝所有超过计数阈值的号码
  bool rejectExceededNumbers;
  
  // 是否允许所有未超过计数阈值的号码
  bool allowNonExceededNumbers;
  
  // 是否优先考虑远程数据库中的动作设置
  bool prioritizeRemoteAction;
  
  // 是否记录所有远程号码查询
  bool logAllRemoteQueries;
  
  // 构造函数
  RemoteNumberFilterConfig({
    this.enableRemoteNumberFilter = true,
    this.countThreshold = 5,
    this.rejectExceededNumbers = true,
    this.allowNonExceededNumbers = false,
    this.prioritizeRemoteAction = true,
    this.logAllRemoteQueries = true,
  });
  
  /// 从Map创建配置对象
  factory RemoteNumberFilterConfig.fromMap(Map<String, dynamic> map) {
    return RemoteNumberFilterConfig(
      enableRemoteNumberFilter: map['enableRemoteNumberFilter'] ?? true,
      countThreshold: map['countThreshold'] ?? 5,
      rejectExceededNumbers: map['rejectExceededNumbers'] ?? true,
      allowNonExceededNumbers: map['allowNonExceededNumbers'] ?? false,
      prioritizeRemoteAction: map['prioritizeRemoteAction'] ?? true,
      logAllRemoteQueries: map['logAllRemoteQueries'] ?? true,
    );
  }
  
  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'enableRemoteNumberFilter': enableRemoteNumberFilter,
      'countThreshold': countThreshold,
      'rejectExceededNumbers': rejectExceededNumbers,
      'allowNonExceededNumbers': allowNonExceededNumbers,
      'prioritizeRemoteAction': prioritizeRemoteAction,
      'logAllRemoteQueries': logAllRemoteQueries,
    };
  }
  
  /// 创建配置副本
  RemoteNumberFilterConfig copyWith({
    bool? enableRemoteNumberFilter,
    int? countThreshold,
    bool? rejectExceededNumbers,
    bool? allowNonExceededNumbers,
    bool? prioritizeRemoteAction,
    bool? logAllRemoteQueries,
  }) {
    return RemoteNumberFilterConfig(
      enableRemoteNumberFilter: enableRemoteNumberFilter ?? this.enableRemoteNumberFilter,
      countThreshold: countThreshold ?? this.countThreshold,
      rejectExceededNumbers: rejectExceededNumbers ?? this.rejectExceededNumbers,
      allowNonExceededNumbers: allowNonExceededNumbers ?? this.allowNonExceededNumbers,
      prioritizeRemoteAction: prioritizeRemoteAction ?? this.prioritizeRemoteAction,
      logAllRemoteQueries: logAllRemoteQueries ?? this.logAllRemoteQueries,
    );
  }
}