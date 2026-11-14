// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_contact_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneContactEntry {

 String get id; String get phoneNumber; String get name; String? get avatar; String? get url; String? get note; String? get labelIds; int get isFavorite; String get lastUpdated;
/// Create a copy of PhoneContactEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneContactEntryCopyWith<PhoneContactEntry> get copyWith => _$PhoneContactEntryCopyWithImpl<PhoneContactEntry>(this as PhoneContactEntry, _$identity);

  /// Serializes this PhoneContactEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PhoneContactEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneContactEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.labelIds, _this.labelIds) || other.labelIds == _this.labelIds)&&(identical(other.isFavorite, _this.isFavorite) || other.isFavorite == _this.isFavorite)&&(identical(other.lastUpdated, _this.lastUpdated) || other.lastUpdated == _this.lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneContactEntry;
  return Object.hash(runtimeType,_this.id,_this.phoneNumber,_this.name,_this.avatar,_this.url,_this.note,_this.labelIds,_this.isFavorite,_this.lastUpdated);
}

@override
String toString() {
  final _this = this as PhoneContactEntry;
  return 'PhoneContactEntry(id: ${_this.id}, phoneNumber: ${_this.phoneNumber}, name: ${_this.name}, avatar: ${_this.avatar}, url: ${_this.url}, note: ${_this.note}, labelIds: ${_this.labelIds}, isFavorite: ${_this.isFavorite}, lastUpdated: ${_this.lastUpdated})';
}


}

/// @nodoc
abstract mixin class $PhoneContactEntryCopyWith<$Res>  {
  factory $PhoneContactEntryCopyWith(PhoneContactEntry value, $Res Function(PhoneContactEntry) _then) = _$PhoneContactEntryCopyWithImpl;
@useResult
$Res call({
 String id, String phoneNumber, String name, String? avatar, String? url, String? note, String? labelIds, int isFavorite, String lastUpdated
});




}
/// @nodoc
class _$PhoneContactEntryCopyWithImpl<$Res>
    implements $PhoneContactEntryCopyWith<$Res> {
  _$PhoneContactEntryCopyWithImpl(this._self, this._then);

  final PhoneContactEntry _self;
  final $Res Function(PhoneContactEntry) _then;

/// Create a copy of PhoneContactEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phoneNumber = null,Object? name = null,Object? avatar = freezed,Object? url = freezed,Object? note = freezed,Object? labelIds = freezed,Object? isFavorite = null,Object? lastUpdated = null,}) {
  return _then(PhoneContactEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,labelIds: freezed == labelIds ? _self.labelIds : labelIds // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneContactEntry].
extension PhoneContactEntryPatterns on PhoneContactEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneContactEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneContactEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneContactEntry value)  $default,){
final _that = this;
switch (_that) {
case _PhoneContactEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneContactEntry value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneContactEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String name,  String? avatar,  String? url,  String? note,  String? labelIds,  int isFavorite,  String lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneContactEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.name,_that.avatar,_that.url,_that.note,_that.labelIds,_that.isFavorite,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String phoneNumber,  String name,  String? avatar,  String? url,  String? note,  String? labelIds,  int isFavorite,  String lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _PhoneContactEntry():
return $default(_that.id,_that.phoneNumber,_that.name,_that.avatar,_that.url,_that.note,_that.labelIds,_that.isFavorite,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String phoneNumber,  String name,  String? avatar,  String? url,  String? note,  String? labelIds,  int isFavorite,  String lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _PhoneContactEntry() when $default != null:
return $default(_that.id,_that.phoneNumber,_that.name,_that.avatar,_that.url,_that.note,_that.labelIds,_that.isFavorite,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneContactEntry extends PhoneContactEntry {
  const _PhoneContactEntry({required this.id, required this.phoneNumber, required this.name, this.avatar, this.url, this.note, this.labelIds, this.isFavorite = 0, this.lastUpdated = ''}): super._();
  factory _PhoneContactEntry.fromJson(Map<String, dynamic> json) => _$PhoneContactEntryFromJson(json);

@override final  String id;
@override final  String phoneNumber;
@override final  String name;
@override final  String? avatar;
@override final  String? url;
@override final  String? note;
@override final  String? labelIds;
@override@JsonKey() final  int isFavorite;
@override@JsonKey() final  String lastUpdated;

/// Create a copy of PhoneContactEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneContactEntryCopyWith<_PhoneContactEntry> get copyWith => __$PhoneContactEntryCopyWithImpl<_PhoneContactEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneContactEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneContactEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.url, url) || other.url == url)&&(identical(other.note, note) || other.note == note)&&(identical(other.labelIds, labelIds) || other.labelIds == labelIds)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,phoneNumber,name,avatar,url,note,labelIds,isFavorite,lastUpdated);
}

@override
String toString() {
    return 'PhoneContactEntry(id: $id, phoneNumber: $phoneNumber, name: $name, avatar: $avatar, url: $url, note: $note, labelIds: $labelIds, isFavorite: $isFavorite, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$PhoneContactEntryCopyWith<$Res> implements $PhoneContactEntryCopyWith<$Res> {
  factory _$PhoneContactEntryCopyWith(_PhoneContactEntry value, $Res Function(_PhoneContactEntry) _then) = __$PhoneContactEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String phoneNumber, String name, String? avatar, String? url, String? note, String? labelIds, int isFavorite, String lastUpdated
});




}
/// @nodoc
class __$PhoneContactEntryCopyWithImpl<$Res>
    implements _$PhoneContactEntryCopyWith<$Res> {
  __$PhoneContactEntryCopyWithImpl(this._self, this._then);

  final _PhoneContactEntry _self;
  final $Res Function(_PhoneContactEntry) _then;

/// Create a copy of PhoneContactEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phoneNumber = null,Object? name = null,Object? avatar = freezed,Object? url = freezed,Object? note = freezed,Object? labelIds = freezed,Object? isFavorite = null,Object? lastUpdated = null,}) {
  return _then(_PhoneContactEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,labelIds: freezed == labelIds ? _self.labelIds : labelIds // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
