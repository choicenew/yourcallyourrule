import 'package:isar_community/isar.dart';

part 'crowdsourced_submission.g.dart';

/// 提议/提交频率限制离线记录 (Isar Collection)
@collection
class CrowdsourcedSubmission {
  Id id = Isar.autoIncrement;

  /// 提交者的设备 ID
  @Index()
  late String proposerDeviceId;

  /// 业务域: 'takeout_rule', 'novel_tag', 'music_metadata'
  @Index()
  late String domain;

  /// 领域内 Key
  @Index()
  late String entityKey;

  /// 提交时间
  late DateTime submissionTime;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'proposerDeviceId': proposerDeviceId,
      'domain': domain,
      'entityKey': entityKey,
      'submissionTime': submissionTime.toIso8601String(),
    };
  }
}
