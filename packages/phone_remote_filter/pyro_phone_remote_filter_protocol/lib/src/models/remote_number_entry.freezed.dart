// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_number_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteNumberEntry {

 String get id; String get phoneNumber; String? get name; String? get label; int get count; String get actionType; bool get isEnabled;
/// Create a copy of RemoteNumberEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteNumberEntryCopyWith<RemoteNumberEntry> get copyWith => _$RemoteNumberEntryCopyWithImpl<RemoteNumberEntry>(this as RemoteNumberEntry, _$identity);

  /// Serializes this RemoteNumberEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RemoteNumberEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteNumberEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.actionType, _this.actionType) || other.actionType == _this.actionType)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RemoteNumberEntry;
  return Object.hash(runtimeType,_this.id,_this.phoneNumber,_this.name,_this.label,_this.count,_this.actionType,_this.isEnabled);
}

@override
String toString() {
  final _this = this as RemoteNumberEntry;
  return 'RemoteNumberEntry(id: ${_this.id}, phoneNumber: ${_this.phoneNumber}, name: ${_this.name}, label: ${_this.label}, count: ${_this.count}, actionType: ${_this.actionType}, isEnabled: ${_this.isEnabled})';
}


}

/// @nodoc
abstract mixin class $RemoteNumberEntryCopyWith<$Res>  {
  factory $RemoteNumberEntryCopyWith(RemoteNumberEntry value, $Res Function(RemoteNumberEntry) _then) = _$RemoteNumberEntryCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, String? name, String? label, int count, String actionType, bool isEnabled
});




}
/// @nodoc
class _$RemoteNumberEntryCopyWithImpl<$Res>
    implements $RemoteNumberEntryCopyWith<$Res> {
  _$RemoteNumberEntryCopyWithImpl(this._self, this._then);

  final RemoteNumberEntry _self;
  final $Res Function(RemoteNumberEntry) _then;

/// Create a copy of RemoteNumberEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? name = freezed,Object? label = freezed,Object? count = null,Object? actionType = null,Object? isEnabled = null,}) {
  return _then(RemoteNumberEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RemoteNumberEntry].
extension RemoteNumberEntryPatterns on RemoteNumberEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemoteNumberEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemoteNumberEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemoteNumberEntry value)  $default,){
final _that = this;
switch (_that) {
case _RemoteNumberEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemoteNumberEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RemoteNumberEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String? name,  String? label,  int count,  String actionType,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemoteNumberEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.name,_that.label,_that.count,_that.actionType,_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String? name,  String? label,  int count,  String actionType,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _RemoteNumberEntry():
return $default(_that.id,_that.phoneNumber,_that.name,_that.label,_that.count,_that.actionType,_that.isEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  String? name,  String? label,  int count,  String actionType,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _RemoteNumberEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.name,_that.label,_that.count,_that.actionType,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemoteNumberEntry extends RemoteNumberEntry {
  const _RemoteNumberEntry({required this.id, required this.phoneNumber, this.name, this.label, this.count = 0, this.actionType = 'block', this.isEnabled = true}): super._();
  factory _RemoteNumberEntry.fromJson(Map<String, dynamic> json) => _$RemoteNumberEntryFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  String? name;
@override final  String? label;
@override@JsonKey() final  int count;
@override@JsonKey() final  String actionType;
@override@JsonKey() final  bool isEnabled;

/// Create a copy of RemoteNumberEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteNumberEntryCopyWith<_RemoteNumberEntry> get copyWith => __$RemoteNumberEntryCopyWithImpl<_RemoteNumberEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteNumberEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteNumberEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,phoneNumber,name,label,count,actionType,isEnabled);
}

@override
String toString() {
    return 'RemoteNumberEntry(id: $id, phoneNumber: $phoneNumber, name: $name, label: $label, count: $count, actionType: $actionType, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$RemoteNumberEntryCopyWith<$Res> implements $RemoteNumberEntryCopyWith<$Res> {
  factory _$RemoteNumberEntryCopyWith(_RemoteNumberEntry value, $Res Function(_RemoteNumberEntry) _then) = __$RemoteNumberEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, String? name, String? label, int count, String actionType, bool isEnabled
});




}
/// @nodoc
class __$RemoteNumberEntryCopyWithImpl<$Res>
    implements _$RemoteNumberEntryCopyWith<$Res> {
  __$RemoteNumberEntryCopyWithImpl(this._self, this._then);

  final _RemoteNumberEntry _self;
  final $Res Function(_RemoteNumberEntry) _then;

/// Create a copy of RemoteNumberEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? name = freezed,Object? label = freezed,Object? count = null,Object? actionType = null,Object? isEnabled = null,}) {
  return _then(_RemoteNumberEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
