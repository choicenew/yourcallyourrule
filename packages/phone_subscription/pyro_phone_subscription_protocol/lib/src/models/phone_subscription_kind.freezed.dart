// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_subscription_kind.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneSubscriptionKind {

 String get id;
/// Create a copy of PhoneSubscriptionKind
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneSubscriptionKindCopyWith<PhoneSubscriptionKind> get copyWith => _$PhoneSubscriptionKindCopyWithImpl<PhoneSubscriptionKind>(this as PhoneSubscriptionKind, _$identity);

  /// Serializes this PhoneSubscriptionKind to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneSubscriptionKind;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneSubscriptionKind&&(identical(other.id, _this.id) || other.id == _this.id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneSubscriptionKind;
  return Object.hash(runtimeType,_this.id);
}

@override
String toString() {
  final _this = this as PhoneSubscriptionKind;
  return 'PhoneSubscriptionKind(id: ${_this.id})';
}


}

/// @nodoc
abstract mixin class $PhoneSubscriptionKindCopyWith<$Res>  {
  factory $PhoneSubscriptionKindCopyWith(PhoneSubscriptionKind value, $Res Function(PhoneSubscriptionKind) _then) = _$PhoneSubscriptionKindCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$PhoneSubscriptionKindCopyWithImpl<$Res>
    implements $PhoneSubscriptionKindCopyWith<$Res> {
  _$PhoneSubscriptionKindCopyWithImpl(this._self, this._then);

  final PhoneSubscriptionKind _self;
  final $Res Function(PhoneSubscriptionKind) _then;

/// Create a copy of PhoneSubscriptionKind
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(PhoneSubscriptionKind(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneSubscriptionKind].
extension PhoneSubscriptionKindPatterns on PhoneSubscriptionKind {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneSubscriptionKind value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneSubscriptionKind() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneSubscriptionKind value)  $default,){
final _that = this;
switch (_that) {
case _PhoneSubscriptionKind():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneSubscriptionKind value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneSubscriptionKind() when $default != null:
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
case _PhoneSubscriptionKind() when $default != null:
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
case _PhoneSubscriptionKind():
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
case _PhoneSubscriptionKind() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneSubscriptionKind extends PhoneSubscriptionKind {
  const _PhoneSubscriptionKind({required this.id}): super._();
  factory _PhoneSubscriptionKind.fromJson(Map<String, dynamic> json) => _$PhoneSubscriptionKindFromJson(json);

@override final  String id;

/// Create a copy of PhoneSubscriptionKind
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneSubscriptionKindCopyWith<_PhoneSubscriptionKind> get copyWith => __$PhoneSubscriptionKindCopyWithImpl<_PhoneSubscriptionKind>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneSubscriptionKindToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneSubscriptionKind&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'PhoneSubscriptionKind(id: $id)';
}


}

/// @nodoc
abstract mixin class _$PhoneSubscriptionKindCopyWith<$Res> implements $PhoneSubscriptionKindCopyWith<$Res> {
  factory _$PhoneSubscriptionKindCopyWith(_PhoneSubscriptionKind value, $Res Function(_PhoneSubscriptionKind) _then) = __$PhoneSubscriptionKindCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$PhoneSubscriptionKindCopyWithImpl<$Res>
    implements _$PhoneSubscriptionKindCopyWith<$Res> {
  __$PhoneSubscriptionKindCopyWithImpl(this._self, this._then);

  final _PhoneSubscriptionKind _self;
  final $Res Function(_PhoneSubscriptionKind) _then;

/// Create a copy of PhoneSubscriptionKind
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_PhoneSubscriptionKind(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
