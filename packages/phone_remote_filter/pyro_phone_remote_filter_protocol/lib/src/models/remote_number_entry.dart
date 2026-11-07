import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_number_entry.freezed.dart';
part 'remote_number_entry.g.dart';

/// 纯数据驱动远程号码强实体 (RemoteNumberEntry)
@freezed
abstract class RemoteNumberEntry with _$RemoteNumberEntry {
  const RemoteNumberEntry._();

  const factory RemoteNumberEntry({
    required String id,
    required String phoneNumber,
    String? name,
    String? label,
    @Default(0) int count,
    @Default('block') String actionType,
    @Default(true) bool isEnabled,
  }) = _RemoteNumberEntry;

  factory RemoteNumberEntry.fromJson(Map<String, dynamic> json) => _$RemoteNumberEntryFromJson(json);

  factory RemoteNumberEntry.fromMap(Map<String, dynamic> map) => RemoteNumberEntry.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
