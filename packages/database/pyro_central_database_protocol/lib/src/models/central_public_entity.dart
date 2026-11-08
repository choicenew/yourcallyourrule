/// 系统中央公共数据实体类 (例如：公共规则、系统公告、公共书源配置)
class CentralPublicEntity {
  final String id;
  final String domain;       // 业务域: 'system_rule', 'public_source', 'announcement' 等
  final String entityKey;    // 领域内 Key
  final Map<String, dynamic> payload;
  final int version;
  final String updatedAt;

  const CentralPublicEntity({
    required this.id,
    required this.domain,
    required this.entityKey,
    required this.payload,
    this.version = 1,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'domain': domain,
        'entityKey': entityKey,
        'payload': payload,
        'version': version,
        'updatedAt': updatedAt,
      };

  factory CentralPublicEntity.fromJson(Map<String, dynamic> json) {
    return CentralPublicEntity(
      id: json['id'] as String? ?? '',
      domain: json['domain'] as String? ?? 'default',
      entityKey: json['entityKey'] as String? ?? '',
      payload: (json['payload'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      version: (json['version'] as num?)?.toInt() ?? 1,
      updatedAt: json['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
    );
  }
}
