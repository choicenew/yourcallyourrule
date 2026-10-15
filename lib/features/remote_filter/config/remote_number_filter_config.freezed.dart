// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_number_filter_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteNumberFilterConfig {

 bool get enableRemoteNumberFilter; int get countThreshold; bool get rejectExceededNumbers; bool get allowNonExceededNumbers; bool get prioritizeRemoteAction; bool get logAllRemoteQueries;
/// Create a copy of RemoteNumberFilterConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteNumberFilterConfigCopyWith<RemoteNumberFilterConfig> get copyWith => _$RemoteNumberFilterConfigCopyWithImpl<RemoteNumberFilterConfig>(this as RemoteNumberFilterConfig, _$identity);

  /// Serializes this RemoteNumberFilterConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RemoteNumberFilterConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteNumberFilterConfig&&(identical(other.enableRemoteNumberFilter, _this.enableRemoteNumberFilter) || other.enableRemoteNumberFilter == _this.enableRemoteNumberFilter)&&(identical(other.countThreshold, _this.countThreshold) || other.countThreshold == _this.countThreshold)&&(identical(other.rejectExceededNumbers, _this.rejectExceededNumbers) || other.rejectExceededNumbers == _this.rejectExceededNumbers)&&(identical(other.allowNonExceededNumbers, _this.allowNonExceededNumbers) || other.allowNonExceededNumbers == _this.allowNonExceededNumbers)&&(identical(other.prioritizeRemoteAction, _this.prioritizeRemoteAction) || other.prioritizeRemoteAction == _this.prioritizeRemoteAction)&&(identical(other.logAllRemoteQueries, _this.logAllRemoteQueries) || other.logAllRemoteQueries == _this.logAllRemoteQueries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RemoteNumberFilterConfig;
  return Object.hash(runtimeType,_this.enableRemoteNumberFilter,_this.countThreshold,_this.rejectExceededNumbers,_this.allowNonExceededNumbers,_this.prioritizeRemoteAction,_this.logAllRemoteQueries);
}

@override
String toString() {
  final _this = this as RemoteNumberFilterConfig;
  return 'RemoteNumberFilterConfig(enableRemoteNumberFilter: ${_this.enableRemoteNumberFilter}, countThreshold: ${_this.countThreshold}, rejectExceededNumbers: ${_this.rejectExceededNumbers}, allowNonExceededNumbers: ${_this.allowNonExceededNumbers}, prioritizeRemoteAction: ${_this.prioritizeRemoteAction}, logAllRemoteQueries: ${_this.logAllRemoteQueries})';
}


}

