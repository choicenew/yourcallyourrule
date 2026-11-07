import 'risk_types.dart';

/// 用户风控画像数据实体
class UserRiskProfile {
  final String userId;
  int sensitivityLevel;
  double sensitivityScore;
  DateTime lastLevelUpdate;
  Map<String, dynamic> metadata;

  UserRiskProfile({
    required this.userId,
    this.sensitivityLevel = 0,
    this.sensitivityScore = 0.0,
    DateTime? lastLevelUpdate,
    Map<String, dynamic>? metadata,
  })  : lastLevelUpdate = lastLevelUpdate ?? DateTime.now(),
        metadata = metadata ?? {};

  UserSensitivityLevel get sensitivityLevelEnum =>
      UserSensitivityLevel.fromLevel(sensitivityLevel);

  UserRiskProfile copyWith({
    String? userId,
    int? sensitivityLevel,
    double? sensitivityScore,
    DateTime? lastLevelUpdate,
    Map<String, dynamic>? metadata,
  }) {
    return UserRiskProfile(
      userId: userId ?? this.userId,
      sensitivityLevel: sensitivityLevel ?? this.sensitivityLevel,
      sensitivityScore: sensitivityScore ?? this.sensitivityScore,
      lastLevelUpdate: lastLevelUpdate ?? this.lastLevelUpdate,
      metadata: metadata ?? Map<String, dynamic>.from(this.metadata),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'sensitivityLevel': sensitivityLevel,
        'sensitivityScore': sensitivityScore,
        'lastLevelUpdate': lastLevelUpdate.toIso8601String(),
        'metadata': metadata,
      };

  factory UserRiskProfile.fromJson(Map<String, dynamic> json) =>
      UserRiskProfile(
        userId: json['userId'] as String? ?? 'primary_user',
        sensitivityLevel: json['sensitivityLevel'] as int? ?? 0,
        sensitivityScore: (json['sensitivityScore'] as num?)?.toDouble() ?? 0.0,
        lastLevelUpdate: json['lastLevelUpdate'] != null
            ? DateTime.tryParse(json['lastLevelUpdate'] as String) ??
                DateTime.now()
            : DateTime.now(),
        metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      );
}
