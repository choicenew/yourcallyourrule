import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_location_entry.freezed.dart';
part 'phone_location_entry.g.dart';

/// 纯数据驱动号码归属地条目强实体 (PhoneLocationEntry)
@freezed
abstract class PhoneLocationEntry with _$PhoneLocationEntry {
  const PhoneLocationEntry._();

  const factory PhoneLocationEntry({
    required String id,
    required String phoneNumber,
    String? region,
    String? countryName,
    String? carrier,
    @Default('UNKNOWN') String numberType,
  }) = _PhoneLocationEntry;

  factory PhoneLocationEntry.fromJson(Map<String, dynamic> json) => _$PhoneLocationEntryFromJson(json);

  factory PhoneLocationEntry.fromMap(Map<String, dynamic> map) => PhoneLocationEntry.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
