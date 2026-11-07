import 'dart:convert';
import 'package:isar_community/isar.dart';

part 'crowdsourced_item.g.dart';

/// 状态枚举常量
class CrowdsourcedItemStatus {
  static const String pending = 'pending';
  static const String communityConsensus = 'community_consensus';
  static const String rejected = 'rejected';
  static const String deprecated = 'deprecated';
}

/// 通用社区众包共识与规则实体 (Isar Collection)
@collection
class CrowdsourcedItem {
  Id id = Isar.autoIncrement;

  /// 复合主键: "${domain}:${entityKey}" (唯一无二，覆盖索引)
  @Index(unique: true, replace: true)
  late String compositeKey;

  /// 业务域: 'takeout_rule', 'novel_tag', 'music_metadata', 'cleaner_rule', 'phone_risk' 等
  @Index()
  late String domain;

  /// 领域内Key: 'meituan_keywords_v1', 'book_9527', 'song_123' 等
  @Index()
  late String entityKey;

  /// 泛化负载 JSON 字符串 (储存任何结构化规则、Keywords 数组、配置等)
  late String payloadJson;

  /// 赞成票数 / 好用数
  late int supportVotes;

  /// 反对票数 / 报错数
  late int opposeVotes;

  /// 验证的创作者/归属者计数
  late int verifiedOwnerCount;

  /// 社区置信度得分 (0.0 ~ 1.0)
  late double confidence;

  /// 状态 ('pending' | 'community_consensus' | 'rejected' | 'deprecated')
  @Index()
  late String status;

  /// 创建时间
  late DateTime createdAt;

  /// 最后更新时间
  late DateTime updatedAt;

  /// 构造便捷转换 Map
  @ignore
  Map<String, dynamic> get parsedPayload {
    try {
      return jsonDecode(payloadJson) as Map<String, dynamic>;
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  /// 序列化为 Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'compositeKey': compositeKey,
      'domain': domain,
      'entityKey': entityKey,
      'payloadJson': payloadJson,
      'supportVotes': supportVotes,
      'opposeVotes': opposeVotes,
      'verifiedOwnerCount': verifiedOwnerCount,
      'confidence': confidence,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// 从 Map 构建实体
  static CrowdsourcedItem fromMap(Map<String, dynamic> map) {
    final domain = map['domain'] as String? ?? 'default';
    final entityKey = map['entityKey'] as String? ?? 'unknown';
    return CrowdsourcedItem()
      ..compositeKey = map['compositeKey'] as String? ?? '$domain:$entityKey'
      ..domain = domain
      ..entityKey = entityKey
      ..payloadJson = map['payloadJson'] as String? ?? '{}'
      ..supportVotes = (map['supportVotes'] as num?)?.toInt() ?? 0
      ..opposeVotes = (map['opposeVotes'] as num?)?.toInt() ?? 0
      ..verifiedOwnerCount = (map['verifiedOwnerCount'] as num?)?.toInt() ?? 0
      ..confidence = (map['confidence'] as num?)?.toDouble() ?? 0.0
      ..status = map['status'] as String? ?? CrowdsourcedItemStatus.pending
      ..createdAt = DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now()
      ..updatedAt = DateTime.tryParse(map['updatedAt'] as String? ?? '') ?? DateTime.now();
  }
}
