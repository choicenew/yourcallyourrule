import 'package:freezed_annotation/freezed_annotation.dart';

part 'sim_slot_rule_entity.freezed.dart';
part 'sim_slot_rule_entity.g.dart';

/// 纯数据驱动卡槽规则强实体 (SimSlotRuleEntity)
@freezed
abstract class SimSlotRuleEntity with _$SimSlotRuleEntity {
  const SimSlotRuleEntity._();

  const factory SimSlotRuleEntity({
    required String id,
    required String name,
    required String phoneNumber,
    required int simSlotIndex,
    @Default('') String labelId,
    String? avatar,
    @Default('block') String actionType,
    @Default(100) int priority,
    @Default(true) bool isEnabled,
  }) = _SimSlotRuleEntity;

  factory SimSlotRuleEntity.fromJson(Map<String, dynamic> json) => _$SimSlotRuleEntityFromJson(json);

  factory SimSlotRuleEntity.fromMap(Map<String, dynamic> map) => SimSlotRuleEntity.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
