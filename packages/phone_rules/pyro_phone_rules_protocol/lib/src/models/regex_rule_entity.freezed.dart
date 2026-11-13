// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regex_rule_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegexRuleEntity {

 String get id; String get name; String get pattern; String get actionType; int get priority; String? get subscriptionId; bool get isEnabled;
/// Create a copy of RegexRuleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegexRuleEntityCopyWith<RegexRuleEntity> get copyWith => _$RegexRuleEntityCopyWithImpl<RegexRuleEntity>(this as RegexRuleEntity, _$identity);

  /// Serializes this RegexRuleEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RegexRuleEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegexRuleEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.pattern, _this.pattern) || other.pattern == _this.pattern)&&(identical(other.actionType, _this.actionType) || other.actionType == _this.actionType)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.subscriptionId, _this.subscriptionId) || other.subscriptionId == _this.subscriptionId)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RegexRuleEntity;
  return Object.hash(runtimeType,_this.id,_this.name,_this.pattern,_this.actionType,_this.priority,_this.subscriptionId,_this.isEnabled);
}

@override
String toString() {
  final _this = this as RegexRuleEntity;
  return 'RegexRuleEntity(id: ${_this.id}, name: ${_this.name}, pattern: ${_this.pattern}, actionType: ${_this.actionType}, priority: ${_this.priority}, subscriptionId: ${_this.subscriptionId}, isEnabled: ${_this.isEnabled})';
}


}

/// @nodoc
abstract mixin class $RegexRuleEntityCopyWith<$Res>  {
  factory $RegexRuleEntityCopyWith(RegexRuleEntity value, $Res Function(RegexRuleEntity) _then) = _$RegexRuleEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String pattern, String actionType, int priority, String? subscriptionId, bool isEnabled
});




}
/// @nodoc
class _$RegexRuleEntityCopyWithImpl<$Res>
    implements $RegexRuleEntityCopyWith<$Res> {
  _$RegexRuleEntityCopyWithImpl(this._self, this._then);

  final RegexRuleEntity _self;
  final $Res Function(RegexRuleEntity) _then;

/// Create a copy of RegexRuleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? pattern = null,Object? actionType = null,Object? priority = null,Object? subscriptionId = freezed,Object? isEnabled = null,}) {
  return _then(RegexRuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RegexRuleEntity].
extension RegexRuleEntityPatterns on RegexRuleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegexRuleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegexRuleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegexRuleEntity value)  $default,){
final _that = this;
switch (_that) {
case _RegexRuleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegexRuleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RegexRuleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String pattern,  String actionType,  int priority,  String? subscriptionId,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegexRuleEntity() when $default != null:
return $default(_that.id,_that.name,_that.pattern,_that.actionType,_that.priority,_that.subscriptionId,_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String pattern,  String actionType,  int priority,  String? subscriptionId,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _RegexRuleEntity():
return $default(_that.id,_that.name,_that.pattern,_that.actionType,_that.priority,_that.subscriptionId,_that.isEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String pattern,  String actionType,  int priority,  String? subscriptionId,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _RegexRuleEntity() when $default != null:
return $default(_that.id,_that.name,_that.pattern,_that.actionType,_that.priority,_that.subscriptionId,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegexRuleEntity extends RegexRuleEntity {
  const _RegexRuleEntity({required this.id, required this.name, required this.pattern, this.actionType = 'block', this.priority = 100, this.subscriptionId, this.isEnabled = true}): super._();
  factory _RegexRuleEntity.fromJson(Map<String, dynamic> json) => _$RegexRuleEntityFromJson(json);

@override final  String id;
@override final  String name;
@override final  String pattern;
@override@JsonKey() final  String actionType;
@override@JsonKey() final  int priority;
@override final  String? subscriptionId;
@override@JsonKey() final  bool isEnabled;

/// Create a copy of RegexRuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegexRuleEntityCopyWith<_RegexRuleEntity> get copyWith => __$RegexRuleEntityCopyWithImpl<_RegexRuleEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegexRuleEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegexRuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,pattern,actionType,priority,subscriptionId,isEnabled);
}

@override
String toString() {
    return 'RegexRuleEntity(id: $id, name: $name, pattern: $pattern, actionType: $actionType, priority: $priority, subscriptionId: $subscriptionId, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$RegexRuleEntityCopyWith<$Res> implements $RegexRuleEntityCopyWith<$Res> {
  factory _$RegexRuleEntityCopyWith(_RegexRuleEntity value, $Res Function(_RegexRuleEntity) _then) = __$RegexRuleEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String pattern, String actionType, int priority, String? subscriptionId, bool isEnabled
});




}
/// @nodoc
class __$RegexRuleEntityCopyWithImpl<$Res>
    implements _$RegexRuleEntityCopyWith<$Res> {
  __$RegexRuleEntityCopyWithImpl(this._self, this._then);

  final _RegexRuleEntity _self;
  final $Res Function(_RegexRuleEntity) _then;

/// Create a copy of RegexRuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? pattern = null,Object? actionType = null,Object? priority = null,Object? subscriptionId = freezed,Object? isEnabled = null,}) {
  return _then(_RegexRuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
