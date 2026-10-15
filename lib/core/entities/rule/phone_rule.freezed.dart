// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneRule {

 String get id; String get name;@RuleActionConverter() RuleAction get action;@PhoneNumberConverter() PhoneNumber get phoneNumber; String get labelId; String get ruleType;@RulePriorityConverter() RulePriority get priority; bool get isEnabled; int get count; String? get avatar; String? get subscriptionId;
/// Create a copy of PhoneRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneRuleCopyWith<PhoneRule> get copyWith => _$PhoneRuleCopyWithImpl<PhoneRule>(this as PhoneRule, _$identity);

  /// Serializes this PhoneRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneRule&&super == other&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.labelId, _this.labelId) || other.labelId == _this.labelId)&&(identical(other.ruleType, _this.ruleType) || other.ruleType == _this.ruleType)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.subscriptionId, _this.subscriptionId) || other.subscriptionId == _this.subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneRule;
  return Object.hash(runtimeType,super.hashCode,_this.id,_this.name,_this.action,_this.phoneNumber,_this.labelId,_this.ruleType,_this.priority,_this.isEnabled,_this.count,_this.avatar,_this.subscriptionId);
}

@override
String toString() {
  final _this = this as PhoneRule;
  return 'PhoneRule(id: ${_this.id}, name: ${_this.name}, action: ${_this.action}, phoneNumber: ${_this.phoneNumber}, labelId: ${_this.labelId}, ruleType: ${_this.ruleType}, priority: ${_this.priority}, isEnabled: ${_this.isEnabled}, count: ${_this.count}, avatar: ${_this.avatar}, subscriptionId: ${_this.subscriptionId})';
}


}

/// @nodoc
abstract mixin class $PhoneRuleCopyWith<$Res>  {
  factory $PhoneRuleCopyWith(PhoneRule value, $Res Function(PhoneRule) _then) = _$PhoneRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name,@RuleActionConverter() RuleAction action,@PhoneNumberConverter() PhoneNumber phoneNumber, String labelId, String ruleType,@RulePriorityConverter() RulePriority priority, bool isEnabled, int count, String? avatar, String? subscriptionId
});




}
/// @nodoc
class _$PhoneRuleCopyWithImpl<$Res>
    implements $PhoneRuleCopyWith<$Res> {
  _$PhoneRuleCopyWithImpl(this._self, this._then);

  final PhoneRule _self;
  final $Res Function(PhoneRule) _then;

/// Create a copy of PhoneRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? action = null,Object? phoneNumber = null,Object? labelId = null,Object? ruleType = null,Object? priority = null,Object? isEnabled = null,Object? count = null,Object? avatar = freezed,Object? subscriptionId = freezed,}) {
  return _then(PhoneRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneRule].
extension PhoneRulePatterns on PhoneRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneRule value)  $default,){
final _that = this;
switch (_that) {
case _PhoneRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneRule value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @RuleActionConverter()  RuleAction action, @PhoneNumberConverter()  PhoneNumber phoneNumber,  String labelId,  String ruleType, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  int count,  String? avatar,  String? subscriptionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneRule() when $default != null:
return $default(_that.id,_that.name,_that.action,_that.phoneNumber,_that.labelId,_that.ruleType,_that.priority,_that.isEnabled,_that.count,_that.avatar,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @RuleActionConverter()  RuleAction action, @PhoneNumberConverter()  PhoneNumber phoneNumber,  String labelId,  String ruleType, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  int count,  String? avatar,  String? subscriptionId)  $default,) {final _that = this;
switch (_that) {
case _PhoneRule():
return $default(_that.id,_that.name,_that.action,_that.phoneNumber,_that.labelId,_that.ruleType,_that.priority,_that.isEnabled,_that.count,_that.avatar,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @RuleActionConverter()  RuleAction action, @PhoneNumberConverter()  PhoneNumber phoneNumber,  String labelId,  String ruleType, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  int count,  String? avatar,  String? subscriptionId)?  $default,) {final _that = this;
switch (_that) {
case _PhoneRule() when $default != null:
return $default(_that.id,_that.name,_that.action,_that.phoneNumber,_that.labelId,_that.ruleType,_that.priority,_that.isEnabled,_that.count,_that.avatar,_that.subscriptionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneRule extends PhoneRule implements RuleBase {
  const _PhoneRule({required this.id, required this.name, @RuleActionConverter() required this.action, @PhoneNumberConverter() required this.phoneNumber, required this.labelId, this.ruleType = RuleTypeKeys.phone, @RulePriorityConverter() this.priority = RulePriority.medium, this.isEnabled = true, this.count = 0, this.avatar, this.subscriptionId}): super._();
  factory _PhoneRule.fromJson(Map<String, dynamic> json) => _$PhoneRuleFromJson(json);

@override final  String id;
@override final  String name;
@override@RuleActionConverter() final  RuleAction action;
@override@PhoneNumberConverter() final  PhoneNumber phoneNumber;
@override final  String labelId;
@override@JsonKey() final  String ruleType;
@override@JsonKey()@RulePriorityConverter() final  RulePriority priority;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  int count;
@override final  String? avatar;
@override final  String? subscriptionId;

/// Create a copy of PhoneRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneRuleCopyWith<_PhoneRule> get copyWith => __$PhoneRuleCopyWithImpl<_PhoneRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneRuleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneRule&&super == other&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.action, action) || other.action == action)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.labelId, labelId) || other.labelId == labelId)&&(identical(other.ruleType, ruleType) || other.ruleType == ruleType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.count, count) || other.count == count)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,super.hashCode,id,name,action,phoneNumber,labelId,ruleType,priority,isEnabled,count,avatar,subscriptionId);
}

@override
String toString() {
    return 'PhoneRule(id: $id, name: $name, action: $action, phoneNumber: $phoneNumber, labelId: $labelId, ruleType: $ruleType, priority: $priority, isEnabled: $isEnabled, count: $count, avatar: $avatar, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class _$PhoneRuleCopyWith<$Res> implements $PhoneRuleCopyWith<$Res> {
  factory _$PhoneRuleCopyWith(_PhoneRule value, $Res Function(_PhoneRule) _then) = __$PhoneRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@RuleActionConverter() RuleAction action,@PhoneNumberConverter() PhoneNumber phoneNumber, String labelId, String ruleType,@RulePriorityConverter() RulePriority priority, bool isEnabled, int count, String? avatar, String? subscriptionId
});




}
/// @nodoc
class __$PhoneRuleCopyWithImpl<$Res>
    implements _$PhoneRuleCopyWith<$Res> {
  __$PhoneRuleCopyWithImpl(this._self, this._then);

  final _PhoneRule _self;
  final $Res Function(_PhoneRule) _then;

/// Create a copy of PhoneRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? action = null,Object? phoneNumber = null,Object? labelId = null,Object? ruleType = null,Object? priority = null,Object? isEnabled = null,Object? count = null,Object? avatar = freezed,Object? subscriptionId = freezed,}) {
  return _then(_PhoneRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
