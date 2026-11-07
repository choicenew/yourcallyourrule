// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_sync_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CountrySyncPayload {

 String get countryIsoCode; int get totalRecords; String get status; int? get timestamp;
/// Create a copy of CountrySyncPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CountrySyncPayloadCopyWith<CountrySyncPayload> get copyWith => _$CountrySyncPayloadCopyWithImpl<CountrySyncPayload>(this as CountrySyncPayload, _$identity);

  /// Serializes this CountrySyncPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CountrySyncPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CountrySyncPayload&&(identical(other.countryIsoCode, _this.countryIsoCode) || other.countryIsoCode == _this.countryIsoCode)&&(identical(other.totalRecords, _this.totalRecords) || other.totalRecords == _this.totalRecords)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CountrySyncPayload;
  return Object.hash(runtimeType,_this.countryIsoCode,_this.totalRecords,_this.status,_this.timestamp);
}

@override
String toString() {
  final _this = this as CountrySyncPayload;
  return 'CountrySyncPayload(countryIsoCode: ${_this.countryIsoCode}, totalRecords: ${_this.totalRecords}, status: ${_this.status}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $CountrySyncPayloadCopyWith<$Res>  {
  factory $CountrySyncPayloadCopyWith(CountrySyncPayload value, $Res Function(CountrySyncPayload) _then) = _$CountrySyncPayloadCopyWithImpl;
@useResult
$Res call({
 String countryIsoCode, int totalRecords, String status, int? timestamp
});




}
/// @nodoc
class _$CountrySyncPayloadCopyWithImpl<$Res>
    implements $CountrySyncPayloadCopyWith<$Res> {
  _$CountrySyncPayloadCopyWithImpl(this._self, this._then);

  final CountrySyncPayload _self;
  final $Res Function(CountrySyncPayload) _then;

/// Create a copy of CountrySyncPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? countryIsoCode = null,Object? totalRecords = null,Object? status = null,Object? timestamp = freezed,}) {
  return _then(CountrySyncPayload(
countryIsoCode: null == countryIsoCode ? _self.countryIsoCode : countryIsoCode // ignore: cast_nullable_to_non_nullable
as String,totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CountrySyncPayload].
extension CountrySyncPayloadPatterns on CountrySyncPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CountrySyncPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CountrySyncPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CountrySyncPayload value)  $default,){
final _that = this;
switch (_that) {
case _CountrySyncPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CountrySyncPayload value)?  $default,){
final _that = this;
switch (_that) {
case _CountrySyncPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String countryIsoCode,  int totalRecords,  String status,  int? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CountrySyncPayload() when $default != null:
return $default(_that.countryIsoCode,_that.totalRecords,_that.status,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String countryIsoCode,  int totalRecords,  String status,  int? timestamp)  $default,) {final _that = this;
switch (_that) {
case _CountrySyncPayload():
return $default(_that.countryIsoCode,_that.totalRecords,_that.status,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String countryIsoCode,  int totalRecords,  String status,  int? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _CountrySyncPayload() when $default != null:
return $default(_that.countryIsoCode,_that.totalRecords,_that.status,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CountrySyncPayload extends CountrySyncPayload {
  const _CountrySyncPayload({required this.countryIsoCode, this.totalRecords = 0, this.status = 'completed', this.timestamp}): super._();
  factory _CountrySyncPayload.fromJson(Map<String, dynamic> json) => _$CountrySyncPayloadFromJson(json);

@override final  String countryIsoCode;
@override@JsonKey() final  int totalRecords;
@override@JsonKey() final  String status;
@override final  int? timestamp;

/// Create a copy of CountrySyncPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountrySyncPayloadCopyWith<_CountrySyncPayload> get copyWith => __$CountrySyncPayloadCopyWithImpl<_CountrySyncPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CountrySyncPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountrySyncPayload&&(identical(other.countryIsoCode, countryIsoCode) || other.countryIsoCode == countryIsoCode)&&(identical(other.totalRecords, totalRecords) || other.totalRecords == totalRecords)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,countryIsoCode,totalRecords,status,timestamp);
}

@override
String toString() {
    return 'CountrySyncPayload(countryIsoCode: $countryIsoCode, totalRecords: $totalRecords, status: $status, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$CountrySyncPayloadCopyWith<$Res> implements $CountrySyncPayloadCopyWith<$Res> {
  factory _$CountrySyncPayloadCopyWith(_CountrySyncPayload value, $Res Function(_CountrySyncPayload) _then) = __$CountrySyncPayloadCopyWithImpl;
@override @useResult
$Res call({
 String countryIsoCode, int totalRecords, String status, int? timestamp
});




}
/// @nodoc
class __$CountrySyncPayloadCopyWithImpl<$Res>
    implements _$CountrySyncPayloadCopyWith<$Res> {
  __$CountrySyncPayloadCopyWithImpl(this._self, this._then);

  final _CountrySyncPayload _self;
  final $Res Function(_CountrySyncPayload) _then;

/// Create a copy of CountrySyncPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? countryIsoCode = null,Object? totalRecords = null,Object? status = null,Object? timestamp = freezed,}) {
  return _then(_CountrySyncPayload(
countryIsoCode: null == countryIsoCode ? _self.countryIsoCode : countryIsoCode // ignore: cast_nullable_to_non_nullable
as String,totalRecords: null == totalRecords ? _self.totalRecords : totalRecords // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
