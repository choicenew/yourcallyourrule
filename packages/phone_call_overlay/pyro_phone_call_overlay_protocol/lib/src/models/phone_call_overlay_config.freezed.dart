// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_call_overlay_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneCallOverlayConfig {

 bool get enableOverlay; String get backgroundColor; int get fontSize; int get positionY;
/// Create a copy of PhoneCallOverlayConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneCallOverlayConfigCopyWith<PhoneCallOverlayConfig> get copyWith => _$PhoneCallOverlayConfigCopyWithImpl<PhoneCallOverlayConfig>(this as PhoneCallOverlayConfig, _$identity);

  /// Serializes this PhoneCallOverlayConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneCallOverlayConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneCallOverlayConfig&&(identical(other.enableOverlay, _this.enableOverlay) || other.enableOverlay == _this.enableOverlay)&&(identical(other.backgroundColor, _this.backgroundColor) || other.backgroundColor == _this.backgroundColor)&&(identical(other.fontSize, _this.fontSize) || other.fontSize == _this.fontSize)&&(identical(other.positionY, _this.positionY) || other.positionY == _this.positionY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneCallOverlayConfig;
  return Object.hash(runtimeType,_this.enableOverlay,_this.backgroundColor,_this.fontSize,_this.positionY);
}

@override
String toString() {
  final _this = this as PhoneCallOverlayConfig;
  return 'PhoneCallOverlayConfig(enableOverlay: ${_this.enableOverlay}, backgroundColor: ${_this.backgroundColor}, fontSize: ${_this.fontSize}, positionY: ${_this.positionY})';
}


}

/// @nodoc
abstract mixin class $PhoneCallOverlayConfigCopyWith<$Res>  {
  factory $PhoneCallOverlayConfigCopyWith(PhoneCallOverlayConfig value, $Res Function(PhoneCallOverlayConfig) _then) = _$PhoneCallOverlayConfigCopyWithImpl;
@useResult
$Res call({
 bool enableOverlay, String backgroundColor, int fontSize, int positionY
});




}
/// @nodoc
class _$PhoneCallOverlayConfigCopyWithImpl<$Res>
    implements $PhoneCallOverlayConfigCopyWith<$Res> {
  _$PhoneCallOverlayConfigCopyWithImpl(this._self, this._then);

  final PhoneCallOverlayConfig _self;
  final $Res Function(PhoneCallOverlayConfig) _then;

/// Create a copy of PhoneCallOverlayConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enableOverlay = null,Object? backgroundColor = null,Object? fontSize = null,Object? positionY = null,}) {
  return _then(PhoneCallOverlayConfig(
enableOverlay: null == enableOverlay ? _self.enableOverlay : enableOverlay // ignore: cast_nullable_to_non_nullable
as bool,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as int,positionY: null == positionY ? _self.positionY : positionY // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneCallOverlayConfig].
extension PhoneCallOverlayConfigPatterns on PhoneCallOverlayConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneCallOverlayConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneCallOverlayConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneCallOverlayConfig value)  $default,){
final _that = this;
switch (_that) {
case _PhoneCallOverlayConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneCallOverlayConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneCallOverlayConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enableOverlay,  String backgroundColor,  int fontSize,  int positionY)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneCallOverlayConfig() when $default != null:
return $default(_that.enableOverlay,_that.backgroundColor,_that.fontSize,_that.positionY);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enableOverlay,  String backgroundColor,  int fontSize,  int positionY)  $default,) {final _that = this;
switch (_that) {
case _PhoneCallOverlayConfig():
return $default(_that.enableOverlay,_that.backgroundColor,_that.fontSize,_that.positionY);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enableOverlay,  String backgroundColor,  int fontSize,  int positionY)?  $default,) {final _that = this;
switch (_that) {
case _PhoneCallOverlayConfig() when $default != null:
return $default(_that.enableOverlay,_that.backgroundColor,_that.fontSize,_that.positionY);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneCallOverlayConfig extends PhoneCallOverlayConfig {
  const _PhoneCallOverlayConfig({this.enableOverlay = true, this.backgroundColor = '#000000', this.fontSize = 16, this.positionY = 0}): super._();
  factory _PhoneCallOverlayConfig.fromJson(Map<String, dynamic> json) => _$PhoneCallOverlayConfigFromJson(json);

@override@JsonKey() final  bool enableOverlay;
@override@JsonKey() final  String backgroundColor;
@override@JsonKey() final  int fontSize;
@override@JsonKey() final  int positionY;

/// Create a copy of PhoneCallOverlayConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneCallOverlayConfigCopyWith<_PhoneCallOverlayConfig> get copyWith => __$PhoneCallOverlayConfigCopyWithImpl<_PhoneCallOverlayConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneCallOverlayConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneCallOverlayConfig&&(identical(other.enableOverlay, enableOverlay) || other.enableOverlay == enableOverlay)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.positionY, positionY) || other.positionY == positionY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enableOverlay,backgroundColor,fontSize,positionY);
}

@override
String toString() {
    return 'PhoneCallOverlayConfig(enableOverlay: $enableOverlay, backgroundColor: $backgroundColor, fontSize: $fontSize, positionY: $positionY)';
}


}

/// @nodoc
abstract mixin class _$PhoneCallOverlayConfigCopyWith<$Res> implements $PhoneCallOverlayConfigCopyWith<$Res> {
  factory _$PhoneCallOverlayConfigCopyWith(_PhoneCallOverlayConfig value, $Res Function(_PhoneCallOverlayConfig) _then) = __$PhoneCallOverlayConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enableOverlay, String backgroundColor, int fontSize, int positionY
});




}
/// @nodoc
class __$PhoneCallOverlayConfigCopyWithImpl<$Res>
    implements _$PhoneCallOverlayConfigCopyWith<$Res> {
  __$PhoneCallOverlayConfigCopyWithImpl(this._self, this._then);

  final _PhoneCallOverlayConfig _self;
  final $Res Function(_PhoneCallOverlayConfig) _then;

/// Create a copy of PhoneCallOverlayConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enableOverlay = null,Object? backgroundColor = null,Object? fontSize = null,Object? positionY = null,}) {
  return _then(_PhoneCallOverlayConfig(
enableOverlay: null == enableOverlay ? _self.enableOverlay : enableOverlay // ignore: cast_nullable_to_non_nullable
as bool,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as int,positionY: null == positionY ? _self.positionY : positionY // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
