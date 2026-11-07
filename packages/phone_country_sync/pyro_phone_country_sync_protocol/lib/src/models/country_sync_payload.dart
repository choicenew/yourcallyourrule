import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_sync_payload.freezed.dart';
part 'country_sync_payload.g.dart';

/// 纯数据驱动国家数据镜像同步载荷强实体 (CountrySyncPayload)
@freezed
abstract class CountrySyncPayload with _$CountrySyncPayload {
  const CountrySyncPayload._();

  const factory CountrySyncPayload({
    required String countryIsoCode,
    @Default(0) int totalRecords,
    @Default('completed') String status,
    int? timestamp,
  }) = _CountrySyncPayload;

  factory CountrySyncPayload.fromJson(Map<String, dynamic> json) => _$CountrySyncPayloadFromJson(json);

  factory CountrySyncPayload.fromMap(Map<String, dynamic> map) => CountrySyncPayload.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
