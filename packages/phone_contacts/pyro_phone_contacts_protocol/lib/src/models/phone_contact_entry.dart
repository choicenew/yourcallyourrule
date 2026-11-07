import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_contact_entry.freezed.dart';
part 'phone_contact_entry.g.dart';

/// 纯数据驱动联系人强实体 (PhoneContactEntry)
@freezed
abstract class PhoneContactEntry with _$PhoneContactEntry {
  const PhoneContactEntry._();

  const factory PhoneContactEntry({
    required String id,
    required String displayName,
    required List<String> phoneNumbers,
    String? photoUrl,
    @Default(false) bool isStarred,
  }) = _PhoneContactEntry;

  factory PhoneContactEntry.fromJson(Map<String, dynamic> json) => _$PhoneContactEntryFromJson(json);

  factory PhoneContactEntry.fromMap(Map<String, dynamic> map) => PhoneContactEntry.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
