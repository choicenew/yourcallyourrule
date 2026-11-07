import 'package:isar_community/isar.dart';

part 'crowdsourced_vote.g.dart';

/// 投票历史记录 (Isar Collection)
@collection
class CrowdsourcedVote {
  Id id = Isar.autoIncrement;

  /// 复合键: "${domain}:${entityKey}"
  @Index()
  late String compositeKey;

  /// 投票者设备 ID
  @Index()
  late String deviceId;

  /// 投票类型: 'support' | 'oppose'
  late String voteType;

  /// 投票时间
  late DateTime voteTime;
}
