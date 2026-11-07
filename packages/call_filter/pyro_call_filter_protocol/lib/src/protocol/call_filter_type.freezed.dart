// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_filter_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallFilterType {

 String get id;
/// Create a copy of CallFilterType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallFilterTypeCopyWith<CallFilterType> get copyWith => _$CallFilterTypeCopyWithImpl<CallFilterType>(this as CallFilterType, _$identity);

  /// Serializes this CallFilterType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CallFilterType;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallFilterType&&(identical(other.id, _this.id) || other.id == _this.id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CallFilterType;
  return Object.hash(runtimeType,_this.id);
}

@override
String toString() {
  final _this = this as CallFilterType;
  return 'CallFilterType(id: ${_this.id})';
}


}

/// @nodoc
abstract mixin class $CallFilterTypeCopyWith<$Res>  {
  factory $CallFilterTypeCopyWith(CallFilterType value, $Res Function(CallFilterType) _then) = _$CallFilterTypeCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$CallFilterTypeCopyWithImpl<$Res>
    implements $CallFilterTypeCopyWith<$Res> {
  _$CallFilterTypeCopyWithImpl(this._self, this._then);

  final CallFilterType _self;
  final $Res Function(CallFilterType) _then;

/// Create a copy of CallFilterType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(CallFilterType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallFilterType].
extension CallFilterTypePatterns on CallFilterType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallFilterType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallFilterType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallFilterType value)  $default,){
final _that = this;
switch (_that) {
case _CallFilterType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallFilterType value)?  $default,){
final _that = this;
switch (_that) {
case _CallFilterType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallFilterType() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _CallFilterType():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _CallFilterType() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallFilterType extends CallFilterType {
  const _CallFilterType({required this.id}): super._();
  factory _CallFilterType.fromJson(Map<String, dynamic> json) => _$CallFilterTypeFromJson(json);

@override final  String id;

/// Create a copy of CallFilterType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallFilterTypeCopyWith<_CallFilterType> get copyWith => __$CallFilterTypeCopyWithImpl<_CallFilterType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallFilterTypeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallFilterType&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'CallFilterType(id: $id)';
}


}

/// @nodoc
abstract mixin class _$CallFilterTypeCopyWith<$Res> implements $CallFilterTypeCopyWith<$Res> {
  factory _$CallFilterTypeCopyWith(_CallFilterType value, $Res Function(_CallFilterType) _then) = __$CallFilterTypeCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$CallFilterTypeCopyWithImpl<$Res>
    implements _$CallFilterTypeCopyWith<$Res> {
  __$CallFilterTypeCopyWithImpl(this._self, this._then);

  final _CallFilterType _self;
  final $Res Function(_CallFilterType) _then;

/// Create a copy of CallFilterType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_CallFilterType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
