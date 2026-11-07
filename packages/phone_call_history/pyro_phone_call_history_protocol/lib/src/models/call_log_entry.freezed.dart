// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_log_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallLogEntry {

 String get id; String get phoneNumber; String get callType; int? get timestamp; int? get durationSeconds; String? get name; String? get location;
/// Create a copy of CallLogEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallLogEntryCopyWith<CallLogEntry> get copyWith => _$CallLogEntryCopyWithImpl<CallLogEntry>(this as CallLogEntry, _$identity);

  /// Serializes this CallLogEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CallLogEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallLogEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.callType, _this.callType) || other.callType == _this.callType)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.location, _this.location) || other.location == _this.location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CallLogEntry;
  return Object.hash(runtimeType,_this.id,_this.phoneNumber,_this.callType,_this.timestamp,_this.durationSeconds,_this.name,_this.location);
}

@override
String toString() {
  final _this = this as CallLogEntry;
  return 'CallLogEntry(id: ${_this.id}, phoneNumber: ${_this.phoneNumber}, callType: ${_this.callType}, timestamp: ${_this.timestamp}, durationSeconds: ${_this.durationSeconds}, name: ${_this.name}, location: ${_this.location})';
}


}

/// @nodoc
abstract mixin class $CallLogEntryCopyWith<$Res>  {
  factory $CallLogEntryCopyWith(CallLogEntry value, $Res Function(CallLogEntry) _then) = _$CallLogEntryCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, String callType, int? timestamp, int? durationSeconds, String? name, String? location
});




}
/// @nodoc
class _$CallLogEntryCopyWithImpl<$Res>
    implements $CallLogEntryCopyWith<$Res> {
  _$CallLogEntryCopyWithImpl(this._self, this._then);

  final CallLogEntry _self;
  final $Res Function(CallLogEntry) _then;

/// Create a copy of CallLogEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? callType = null,Object? timestamp = freezed,Object? durationSeconds = freezed,Object? name = freezed,Object? location = freezed,}) {
  return _then(CallLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallLogEntry].
extension CallLogEntryPatterns on CallLogEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallLogEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallLogEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallLogEntry value)  $default,){
final _that = this;
switch (_that) {
case _CallLogEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallLogEntry value)?  $default,){
final _that = this;
switch (_that) {
case _CallLogEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String callType,  int? timestamp,  int? durationSeconds,  String? name,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallLogEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.callType,_that.timestamp,_that.durationSeconds,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String callType,  int? timestamp,  int? durationSeconds,  String? name,  String? location)  $default,) {final _that = this;
switch (_that) {
case _CallLogEntry():
return $default(_that.id,_that.phoneNumber,_that.callType,_that.timestamp,_that.durationSeconds,_that.name,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  String callType,  int? timestamp,  int? durationSeconds,  String? name,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _CallLogEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.callType,_that.timestamp,_that.durationSeconds,_that.name,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallLogEntry extends CallLogEntry {
  const _CallLogEntry({required this.id, required this.phoneNumber, required this.callType, this.timestamp, this.durationSeconds, this.name, this.location}): super._();
  factory _CallLogEntry.fromJson(Map<String, dynamic> json) => _$CallLogEntryFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  String callType;
@override final  int? timestamp;
@override final  int? durationSeconds;
@override final  String? name;
@override final  String? location;

/// Create a copy of CallLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallLogEntryCopyWith<_CallLogEntry> get copyWith => __$CallLogEntryCopyWithImpl<_CallLogEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallLogEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallLogEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.name, name) || other.name == name)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,phoneNumber,callType,timestamp,durationSeconds,name,location);
}

@override
String toString() {
    return 'CallLogEntry(id: $id, phoneNumber: $phoneNumber, callType: $callType, timestamp: $timestamp, durationSeconds: $durationSeconds, name: $name, location: $location)';
}


}

/// @nodoc
abstract mixin class _$CallLogEntryCopyWith<$Res> implements $CallLogEntryCopyWith<$Res> {
  factory _$CallLogEntryCopyWith(_CallLogEntry value, $Res Function(_CallLogEntry) _then) = __$CallLogEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, String callType, int? timestamp, int? durationSeconds, String? name, String? location
});




}
/// @nodoc
class __$CallLogEntryCopyWithImpl<$Res>
    implements _$CallLogEntryCopyWith<$Res> {
  __$CallLogEntryCopyWithImpl(this._self, this._then);

  final _CallLogEntry _self;
  final $Res Function(_CallLogEntry) _then;

/// Create a copy of CallLogEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? callType = null,Object? timestamp = freezed,Object? durationSeconds = freezed,Object? name = freezed,Object? location = freezed,}) {
  return _then(_CallLogEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
