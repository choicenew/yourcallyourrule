import 'package:freezed_annotation/freezed_annotation.dart';

part 'label_phone_entry.freezed.dart';
part 'label_phone_entry.g.dart';

/// 纯数据驱动用户号码打标条目强实体 (LabelPhoneEntry)
@freezed
abstract class LabelPhoneEntry with _$LabelPhoneEntry {
  const LabelPhoneEntry._();

  const factory LabelPhoneEntry({
    required String id,
    required String phoneNumber,
    required String labelId,
    @Default('') String name,
    String? avatar,
    String? icon,
    @Default(100) int priority,
    @Default(true) bool isEnabled,
  }) = _LabelPhoneEntry;

  factory LabelPhoneEntry.fromJson(Map<String, dynamic> json) => _$LabelPhoneEntryFromJson(json);

  factory LabelPhoneEntry.fromMap(Map<String, dynamic> map) => LabelPhoneEntry.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
