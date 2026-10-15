// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_count_filter_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalCountFilterConfig {

 bool get enableLocalCountFilter; int get countThreshold; bool get rejectExceededNumbers; bool get allowNonExceededNumbers; bool get logAllLocalQueries;
/// Create a copy of LocalCountFilterConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalCountFilterConfigCopyWith<LocalCountFilterConfig> get copyWith => _$LocalCountFilterConfigCopyWithImpl<LocalCountFilterConfig>(this as LocalCountFilterConfig, _$identity);

  /// Serializes this LocalCountFilterConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LocalCountFilterConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalCountFilterConfig&&(identical(other.enableLocalCountFilter, _this.enableLocalCountFilter) || other.enableLocalCountFilter == _this.enableLocalCountFilter)&&(identical(other.countThreshold, _this.countThreshold) || other.countThreshold == _this.countThreshold)&&(identical(other.rejectExceededNumbers, _this.rejectExceededNumbers) || other.rejectExceededNumbers == _this.rejectExceededNumbers)&&(identical(other.allowNonExceededNumbers, _this.allowNonExceededNumbers) || other.allowNonExceededNumbers == _this.allowNonExceededNumbers)&&(identical(other.logAllLocalQueries, _this.logAllLocalQueries) || other.logAllLocalQueries == _this.logAllLocalQueries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LocalCountFilterConfig;
  return Object.hash(runtimeType,_this.enableLocalCountFilter,_this.countThreshold,_this.rejectExceededNumbers,_this.allowNonExceededNumbers,_this.logAllLocalQueries);
}

@override
String toString() {
  final _this = this as LocalCountFilterConfig;
  return 'LocalCountFilterConfig(enableLocalCountFilter: ${_this.enableLocalCountFilter}, countThreshold: ${_this.countThreshold}, rejectExceededNumbers: ${_this.rejectExceededNumbers}, allowNonExceededNumbers: ${_this.allowNonExceededNumbers}, logAllLocalQueries: ${_this.logAllLocalQueries})';
}


}

