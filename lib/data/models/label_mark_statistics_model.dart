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
      phoneNumber: map['phoneNumber'],
      labelId: map['labelId'],
      markedAt: DateTime.parse(map['markedAt']),
      isCounted: map['isCounted'] == 1,
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'phoneNumber': phoneNumber,
      'labelId': labelId,
      'markedAt': markedAt.toIso8601String(),
      'isCounted': isCounted ? 1 : 0,
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
      totalCount: map['totalCount'],
      lastUpdated: DateTime.parse(map['lastUpdated']),
    );
  }

  // 将模型转换为Map
  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'totalCount': totalCount,
      'lastUpdated': lastUpdated.toIso8601String(),
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