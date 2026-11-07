// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'label_phone_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LabelPhoneEntry {

 String get id; String get phoneNumber; String get labelId; String get name; String? get avatar; String? get icon; int get priority; bool get isEnabled;
/// Create a copy of LabelPhoneEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelPhoneEntryCopyWith<LabelPhoneEntry> get copyWith => _$LabelPhoneEntryCopyWithImpl<LabelPhoneEntry>(this as LabelPhoneEntry, _$identity);

  /// Serializes this LabelPhoneEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LabelPhoneEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabelPhoneEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.labelId, _this.labelId) || other.labelId == _this.labelId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.isEnabled, _this.isEnabled) || other.isEnabled == _this.isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LabelPhoneEntry;
  return Object.hash(runtimeType,_this.id,_this.phoneNumber,_this.labelId,_this.name,_this.avatar,_this.icon,_this.priority,_this.isEnabled);
}

@override
String toString() {
  final _this = this as LabelPhoneEntry;
  return 'LabelPhoneEntry(id: ${_this.id}, phoneNumber: ${_this.phoneNumber}, labelId: ${_this.labelId}, name: ${_this.name}, avatar: ${_this.avatar}, icon: ${_this.icon}, priority: ${_this.priority}, isEnabled: ${_this.isEnabled})';
}


}

/// @nodoc
abstract mixin class $LabelPhoneEntryCopyWith<$Res>  {
  factory $LabelPhoneEntryCopyWith(LabelPhoneEntry value, $Res Function(LabelPhoneEntry) _then) = _$LabelPhoneEntryCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, String labelId, String name, String? avatar, String? icon, int priority, bool isEnabled
});




}
/// @nodoc
class _$LabelPhoneEntryCopyWithImpl<$Res>
    implements $LabelPhoneEntryCopyWith<$Res> {
  _$LabelPhoneEntryCopyWithImpl(this._self, this._then);

  final LabelPhoneEntry _self;
  final $Res Function(LabelPhoneEntry) _then;

/// Create a copy of LabelPhoneEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? labelId = null,Object? name = null,Object? avatar = freezed,Object? icon = freezed,Object? priority = null,Object? isEnabled = null,}) {
  return _then(LabelPhoneEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LabelPhoneEntry].
extension LabelPhoneEntryPatterns on LabelPhoneEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LabelPhoneEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LabelPhoneEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LabelPhoneEntry value)  $default,){
final _that = this;
switch (_that) {
case _LabelPhoneEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LabelPhoneEntry value)?  $default,){
final _that = this;
switch (_that) {
case _LabelPhoneEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String labelId,  String name,  String? avatar,  String? icon,  int priority,  bool isEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LabelPhoneEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.labelId,_that.name,_that.avatar,_that.icon,_that.priority,_that.isEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String labelId,  String name,  String? avatar,  String? icon,  int priority,  bool isEnabled)  $default,) {final _that = this;
switch (_that) {
case _LabelPhoneEntry():
return $default(_that.id,_that.phoneNumber,_that.labelId,_that.name,_that.avatar,_that.icon,_that.priority,_that.isEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  String labelId,  String name,  String? avatar,  String? icon,  int priority,  bool isEnabled)?  $default,) {final _that = this;
switch (_that) {
case _LabelPhoneEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.labelId,_that.name,_that.avatar,_that.icon,_that.priority,_that.isEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LabelPhoneEntry extends LabelPhoneEntry {
  const _LabelPhoneEntry({required this.id, required this.phoneNumber, required this.labelId, this.name = '', this.avatar, this.icon, this.priority = 100, this.isEnabled = true}): super._();
  factory _LabelPhoneEntry.fromJson(Map<String, dynamic> json) => _$LabelPhoneEntryFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  String labelId;
@override@JsonKey() final  String name;
@override final  String? avatar;
@override final  String? icon;
@override@JsonKey() final  int priority;
@override@JsonKey() final  bool isEnabled;

/// Create a copy of LabelPhoneEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabelPhoneEntryCopyWith<_LabelPhoneEntry> get copyWith => __$LabelPhoneEntryCopyWithImpl<_LabelPhoneEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelPhoneEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabelPhoneEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.labelId, labelId) || other.labelId == labelId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,phoneNumber,labelId,name,avatar,icon,priority,isEnabled);
}

@override
String toString() {
    return 'LabelPhoneEntry(id: $id, phoneNumber: $phoneNumber, labelId: $labelId, name: $name, avatar: $avatar, icon: $icon, priority: $priority, isEnabled: $isEnabled)';
}


}

/// @nodoc
abstract mixin class _$LabelPhoneEntryCopyWith<$Res> implements $LabelPhoneEntryCopyWith<$Res> {
  factory _$LabelPhoneEntryCopyWith(_LabelPhoneEntry value, $Res Function(_LabelPhoneEntry) _then) = __$LabelPhoneEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, String labelId, String name, String? avatar, String? icon, int priority, bool isEnabled
});




}
/// @nodoc
class __$LabelPhoneEntryCopyWithImpl<$Res>
    implements _$LabelPhoneEntryCopyWith<$Res> {
  __$LabelPhoneEntryCopyWithImpl(this._self, this._then);

  final _LabelPhoneEntry _self;
  final $Res Function(_LabelPhoneEntry) _then;

/// Create a copy of LabelPhoneEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? labelId = null,Object? name = null,Object? avatar = freezed,Object? icon = freezed,Object? priority = null,Object? isEnabled = null,}) {
  return _then(_LabelPhoneEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,labelId: null == labelId ? _self.labelId : labelId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