/// @nodoc
abstract mixin class $LocalCountFilterConfigCopyWith<$Res>  {
  factory $LocalCountFilterConfigCopyWith(LocalCountFilterConfig value, $Res Function(LocalCountFilterConfig) _then) = _$LocalCountFilterConfigCopyWithImpl;
@useResult
$Res call({
 bool enableLocalCountFilter, int countThreshold, bool rejectExceededNumbers, bool allowNonExceededNumbers, bool logAllLocalQueries
});




}
/// @nodoc
class _$LocalCountFilterConfigCopyWithImpl<$Res>
    implements $LocalCountFilterConfigCopyWith<$Res> {
  _$LocalCountFilterConfigCopyWithImpl(this._self, this._then);

  final LocalCountFilterConfig _self;
  final $Res Function(LocalCountFilterConfig) _then;

/// Create a copy of LocalCountFilterConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enableLocalCountFilter = null,Object? countThreshold = null,Object? rejectExceededNumbers = null,Object? allowNonExceededNumbers = null,Object? logAllLocalQueries = null,}) {
  return _then(LocalCountFilterConfig(
enableLocalCountFilter: null == enableLocalCountFilter ? _self.enableLocalCountFilter : enableLocalCountFilter // ignore: cast_nullable_to_non_nullable
as bool,countThreshold: null == countThreshold ? _self.countThreshold : countThreshold // ignore: cast_nullable_to_non_nullable
as int,rejectExceededNumbers: null == rejectExceededNumbers ? _self.rejectExceededNumbers : rejectExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,allowNonExceededNumbers: null == allowNonExceededNumbers ? _self.allowNonExceededNumbers : allowNonExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,logAllLocalQueries: null == logAllLocalQueries ? _self.logAllLocalQueries : logAllLocalQueries // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalCountFilterConfig].
extension LocalCountFilterConfigPatterns on LocalCountFilterConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalCountFilterConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalCountFilterConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalCountFilterConfig value)  $default,){
final _that = this;
switch (_that) {
case _LocalCountFilterConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalCountFilterConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LocalCountFilterConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enableLocalCountFilter,  int countThreshold,  bool rejectExceededNumbers,  bool allowNonExceededNumbers,  bool logAllLocalQueries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalCountFilterConfig() when $default != null:
return $default(_that.enableLocalCountFilter,_that.countThreshold,_that.rejectExceededNumbers,_that.allowNonExceededNumbers,_that.logAllLocalQueries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enableLocalCountFilter,  int countThreshold,  bool rejectExceededNumbers,  bool allowNonExceededNumbers,  bool logAllLocalQueries)  $default,) {final _that = this;
switch (_that) {
case _LocalCountFilterConfig():
return $default(_that.enableLocalCountFilter,_that.countThreshold,_that.rejectExceededNumbers,_that.allowNonExceededNumbers,_that.logAllLocalQueries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enableLocalCountFilter,  int countThreshold,  bool rejectExceededNumbers,  bool allowNonExceededNumbers,  bool logAllLocalQueries)?  $default,) {final _that = this;
switch (_that) {
case _LocalCountFilterConfig() when $default != null:
return $default(_that.enableLocalCountFilter,_that.countThreshold,_that.rejectExceededNumbers,_that.allowNonExceededNumbers,_that.logAllLocalQueries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalCountFilterConfig extends LocalCountFilterConfig {
  const _LocalCountFilterConfig({this.enableLocalCountFilter = true, this.countThreshold = 5, this.rejectExceededNumbers = true, this.allowNonExceededNumbers = false, this.logAllLocalQueries = true}): super._();
  factory _LocalCountFilterConfig.fromJson(Map<String, dynamic> json) => _$LocalCountFilterConfigFromJson(json);

@override@JsonKey() final  bool enableLocalCountFilter;
@override@JsonKey() final  int countThreshold;
@override@JsonKey() final  bool rejectExceededNumbers;
@override@JsonKey() final  bool allowNonExceededNumbers;
@override@JsonKey() final  bool logAllLocalQueries;

/// Create a copy of LocalCountFilterConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalCountFilterConfigCopyWith<_LocalCountFilterConfig> get copyWith => __$LocalCountFilterConfigCopyWithImpl<_LocalCountFilterConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalCountFilterConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalCountFilterConfig&&(identical(other.enableLocalCountFilter, enableLocalCountFilter) || other.enableLocalCountFilter == enableLocalCountFilter)&&(identical(other.countThreshold, countThreshold) || other.countThreshold == countThreshold)&&(identical(other.rejectExceededNumbers, rejectExceededNumbers) || other.rejectExceededNumbers == rejectExceededNumbers)&&(identical(other.allowNonExceededNumbers, allowNonExceededNumbers) || other.allowNonExceededNumbers == allowNonExceededNumbers)&&(identical(other.logAllLocalQueries, logAllLocalQueries) || other.logAllLocalQueries == logAllLocalQueries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enableLocalCountFilter,countThreshold,rejectExceededNumbers,allowNonExceededNumbers,logAllLocalQueries);
}

@override
String toString() {
    return 'LocalCountFilterConfig(enableLocalCountFilter: $enableLocalCountFilter, countThreshold: $countThreshold, rejectExceededNumbers: $rejectExceededNumbers, allowNonExceededNumbers: $allowNonExceededNumbers, logAllLocalQueries: $logAllLocalQueries)';
}


}

/// @nodoc
abstract mixin class _$LocalCountFilterConfigCopyWith<$Res> implements $LocalCountFilterConfigCopyWith<$Res> {
  factory _$LocalCountFilterConfigCopyWith(_LocalCountFilterConfig value, $Res Function(_LocalCountFilterConfig) _then) = __$LocalCountFilterConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enableLocalCountFilter, int countThreshold, bool rejectExceededNumbers, bool allowNonExceededNumbers, bool logAllLocalQueries
});




}
/// @nodoc
class __$LocalCountFilterConfigCopyWithImpl<$Res>
    implements _$LocalCountFilterConfigCopyWith<$Res> {
  __$LocalCountFilterConfigCopyWithImpl(this._self, this._then);

  final _LocalCountFilterConfig _self;
  final $Res Function(_LocalCountFilterConfig) _then;

/// Create a copy of LocalCountFilterConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enableLocalCountFilter = null,Object? countThreshold = null,Object? rejectExceededNumbers = null,Object? allowNonExceededNumbers = null,Object? logAllLocalQueries = null,}) {
  return _then(_LocalCountFilterConfig(
enableLocalCountFilter: null == enableLocalCountFilter ? _self.enableLocalCountFilter : enableLocalCountFilter // ignore: cast_nullable_to_non_nullable
as bool,countThreshold: null == countThreshold ? _self.countThreshold : countThreshold // ignore: cast_nullable_to_non_nullable
as int,rejectExceededNumbers: null == rejectExceededNumbers ? _self.rejectExceededNumbers : rejectExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,allowNonExceededNumbers: null == allowNonExceededNumbers ? _self.allowNonExceededNumbers : allowNonExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,logAllLocalQueries: null == logAllLocalQueries ? _self.logAllLocalQueries : logAllLocalQueries // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
