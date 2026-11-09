import 'package:freezed_annotation/freezed_annotation.dart';

part 'regex_rule_entity.freezed.dart';
part 'regex_rule_entity.g.dart';

/// 纯数据驱动电话正则规则强实体 (RegexRuleEntity)
@freezed
abstract class RegexRuleEntity with _$RegexRuleEntity {
  const RegexRuleEntity._();

  const factory RegexRuleEntity({
    required String id,
    required String name,
    required String pattern,
    @Default('block') String actionType,
    @Default(100) int priority,
    String? subscriptionId,
    @Default(true) bool isEnabled,
  }) = _RegexRuleEntity;

  bool get isSubscribed => subscriptionId != null;

  bool matches(String input) {
    if (!isEnabled) return false;
    try {
      return RegExp(pattern).hasMatch(input);
    } catch (_) {
      return false;
    }
  }

  factory RegexRuleEntity.fromJson(Map<String, dynamic> json) => _$RegexRuleEntityFromJson(json);

  factory RegexRuleEntity.fromMap(Map<String, dynamic> map) => RegexRuleEntity.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
