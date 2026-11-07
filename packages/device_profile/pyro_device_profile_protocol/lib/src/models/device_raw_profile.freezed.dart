// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_raw_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceRawProfile {

 String? get deviceId; String? get hashedDeviceId; String? get simState; String? get ipAddress; String? get countryCode; String? get city;
/// Create a copy of DeviceRawProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceRawProfileCopyWith<DeviceRawProfile> get copyWith => _$DeviceRawProfileCopyWithImpl<DeviceRawProfile>(this as DeviceRawProfile, _$identity);

  /// Serializes this DeviceRawProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DeviceRawProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceRawProfile&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.hashedDeviceId, _this.hashedDeviceId) || other.hashedDeviceId == _this.hashedDeviceId)&&(identical(other.simState, _this.simState) || other.simState == _this.simState)&&(identical(other.ipAddress, _this.ipAddress) || other.ipAddress == _this.ipAddress)&&(identical(other.countryCode, _this.countryCode) || other.countryCode == _this.countryCode)&&(identical(other.city, _this.city) || other.city == _this.city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DeviceRawProfile;
  return Object.hash(runtimeType,_this.deviceId,_this.hashedDeviceId,_this.simState,_this.ipAddress,_this.countryCode,_this.city);
}

@override
String toString() {
  final _this = this as DeviceRawProfile;
  return 'DeviceRawProfile(deviceId: ${_this.deviceId}, hashedDeviceId: ${_this.hashedDeviceId}, simState: ${_this.simState}, ipAddress: ${_this.ipAddress}, countryCode: ${_this.countryCode}, city: ${_this.city})';
}


}

/// @nodoc
abstract mixin class $DeviceRawProfileCopyWith<$Res>  {
  factory $DeviceRawProfileCopyWith(DeviceRawProfile value, $Res Function(DeviceRawProfile) _then) = _$DeviceRawProfileCopyWithImpl;
@useResult
$Res call({
 String? deviceId, String? hashedDeviceId, String? simState, String? ipAddress, String? countryCode, String? city
});




}
/// @nodoc
class _$DeviceRawProfileCopyWithImpl<$Res>
    implements $DeviceRawProfileCopyWith<$Res> {
  _$DeviceRawProfileCopyWithImpl(this._self, this._then);

  final DeviceRawProfile _self;
  final $Res Function(DeviceRawProfile) _then;

/// Create a copy of DeviceRawProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = freezed,Object? hashedDeviceId = freezed,Object? simState = freezed,Object? ipAddress = freezed,Object? countryCode = freezed,Object? city = freezed,}) {
  return _then(DeviceRawProfile(
deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,hashedDeviceId: freezed == hashedDeviceId ? _self.hashedDeviceId : hashedDeviceId // ignore: cast_nullable_to_non_nullable
as String?,simState: freezed == simState ? _self.simState : simState // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceRawProfile].
extension DeviceRawProfilePatterns on DeviceRawProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceRawProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceRawProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceRawProfile value)  $default,){
final _that = this;
switch (_that) {
case _DeviceRawProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceRawProfile value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceRawProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? deviceId,  String? hashedDeviceId,  String? simState,  String? ipAddress,  String? countryCode,  String? city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceRawProfile() when $default != null:
return $default(_that.deviceId,_that.hashedDeviceId,_that.simState,_that.ipAddress,_that.countryCode,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? deviceId,  String? hashedDeviceId,  String? simState,  String? ipAddress,  String? countryCode,  String? city)  $default,) {final _that = this;
switch (_that) {
case _DeviceRawProfile():
return $default(_that.deviceId,_that.hashedDeviceId,_that.simState,_that.ipAddress,_that.countryCode,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? deviceId,  String? hashedDeviceId,  String? simState,  String? ipAddress,  String? countryCode,  String? city)?  $default,) {final _that = this;
switch (_that) {
case _DeviceRawProfile() when $default != null:
return $default(_that.deviceId,_that.hashedDeviceId,_that.simState,_that.ipAddress,_that.countryCode,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceRawProfile extends DeviceRawProfile {
  const _DeviceRawProfile({this.deviceId, this.hashedDeviceId, this.simState, this.ipAddress, this.countryCode, this.city}): super._();
  factory _DeviceRawProfile.fromJson(Map<String, dynamic> json) => _$DeviceRawProfileFromJson(json);

@override final  String? deviceId;
@override final  String? hashedDeviceId;
@override final  String? simState;
@override final  String? ipAddress;
@override final  String? countryCode;
@override final  String? city;

/// Create a copy of DeviceRawProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceRawProfileCopyWith<_DeviceRawProfile> get copyWith => __$DeviceRawProfileCopyWithImpl<_DeviceRawProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceRawProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceRawProfile&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.hashedDeviceId, hashedDeviceId) || other.hashedDeviceId == hashedDeviceId)&&(identical(other.simState, simState) || other.simState == simState)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,deviceId,hashedDeviceId,simState,ipAddress,countryCode,city);
}

@override
String toString() {
    return 'DeviceRawProfile(deviceId: $deviceId, hashedDeviceId: $hashedDeviceId, simState: $simState, ipAddress: $ipAddress, countryCode: $countryCode, city: $city)';
}


}

/// @nodoc
abstract mixin class _$DeviceRawProfileCopyWith<$Res> implements $DeviceRawProfileCopyWith<$Res> {
  factory _$DeviceRawProfileCopyWith(_DeviceRawProfile value, $Res Function(_DeviceRawProfile) _then) = __$DeviceRawProfileCopyWithImpl;
@override @useResult
$Res call({
 String? deviceId, String? hashedDeviceId, String? simState, String? ipAddress, String? countryCode, String? city
});




}
/// @nodoc
class __$DeviceRawProfileCopyWithImpl<$Res>
    implements _$DeviceRawProfileCopyWith<$Res> {
  __$DeviceRawProfileCopyWithImpl(this._self, this._then);

  final _DeviceRawProfile _self;
  final $Res Function(_DeviceRawProfile) _then;

/// Create a copy of DeviceRawProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = freezed,Object? hashedDeviceId = freezed,Object? simState = freezed,Object? ipAddress = freezed,Object? countryCode = freezed,Object? city = freezed,}) {
  return _then(_DeviceRawProfile(
deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,hashedDeviceId: freezed == hashedDeviceId ? _self.hashedDeviceId : hashedDeviceId // ignore: cast_nullable_to_non_nullable
as String?,simState: freezed == simState ? _self.simState : simState // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
