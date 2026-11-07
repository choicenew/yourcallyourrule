// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_location_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneLocationEntry {

 String get id; String get phoneNumber; String? get region; String? get countryName; String? get carrier; String get numberType;
/// Create a copy of PhoneLocationEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneLocationEntryCopyWith<PhoneLocationEntry> get copyWith => _$PhoneLocationEntryCopyWithImpl<PhoneLocationEntry>(this as PhoneLocationEntry, _$identity);

  /// Serializes this PhoneLocationEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneLocationEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneLocationEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.region, _this.region) || other.region == _this.region)&&(identical(other.countryName, _this.countryName) || other.countryName == _this.countryName)&&(identical(other.carrier, _this.carrier) || other.carrier == _this.carrier)&&(identical(other.numberType, _this.numberType) || other.numberType == _this.numberType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneLocationEntry;
  return Object.hash(runtimeType,_this.id,_this.phoneNumber,_this.region,_this.countryName,_this.carrier,_this.numberType);
}

@override
String toString() {
  final _this = this as PhoneLocationEntry;
  return 'PhoneLocationEntry(id: ${_this.id}, phoneNumber: ${_this.phoneNumber}, region: ${_this.region}, countryName: ${_this.countryName}, carrier: ${_this.carrier}, numberType: ${_this.numberType})';
}


}

/// @nodoc
abstract mixin class $PhoneLocationEntryCopyWith<$Res>  {
  factory $PhoneLocationEntryCopyWith(PhoneLocationEntry value, $Res Function(PhoneLocationEntry) _then) = _$PhoneLocationEntryCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, String? region, String? countryName, String? carrier, String numberType
});




}
/// @nodoc
class _$PhoneLocationEntryCopyWithImpl<$Res>
    implements $PhoneLocationEntryCopyWith<$Res> {
  _$PhoneLocationEntryCopyWithImpl(this._self, this._then);

  final PhoneLocationEntry _self;
  final $Res Function(PhoneLocationEntry) _then;

/// Create a copy of PhoneLocationEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? region = freezed,Object? countryName = freezed,Object? carrier = freezed,Object? numberType = null,}) {
  return _then(PhoneLocationEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,numberType: null == numberType ? _self.numberType : numberType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneLocationEntry].
extension PhoneLocationEntryPatterns on PhoneLocationEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneLocationEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneLocationEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneLocationEntry value)  $default,){
final _that = this;
switch (_that) {
case _PhoneLocationEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneLocationEntry value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneLocationEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String? region,  String? countryName,  String? carrier,  String numberType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneLocationEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.region,_that.countryName,_that.carrier,_that.numberType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String? region,  String? countryName,  String? carrier,  String numberType)  $default,) {final _that = this;
switch (_that) {
case _PhoneLocationEntry():
return $default(_that.id,_that.phoneNumber,_that.region,_that.countryName,_that.carrier,_that.numberType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  String? region,  String? countryName,  String? carrier,  String numberType)?  $default,) {final _that = this;
switch (_that) {
case _PhoneLocationEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.region,_that.countryName,_that.carrier,_that.numberType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneLocationEntry extends PhoneLocationEntry {
  const _PhoneLocationEntry({required this.id, required this.phoneNumber, this.region, this.countryName, this.carrier, this.numberType = 'UNKNOWN'}): super._();
  factory _PhoneLocationEntry.fromJson(Map<String, dynamic> json) => _$PhoneLocationEntryFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  String? region;
@override final  String? countryName;
@override final  String? carrier;
@override@JsonKey() final  String numberType;

/// Create a copy of PhoneLocationEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneLocationEntryCopyWith<_PhoneLocationEntry> get copyWith => __$PhoneLocationEntryCopyWithImpl<_PhoneLocationEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneLocationEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneLocationEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.region, region) || other.region == region)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.carrier, carrier) || other.carrier == carrier)&&(identical(other.numberType, numberType) || other.numberType == numberType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,phoneNumber,region,countryName,carrier,numberType);
}

@override
String toString() {
    return 'PhoneLocationEntry(id: $id, phoneNumber: $phoneNumber, region: $region, countryName: $countryName, carrier: $carrier, numberType: $numberType)';
}


}

/// @nodoc
abstract mixin class _$PhoneLocationEntryCopyWith<$Res> implements $PhoneLocationEntryCopyWith<$Res> {
  factory _$PhoneLocationEntryCopyWith(_PhoneLocationEntry value, $Res Function(_PhoneLocationEntry) _then) = __$PhoneLocationEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, String? region, String? countryName, String? carrier, String numberType
});




}
/// @nodoc
class __$PhoneLocationEntryCopyWithImpl<$Res>
    implements _$PhoneLocationEntryCopyWith<$Res> {
  __$PhoneLocationEntryCopyWithImpl(this._self, this._then);

  final _PhoneLocationEntry _self;
  final $Res Function(_PhoneLocationEntry) _then;

/// Create a copy of PhoneLocationEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? region = freezed,Object? countryName = freezed,Object? carrier = freezed,Object? numberType = null,}) {
  return _then(_PhoneLocationEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,numberType: null == numberType ? _self.numberType : numberType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
