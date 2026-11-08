import 'package:isar_community/isar.dart';

part 'crowdsourced_submission.g.dart';

/// 提交频率限制离线记录 (Isar Collection)
@collection
class CrowdsourcedSubmission {
  Id id = Isar.autoIncrement;

  @Index()
  late String proposerDeviceId;

  @Index()
  late String domain;

  @Index()
  late String entityKey;

  late DateTime submissionTime;
}
