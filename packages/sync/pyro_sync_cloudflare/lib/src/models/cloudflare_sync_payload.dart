/// 泛化云端同步操作原子 (Cloudflare Operations)
class CloudflareSyncOperation {
  final String id;
  final String domain;       // target_type (如 'takeout_rule', 'novel_tag', 'cleaner_rule')
  final String entityKey;    // target_id (如 'meituan_keywords_v1')
  final String operation;    // 'PROPOSE', 'VOTE', 'UPDATE', 'DELETE'
  final Map<String, dynamic> payload;
  final String timestamp;

  CloudflareSyncOperation({
    required this.id,
    required this.domain,
    required this.entityKey,
    required this.operation,
    required this.payload,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domain': domain,
      'entityKey': entityKey,
      'operation': operation,
      'payload': payload,
      'timestamp': timestamp,
    };
  }

  factory CloudflareSyncOperation.fromJson(Map<String, dynamic> json) {
    return CloudflareSyncOperation(
      id: json['id'] as String? ?? '',
      domain: json['domain'] as String? ?? json['target_type'] as String? ?? 'default',
      entityKey: json['entityKey'] as String? ?? json['target_id'] as String? ?? '',
      operation: json['operation'] as String? ?? 'PROPOSE',
      payload: (json['payload'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      timestamp: json['timestamp'] as String? ?? DateTime.now().toIso8601String(),
    );
  }
}
