import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_live_activity_record.freezed.dart';
part 'phone_live_activity_record.g.dart';

/// 纯数据驱动灵动岛与实时卡片强实体 (PhoneLiveActivityRecord)
@freezed
abstract class PhoneLiveActivityRecord with _$PhoneLiveActivityRecord {
  const PhoneLiveActivityRecord._();

  const factory PhoneLiveActivityRecord({
    required String activityId,
    required String phoneNumber,
    required String title,
    String? subtitle,
    @Default('active') String status,
    int? timestamp,
  }) = _PhoneLiveActivityRecord;

  factory PhoneLiveActivityRecord.fromJson(Map<String, dynamic> json) => _$PhoneLiveActivityRecordFromJson(json);

  factory PhoneLiveActivityRecord.fromMap(Map<String, dynamic> map) => PhoneLiveActivityRecord.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
