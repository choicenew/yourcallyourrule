import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_coordinator_data.freezed.dart';
part 'call_coordinator_data.g.dart';

/// 纯数据驱动 Coordinator 完整聚合通话实体 (CallCoordinatorData)
@freezed
abstract class CallCoordinatorData with _$CallCoordinatorData {
  const CallCoordinatorData._();

  const factory CallCoordinatorData({
    required String phoneNumber,
    String? name,
    String? region,
    String? carrier,
    @Default([]) List<String> labels,
    @Default(0) int localCount,
    @Default(0) int pluginCount,
    @Default(0) int remoteCount,
    @Default('allow') String actionName,
  }) = _CallCoordinatorData;

  factory CallCoordinatorData.fromJson(Map<String, dynamic> json) => _$CallCoordinatorDataFromJson(json);

  factory CallCoordinatorData.fromMap(Map<String, dynamic> map) => CallCoordinatorData.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
