// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intercept_action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterceptAction {

 String get actionName;
/// Create a copy of InterceptAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterceptActionCopyWith<InterceptAction> get copyWith => _$InterceptActionCopyWithImpl<InterceptAction>(this as InterceptAction, _$identity);

  /// Serializes this InterceptAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InterceptAction;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterceptAction&&(identical(other.actionName, _this.actionName) || other.actionName == _this.actionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InterceptAction;
  return Object.hash(runtimeType,_this.actionName);
}

@override
String toString() {
  final _this = this as InterceptAction;
  return 'InterceptAction(actionName: ${_this.actionName})';
}


}

/// @nodoc
abstract mixin class $InterceptActionCopyWith<$Res>  {
  factory $InterceptActionCopyWith(InterceptAction value, $Res Function(InterceptAction) _then) = _$InterceptActionCopyWithImpl;
@useResult
$Res call({
 String actionName
});




}
/// @nodoc
class _$InterceptActionCopyWithImpl<$Res>
    implements $InterceptActionCopyWith<$Res> {
  _$InterceptActionCopyWithImpl(this._self, this._then);

  final InterceptAction _self;
  final $Res Function(InterceptAction) _then;

/// Create a copy of InterceptAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? actionName = null,}) {
  return _then(InterceptAction(
actionName: null == actionName ? _self.actionName : actionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InterceptAction].
extension InterceptActionPatterns on InterceptAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InterceptAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InterceptAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InterceptAction value)  $default,){
final _that = this;
switch (_that) {
case _InterceptAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InterceptAction value)?  $default,){
final _that = this;
switch (_that) {
case _InterceptAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String actionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InterceptAction() when $default != null:
return $default(_that.actionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String actionName)  $default,) {final _that = this;
switch (_that) {
case _InterceptAction():
return $default(_that.actionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String actionName)?  $default,) {final _that = this;
switch (_that) {
case _InterceptAction() when $default != null:
return $default(_that.actionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InterceptAction extends InterceptAction {
  const _InterceptAction({required this.actionName}): super._();
  factory _InterceptAction.fromJson(Map<String, dynamic> json) => _$InterceptActionFromJson(json);

@override final  String actionName;

/// Create a copy of InterceptAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterceptActionCopyWith<_InterceptAction> get copyWith => __$InterceptActionCopyWithImpl<_InterceptAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterceptActionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InterceptAction&&(identical(other.actionName, actionName) || other.actionName == actionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,actionName);
}

@override
String toString() {
    return 'InterceptAction(actionName: $actionName)';
}


}

/// @nodoc
abstract mixin class _$InterceptActionCopyWith<$Res> implements $InterceptActionCopyWith<$Res> {
  factory _$InterceptActionCopyWith(_InterceptAction value, $Res Function(_InterceptAction) _then) = __$InterceptActionCopyWithImpl;
@override @useResult
$Res call({
 String actionName
});




}
/// @nodoc
class __$InterceptActionCopyWithImpl<$Res>
    implements _$InterceptActionCopyWith<$Res> {
  __$InterceptActionCopyWithImpl(this._self, this._then);

  final _InterceptAction _self;
  final $Res Function(_InterceptAction) _then;

/// Create a copy of InterceptAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? actionName = null,}) {
  return _then(_InterceptAction(
actionName: null == actionName ? _self.actionName : actionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
