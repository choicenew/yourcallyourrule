import 'package:isar_community/isar.dart';

part 'crowdsourced_vote.g.dart';

/// 投票历史记录 (Isar Collection)
@collection
class CrowdsourcedVote {
  Id id = Isar.autoIncrement;

  @Index()
  late String compositeKey;

  @Index()
  late String deviceId;

  late String voteType; // 'support' | 'oppose'

  late DateTime voteTime;
}
