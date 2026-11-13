// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sim_slot_rule_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SimSlotRuleEntity {

 String get id; String get name; String get phoneNumber; int get simSlotIndex; String get labelId; String? get avatar; String get actionType; int get priority; bool get isEnabled;
/// Create a copy of SimSlotRuleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimSlotRuleEntityCopyWith<SimSlotRuleEntity> get copyWith => _$SimSlotRuleEntityCopyWithImpl<SimSlotRuleEntity>(this as SimSlotRuleEntity, _$identity);

  /// Serializes this SimSlotRuleEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SimSlotRuleEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimSlotRuleEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.simSlotIndex, _this.simSlotIndex) || other.simSlotIndex == _this.simSlotIndex)&&(identical(other.labelId, _this.labelId) || other.labelId == _this.labelId)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.actionType, _this.actionType) || other.actionType == _this.actionType)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SimSlotRuleEntity;
  return Object.hash(runtimeType,_this.id,_this.name,_this.phoneNumber,_this.simSlotIndex,_this.labelId,_this.avatar,_this.actionType,_this.priority,_this.isEnabled);
}

@override
String toString() {
  final _this = this as SimSlotRuleEntity;
  return 'SimSlotRuleEntity(id: ${_this.id}, name: ${_this.name}, phoneNumber: ${_this.phoneNumber}, simSlotIndex: ${_this.simSlotIndex}, labelId: ${_this.labelId}, avatar: ${_this.avatar}, actionType: ${_this.actionType}, priority: ${_this.priority}, isEnabled: ${_this.isEnabled})';
}


}

/// @nodoc
abstract mixin class $SimSlotRuleEntityCopyWith<$Res>  {
  factory $SimSlotRuleEntityCopyWith(SimSlotRuleEntity value, $Res Function(SimSlotRuleEntity) _then) = _$SimSlotRuleEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phoneNumber, int simSlotIndex, String labelId, String? avatar, String actionType, int priority, bool isEnabled
});




}
/// @nodoc
class _$SimSlotRuleEntityCopyWithImpl<$Res>
    implements $SimSlotRuleEntityCopyWith<$Res> {
  _$SimSlotRuleEntityCopyWithImpl(this._self, this._then);

  final SimSlotRuleEntity _self;
  final $Res Function(SimSlotRuleEntity) _then;

/// Create a copy of SimSlotRuleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? simSlotIndex = null,Object? labelId = null,Object? avatar = freezed,Object? actionType = null,Object? priority = null,Object? isEnabled = null,}) {
  return _then(SimSlotRuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,simSlotIndex: null == simSlotIndex ? _self.simSlotIndex : simSlotIndex // ignore: cast_nullable_to_non_nullable
as int,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SimSlotRuleEntity].
extension SimSlotRuleEntityPatterns on SimSlotRuleEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimSlotRuleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimSlotRuleEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimSlotRuleEntity value)  $default,){
final _that = this;
switch (_that) {
case _SimSlotRuleEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimSlotRuleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SimSlotRuleEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phoneNumber,  int simSlotIndex,  String labelId,  String? avatar,  String actionType,  int priority,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimSlotRuleEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.simSlotIndex,_that.labelId,_that.avatar,_that.actionType,_that.priority,_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phoneNumber,  int simSlotIndex,  String labelId,  String? avatar,  String actionType,  int priority,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _SimSlotRuleEntity():
return $default(_that.id,_that.name,_that.phoneNumber,_that.simSlotIndex,_that.labelId,_that.avatar,_that.actionType,_that.priority,_that.isEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phoneNumber,  int simSlotIndex,  String labelId,  String? avatar,  String actionType,  int priority,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _SimSlotRuleEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.simSlotIndex,_that.labelId,_that.avatar,_that.actionType,_that.priority,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimSlotRuleEntity extends SimSlotRuleEntity {
  const _SimSlotRuleEntity({required this.id, required this.name, required this.phoneNumber, required this.simSlotIndex, this.labelId = '', this.avatar, this.actionType = 'block', this.priority = 100, this.isEnabled = true}): super._();
  factory _SimSlotRuleEntity.fromJson(Map<String, dynamic> json) => _$SimSlotRuleEntityFromJson(json);

@override final  String id;
@override final  String name;
@override final  String phoneNumber;
@override final  int simSlotIndex;
@override@JsonKey() final  String labelId;
@override final  String? avatar;
@override@JsonKey() final  String actionType;
@override@JsonKey() final  int priority;
@override@JsonKey() final  bool isEnabled;

/// Create a copy of SimSlotRuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimSlotRuleEntityCopyWith<_SimSlotRuleEntity> get copyWith => __$SimSlotRuleEntityCopyWithImpl<_SimSlotRuleEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimSlotRuleEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimSlotRuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.simSlotIndex, simSlotIndex) || other.simSlotIndex == simSlotIndex)&&(identical(other.labelId, labelId) || other.labelId == labelId)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,phoneNumber,simSlotIndex,labelId,avatar,actionType,priority,isEnabled);
}

@override
String toString() {
    return 'SimSlotRuleEntity(id: $id, name: $name, phoneNumber: $phoneNumber, simSlotIndex: $simSlotIndex, labelId: $labelId, avatar: $avatar, actionType: $actionType, priority: $priority, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$SimSlotRuleEntityCopyWith<$Res> implements $SimSlotRuleEntityCopyWith<$Res> {
  factory _$SimSlotRuleEntityCopyWith(_SimSlotRuleEntity value, $Res Function(_SimSlotRuleEntity) _then) = __$SimSlotRuleEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phoneNumber, int simSlotIndex, String labelId, String? avatar, String actionType, int priority, bool isEnabled
});




}
/// @nodoc
class __$SimSlotRuleEntityCopyWithImpl<$Res>
    implements _$SimSlotRuleEntityCopyWith<$Res> {
  __$SimSlotRuleEntityCopyWithImpl(this._self, this._then);

  final _SimSlotRuleEntity _self;
  final $Res Function(_SimSlotRuleEntity) _then;

/// Create a copy of SimSlotRuleEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? simSlotIndex = null,Object? labelId = null,Object? avatar = freezed,Object? actionType = null,Object? priority = null,Object? isEnabled = null,}) {
  return _then(_SimSlotRuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,simSlotIndex: null == simSlotIndex ? _self.simSlotIndex : simSlotIndex // ignore: cast_nullable_to_non_nullable
as int,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
