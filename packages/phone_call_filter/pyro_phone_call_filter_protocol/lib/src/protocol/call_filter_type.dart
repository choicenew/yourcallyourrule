import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_filter_type.freezed.dart';
part 'call_filter_type.g.dart';

/// 纯数据驱动过滤器类型值对象 (CallFilterType Value Object)
@freezed
abstract class CallFilterType with _$CallFilterType {
  const CallFilterType._();

  const factory CallFilterType({
    required String id,
  }) = _CallFilterType;

  static const CallFilterType basicRule = CallFilterType(id: 'basicRule');
  static const CallFilterType localCount = CallFilterType(id: 'localCount');
  static const CallFilterType remoteNumber = CallFilterType(id: 'remoteNumber');
  static const CallFilterType simSlot = CallFilterType(id: 'simSlot');

  factory CallFilterType.fromJson(Map<String, dynamic> json) => _$CallFilterTypeFromJson(json);

  factory CallFilterType.fromMap(Map<String, dynamic> map) => CallFilterType.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
