// 同步记录模型类，用于记录同步状态和历史

import 'dart:convert';

import '../../base_model.dart';

// 同步记录实体类
class SyncRecordEntity {
  // ID
  final String id;
  
  // 同步时间
  final DateTime syncTime;
  
  // 同步类型（全量/增量）
  final String syncType;
  
  // 同步状态（成功/失败）
  final String status;
  
  // 错误信息（可选）
  final String? error;
  
  // 元数据（JSON字符串，用于存储额外信息）
  final String? metadata;
  
  // 构造函数
  const SyncRecordEntity({
    required this.id,
    required this.syncTime,
    required this.syncType,
    required this.status,
    this.error,
    this.metadata,
  });
}

// 同步记录模型类
class SyncRecordModel extends BaseModel<SyncRecordEntity> {
  // 同步时间
  final DateTime syncTime;
  
  // 同步类型（全量/增量）
  final String syncType;
  
  // 同步状态（成功/失败）
  final String status;
  
  // 错误信息（可选）
  final String? error;
  
  // 元数据（JSON字符串，用于存储额外信息）
  final String? metadata;
  
  // 构造函数
  const SyncRecordModel({
    required super.id,
    required this.syncTime,
    required this.syncType,
    required this.status,
    this.error,
    this.metadata,
  });
  
  // 从Map创建模型
  factory SyncRecordModel.fromMap(Map<String, dynamic> map) {
    return SyncRecordModel(
      id: map['id'],
      syncTime: DateTime.parse(map['syncTime']),
      syncType: map['syncType'],
      status: map['status'],
      error: map['error'],
      metadata: map['metadata'],
    );
  }
  
  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'syncTime': syncTime.toIso8601String(),
      'syncType': syncType,
      'status': status,
      'error': error,
      'metadata': metadata,
    });
    return map;
  }
  
  // 将模型转换为实体
  @override
  SyncRecordEntity toEntity() {
    return SyncRecordEntity(
      id: id,
      syncTime: syncTime,
      syncType: syncType,
      status: status,
      error: error,
      metadata: metadata,
    );
  }
  
  // 复制模型并修改部分属性
  SyncRecordModel copyWith({
    String? id,
    DateTime? syncTime,
    String? syncType,
    String? status,
    String? error,
    String? metadata,
  }) {
    return SyncRecordModel(
      id: id ?? this.id,
      syncTime: syncTime ?? this.syncTime,
      syncType: syncType ?? this.syncType,
      status: status ?? this.status,
      error: error ?? this.error,
      metadata: metadata ?? this.metadata,
    );
  }
  
  // 获取元数据Map
  Map<String, dynamic>? getMetadataMap() {
    if (metadata == null || metadata!.isEmpty) {
      return null;
    }
    
    try {
      return jsonDecode(metadata!) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
  
  // 获取元数据中的特定字段
  T? getMetadataValue<T>(String key) {
    final map = getMetadataMap();
    if (map == null) {
      return null;
    }
    
    return map[key] as T?;
  }
}