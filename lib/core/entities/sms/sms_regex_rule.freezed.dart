// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_regex_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SmsRegexRule {

 String get id; String get name;@RuleActionConverter() RuleAction get action; String get contentRegex; String? get senderRegex;@RulePriorityConverter() RulePriority get priority; bool get isEnabled; String get labelId; String get ruleType;
/// Create a copy of SmsRegexRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmsRegexRuleCopyWith<SmsRegexRule> get copyWith => _$SmsRegexRuleCopyWithImpl<SmsRegexRule>(this as SmsRegexRule, _$identity);

  /// Serializes this SmsRegexRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SmsRegexRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmsRegexRule&&super == other&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.contentRegex, _this.contentRegex) || other.contentRegex == _this.contentRegex)&&(identical(other.senderRegex, _this.senderRegex) || other.senderRegex == _this.senderRegex)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled)&&(identical(other.labelId, _this.labelId) || other.labelId == _this.labelId)&&(identical(other.ruleType, _this.ruleType) || other.ruleType == _this.ruleType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SmsRegexRule;
  return Object.hash(runtimeType,super.hashCode,_this.id,_this.name,_this.action,_this.contentRegex,_this.senderRegex,_this.priority,_this.isEnabled,_this.labelId,_this.ruleType);
}

@override
String toString() {
  final _this = this as SmsRegexRule;
  return 'SmsRegexRule(id: ${_this.id}, name: ${_this.name}, action: ${_this.action}, contentRegex: ${_this.contentRegex}, senderRegex: ${_this.senderRegex}, priority: ${_this.priority}, isEnabled: ${_this.isEnabled}, labelId: ${_this.labelId}, ruleType: ${_this.ruleType})';
}


}

/// @nodoc
abstract mixin class $SmsRegexRuleCopyWith<$Res>  {
  factory $SmsRegexRuleCopyWith(SmsRegexRule value, $Res Function(SmsRegexRule) _then) = _$SmsRegexRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name,@RuleActionConverter() RuleAction action, String contentRegex, String? senderRegex,@RulePriorityConverter() RulePriority priority, bool isEnabled, String labelId, String ruleType
});




}
/// @nodoc
class _$SmsRegexRuleCopyWithImpl<$Res>
    implements $SmsRegexRuleCopyWith<$Res> {
  _$SmsRegexRuleCopyWithImpl(this._self, this._then);

  final SmsRegexRule _self;
  final $Res Function(SmsRegexRule) _then;

/// Create a copy of SmsRegexRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? action = null,Object? contentRegex = null,Object? senderRegex = freezed,Object? priority = null,Object? isEnabled = null,Object? labelId = null,Object? ruleType = null,}) {
  return _then(SmsRegexRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,contentRegex: null == contentRegex ? _self.contentRegex : contentRegex // ignore: cast_nullable_to_non_nullable
as String,senderRegex: freezed == senderRegex ? _self.senderRegex : senderRegex // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SmsRegexRule].
extension SmsRegexRulePatterns on SmsRegexRule {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmsRegexRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmsRegexRule() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmsRegexRule value)  $default,){
final _that = this;
switch (_that) {
case _SmsRegexRule():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmsRegexRule value)?  $default,){
final _that = this;
switch (_that) {
case _SmsRegexRule() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @RuleActionConverter()  RuleAction action,  String contentRegex,  String? senderRegex, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  String labelId,  String ruleType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmsRegexRule() when $default != null:
return $default(_that.id,_that.name,_that.action,_that.contentRegex,_that.senderRegex,_that.priority,_that.isEnabled,_that.labelId,_that.ruleType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @RuleActionConverter()  RuleAction action,  String contentRegex,  String? senderRegex, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  String labelId,  String ruleType)  $default,) {final _that = this;
switch (_that) {
case _SmsRegexRule():
return $default(_that.id,_that.name,_that.action,_that.contentRegex,_that.senderRegex,_that.priority,_that.isEnabled,_that.labelId,_that.ruleType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @RuleActionConverter()  RuleAction action,  String contentRegex,  String? senderRegex, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  String labelId,  String ruleType)?  $default,) {final _that = this;
switch (_that) {
case _SmsRegexRule() when $default != null:
return $default(_that.id,_that.name,_that.action,_that.contentRegex,_that.senderRegex,_that.priority,_that.isEnabled,_that.labelId,_that.ruleType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SmsRegexRule extends SmsRegexRule implements RuleBase {
  const _SmsRegexRule({required this.id, required this.name, @RuleActionConverter() required this.action, required this.contentRegex, this.senderRegex, @RulePriorityConverter() this.priority = RulePriority.medium, this.isEnabled = true, this.labelId = '', this.ruleType = RuleTypeKeys.smsRegex}): super._();
  factory _SmsRegexRule.fromJson(Map<String, dynamic> json) => _$SmsRegexRuleFromJson(json);

@override final  String id;
@override final  String name;
@override@RuleActionConverter() final  RuleAction action;
@override final  String contentRegex;
@override final  String? senderRegex;
@override@JsonKey()@RulePriorityConverter() final  RulePriority priority;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  String labelId;
@override@JsonKey() final  String ruleType;

/// Create a copy of SmsRegexRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmsRegexRuleCopyWith<_SmsRegexRule> get copyWith => __$SmsRegexRuleCopyWithImpl<_SmsRegexRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SmsRegexRuleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmsRegexRule&&super == other&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.action, action) || other.action == action)&&(identical(other.contentRegex, contentRegex) || other.contentRegex == contentRegex)&&(identical(other.senderRegex, senderRegex) || other.senderRegex == senderRegex)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.labelId, labelId) || other.labelId == labelId)&&(identical(other.ruleType, ruleType) || other.ruleType == ruleType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,super.hashCode,id,name,action,contentRegex,senderRegex,priority,isEnabled,labelId,ruleType);
}

@override
String toString() {
    return 'SmsRegexRule(id: $id, name: $name, action: $action, contentRegex: $contentRegex, senderRegex: $senderRegex, priority: $priority, isEnabled: $isEnabled, labelId: $labelId, ruleType: $ruleType)';
}


}

/// @nodoc
abstract mixin class _$SmsRegexRuleCopyWith<$Res> implements $SmsRegexRuleCopyWith<$Res> {
  factory _$SmsRegexRuleCopyWith(_SmsRegexRule value, $Res Function(_SmsRegexRule) _then) = __$SmsRegexRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@RuleActionConverter() RuleAction action, String contentRegex, String? senderRegex,@RulePriorityConverter() RulePriority priority, bool isEnabled, String labelId, String ruleType
});




}
/// @nodoc
class __$SmsRegexRuleCopyWithImpl<$Res>
    implements _$SmsRegexRuleCopyWith<$Res> {
  __$SmsRegexRuleCopyWithImpl(this._self, this._then);

  final _SmsRegexRule _self;
  final $Res Function(_SmsRegexRule) _then;

/// Create a copy of SmsRegexRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? action = null,Object? contentRegex = null,Object? senderRegex = freezed,Object? priority = null,Object? isEnabled = null,Object? labelId = null,Object? ruleType = null,}) {
  return _then(_SmsRegexRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,contentRegex: null == contentRegex ? _self.contentRegex : contentRegex // ignore: cast_nullable_to_non_nullable
as String,senderRegex: freezed == senderRegex ? _self.senderRegex : senderRegex // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
