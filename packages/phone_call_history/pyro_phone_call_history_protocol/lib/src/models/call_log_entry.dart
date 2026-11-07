import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_log_entry.freezed.dart';
part 'call_log_entry.g.dart';

/// 纯数据驱动通话历史强实体 (CallLogEntry)
@freezed
abstract class CallLogEntry with _$CallLogEntry {
  const CallLogEntry._();

  const factory CallLogEntry({
    required String id,
    required String phoneNumber,
    required String callType,
    int? timestamp,
    int? durationSeconds,
    String? name,
    String? location,
  }) = _CallLogEntry;

  factory CallLogEntry.fromJson(Map<String, dynamic> json) => _$CallLogEntryFromJson(json);

  factory CallLogEntry.fromMap(Map<String, dynamic> map) => CallLogEntry.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
