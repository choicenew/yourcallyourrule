// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regex_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegexRule {

 String get id; String get name; String get pattern;@RuleActionConverter() RuleAction get action;@RulePriorityConverter() RulePriority get priority; bool get isEnabled; String get ruleType; String? get subscriptionId;
/// Create a copy of RegexRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegexRuleCopyWith<RegexRule> get copyWith => _$RegexRuleCopyWithImpl<RegexRule>(this as RegexRule, _$identity);

  /// Serializes this RegexRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegexRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegexRule&&super == other&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.pattern, _this.pattern) || other.pattern == _this.pattern)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled)&&(identical(other.ruleType, _this.ruleType) || other.ruleType == _this.ruleType)&&(identical(other.subscriptionId, _this.subscriptionId) || other.subscriptionId == _this.subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegexRule;
  return Object.hash(runtimeType,super.hashCode,_this.id,_this.name,_this.pattern,_this.action,_this.priority,_this.isEnabled,_this.ruleType,_this.subscriptionId);
}

@override
String toString() {
  final _this = this as RegexRule;
  return 'RegexRule(id: ${_this.id}, name: ${_this.name}, pattern: ${_this.pattern}, action: ${_this.action}, priority: ${_this.priority}, isEnabled: ${_this.isEnabled}, ruleType: ${_this.ruleType}, subscriptionId: ${_this.subscriptionId})';
}


}

/// @nodoc
abstract mixin class $RegexRuleCopyWith<$Res>  {
  factory $RegexRuleCopyWith(RegexRule value, $Res Function(RegexRule) _then) = _$RegexRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String pattern,@RuleActionConverter() RuleAction action,@RulePriorityConverter() RulePriority priority, bool isEnabled, String ruleType, String? subscriptionId
});




}
/// @nodoc
class _$RegexRuleCopyWithImpl<$Res>
    implements $RegexRuleCopyWith<$Res> {
  _$RegexRuleCopyWithImpl(this._self, this._then);

  final RegexRule _self;
  final $Res Function(RegexRule) _then;

/// Create a copy of RegexRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? pattern = null,Object? action = null,Object? priority = null,Object? isEnabled = null,Object? ruleType = null,Object? subscriptionId = freezed,}) {
  return _then(RegexRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegexRule].
extension RegexRulePatterns on RegexRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegexRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegexRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegexRule value)  $default,){
final _that = this;
switch (_that) {
case _RegexRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegexRule value)?  $default,){
final _that = this;
switch (_that) {
case _RegexRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String pattern, @RuleActionConverter()  RuleAction action, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  String ruleType,  String? subscriptionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegexRule() when $default != null:
return $default(_that.id,_that.name,_that.pattern,_that.action,_that.priority,_that.isEnabled,_that.ruleType,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String pattern, @RuleActionConverter()  RuleAction action, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  String ruleType,  String? subscriptionId)  $default,) {final _that = this;
switch (_that) {
case _RegexRule():
return $default(_that.id,_that.name,_that.pattern,_that.action,_that.priority,_that.isEnabled,_that.ruleType,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String pattern, @RuleActionConverter()  RuleAction action, @RulePriorityConverter()  RulePriority priority,  bool isEnabled,  String ruleType,  String? subscriptionId)?  $default,) {final _that = this;
switch (_that) {
case _RegexRule() when $default != null:
return $default(_that.id,_that.name,_that.pattern,_that.action,_that.priority,_that.isEnabled,_that.ruleType,_that.subscriptionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegexRule extends RegexRule implements RuleBase {
  const _RegexRule({required this.id, required this.name, required this.pattern, @RuleActionConverter() required this.action, @RulePriorityConverter() this.priority = RulePriority.medium, this.isEnabled = true, this.ruleType = RuleTypeKeys.regex, this.subscriptionId}): super._();
  factory _RegexRule.fromJson(Map<String, dynamic> json) => _$RegexRuleFromJson(json);

@override final  String id;
@override final  String name;
@override final  String pattern;
@override@RuleActionConverter() final  RuleAction action;
@override@JsonKey()@RulePriorityConverter() final  RulePriority priority;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  String ruleType;
@override final  String? subscriptionId;

/// Create a copy of RegexRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegexRuleCopyWith<_RegexRule> get copyWith => __$RegexRuleCopyWithImpl<_RegexRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegexRuleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegexRule&&super == other&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.action, action) || other.action == action)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.ruleType, ruleType) || other.ruleType == ruleType)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,super.hashCode,id,name,pattern,action,priority,isEnabled,ruleType,subscriptionId);
}

@override
String toString() {
    return 'RegexRule(id: $id, name: $name, pattern: $pattern, action: $action, priority: $priority, isEnabled: $isEnabled, ruleType: $ruleType, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class _$RegexRuleCopyWith<$Res> implements $RegexRuleCopyWith<$Res> {
  factory _$RegexRuleCopyWith(_RegexRule value, $Res Function(_RegexRule) _then) = __$RegexRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String pattern,@RuleActionConverter() RuleAction action,@RulePriorityConverter() RulePriority priority, bool isEnabled, String ruleType, String? subscriptionId
});




}
/// @nodoc
class __$RegexRuleCopyWithImpl<$Res>
    implements _$RegexRuleCopyWith<$Res> {
  __$RegexRuleCopyWithImpl(this._self, this._then);

  final _RegexRule _self;
  final $Res Function(_RegexRule) _then;

/// Create a copy of RegexRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? pattern = null,Object? action = null,Object? priority = null,Object? isEnabled = null,Object? ruleType = null,Object? subscriptionId = freezed,}) {
  return _then(_RegexRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as RulePriority,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,ruleType: null == ruleType ? _self.ruleType : ruleType // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
