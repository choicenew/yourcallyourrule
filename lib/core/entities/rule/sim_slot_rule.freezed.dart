// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_slot_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SimSlotRule {

 String get id; String get name; RulePriority get priority; PhoneNumber get phoneNumber; int get simSlotIndex; String get labelId; String? get avatar; String get ruleType; RuleAction get action; bool get isEnabled;
/// Create a copy of SimSlotRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimSlotRuleCopyWith<SimSlotRule> get copyWith => _$SimSlotRuleCopyWithImpl<SimSlotRule>(this as SimSlotRule, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SimSlotRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimSlotRule&&super == other&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.simSlotIndex, _this.simSlotIndex) || other.simSlotIndex == _this.simSlotIndex)&&(identical(other.labelId, _this.labelId) || other.labelId == _this.labelId)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.ruleType, _this.ruleType) || other.ruleType == _this.ruleType)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled));
}


@override
int get hashCode {
  final _this = this as SimSlotRule;
  return Object.hash(runtimeType,super.hashCode,_this.id,_this.name,_this.priority,_this.phoneNumber,_this.simSlotIndex,_this.labelId,_this.avatar,_this.ruleType,_this.action,_this.isEnabled);
}

@override
String toString() {
  final _this = this as SimSlotRule;
  return 'SimSlotRule(id: ${_this.id}, name: ${_this.name}, priority: ${_this.priority}, phoneNumber: ${_this.phoneNumber}, simSlotIndex: ${_this.simSlotIndex}, labelId: ${_this.labelId}, avatar: ${_this.avatar}, ruleType: ${_this.ruleType}, action: ${_this.action}, isEnabled: ${_this.isEnabled})';
}


}

/// @nodoc
abstract mixin class $SimSlotRuleCopyWith<$Res>  {
  factory $SimSlotRuleCopyWith(SimSlotRule value, $Res Function(SimSlotRule) _then) = _$SimSlotRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name, RulePriority priority, PhoneNumber phoneNumber, int simSlotIndex, String labelId, String? avatar, String ruleType, RuleAction action, bool isEnabled
});




}
/// @nodoc
class _$SimSlotRuleCopyWithImpl<$Res>
    implements $SimSlotRuleCopyWith<$Res> {
  _$SimSlotRuleCopyWithImpl(this._self, this._then);

  final SimSlotRule _self;
  final $Res Function(SimSlotRule) _then;

/// Create a copy of SimSlotRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? priority = null,Object? phoneNumber = null,Object? simSlotIndex = null,Object? labelId = null,Object? avatar = freezed,Object? ruleType = null,Object? action = null,Object? isEnabled = null,}) {
  return _then(SimSlotRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,simSlotIndex: null == simSlotIndex ? _self.simSlotIndex : simSlotIndex // ignore: cast_nullable_to_non_nullable
as int,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SimSlotRule].
extension SimSlotRulePatterns on SimSlotRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimSlotRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimSlotRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimSlotRule value)  $default,){
final _that = this;
switch (_that) {
case _SimSlotRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimSlotRule value)?  $default,){
final _that = this;
switch (_that) {
case _SimSlotRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  RulePriority priority,  PhoneNumber phoneNumber,  int simSlotIndex,  String labelId,  String? avatar,  String ruleType,  RuleAction action,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimSlotRule() when $default != null:
return $default(_that.id,_that.name,_that.priority,_that.phoneNumber,_that.simSlotIndex,_that.labelId,_that.avatar,_that.ruleType,_that.action,_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  RulePriority priority,  PhoneNumber phoneNumber,  int simSlotIndex,  String labelId,  String? avatar,  String ruleType,  RuleAction action,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _SimSlotRule():
return $default(_that.id,_that.name,_that.priority,_that.phoneNumber,_that.simSlotIndex,_that.labelId,_that.avatar,_that.ruleType,_that.action,_that.isEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  RulePriority priority,  PhoneNumber phoneNumber,  int simSlotIndex,  String labelId,  String? avatar,  String ruleType,  RuleAction action,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _SimSlotRule() when $default != null:
return $default(_that.id,_that.name,_that.priority,_that.phoneNumber,_that.simSlotIndex,_that.labelId,_that.avatar,_that.ruleType,_that.action,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _SimSlotRule extends SimSlotRule implements RuleBase {
  const _SimSlotRule({required this.id, required this.name, required this.priority, required this.phoneNumber, required this.simSlotIndex, this.labelId = '', this.avatar, this.ruleType = RuleTypeKeys.simSlot, this.action = RuleAction.block, this.isEnabled = true}): super._();
  

@override final  String id;
@override final  String name;
@override final  RulePriority priority;
@override final  PhoneNumber phoneNumber;
@override final  int simSlotIndex;
@override@JsonKey() final  String labelId;
@override final  String? avatar;
@override@JsonKey() final  String ruleType;
@override@JsonKey() final  RuleAction action;
@override@JsonKey() final  bool isEnabled;

/// Create a copy of SimSlotRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimSlotRuleCopyWith<_SimSlotRule> get copyWith => __$SimSlotRuleCopyWithImpl<_SimSlotRule>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimSlotRule&&super == other&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.simSlotIndex, simSlotIndex) || other.simSlotIndex == simSlotIndex)&&(identical(other.labelId, labelId) || other.labelId == labelId)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.ruleType, ruleType) || other.ruleType == ruleType)&&(identical(other.action, action) || other.action == action)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,super.hashCode,id,name,priority,phoneNumber,simSlotIndex,labelId,avatar,ruleType,action,isEnabled);
}

@override
String toString() {
    return 'SimSlotRule(id: $id, name: $name, priority: $priority, phoneNumber: $phoneNumber, simSlotIndex: $simSlotIndex, labelId: $labelId, avatar: $avatar, ruleType: $ruleType, action: $action, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$SimSlotRuleCopyWith<$Res> implements $SimSlotRuleCopyWith<$Res> {
  factory _$SimSlotRuleCopyWith(_SimSlotRule value, $Res Function(_SimSlotRule) _then) = __$SimSlotRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, RulePriority priority, PhoneNumber phoneNumber, int simSlotIndex, String labelId, String? avatar, String ruleType, RuleAction action, bool isEnabled
});




}
/// @nodoc
class __$SimSlotRuleCopyWithImpl<$Res>
    implements _$SimSlotRuleCopyWith<$Res> {
  __$SimSlotRuleCopyWithImpl(this._self, this._then);

  final _SimSlotRule _self;
  final $Res Function(_SimSlotRule) _then;

/// Create a copy of SimSlotRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? priority = null,Object? phoneNumber = null,Object? simSlotIndex = null,Object? labelId = null,Object? avatar = freezed,Object? ruleType = null,Object? action = null,Object? isEnabled = null,}) {
  return _then(_SimSlotRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as PhoneNumber,simSlotIndex: null == simSlotIndex ? _self.simSlotIndex : simSlotIndex // ignore: cast_nullable_to_non_nullable
as int,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
