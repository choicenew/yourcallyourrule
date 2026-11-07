// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proposal_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProposalEntity {

 String get id; String get phoneNumber; String get reason; String get status; int get voteCount; int? get createdAt;
/// Create a copy of ProposalEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProposalEntityCopyWith<ProposalEntity> get copyWith => _$ProposalEntityCopyWithImpl<ProposalEntity>(this as ProposalEntity, _$identity);

  /// Serializes this ProposalEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ProposalEntity;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProposalEntity&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.voteCount, _this.voteCount) || other.voteCount == _this.voteCount)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ProposalEntity;
  return Object.hash(runtimeType,_this.id,_this.phoneNumber,_this.reason,_this.status,_this.voteCount,_this.createdAt);
}

@override
String toString() {
  final _this = this as ProposalEntity;
  return 'ProposalEntity(id: ${_this.id}, phoneNumber: ${_this.phoneNumber}, reason: ${_this.reason}, status: ${_this.status}, voteCount: ${_this.voteCount}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $ProposalEntityCopyWith<$Res>  {
  factory $ProposalEntityCopyWith(ProposalEntity value, $Res Function(ProposalEntity) _then) = _$ProposalEntityCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, String reason, String status, int voteCount, int? createdAt
});




}
/// @nodoc
class _$ProposalEntityCopyWithImpl<$Res>
    implements $ProposalEntityCopyWith<$Res> {
  _$ProposalEntityCopyWithImpl(this._self, this._then);

  final ProposalEntity _self;
  final $Res Function(ProposalEntity) _then;

/// Create a copy of ProposalEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? reason = null,Object? status = null,Object? voteCount = null,Object? createdAt = freezed,}) {
  return _then(ProposalEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProposalEntity].
extension ProposalEntityPatterns on ProposalEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProposalEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProposalEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProposalEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProposalEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProposalEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProposalEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String reason,  String status,  int voteCount,  int? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProposalEntity() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.reason,_that.status,_that.voteCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String reason,  String status,  int voteCount,  int? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ProposalEntity():
return $default(_that.id,_that.phoneNumber,_that.reason,_that.status,_that.voteCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  String reason,  String status,  int voteCount,  int? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ProposalEntity() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.reason,_that.status,_that.voteCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProposalEntity extends ProposalEntity {
  const _ProposalEntity({required this.id, required this.phoneNumber, required this.reason, this.status = 'pending', this.voteCount = 0, this.createdAt}): super._();
  factory _ProposalEntity.fromJson(Map<String, dynamic> json) => _$ProposalEntityFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  String reason;
@override@JsonKey() final  String status;
@override@JsonKey() final  int voteCount;
@override final  int? createdAt;

/// Create a copy of ProposalEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProposalEntityCopyWith<_ProposalEntity> get copyWith => __$ProposalEntityCopyWithImpl<_ProposalEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProposalEntityToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProposalEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.voteCount, voteCount) || other.voteCount == voteCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,phoneNumber,reason,status,voteCount,createdAt);
}

@override
String toString() {
    return 'ProposalEntity(id: $id, phoneNumber: $phoneNumber, reason: $reason, status: $status, voteCount: $voteCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ProposalEntityCopyWith<$Res> implements $ProposalEntityCopyWith<$Res> {
  factory _$ProposalEntityCopyWith(_ProposalEntity value, $Res Function(_ProposalEntity) _then) = __$ProposalEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, String reason, String status, int voteCount, int? createdAt
});




}
/// @nodoc
class __$ProposalEntityCopyWithImpl<$Res>
    implements _$ProposalEntityCopyWith<$Res> {
  __$ProposalEntityCopyWithImpl(this._self, this._then);

  final _ProposalEntity _self;
  final $Res Function(_ProposalEntity) _then;

/// Create a copy of ProposalEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? reason = null,Object? status = null,Object? voteCount = null,Object? createdAt = freezed,}) {
  return _then(_ProposalEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,voteCount: null == voteCount ? _self.voteCount : voteCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
