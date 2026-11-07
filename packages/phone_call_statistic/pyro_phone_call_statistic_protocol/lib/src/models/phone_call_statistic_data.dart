import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_call_statistic_data.freezed.dart';
part 'phone_call_statistic_data.g.dart';

/// 纯数据驱动通话拦截统计强实体 (PhoneCallStatisticData)
@freezed
abstract class PhoneCallStatisticData with _$PhoneCallStatisticData {
  const PhoneCallStatisticData._();

  const factory PhoneCallStatisticData({
    @Default(0) int totalCalls,
    @Default(0) int blockedCalls,
    @Default(0) int allowedCalls,
    @Default(0) int silencedCalls,
  }) = _PhoneCallStatisticData;

  factory PhoneCallStatisticData.fromJson(Map<String, dynamic> json) => _$PhoneCallStatisticDataFromJson(json);

  factory PhoneCallStatisticData.fromMap(Map<String, dynamic> map) => PhoneCallStatisticData.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
