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

 String get id; String get displayName; List<String> get phoneNumbers; String? get photoUrl; bool get isStarred;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneContactEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&const DeepCollectionEquality().equals(other.phoneNumbers, _this.phoneNumbers)&&(identical(other.photoUrl, _this.photoUrl) || other.photoUrl == _this.photoUrl)&&(identical(other.isStarred, _this.isStarred) || other.isStarred == _this.isStarred));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PhoneContactEntry;
  return Object.hash(runtimeType,_this.id,_this.displayName,const DeepCollectionEquality().hash(_this.phoneNumbers),_this.photoUrl,_this.isStarred);
}

@override
String toString() {
  final _this = this as PhoneContactEntry;
  return 'PhoneContactEntry(id: ${_this.id}, displayName: ${_this.displayName}, phoneNumbers: ${_this.phoneNumbers}, photoUrl: ${_this.photoUrl}, isStarred: ${_this.isStarred})';
}


}

/// @nodoc
abstract mixin class $PhoneContactEntryCopyWith<$Res>  {
  factory $PhoneContactEntryCopyWith(PhoneContactEntry value, $Res Function(PhoneContactEntry) _then) = _$PhoneContactEntryCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, List<String> phoneNumbers, String? photoUrl, bool isStarred
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? phoneNumbers = null,Object? photoUrl = freezed,Object? isStarred = null,}) {
  return _then(PhoneContactEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,phoneNumbers: null == phoneNumbers ? _self.phoneNumbers : phoneNumbers // ignore: cast_nullable_to_non_nullable
as List<String>,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isStarred: null == isStarred ? _self.isStarred : isStarred // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  List<String> phoneNumbers,  String? photoUrl,  bool isStarred)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneContactEntry() when $default != null:
return $default(_that.id,_that.displayName,_that.phoneNumbers,_that.photoUrl,_that.isStarred);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  List<String> phoneNumbers,  String? photoUrl,  bool isStarred)  $default,) {final _that = this;
switch (_that) {
case _PhoneContactEntry():
return $default(_that.id,_that.displayName,_that.phoneNumbers,_that.photoUrl,_that.isStarred);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  List<String> phoneNumbers,  String? photoUrl,  bool isStarred)?  $default,) {final _that = this;
switch (_that) {
case _PhoneContactEntry() when $default != null:
return $default(_that.id,_that.displayName,_that.phoneNumbers,_that.photoUrl,_that.isStarred);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneContactEntry extends PhoneContactEntry {
  const _PhoneContactEntry({required this.id, required this.displayName, required  List<String> phoneNumbers, this.photoUrl, this.isStarred = false}): _phoneNumbers = phoneNumbers,super._();
  factory _PhoneContactEntry.fromJson(Map<String, dynamic> json) => _$PhoneContactEntryFromJson(json);

@override final  String id;
@override final  String displayName;
 final  List<String> _phoneNumbers;
@override List<String> get phoneNumbers {
  if (_phoneNumbers is EqualUnmodifiableListView) return _phoneNumbers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phoneNumbers);
}

@override final  String? photoUrl;
@override@JsonKey() final  bool isStarred;

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
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneContactEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&const DeepCollectionEquality().equals(other.phoneNumbers, _phoneNumbers)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isStarred, isStarred) || other.isStarred == isStarred));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,const DeepCollectionEquality().hash(_phoneNumbers),photoUrl,isStarred);
}

@override
String toString() {
    return 'PhoneContactEntry(id: $id, displayName: $displayName, phoneNumbers: $phoneNumbers, photoUrl: $photoUrl, isStarred: $isStarred)';
}


}

/// @nodoc
abstract mixin class _$PhoneContactEntryCopyWith<$Res> implements $PhoneContactEntryCopyWith<$Res> {
  factory _$PhoneContactEntryCopyWith(_PhoneContactEntry value, $Res Function(_PhoneContactEntry) _then) = __$PhoneContactEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, List<String> phoneNumbers, String? photoUrl, bool isStarred
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? phoneNumbers = null,Object? photoUrl = freezed,Object? isStarred = null,}) {
  return _then(_PhoneContactEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,phoneNumbers: null == phoneNumbers ? _self._phoneNumbers : phoneNumbers // ignore: cast_nullable_to_non_nullable
as List<String>,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isStarred: null == isStarred ? _self.isStarred : isStarred // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