/// @nodoc
abstract mixin class $RemoteNumberFilterConfigCopyWith<$Res>  {
  factory $RemoteNumberFilterConfigCopyWith(RemoteNumberFilterConfig value, $Res Function(RemoteNumberFilterConfig) _then) = _$RemoteNumberFilterConfigCopyWithImpl;
@useResult
$Res call({
 bool enableRemoteNumberFilter, int countThreshold, bool rejectExceededNumbers, bool allowNonExceededNumbers, bool prioritizeRemoteAction, bool logAllRemoteQueries
});




}
/// @nodoc
class _$RemoteNumberFilterConfigCopyWithImpl<$Res>
    implements $RemoteNumberFilterConfigCopyWith<$Res> {
  _$RemoteNumberFilterConfigCopyWithImpl(this._self, this._then);

  final RemoteNumberFilterConfig _self;
  final $Res Function(RemoteNumberFilterConfig) _then;

/// Create a copy of RemoteNumberFilterConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enableRemoteNumberFilter = null,Object? countThreshold = null,Object? rejectExceededNumbers = null,Object? allowNonExceededNumbers = null,Object? prioritizeRemoteAction = null,Object? logAllRemoteQueries = null,}) {
  return _then(RemoteNumberFilterConfig(
enableRemoteNumberFilter: null == enableRemoteNumberFilter ? _self.enableRemoteNumberFilter : enableRemoteNumberFilter // ignore: cast_nullable_to_non_nullable
as bool,countThreshold: null == countThreshold ? _self.countThreshold : countThreshold // ignore: cast_nullable_to_non_nullable
as int,rejectExceededNumbers: null == rejectExceededNumbers ? _self.rejectExceededNumbers : rejectExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,allowNonExceededNumbers: null == allowNonExceededNumbers ? _self.allowNonExceededNumbers : allowNonExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,prioritizeRemoteAction: null == prioritizeRemoteAction ? _self.prioritizeRemoteAction : prioritizeRemoteAction // ignore: cast_nullable_to_non_nullable
as bool,logAllRemoteQueries: null == logAllRemoteQueries ? _self.logAllRemoteQueries : logAllRemoteQueries // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoteNumberFilterConfig].
extension RemoteNumberFilterConfigPatterns on RemoteNumberFilterConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoteNumberFilterConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoteNumberFilterConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoteNumberFilterConfig value)  $default,){
final _that = this;
switch (_that) {
case _RemoteNumberFilterConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoteNumberFilterConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RemoteNumberFilterConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enableRemoteNumberFilter,  int countThreshold,  bool rejectExceededNumbers,  bool allowNonExceededNumbers,  bool prioritizeRemoteAction,  bool logAllRemoteQueries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoteNumberFilterConfig() when $default != null:
return $default(_that.enableRemoteNumberFilter,_that.countThreshold,_that.rejectExceededNumbers,_that.allowNonExceededNumbers,_that.prioritizeRemoteAction,_that.logAllRemoteQueries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enableRemoteNumberFilter,  int countThreshold,  bool rejectExceededNumbers,  bool allowNonExceededNumbers,  bool prioritizeRemoteAction,  bool logAllRemoteQueries)  $default,) {final _that = this;
switch (_that) {
case _RemoteNumberFilterConfig():
return $default(_that.enableRemoteNumberFilter,_that.countThreshold,_that.rejectExceededNumbers,_that.allowNonExceededNumbers,_that.prioritizeRemoteAction,_that.logAllRemoteQueries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enableRemoteNumberFilter,  int countThreshold,  bool rejectExceededNumbers,  bool allowNonExceededNumbers,  bool prioritizeRemoteAction,  bool logAllRemoteQueries)?  $default,) {final _that = this;
switch (_that) {
case _RemoteNumberFilterConfig() when $default != null:
return $default(_that.enableRemoteNumberFilter,_that.countThreshold,_that.rejectExceededNumbers,_that.allowNonExceededNumbers,_that.prioritizeRemoteAction,_that.logAllRemoteQueries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoteNumberFilterConfig extends RemoteNumberFilterConfig {
  const _RemoteNumberFilterConfig({this.enableRemoteNumberFilter = true, this.countThreshold = 5, this.rejectExceededNumbers = true, this.allowNonExceededNumbers = false, this.prioritizeRemoteAction = true, this.logAllRemoteQueries = true}): super._();
  factory _RemoteNumberFilterConfig.fromJson(Map<String, dynamic> json) => _$RemoteNumberFilterConfigFromJson(json);

@override@JsonKey() final  bool enableRemoteNumberFilter;
@override@JsonKey() final  int countThreshold;
@override@JsonKey() final  bool rejectExceededNumbers;
@override@JsonKey() final  bool allowNonExceededNumbers;
@override@JsonKey() final  bool prioritizeRemoteAction;
@override@JsonKey() final  bool logAllRemoteQueries;

/// Create a copy of RemoteNumberFilterConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteNumberFilterConfigCopyWith<_RemoteNumberFilterConfig> get copyWith => __$RemoteNumberFilterConfigCopyWithImpl<_RemoteNumberFilterConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteNumberFilterConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteNumberFilterConfig&&(identical(other.enableRemoteNumberFilter, enableRemoteNumberFilter) || other.enableRemoteNumberFilter == enableRemoteNumberFilter)&&(identical(other.countThreshold, countThreshold) || other.countThreshold == countThreshold)&&(identical(other.rejectExceededNumbers, rejectExceededNumbers) || other.rejectExceededNumbers == rejectExceededNumbers)&&(identical(other.allowNonExceededNumbers, allowNonExceededNumbers) || other.allowNonExceededNumbers == allowNonExceededNumbers)&&(identical(other.prioritizeRemoteAction, prioritizeRemoteAction) || other.prioritizeRemoteAction == prioritizeRemoteAction)&&(identical(other.logAllRemoteQueries, logAllRemoteQueries) || other.logAllRemoteQueries == logAllRemoteQueries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enableRemoteNumberFilter,countThreshold,rejectExceededNumbers,allowNonExceededNumbers,prioritizeRemoteAction,logAllRemoteQueries);
}

@override
String toString() {
    return 'RemoteNumberFilterConfig(enableRemoteNumberFilter: $enableRemoteNumberFilter, countThreshold: $countThreshold, rejectExceededNumbers: $rejectExceededNumbers, allowNonExceededNumbers: $allowNonExceededNumbers, prioritizeRemoteAction: $prioritizeRemoteAction, logAllRemoteQueries: $logAllRemoteQueries)';
}


}

/// @nodoc
abstract mixin class _$RemoteNumberFilterConfigCopyWith<$Res> implements $RemoteNumberFilterConfigCopyWith<$Res> {
  factory _$RemoteNumberFilterConfigCopyWith(_RemoteNumberFilterConfig value, $Res Function(_RemoteNumberFilterConfig) _then) = __$RemoteNumberFilterConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enableRemoteNumberFilter, int countThreshold, bool rejectExceededNumbers, bool allowNonExceededNumbers, bool prioritizeRemoteAction, bool logAllRemoteQueries
});




}
/// @nodoc
class __$RemoteNumberFilterConfigCopyWithImpl<$Res>
    implements _$RemoteNumberFilterConfigCopyWith<$Res> {
  __$RemoteNumberFilterConfigCopyWithImpl(this._self, this._then);

  final _RemoteNumberFilterConfig _self;
  final $Res Function(_RemoteNumberFilterConfig) _then;

/// Create a copy of RemoteNumberFilterConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enableRemoteNumberFilter = null,Object? countThreshold = null,Object? rejectExceededNumbers = null,Object? allowNonExceededNumbers = null,Object? prioritizeRemoteAction = null,Object? logAllRemoteQueries = null,}) {
  return _then(_RemoteNumberFilterConfig(
enableRemoteNumberFilter: null == enableRemoteNumberFilter ? _self.enableRemoteNumberFilter : enableRemoteNumberFilter // ignore: cast_nullable_to_non_nullable
as bool,countThreshold: null == countThreshold ? _self.countThreshold : countThreshold // ignore: cast_nullable_to_non_nullable
as int,rejectExceededNumbers: null == rejectExceededNumbers ? _self.rejectExceededNumbers : rejectExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,allowNonExceededNumbers: null == allowNonExceededNumbers ? _self.allowNonExceededNumbers : allowNonExceededNumbers // ignore: cast_nullable_to_non_nullable
as bool,prioritizeRemoteAction: null == prioritizeRemoteAction ? _self.prioritizeRemoteAction : prioritizeRemoteAction // ignore: cast_nullable_to_non_nullable
as bool,logAllRemoteQueries: null == logAllRemoteQueries ? _self.logAllRemoteQueries : logAllRemoteQueries // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
