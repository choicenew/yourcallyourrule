// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactSubscription {

 String get id; String get name; Url get url; bool get isEnabled; bool get autoUpdate; DateTime get lastUpdated; String get tableType;
/// Create a copy of ContactSubscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactSubscriptionCopyWith<ContactSubscription> get copyWith => _$ContactSubscriptionCopyWithImpl<ContactSubscription>(this as ContactSubscription, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ContactSubscription;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactSubscription&&super == other&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled)&&(identical(other.autoUpdate, _this.autoUpdate) || other.autoUpdate == _this.autoUpdate)&&(identical(other.lastUpdated, _this.lastUpdated) || other.lastUpdated == _this.lastUpdated)&&(identical(other.tableType, _this.tableType) || other.tableType == _this.tableType));
}


@override
int get hashCode {
  final _this = this as ContactSubscription;
  return Object.hash(runtimeType,super.hashCode,_this.id,_this.name,_this.url,_this.isEnabled,_this.autoUpdate,_this.lastUpdated,_this.tableType);
}

@override
String toString() {
  final _this = this as ContactSubscription;
  return 'ContactSubscription(id: ${_this.id}, name: ${_this.name}, url: ${_this.url}, isEnabled: ${_this.isEnabled}, autoUpdate: ${_this.autoUpdate}, lastUpdated: ${_this.lastUpdated}, tableType: ${_this.tableType})';
}


}

/// @nodoc
abstract mixin class $ContactSubscriptionCopyWith<$Res>  {
  factory $ContactSubscriptionCopyWith(ContactSubscription value, $Res Function(ContactSubscription) _then) = _$ContactSubscriptionCopyWithImpl;
@useResult
$Res call({
 String id, String name, Url url, bool isEnabled, bool autoUpdate, DateTime lastUpdated, String tableType
});




}
/// @nodoc
class _$ContactSubscriptionCopyWithImpl<$Res>
    implements $ContactSubscriptionCopyWith<$Res> {
  _$ContactSubscriptionCopyWithImpl(this._self, this._then);

  final ContactSubscription _self;
  final $Res Function(ContactSubscription) _then;

/// Create a copy of ContactSubscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? isEnabled = null,Object? autoUpdate = null,Object? lastUpdated = null,Object? tableType = null,}) {
  return _then(ContactSubscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Url,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoUpdate: null == autoUpdate ? _self.autoUpdate : autoUpdate // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,tableType: null == tableType ? _self.tableType : tableType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactSubscription].
extension ContactSubscriptionPatterns on ContactSubscription {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactSubscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactSubscription() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactSubscription value)  $default,){
final _that = this;
switch (_that) {
case _ContactSubscription():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactSubscription value)?  $default,){
final _that = this;
switch (_that) {
case _ContactSubscription() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  Url url,  bool isEnabled,  bool autoUpdate,  DateTime lastUpdated,  String tableType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactSubscription() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.isEnabled,_that.autoUpdate,_that.lastUpdated,_that.tableType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  Url url,  bool isEnabled,  bool autoUpdate,  DateTime lastUpdated,  String tableType)  $default,) {final _that = this;
switch (_that) {
case _ContactSubscription():
return $default(_that.id,_that.name,_that.url,_that.isEnabled,_that.autoUpdate,_that.lastUpdated,_that.tableType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  Url url,  bool isEnabled,  bool autoUpdate,  DateTime lastUpdated,  String tableType)?  $default,) {final _that = this;
switch (_that) {
case _ContactSubscription() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.isEnabled,_that.autoUpdate,_that.lastUpdated,_that.tableType);case _:
  return null;

}
}

}

/// @nodoc


class _ContactSubscription extends ContactSubscription implements BaseEntity {
  const _ContactSubscription({required this.id, required this.name, required this.url, this.isEnabled = true, this.autoUpdate = false, required this.lastUpdated, this.tableType = SubscriptionTableKeys.contact}): super._();
  

@override final  String id;
@override final  String name;
@override final  Url url;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  bool autoUpdate;
@override final  DateTime lastUpdated;
@override@JsonKey() final  String tableType;

/// Create a copy of ContactSubscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactSubscriptionCopyWith<_ContactSubscription> get copyWith => __$ContactSubscriptionCopyWithImpl<_ContactSubscription>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactSubscription&&super == other&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.autoUpdate, autoUpdate) || other.autoUpdate == autoUpdate)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.tableType, tableType) || other.tableType == tableType));
}


@override
int get hashCode {
    return Object.hash(runtimeType,super.hashCode,id,name,url,isEnabled,autoUpdate,lastUpdated,tableType);
}

@override
String toString() {
    return 'ContactSubscription(id: $id, name: $name, url: $url, isEnabled: $isEnabled, autoUpdate: $autoUpdate, lastUpdated: $lastUpdated, tableType: $tableType)';
}


}

/// @nodoc
abstract mixin class _$ContactSubscriptionCopyWith<$Res> implements $ContactSubscriptionCopyWith<$Res> {
  factory _$ContactSubscriptionCopyWith(_ContactSubscription value, $Res Function(_ContactSubscription) _then) = __$ContactSubscriptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, Url url, bool isEnabled, bool autoUpdate, DateTime lastUpdated, String tableType
});




}
/// @nodoc
class __$ContactSubscriptionCopyWithImpl<$Res>
    implements _$ContactSubscriptionCopyWith<$Res> {
  __$ContactSubscriptionCopyWithImpl(this._self, this._then);

  final _ContactSubscription _self;
  final $Res Function(_ContactSubscription) _then;

/// Create a copy of ContactSubscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,Object? isEnabled = null,Object? autoUpdate = null,Object? lastUpdated = null,Object? tableType = null,}) {
  return _then(_ContactSubscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as Url,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,autoUpdate: null == autoUpdate ? _self.autoUpdate : autoUpdate // ignore: cast_nullable_to_non_nullable
as bool,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,tableType: null == tableType ? _self.tableType : tableType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
