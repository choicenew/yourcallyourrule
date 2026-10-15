// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sms_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SmsSubscription {

 String get id; String get name; Url get url; bool get isEnabled; RuleAction get action; DateTime get lastUpdated; bool get autoUpdate; String get tableType;
/// Create a copy of SmsSubscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmsSubscriptionCopyWith<SmsSubscription> get copyWith => _$SmsSubscriptionCopyWithImpl<SmsSubscription>(this as SmsSubscription, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SmsSubscription;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmsSubscription&&super == other&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled)&&(identical(other.action, _this.action) || other.action == _this.action)&&(identical(other.lastUpdated, _this.lastUpdated) || other.lastUpdated == _this.lastUpdated)&&(identical(other.autoUpdate, _this.autoUpdate) || other.autoUpdate == _this.autoUpdate)&&(identical(other.tableType, _this.tableType) || other.tableType == _this.tableType));
}


@override
int get hashCode {
  final _this = this as SmsSubscription;
  return Object.hash(runtimeType,super.hashCode,_this.id,_this.name,_this.url,_this.isEnabled,_this.action,_this.lastUpdated,_this.autoUpdate,_this.tableType);
}

@override
String toString() {
  final _this = this as SmsSubscription;
  return 'SmsSubscription(id: ${_this.id}, name: ${_this.name}, url: ${_this.url}, isEnabled: ${_this.isEnabled}, action: ${_this.action}, lastUpdated: ${_this.lastUpdated}, autoUpdate: ${_this.autoUpdate}, tableType: ${_this.tableType})';
}


}

/// @nodoc
abstract mixin class $SmsSubscriptionCopyWith<$Res>  {
  factory $SmsSubscriptionCopyWith(SmsSubscription value, $Res Function(SmsSubscription) _then) = _$SmsSubscriptionCopyWithImpl;
@useResult
$Res call({
 String id, String name, Url url, bool isEnabled, RuleAction action, DateTime lastUpdated, bool autoUpdate, String tableType
});




}
/// @nodoc
class _$SmsSubscriptionCopyWithImpl<$Res>
    implements $SmsSubscriptionCopyWith<$Res> {
  _$SmsSubscriptionCopyWithImpl(this._self, this._then);

  final SmsSubscription _self;
  final $Res Function(SmsSubscription) _then;

/// Create a copy of SmsSubscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? isEnabled = null,Object? action = null,Object? lastUpdated = null,Object? autoUpdate = null,Object? tableType = null,}) {
  return _then(SmsSubscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Url,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,autoUpdate: null == autoUpdate ? _self.autoUpdate : autoUpdate // ignore: cast_nullable_to_non_nullable
as bool,tableType: null == tableType ? _self.tableType : tableType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SmsSubscription].
extension SmsSubscriptionPatterns on SmsSubscription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SmsSubscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SmsSubscription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SmsSubscription value)  $default,){
final _that = this;
switch (_that) {
case _SmsSubscription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SmsSubscription value)?  $default,){
final _that = this;
switch (_that) {
case _SmsSubscription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Url url,  bool isEnabled,  RuleAction action,  DateTime lastUpdated,  bool autoUpdate,  String tableType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SmsSubscription() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.isEnabled,_that.action,_that.lastUpdated,_that.autoUpdate,_that.tableType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Url url,  bool isEnabled,  RuleAction action,  DateTime lastUpdated,  bool autoUpdate,  String tableType)  $default,) {final _that = this;
switch (_that) {
case _SmsSubscription():
return $default(_that.id,_that.name,_that.url,_that.isEnabled,_that.action,_that.lastUpdated,_that.autoUpdate,_that.tableType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Url url,  bool isEnabled,  RuleAction action,  DateTime lastUpdated,  bool autoUpdate,  String tableType)?  $default,) {final _that = this;
switch (_that) {
case _SmsSubscription() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.isEnabled,_that.action,_that.lastUpdated,_that.autoUpdate,_that.tableType);case _:
  return null;

}
}

}

/// @nodoc


class _SmsSubscription extends SmsSubscription implements BaseEntity {
  const _SmsSubscription({required this.id, required this.name, required this.url, this.isEnabled = true, this.action = RuleAction.block, required this.lastUpdated, this.autoUpdate = false, this.tableType = SubscriptionTableKeys.sms}): super._();
  

@override final  String id;
@override final  String name;
@override final  Url url;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  RuleAction action;
@override final  DateTime lastUpdated;
@override@JsonKey() final  bool autoUpdate;
@override@JsonKey() final  String tableType;

/// Create a copy of SmsSubscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SmsSubscriptionCopyWith<_SmsSubscription> get copyWith => __$SmsSubscriptionCopyWithImpl<_SmsSubscription>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SmsSubscription&&super == other&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.action, action) || other.action == action)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.autoUpdate, autoUpdate) || other.autoUpdate == autoUpdate)&&(identical(other.tableType, tableType) || other.tableType == tableType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,super.hashCode,id,name,url,isEnabled,action,lastUpdated,autoUpdate,tableType);
}

@override
String toString() {
    return 'SmsSubscription(id: $id, name: $name, url: $url, isEnabled: $isEnabled, action: $action, lastUpdated: $lastUpdated, autoUpdate: $autoUpdate, tableType: $tableType)';
}


}

/// @nodoc
abstract mixin class _$SmsSubscriptionCopyWith<$Res> implements $SmsSubscriptionCopyWith<$Res> {
  factory _$SmsSubscriptionCopyWith(_SmsSubscription value, $Res Function(_SmsSubscription) _then) = __$SmsSubscriptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Url url, bool isEnabled, RuleAction action, DateTime lastUpdated, bool autoUpdate, String tableType
});




}
/// @nodoc
class __$SmsSubscriptionCopyWithImpl<$Res>
    implements _$SmsSubscriptionCopyWith<$Res> {
  __$SmsSubscriptionCopyWithImpl(this._self, this._then);

  final _SmsSubscription _self;
  final $Res Function(_SmsSubscription) _then;

/// Create a copy of SmsSubscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,Object? isEnabled = null,Object? action = null,Object? lastUpdated = null,Object? autoUpdate = null,Object? tableType = null,}) {
  return _then(_SmsSubscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Url,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as RuleAction,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,autoUpdate: null == autoUpdate ? _self.autoUpdate : autoUpdate // ignore: cast_nullable_to_non_nullable
as bool,tableType: null == tableType ? _self.tableType : tableType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
