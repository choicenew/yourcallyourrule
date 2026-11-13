import 'package:freezed_annotation/freezed_annotation.dart';

part 'caller_id_data.freezed.dart';
part 'caller_id_data.g.dart';

/// 强实体身份画像模型 (CallerIdData)
@freezed
abstract class CallerIdData with _$CallerIdData {
  const CallerIdData._();

  const factory CallerIdData({
    required String phoneNumber,
    String? name,
    String? region,
    String? countryName,
    String? carrier,
    @Default([]) List<String> labels,
    @Default(0) int localCount,
    @Default(0) int pluginCount,
    @Default(0) int remoteCount,
  }) = _CallerIdData;

  factory CallerIdData.fromJson(Map<String, dynamic> json) => _$CallerIdDataFromJson(json);

  factory CallerIdData.fromMap(Map<String, dynamic> map) => CallerIdData.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
