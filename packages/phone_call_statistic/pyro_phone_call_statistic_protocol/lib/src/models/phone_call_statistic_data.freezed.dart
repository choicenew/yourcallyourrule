// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_call_statistic_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneCallStatisticData {

 int get totalCalls; int get blockedCalls; int get allowedCalls; int get silencedCalls;
/// Create a copy of PhoneCallStatisticData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneCallStatisticDataCopyWith<PhoneCallStatisticData> get copyWith => _$PhoneCallStatisticDataCopyWithImpl<PhoneCallStatisticData>(this as PhoneCallStatisticData, _$identity);

  /// Serializes this PhoneCallStatisticData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneCallStatisticData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneCallStatisticData&&(identical(other.totalCalls, _this.totalCalls) || other.totalCalls == _this.totalCalls)&&(identical(other.blockedCalls, _this.blockedCalls) || other.blockedCalls == _this.blockedCalls)&&(identical(other.allowedCalls, _this.allowedCalls) || other.allowedCalls == _this.allowedCalls)&&(identical(other.silencedCalls, _this.silencedCalls) || other.silencedCalls == _this.silencedCalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneCallStatisticData;
  return Object.hash(runtimeType,_this.totalCalls,_this.blockedCalls,_this.allowedCalls,_this.silencedCalls);
}

@override
String toString() {
  final _this = this as PhoneCallStatisticData;
  return 'PhoneCallStatisticData(totalCalls: ${_this.totalCalls}, blockedCalls: ${_this.blockedCalls}, allowedCalls: ${_this.allowedCalls}, silencedCalls: ${_this.silencedCalls})';
}


}

/// @nodoc
abstract mixin class $PhoneCallStatisticDataCopyWith<$Res>  {
  factory $PhoneCallStatisticDataCopyWith(PhoneCallStatisticData value, $Res Function(PhoneCallStatisticData) _then) = _$PhoneCallStatisticDataCopyWithImpl;
@useResult
$Res call({
 int totalCalls, int blockedCalls, int allowedCalls, int silencedCalls
});




}
/// @nodoc
class _$PhoneCallStatisticDataCopyWithImpl<$Res>
    implements $PhoneCallStatisticDataCopyWith<$Res> {
  _$PhoneCallStatisticDataCopyWithImpl(this._self, this._then);

  final PhoneCallStatisticData _self;
  final $Res Function(PhoneCallStatisticData) _then;

/// Create a copy of PhoneCallStatisticData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCalls = null,Object? blockedCalls = null,Object? allowedCalls = null,Object? silencedCalls = null,}) {
  return _then(PhoneCallStatisticData(
totalCalls: null == totalCalls ? _self.totalCalls : totalCalls // ignore: cast_nullable_to_non_nullable
as int,blockedCalls: null == blockedCalls ? _self.blockedCalls : blockedCalls // ignore: cast_nullable_to_non_nullable
as int,allowedCalls: null == allowedCalls ? _self.allowedCalls : allowedCalls // ignore: cast_nullable_to_non_nullable
as int,silencedCalls: null == silencedCalls ? _self.silencedCalls : silencedCalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneCallStatisticData].
extension PhoneCallStatisticDataPatterns on PhoneCallStatisticData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneCallStatisticData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneCallStatisticData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneCallStatisticData value)  $default,){
final _that = this;
switch (_that) {
case _PhoneCallStatisticData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneCallStatisticData value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneCallStatisticData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalCalls,  int blockedCalls,  int allowedCalls,  int silencedCalls)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneCallStatisticData() when $default != null:
return $default(_that.totalCalls,_that.blockedCalls,_that.allowedCalls,_that.silencedCalls);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalCalls,  int blockedCalls,  int allowedCalls,  int silencedCalls)  $default,) {final _that = this;
switch (_that) {
case _PhoneCallStatisticData():
return $default(_that.totalCalls,_that.blockedCalls,_that.allowedCalls,_that.silencedCalls);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalCalls,  int blockedCalls,  int allowedCalls,  int silencedCalls)?  $default,) {final _that = this;
switch (_that) {
case _PhoneCallStatisticData() when $default != null:
return $default(_that.totalCalls,_that.blockedCalls,_that.allowedCalls,_that.silencedCalls);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneCallStatisticData extends PhoneCallStatisticData {
  const _PhoneCallStatisticData({this.totalCalls = 0, this.blockedCalls = 0, this.allowedCalls = 0, this.silencedCalls = 0}): super._();
  factory _PhoneCallStatisticData.fromJson(Map<String, dynamic> json) => _$PhoneCallStatisticDataFromJson(json);

@override@JsonKey() final  int totalCalls;
@override@JsonKey() final  int blockedCalls;
@override@JsonKey() final  int allowedCalls;
@override@JsonKey() final  int silencedCalls;

/// Create a copy of PhoneCallStatisticData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneCallStatisticDataCopyWith<_PhoneCallStatisticData> get copyWith => __$PhoneCallStatisticDataCopyWithImpl<_PhoneCallStatisticData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneCallStatisticDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneCallStatisticData&&(identical(other.totalCalls, totalCalls) || other.totalCalls == totalCalls)&&(identical(other.blockedCalls, blockedCalls) || other.blockedCalls == blockedCalls)&&(identical(other.allowedCalls, allowedCalls) || other.allowedCalls == allowedCalls)&&(identical(other.silencedCalls, silencedCalls) || other.silencedCalls == silencedCalls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,totalCalls,blockedCalls,allowedCalls,silencedCalls);
}

@override
String toString() {
    return 'PhoneCallStatisticData(totalCalls: $totalCalls, blockedCalls: $blockedCalls, allowedCalls: $allowedCalls, silencedCalls: $silencedCalls)';
}


}

/// @nodoc
abstract mixin class _$PhoneCallStatisticDataCopyWith<$Res> implements $PhoneCallStatisticDataCopyWith<$Res> {
  factory _$PhoneCallStatisticDataCopyWith(_PhoneCallStatisticData value, $Res Function(_PhoneCallStatisticData) _then) = __$PhoneCallStatisticDataCopyWithImpl;
@override @useResult
$Res call({
 int totalCalls, int blockedCalls, int allowedCalls, int silencedCalls
});




}
/// @nodoc
class __$PhoneCallStatisticDataCopyWithImpl<$Res>
    implements _$PhoneCallStatisticDataCopyWith<$Res> {
  __$PhoneCallStatisticDataCopyWithImpl(this._self, this._then);

  final _PhoneCallStatisticData _self;
  final $Res Function(_PhoneCallStatisticData) _then;

/// Create a copy of PhoneCallStatisticData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCalls = null,Object? blockedCalls = null,Object? allowedCalls = null,Object? silencedCalls = null,}) {
  return _then(_PhoneCallStatisticData(
totalCalls: null == totalCalls ? _self.totalCalls : totalCalls // ignore: cast_nullable_to_non_nullable
as int,blockedCalls: null == blockedCalls ? _self.blockedCalls : blockedCalls // ignore: cast_nullable_to_non_nullable
as int,allowedCalls: null == allowedCalls ? _self.allowedCalls : allowedCalls // ignore: cast_nullable_to_non_nullable
as int,silencedCalls: null == silencedCalls ? _self.silencedCalls : silencedCalls // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
