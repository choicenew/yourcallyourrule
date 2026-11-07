// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_live_activity_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneLiveActivityRecord {

 String get activityId; String get phoneNumber; String get title; String? get subtitle; String get status; int? get timestamp;
/// Create a copy of PhoneLiveActivityRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneLiveActivityRecordCopyWith<PhoneLiveActivityRecord> get copyWith => _$PhoneLiveActivityRecordCopyWithImpl<PhoneLiveActivityRecord>(this as PhoneLiveActivityRecord, _$identity);

  /// Serializes this PhoneLiveActivityRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneLiveActivityRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneLiveActivityRecord&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneLiveActivityRecord;
  return Object.hash(runtimeType,_this.activityId,_this.phoneNumber,_this.title,_this.subtitle,_this.status,_this.timestamp);
}

@override
String toString() {
  final _this = this as PhoneLiveActivityRecord;
  return 'PhoneLiveActivityRecord(activityId: ${_this.activityId}, phoneNumber: ${_this.phoneNumber}, title: ${_this.title}, subtitle: ${_this.subtitle}, status: ${_this.status}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $PhoneLiveActivityRecordCopyWith<$Res>  {
  factory $PhoneLiveActivityRecordCopyWith(PhoneLiveActivityRecord value, $Res Function(PhoneLiveActivityRecord) _then) = _$PhoneLiveActivityRecordCopyWithImpl;
@useResult
$Res call({
 String activityId, String phoneNumber, String title, String? subtitle, String status, int? timestamp
});




}
/// @nodoc
class _$PhoneLiveActivityRecordCopyWithImpl<$Res>
    implements $PhoneLiveActivityRecordCopyWith<$Res> {
  _$PhoneLiveActivityRecordCopyWithImpl(this._self, this._then);

  final PhoneLiveActivityRecord _self;
  final $Res Function(PhoneLiveActivityRecord) _then;

/// Create a copy of PhoneLiveActivityRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityId = null,Object? phoneNumber = null,Object? title = null,Object? subtitle = freezed,Object? status = null,Object? timestamp = freezed,}) {
  return _then(PhoneLiveActivityRecord(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneLiveActivityRecord].
extension PhoneLiveActivityRecordPatterns on PhoneLiveActivityRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneLiveActivityRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneLiveActivityRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneLiveActivityRecord value)  $default,){
final _that = this;
switch (_that) {
case _PhoneLiveActivityRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneLiveActivityRecord value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneLiveActivityRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String activityId,  String phoneNumber,  String title,  String? subtitle,  String status,  int? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneLiveActivityRecord() when $default != null:
return $default(_that.activityId,_that.phoneNumber,_that.title,_that.subtitle,_that.status,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String activityId,  String phoneNumber,  String title,  String? subtitle,  String status,  int? timestamp)  $default,) {final _that = this;
switch (_that) {
case _PhoneLiveActivityRecord():
return $default(_that.activityId,_that.phoneNumber,_that.title,_that.subtitle,_that.status,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String activityId,  String phoneNumber,  String title,  String? subtitle,  String status,  int? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _PhoneLiveActivityRecord() when $default != null:
return $default(_that.activityId,_that.phoneNumber,_that.title,_that.subtitle,_that.status,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneLiveActivityRecord extends PhoneLiveActivityRecord {
  const _PhoneLiveActivityRecord({required this.activityId, required this.phoneNumber, required this.title, this.subtitle, this.status = 'active', this.timestamp}): super._();
  factory _PhoneLiveActivityRecord.fromJson(Map<String, dynamic> json) => _$PhoneLiveActivityRecordFromJson(json);

@override final  String activityId;
@override final  String phoneNumber;
@override final  String title;
@override final  String? subtitle;
@override@JsonKey() final  String status;
@override final  int? timestamp;

/// Create a copy of PhoneLiveActivityRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneLiveActivityRecordCopyWith<_PhoneLiveActivityRecord> get copyWith => __$PhoneLiveActivityRecordCopyWithImpl<_PhoneLiveActivityRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneLiveActivityRecordToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneLiveActivityRecord&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activityId,phoneNumber,title,subtitle,status,timestamp);
}

@override
String toString() {
    return 'PhoneLiveActivityRecord(activityId: $activityId, phoneNumber: $phoneNumber, title: $title, subtitle: $subtitle, status: $status, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PhoneLiveActivityRecordCopyWith<$Res> implements $PhoneLiveActivityRecordCopyWith<$Res> {
  factory _$PhoneLiveActivityRecordCopyWith(_PhoneLiveActivityRecord value, $Res Function(_PhoneLiveActivityRecord) _then) = __$PhoneLiveActivityRecordCopyWithImpl;
@override @useResult
$Res call({
 String activityId, String phoneNumber, String title, String? subtitle, String status, int? timestamp
});




}
/// @nodoc
class __$PhoneLiveActivityRecordCopyWithImpl<$Res>
    implements _$PhoneLiveActivityRecordCopyWith<$Res> {
  __$PhoneLiveActivityRecordCopyWithImpl(this._self, this._then);

  final _PhoneLiveActivityRecord _self;
  final $Res Function(_PhoneLiveActivityRecord) _then;

/// Create a copy of PhoneLiveActivityRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityId = null,Object? phoneNumber = null,Object? title = null,Object? subtitle = freezed,Object? status = null,Object? timestamp = freezed,}) {
  return _then(_PhoneLiveActivityRecord(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: freezed == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
