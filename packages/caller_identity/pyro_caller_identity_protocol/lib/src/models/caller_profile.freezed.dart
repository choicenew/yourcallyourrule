// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'caller_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallerProfile {

 String get phoneNumber; String? get name; String? get region; String? get countryName; String? get carrier; List<String> get labels; int get localCount; int get pluginCount; int get remoteCount;
/// Create a copy of CallerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallerProfileCopyWith<CallerProfile> get copyWith => _$CallerProfileCopyWithImpl<CallerProfile>(this as CallerProfile, _$identity);

  /// Serializes this CallerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CallerProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallerProfile&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.region, _this.region) || other.region == _this.region)&&(identical(other.countryName, _this.countryName) || other.countryName == _this.countryName)&&(identical(other.carrier, _this.carrier) || other.carrier == _this.carrier)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.localCount, _this.localCount) || other.localCount == _this.localCount)&&(identical(other.pluginCount, _this.pluginCount) || other.pluginCount == _this.pluginCount)&&(identical(other.remoteCount, _this.remoteCount) || other.remoteCount == _this.remoteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CallerProfile;
  return Object.hash(runtimeType,_this.phoneNumber,_this.name,_this.region,_this.countryName,_this.carrier,const DeepCollectionEquality().hash(_this.labels),_this.localCount,_this.pluginCount,_this.remoteCount);
}

@override
String toString() {
  final _this = this as CallerProfile;
  return 'CallerProfile(phoneNumber: ${_this.phoneNumber}, name: ${_this.name}, region: ${_this.region}, countryName: ${_this.countryName}, carrier: ${_this.carrier}, labels: ${_this.labels}, localCount: ${_this.localCount}, pluginCount: ${_this.pluginCount}, remoteCount: ${_this.remoteCount})';
}


}

/// @nodoc
abstract mixin class $CallerProfileCopyWith<$Res>  {
  factory $CallerProfileCopyWith(CallerProfile value, $Res Function(CallerProfile) _then) = _$CallerProfileCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String? name, String? region, String? countryName, String? carrier, List<String> labels, int localCount, int pluginCount, int remoteCount
});




}
/// @nodoc
class _$CallerProfileCopyWithImpl<$Res>
    implements $CallerProfileCopyWith<$Res> {
  _$CallerProfileCopyWithImpl(this._self, this._then);

  final CallerProfile _self;
  final $Res Function(CallerProfile) _then;

/// Create a copy of CallerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? name = freezed,Object? region = freezed,Object? countryName = freezed,Object? carrier = freezed,Object? labels = null,Object? localCount = null,Object? pluginCount = null,Object? remoteCount = null,}) {
  return _then(CallerProfile(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,localCount: null == localCount ? _self.localCount : localCount // ignore: cast_nullable_to_non_nullable
as int,pluginCount: null == pluginCount ? _self.pluginCount : pluginCount // ignore: cast_nullable_to_non_nullable
as int,remoteCount: null == remoteCount ? _self.remoteCount : remoteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CallerProfile].
extension CallerProfilePatterns on CallerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallerProfile value)  $default,){
final _that = this;
switch (_that) {
case _CallerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CallerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String? name,  String? region,  String? countryName,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallerProfile() when $default != null:
return $default(_that.phoneNumber,_that.name,_that.region,_that.countryName,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String? name,  String? region,  String? countryName,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount)  $default,) {final _that = this;
switch (_that) {
case _CallerProfile():
return $default(_that.phoneNumber,_that.name,_that.region,_that.countryName,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String? name,  String? region,  String? countryName,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount)?  $default,) {final _that = this;
switch (_that) {
case _CallerProfile() when $default != null:
return $default(_that.phoneNumber,_that.name,_that.region,_that.countryName,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallerProfile extends CallerProfile {
  const _CallerProfile({required this.phoneNumber, this.name, this.region, this.countryName, this.carrier,  List<String> labels = const [], this.localCount = 0, this.pluginCount = 0, this.remoteCount = 0}): _labels = labels,super._();
  factory _CallerProfile.fromJson(Map<String, dynamic> json) => _$CallerProfileFromJson(json);

@override final  String phoneNumber;
@override final  String? name;
@override final  String? region;
@override final  String? countryName;
@override final  String? carrier;
 final  List<String> _labels;
@override@JsonKey() List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override@JsonKey() final  int localCount;
@override@JsonKey() final  int pluginCount;
@override@JsonKey() final  int remoteCount;

/// Create a copy of CallerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallerProfileCopyWith<_CallerProfile> get copyWith => __$CallerProfileCopyWithImpl<_CallerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallerProfile&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.carrier, carrier) || other.carrier == carrier)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.localCount, localCount) || other.localCount == localCount)&&(identical(other.pluginCount, pluginCount) || other.pluginCount == pluginCount)&&(identical(other.remoteCount, remoteCount) || other.remoteCount == remoteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,name,region,countryName,carrier,const DeepCollectionEquality().hash(_labels),localCount,pluginCount,remoteCount);
}

@override
String toString() {
    return 'CallerProfile(phoneNumber: $phoneNumber, name: $name, region: $region, countryName: $countryName, carrier: $carrier, labels: $labels, localCount: $localCount, pluginCount: $pluginCount, remoteCount: $remoteCount)';
}


}

/// @nodoc
abstract mixin class _$CallerProfileCopyWith<$Res> implements $CallerProfileCopyWith<$Res> {
  factory _$CallerProfileCopyWith(_CallerProfile value, $Res Function(_CallerProfile) _then) = __$CallerProfileCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String? name, String? region, String? countryName, String? carrier, List<String> labels, int localCount, int pluginCount, int remoteCount
});




}
/// @nodoc
class __$CallerProfileCopyWithImpl<$Res>
    implements _$CallerProfileCopyWith<$Res> {
  __$CallerProfileCopyWithImpl(this._self, this._then);

  final _CallerProfile _self;
  final $Res Function(_CallerProfile) _then;

/// Create a copy of CallerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? name = freezed,Object? region = freezed,Object? countryName = freezed,Object? carrier = freezed,Object? labels = null,Object? localCount = null,Object? pluginCount = null,Object? remoteCount = null,}) {
  return _then(_CallerProfile(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,localCount: null == localCount ? _self.localCount : localCount // ignore: cast_nullable_to_non_nullable
as int,pluginCount: null == pluginCount ? _self.pluginCount : pluginCount // ignore: cast_nullable_to_non_nullable
as int,remoteCount: null == remoteCount ? _self.remoteCount : remoteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
