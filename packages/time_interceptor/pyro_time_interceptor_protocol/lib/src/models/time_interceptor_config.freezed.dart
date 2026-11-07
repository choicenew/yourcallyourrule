// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_interceptor_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TimeInterceptorConfig {

 int get durationMinutes; bool get shouldIntercept;
/// Create a copy of TimeInterceptorConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeInterceptorConfigCopyWith<TimeInterceptorConfig> get copyWith => _$TimeInterceptorConfigCopyWithImpl<TimeInterceptorConfig>(this as TimeInterceptorConfig, _$identity);

  /// Serializes this TimeInterceptorConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TimeInterceptorConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeInterceptorConfig&&(identical(other.durationMinutes, _this.durationMinutes) || other.durationMinutes == _this.durationMinutes)&&(identical(other.shouldIntercept, _this.shouldIntercept) || other.shouldIntercept == _this.shouldIntercept));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TimeInterceptorConfig;
  return Object.hash(runtimeType,_this.durationMinutes,_this.shouldIntercept);
}

@override
String toString() {
  final _this = this as TimeInterceptorConfig;
  return 'TimeInterceptorConfig(durationMinutes: ${_this.durationMinutes}, shouldIntercept: ${_this.shouldIntercept})';
}


}

/// @nodoc
abstract mixin class $TimeInterceptorConfigCopyWith<$Res>  {
  factory $TimeInterceptorConfigCopyWith(TimeInterceptorConfig value, $Res Function(TimeInterceptorConfig) _then) = _$TimeInterceptorConfigCopyWithImpl;
@useResult
$Res call({
 int durationMinutes, bool shouldIntercept
});




}
/// @nodoc
class _$TimeInterceptorConfigCopyWithImpl<$Res>
    implements $TimeInterceptorConfigCopyWith<$Res> {
  _$TimeInterceptorConfigCopyWithImpl(this._self, this._then);

  final TimeInterceptorConfig _self;
  final $Res Function(TimeInterceptorConfig) _then;

/// Create a copy of TimeInterceptorConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? durationMinutes = null,Object? shouldIntercept = null,}) {
  return _then(TimeInterceptorConfig(
durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,shouldIntercept: null == shouldIntercept ? _self.shouldIntercept : shouldIntercept // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TimeInterceptorConfig].
extension TimeInterceptorConfigPatterns on TimeInterceptorConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimeInterceptorConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimeInterceptorConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimeInterceptorConfig value)  $default,){
final _that = this;
switch (_that) {
case _TimeInterceptorConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimeInterceptorConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TimeInterceptorConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int durationMinutes,  bool shouldIntercept)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimeInterceptorConfig() when $default != null:
return $default(_that.durationMinutes,_that.shouldIntercept);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int durationMinutes,  bool shouldIntercept)  $default,) {final _that = this;
switch (_that) {
case _TimeInterceptorConfig():
return $default(_that.durationMinutes,_that.shouldIntercept);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int durationMinutes,  bool shouldIntercept)?  $default,) {final _that = this;
switch (_that) {
case _TimeInterceptorConfig() when $default != null:
return $default(_that.durationMinutes,_that.shouldIntercept);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimeInterceptorConfig extends TimeInterceptorConfig {
  const _TimeInterceptorConfig({this.durationMinutes = 30, this.shouldIntercept = true}): super._();
  factory _TimeInterceptorConfig.fromJson(Map<String, dynamic> json) => _$TimeInterceptorConfigFromJson(json);

@override@JsonKey() final  int durationMinutes;
@override@JsonKey() final  bool shouldIntercept;

/// Create a copy of TimeInterceptorConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeInterceptorConfigCopyWith<_TimeInterceptorConfig> get copyWith => __$TimeInterceptorConfigCopyWithImpl<_TimeInterceptorConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeInterceptorConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeInterceptorConfig&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.shouldIntercept, shouldIntercept) || other.shouldIntercept == shouldIntercept));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,durationMinutes,shouldIntercept);
}

@override
String toString() {
    return 'TimeInterceptorConfig(durationMinutes: $durationMinutes, shouldIntercept: $shouldIntercept)';
}


}

/// @nodoc
abstract mixin class _$TimeInterceptorConfigCopyWith<$Res> implements $TimeInterceptorConfigCopyWith<$Res> {
  factory _$TimeInterceptorConfigCopyWith(_TimeInterceptorConfig value, $Res Function(_TimeInterceptorConfig) _then) = __$TimeInterceptorConfigCopyWithImpl;
@override @useResult
$Res call({
 int durationMinutes, bool shouldIntercept
});




}
/// @nodoc
class __$TimeInterceptorConfigCopyWithImpl<$Res>
    implements _$TimeInterceptorConfigCopyWith<$Res> {
  __$TimeInterceptorConfigCopyWithImpl(this._self, this._then);

  final _TimeInterceptorConfig _self;
  final $Res Function(_TimeInterceptorConfig) _then;

/// Create a copy of TimeInterceptorConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? durationMinutes = null,Object? shouldIntercept = null,}) {
  return _then(_TimeInterceptorConfig(
durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,shouldIntercept: null == shouldIntercept ? _self.shouldIntercept : shouldIntercept // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
