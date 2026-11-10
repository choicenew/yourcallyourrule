// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_rule_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneRuleEntity {

 String get id; String get name; String get phoneNumber; String get labelId; String? get avatar; String? get subscriptionId; String get actionType; int get priority; int get count; bool get isEnabled;
/// Create a copy of PhoneRuleEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneRuleEntityCopyWith<PhoneRuleEntity> get copyWith => _$PhoneRuleEntityCopyWithImpl<PhoneRuleEntity>(this as PhoneRuleEntity, _$identity);

  /// Serializes this PhoneRuleEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneRuleEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneRuleEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.labelId, _this.labelId) || other.labelId == _this.labelId)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.subscriptionId, _this.subscriptionId) || other.subscriptionId == _this.subscriptionId)&&(identical(other.actionType, _this.actionType) || other.actionType == _this.actionType)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneRuleEntity;
  return Object.hash(runtimeType,_this.id,_this.name,_this.phoneNumber,_this.labelId,_this.avatar,_this.subscriptionId,_this.actionType,_this.priority,_this.count,_this.isEnabled);
}

@override
String toString() {
  final _this = this as PhoneRuleEntity;
  return 'PhoneRuleEntity(id: ${_this.id}, name: ${_this.name}, phoneNumber: ${_this.phoneNumber}, labelId: ${_this.labelId}, avatar: ${_this.avatar}, subscriptionId: ${_this.subscriptionId}, actionType: ${_this.actionType}, priority: ${_this.priority}, count: ${_this.count}, isEnabled: ${_this.isEnabled})';
}


}

/// @nodoc
abstract mixin class $PhoneRuleEntityCopyWith<$Res>  {
  factory $PhoneRuleEntityCopyWith(PhoneRuleEntity value, $Res Function(PhoneRuleEntity) _then) = _$PhoneRuleEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phoneNumber, String labelId, String? avatar, String? subscriptionId, String actionType, int priority, int count, bool isEnabled
});




}
/// @nodoc
class _$PhoneRuleEntityCopyWithImpl<$Res>
    implements $PhoneRuleEntityCopyWith<$Res> {
  _$PhoneRuleEntityCopyWithImpl(this._self, this._then);

  final PhoneRuleEntity _self;
  final $Res Function(PhoneRuleEntity) _then;

/// Create a copy of PhoneRuleEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? labelId = null,Object? avatar = freezed,Object? subscriptionId = freezed,Object? actionType = null,Object? priority = null,Object? count = null,Object? isEnabled = null,}) {
  return _then(PhoneRuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneRuleEntity].
extension PhoneRuleEntityPatterns on PhoneRuleEntity {

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneRuleEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneRuleEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneRuleEntity value)  $default,){
final _that = this;
switch (_that) {
case _PhoneRuleEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneRuleEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneRuleEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phoneNumber,  String labelId,  String? avatar,  String? subscriptionId,  String actionType,  int priority,  int count,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneRuleEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.labelId,_that.avatar,_that.subscriptionId,_that.actionType,_that.priority,_that.count,_that.isEnabled);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phoneNumber,  String labelId,  String? avatar,  String? subscriptionId,  String actionType,  int priority,  int count,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _PhoneRuleEntity():
return $default(_that.id,_that.name,_that.phoneNumber,_that.labelId,_that.avatar,_that.subscriptionId,_that.actionType,_that.priority,_that.count,_that.isEnabled);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phoneNumber,  String labelId,  String? avatar,  String? subscriptionId,  String actionType,  int priority,  int count,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _PhoneRuleEntity() when $default != null:
return $default(_that.id,_that.name,_that.phoneNumber,_that.labelId,_that.avatar,_that.subscriptionId,_that.actionType,_that.priority,_that.count,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneRuleEntity extends PhoneRuleEntity {
  const _PhoneRuleEntity({required this.id, required this.name, required this.phoneNumber, this.labelId = '', this.avatar, this.subscriptionId, this.actionType = 'block', this.priority = 100, this.count = 0, this.isEnabled = true}): super._();
  factory _PhoneRuleEntity.fromJson(Map<String, dynamic> json) => _$PhoneRuleEntityFromJson(json);

@override final  String id;
@override final  String name;
@override final  String phoneNumber;
@override@JsonKey() final  String labelId;
@override final  String? avatar;
@override final  String? subscriptionId;
@override@JsonKey() final  String actionType;
@override@JsonKey() final  int priority;
@override@JsonKey() final  int count;
@override@JsonKey() final  bool isEnabled;

@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneRuleEntityCopyWith<_PhoneRuleEntity> get copyWith => __$PhoneRuleEntityCopyWithImpl<_PhoneRuleEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneRuleEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneRuleEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.labelId, labelId) || other.labelId == labelId)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.count, count) || other.count == count)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,phoneNumber,labelId,avatar,subscriptionId,actionType,priority,count,isEnabled);
}

@override
String toString() {
    return 'PhoneRuleEntity(id: $id, name: $name, phoneNumber: $phoneNumber, labelId: $labelId, avatar: $avatar, subscriptionId: $subscriptionId, actionType: $actionType, priority: $priority, count: $count, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$PhoneRuleEntityCopyWith<$Res> implements $PhoneRuleEntityCopyWith<$Res> {
  factory _$PhoneRuleEntityCopyWith(_PhoneRuleEntity value, $Res Function(_PhoneRuleEntity) _then) = __$PhoneRuleEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phoneNumber, String labelId, String? avatar, String? subscriptionId, String actionType, int priority, int count, bool isEnabled
});




}
/// @nodoc
class __$PhoneRuleEntityCopyWithImpl<$Res>
    implements _$PhoneRuleEntityCopyWith<$Res> {
  __$PhoneRuleEntityCopyWithImpl(this._self, this._then);

  final _PhoneRuleEntity _self;
  final $Res Function(_PhoneRuleEntity) _then;

@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phoneNumber = null,Object? labelId = null,Object? avatar = freezed,Object? subscriptionId = freezed,Object? actionType = null,Object? priority = null,Object? count = null,Object? isEnabled = null,}) {
  return _then(_PhoneRuleEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
