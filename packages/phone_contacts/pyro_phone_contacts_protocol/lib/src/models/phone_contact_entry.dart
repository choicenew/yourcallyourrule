import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_contact_entry.freezed.dart';
part 'phone_contact_entry.g.dart';

/// 纯数据驱动联系人强实体 (PhoneContactEntry)
@freezed
abstract class PhoneContactEntry with _$PhoneContactEntry {
  const PhoneContactEntry._();

  const factory PhoneContactEntry({
    required String id,
    required String phoneNumber,
    required String name,
    String? avatar,
    String? url,
    String? note,
    String? labelIds,
    @Default(0) int isFavorite,
    @Default('') String lastUpdated,
  }) = _PhoneContactEntry;

  String get displayName => name;
  List<String> get phoneNumbers => phoneNumber.isNotEmpty ? [phoneNumber] : const [];
  String? get photoUrl => avatar;
  bool get isStarred => isFavorite == 1;

  factory PhoneContactEntry.fromJson(Map<String, dynamic> json) => _$PhoneContactEntryFromJson(json);

  factory PhoneContactEntry.fromMap(Map<String, dynamic> map) => PhoneContactEntry.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
