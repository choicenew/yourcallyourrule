import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_rule_entity.freezed.dart';
part 'phone_rule_entity.g.dart';

/// 纯数据驱动电话规则强实体 (PhoneRuleEntity)
@freezed
abstract class PhoneRuleEntity with _$PhoneRuleEntity {
  const PhoneRuleEntity._();

  const factory PhoneRuleEntity({
    required String id,
    required String name,
    required String phoneNumber,
    @Default('') String labelId,
    String? avatar,
    String? subscriptionId,
    @Default('block') String actionType,
    @Default(100) int priority,
    @Default(0) int count,
    @Default(true) bool isEnabled,
  }) = _PhoneRuleEntity;

  bool get isSubscribed => subscriptionId != null;

  factory PhoneRuleEntity.fromJson(Map<String, dynamic> json) => _$PhoneRuleEntityFromJson(json);

  factory PhoneRuleEntity.fromMap(Map<String, dynamic> map) => PhoneRuleEntity.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
