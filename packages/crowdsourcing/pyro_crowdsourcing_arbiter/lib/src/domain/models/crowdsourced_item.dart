import 'dart:convert';
import 'package:isar_community/isar.dart';

part 'crowdsourced_item.g.dart';

class CrowdsourcedItemStatus {
  static const String pending = 'pending';
  static const String communityConsensus = 'community_consensus';
  static const String rejected = 'rejected';
}

/// 通用众包条目实体 (Isar Collection)
@collection
class CrowdsourcedItem {
  Id id = Isar.autoIncrement;

  /// 复合主键: "${domain}:${entityKey}"
  @Index(unique: true, replace: true)
  late String compositeKey;

  /// 业务域: 'system_rule', 'public_source', 'cleaner_rule' 等
  @Index()
  late String domain;

  /// 领域内 Key
  @Index()
  late String entityKey;

  /// 泛化负载 JSON 字符串
  late String payloadJson;

  /// 赞成票数
  late int supportVotes;

  /// 反对票数
  late int opposeVotes;

  /// 验证的所有者计数
  late int verifiedOwnerCount;

  /// 社区置信度得分 (0.0 ~ 1.0)
  late double confidence;

  /// 状态 ('pending' | 'community_consensus' | 'rejected')
  @Index()
  late String status;

  /// 创建时间
  late DateTime createdAt;

  /// 最后更新时间
  late DateTime updatedAt;

  @ignore
  Map<String, dynamic> get parsedPayload {
    try {
      return jsonDecode(payloadJson) as Map<String, dynamic>;
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  Map<String, dynamic> toMap() => {
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
