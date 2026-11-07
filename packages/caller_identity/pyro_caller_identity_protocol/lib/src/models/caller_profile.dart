import 'package:freezed_annotation/freezed_annotation.dart';

part 'caller_profile.freezed.dart';
part 'caller_profile.g.dart';

/// 强实体身份画像模型 (CallerProfile)
@freezed
abstract class CallerProfile with _$CallerProfile {
  const CallerProfile._();

  const factory CallerProfile({
    required String phoneNumber,
    String? name,
    String? region,
    String? countryName,
    String? carrier,
    @Default([]) List<String> labels,
    @Default(0) int localCount,
    @Default(0) int pluginCount,
    @Default(0) int remoteCount,
  }) = _CallerProfile;

  factory CallerProfile.fromJson(Map<String, dynamic> json) => _$CallerProfileFromJson(json);

  factory CallerProfile.fromMap(Map<String, dynamic> map) => CallerProfile.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
