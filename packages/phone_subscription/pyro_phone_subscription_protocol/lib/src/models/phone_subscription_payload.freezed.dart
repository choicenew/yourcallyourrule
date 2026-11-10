// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_subscription_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneSubscriptionPayload {
  String get id => payloadId;
  String get payloadId; PhoneSubscriptionKind get kind; Map<String, dynamic> get rawJsonMap; int? get timestamp;
/// Create a copy of PhoneSubscriptionPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneSubscriptionPayloadCopyWith<PhoneSubscriptionPayload> get copyWith => _$PhoneSubscriptionPayloadCopyWithImpl<PhoneSubscriptionPayload>(this as PhoneSubscriptionPayload, _$identity);

  /// Serializes this PhoneSubscriptionPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneSubscriptionPayload;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneSubscriptionPayload&&(identical(other.payloadId, _this.payloadId) || other.payloadId == _this.payloadId)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&const DeepCollectionEquality().equals(other.rawJsonMap, _this.rawJsonMap)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneSubscriptionPayload;
  return Object.hash(runtimeType,_this.payloadId,_this.kind,const DeepCollectionEquality().hash(_this.rawJsonMap),_this.timestamp);
}

@override
String toString() {
  final _this = this as PhoneSubscriptionPayload;
  return 'PhoneSubscriptionPayload(payloadId: ${_this.payloadId}, kind: ${_this.kind}, rawJsonMap: ${_this.rawJsonMap}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $PhoneSubscriptionPayloadCopyWith<$Res>  {
  factory $PhoneSubscriptionPayloadCopyWith(PhoneSubscriptionPayload value, $Res Function(PhoneSubscriptionPayload) _then) = _$PhoneSubscriptionPayloadCopyWithImpl;
@useResult
$Res call({
 String payloadId, PhoneSubscriptionKind kind, Map<String, dynamic> rawJsonMap, int? timestamp
});


$PhoneSubscriptionKindCopyWith<$Res> get kind;

}
/// @nodoc
class _$PhoneSubscriptionPayloadCopyWithImpl<$Res>
    implements $PhoneSubscriptionPayloadCopyWith<$Res> {
  _$PhoneSubscriptionPayloadCopyWithImpl(this._self, this._then);

  final PhoneSubscriptionPayload _self;
  final $Res Function(PhoneSubscriptionPayload) _then;

/// Create a copy of PhoneSubscriptionPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payloadId = null,Object? kind = null,Object? rawJsonMap = null,Object? timestamp = freezed,}) {
  return _then(PhoneSubscriptionPayload(
payloadId: null == payloadId ? _self.payloadId : payloadId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PhoneSubscriptionKind,rawJsonMap: null == rawJsonMap ? _self.rawJsonMap : rawJsonMap // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of PhoneSubscriptionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneSubscriptionKindCopyWith<$Res> get kind {
  
  return $PhoneSubscriptionKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}


/// Adds pattern-matching-related methods to [PhoneSubscriptionPayload].
extension PhoneSubscriptionPayloadPatterns on PhoneSubscriptionPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneSubscriptionPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneSubscriptionPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneSubscriptionPayload value)  $default,){
final _that = this;
switch (_that) {
case _PhoneSubscriptionPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneSubscriptionPayload value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneSubscriptionPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String payloadId,  PhoneSubscriptionKind kind,  Map<String, dynamic> rawJsonMap,  int? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneSubscriptionPayload() when $default != null:
return $default(_that.payloadId,_that.kind,_that.rawJsonMap,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String payloadId,  PhoneSubscriptionKind kind,  Map<String, dynamic> rawJsonMap,  int? timestamp)  $default,) {final _that = this;
switch (_that) {
case _PhoneSubscriptionPayload():
return $default(_that.payloadId,_that.kind,_that.rawJsonMap,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String payloadId,  PhoneSubscriptionKind kind,  Map<String, dynamic> rawJsonMap,  int? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _PhoneSubscriptionPayload() when $default != null:
return $default(_that.payloadId,_that.kind,_that.rawJsonMap,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneSubscriptionPayload extends PhoneSubscriptionPayload {
  const _PhoneSubscriptionPayload({required this.payloadId, required this.kind, required  Map<String, dynamic> rawJsonMap, this.timestamp}): _rawJsonMap = rawJsonMap,super._();
  factory _PhoneSubscriptionPayload.fromJson(Map<String, dynamic> json) => _$PhoneSubscriptionPayloadFromJson(json);

@override final  String payloadId;
@override final  PhoneSubscriptionKind kind;
 final  Map<String, dynamic> _rawJsonMap;
@override Map<String, dynamic> get rawJsonMap {
  if (_rawJsonMap is EqualUnmodifiableMapView) return _rawJsonMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rawJsonMap);
}

@override final  int? timestamp;

/// Create a copy of PhoneSubscriptionPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneSubscriptionPayloadCopyWith<_PhoneSubscriptionPayload> get copyWith => __$PhoneSubscriptionPayloadCopyWithImpl<_PhoneSubscriptionPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneSubscriptionPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneSubscriptionPayload&&(identical(other.payloadId, payloadId) || other.payloadId == payloadId)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.rawJsonMap, _rawJsonMap)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,payloadId,kind,const DeepCollectionEquality().hash(_rawJsonMap),timestamp);
}

@override
String toString() {
    return 'PhoneSubscriptionPayload(payloadId: $payloadId, kind: $kind, rawJsonMap: $rawJsonMap, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PhoneSubscriptionPayloadCopyWith<$Res> implements $PhoneSubscriptionPayloadCopyWith<$Res> {
  factory _$PhoneSubscriptionPayloadCopyWith(_PhoneSubscriptionPayload value, $Res Function(_PhoneSubscriptionPayload) _then) = __$PhoneSubscriptionPayloadCopyWithImpl;
@override @useResult
$Res call({
 String payloadId, PhoneSubscriptionKind kind, Map<String, dynamic> rawJsonMap, int? timestamp
});


@override $PhoneSubscriptionKindCopyWith<$Res> get kind;

}
/// @nodoc
class __$PhoneSubscriptionPayloadCopyWithImpl<$Res>
    implements _$PhoneSubscriptionPayloadCopyWith<$Res> {
  __$PhoneSubscriptionPayloadCopyWithImpl(this._self, this._then);

  final _PhoneSubscriptionPayload _self;
  final $Res Function(_PhoneSubscriptionPayload) _then;

/// Create a copy of PhoneSubscriptionPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? payloadId = null,Object? kind = null,Object? rawJsonMap = null,Object? timestamp = freezed,}) {
  return _then(_PhoneSubscriptionPayload(
payloadId: null == payloadId ? _self.payloadId : payloadId // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PhoneSubscriptionKind,rawJsonMap: null == rawJsonMap ? _self._rawJsonMap : rawJsonMap // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of PhoneSubscriptionPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneSubscriptionKindCopyWith<$Res> get kind {
  
  return $PhoneSubscriptionKindCopyWith<$Res>(_self.kind, (value) {
    return _then(_self.copyWith(kind: value));
  });
}
}

// dart format on
