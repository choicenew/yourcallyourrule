// 标记统计数据模型，用于数据层与领域层之间的转换

import '../base_model.dart';

// 标记记录模型类
class LabelMarkRecordModel extends BaseModel<void> {
  // 电话号码
  final String phoneNumber;
  // 标签ID
  final String labelId;
  // 标记时间
  final DateTime markedAt;
  // 是否已计数
  final bool isCounted;

  // 构造函数
  const LabelMarkRecordModel({
    required super.id,
    required this.phoneNumber,
    required this.labelId,
    required this.markedAt,
    this.isCounted = true,
  });

  // 从Map创建模型
  factory LabelMarkRecordModel.fromMap(Map<String, dynamic> map) {
    return LabelMarkRecordModel(
      id: map['id'],
      phoneNumber: map['phone_number'],
      labelId: map['label_id'],
      markedAt: DateTime.parse(map['marked_at']),
      isCounted: map['is_counted'] == 1,
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phone_number': phoneNumber,
      'label_id': labelId,
      'marked_at': markedAt.toIso8601String(),
      'is_counted': isCounted ? 1 : 0,
    });
    return map;
  }

  // 将模型转换为实体 - 暂不需要实体类
  @override
  void toEntity() {
    // 暂不需要实体类转换
    return;
  }
}

// 用户标记计数模型类
class UserMarkCountModel extends BaseModel<void> {
  // 总计数
  final int totalCount;
  // 最后更新时间
  final DateTime lastUpdated;

  // 构造函数
  const UserMarkCountModel({
    required super.id,
    required this.totalCount,
    required this.lastUpdated,
  });

  // 从Map创建模型
  factory UserMarkCountModel.fromMap(Map<String, dynamic> map) {
    return UserMarkCountModel(
      id: map['id'],
      totalCount: map['total_count'],
      lastUpdated: DateTime.parse(map['last_updated']),
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'total_count': totalCount,
      'last_updated': lastUpdated.toIso8601String(),
    });
    return map;
  }

  // 将模型转换为实体 - 暂不需要实体类
  @override
  void toEntity() {
    // 暂不需要实体类转换
    return;
  }
}