import 'dart:async';
import 'package:flutter/foundation.dart';

/// 同步操作类型枚举
enum SyncOperationType {
  /// 初始化
  initialization,
  
  /// 规则同步
  ruleSync,
  
  /// 设置同步
  settingsSync,
  
  /// 历史记录同步
  historySync,
  
  /// 设备同步
  deviceSync,
  
  /// 配置操作
  configuration,
  
  /// 全量同步
  fullSync,
}

/// 同步进度状态
class SyncProgressStatus {
  /// 操作类型
  final SyncOperationType operationType;
  
  /// 进度百分比（0-100）
  final int progress;
  
  /// 状态消息
  final String message;
  
  /// 是否有错误
  final bool hasError;
  
  /// 错误消息
  final String? errorMessage;
  
  /// 时间戳
  final DateTime timestamp;
  
  /// 构造函数
  SyncProgressStatus({
    required this.operationType,
    required this.progress,
    required this.message,
    this.hasError = false,
    this.errorMessage,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
  
  /// 创建错误状态
  factory SyncProgressStatus.error({
    required SyncOperationType operationType,
    required String errorMessage,
    String message = '',
  }) {
    return SyncProgressStatus(
      operationType: operationType,
      progress: 0,
      message: message.isEmpty ? '同步操作失败: $errorMessage' : message,
      hasError: true,
      errorMessage: errorMessage,
    );
  }
  
  /// 创建完成状态
  factory SyncProgressStatus.completed({
    required SyncOperationType operationType,
    required String message,
  }) {
    return SyncProgressStatus(
      operationType: operationType,
      progress: 100,
      message: message,
    );
  }
  
  /// 复制并修改
  SyncProgressStatus copyWith({
    SyncOperationType? operationType,
    int? progress,
    String? message,
    bool? hasError,
    String? errorMessage,
    DateTime? timestamp,
  }) {
    return SyncProgressStatus(
      operationType: operationType ?? this.operationType,
      progress: progress ?? this.progress,
      message: message ?? this.message,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      timestamp: timestamp ?? this.timestamp,
    );
  }
  
  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'operationType': operationType.toString(),
      'progress': progress,
      'message': message,
      'hasError': hasError,
      'errorMessage': errorMessage,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

/// 同步进度跟踪器
/// 用于跟踪和报告云同步操作的进度
class SyncProgressTracker extends ChangeNotifier {
  /// 当前进度状态映射（按操作类型）
  final Map<SyncOperationType, SyncProgressStatus> _currentStatus = {};
  
  /// 历史进度状态列表
  final List<SyncProgressStatus> _statusHistory = [];
  
  /// 最大历史记录数
  static const int maxHistorySize = 100;
  
  /// 进度更新流控制器
  final StreamController<SyncProgressStatus> _progressStreamController = 
      StreamController<SyncProgressStatus>.broadcast();
  
  /// 进度更新流
  Stream<SyncProgressStatus> get progressStream => _progressStreamController.stream;
  
  /// 获取当前进度状态
  SyncProgressStatus? getCurrentStatus(SyncOperationType operationType) {
    return _currentStatus[operationType];
  }
  
  /// 获取所有当前进度状态
  Map<SyncOperationType, SyncProgressStatus> getAllCurrentStatus() {
    return Map.unmodifiable(_currentStatus);
  }
  
  /// 获取历史进度状态
  List<SyncProgressStatus> getStatusHistory() {
    return List.unmodifiable(_statusHistory);
  }
  
  /// 更新进度
  void updateProgress({
    required SyncOperationType operationType,
    required int progress,
    required String message,
  }) {
    final status = SyncProgressStatus(
      operationType: operationType,
      progress: progress,
      message: message,
    );
    
    _updateStatus(status);
  }
  
  /// 报告错误
  void reportError({
    SyncOperationType operationType = SyncOperationType.fullSync,
    required String errorMessage,
    String message = '',
  }) {
    final status = SyncProgressStatus.error(
      operationType: operationType,
      errorMessage: errorMessage,
      message: message,
    );
    
    _updateStatus(status);
  }
  
  /// 报告完成
  void reportCompleted({
    required SyncOperationType operationType,
    required String message,
  }) {
    final status = SyncProgressStatus.completed(
      operationType: operationType,
      message: message,
    );
    
    _updateStatus(status);
  }
  
  /// 更新状态
  void _updateStatus(SyncProgressStatus status) {
    // 更新当前状态
    _currentStatus[status.operationType] = status;
    
    // 添加到历史记录
    _statusHistory.add(status);
    
    // 限制历史记录大小
    if (_statusHistory.length > maxHistorySize) {
      _statusHistory.removeAt(0);
    }
    
    // 发送到流
    _progressStreamController.add(status);
    
    // 通知监听器
    notifyListeners();
  }
  
  /// 清除特定操作类型的状态
  void clearStatus(SyncOperationType operationType) {
    _currentStatus.remove(operationType);
    notifyListeners();
  }
  
  /// 清除所有状态
  void clearAllStatus() {
    _currentStatus.clear();
    notifyListeners();
  }
  
  /// 清除历史记录
  void clearHistory() {
    _statusHistory.clear();
    notifyListeners();
  }
  
  /// 释放资源
  @override
  void dispose() {
    _progressStreamController.close();
    super.dispose();
  }
}