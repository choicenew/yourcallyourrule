// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_version_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppVersionInfo {

 String get latestVersion; int get versionCode; String get downloadUrl; String? get releaseNotes; bool get isForceUpdate;
/// Create a copy of AppVersionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppVersionInfoCopyWith<AppVersionInfo> get copyWith => _$AppVersionInfoCopyWithImpl<AppVersionInfo>(this as AppVersionInfo, _$identity);

  /// Serializes this AppVersionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppVersionInfo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppVersionInfo&&(identical(other.latestVersion, _this.latestVersion) || other.latestVersion == _this.latestVersion)&&(identical(other.versionCode, _this.versionCode) || other.versionCode == _this.versionCode)&&(identical(other.downloadUrl, _this.downloadUrl) || other.downloadUrl == _this.downloadUrl)&&(identical(other.releaseNotes, _this.releaseNotes) || other.releaseNotes == _this.releaseNotes)&&(identical(other.isForceUpdate, _this.isForceUpdate) || other.isForceUpdate == _this.isForceUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppVersionInfo;
  return Object.hash(runtimeType,_this.latestVersion,_this.versionCode,_this.downloadUrl,_this.releaseNotes,_this.isForceUpdate);
}

@override
String toString() {
  final _this = this as AppVersionInfo;
  return 'AppVersionInfo(latestVersion: ${_this.latestVersion}, versionCode: ${_this.versionCode}, downloadUrl: ${_this.downloadUrl}, releaseNotes: ${_this.releaseNotes}, isForceUpdate: ${_this.isForceUpdate})';
}


}

/// @nodoc
abstract mixin class $AppVersionInfoCopyWith<$Res>  {
  factory $AppVersionInfoCopyWith(AppVersionInfo value, $Res Function(AppVersionInfo) _then) = _$AppVersionInfoCopyWithImpl;
@useResult
$Res call({
 String latestVersion, int versionCode, String downloadUrl, String? releaseNotes, bool isForceUpdate
});




}
/// @nodoc
class _$AppVersionInfoCopyWithImpl<$Res>
    implements $AppVersionInfoCopyWith<$Res> {
  _$AppVersionInfoCopyWithImpl(this._self, this._then);

  final AppVersionInfo _self;
  final $Res Function(AppVersionInfo) _then;

/// Create a copy of AppVersionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latestVersion = null,Object? versionCode = null,Object? downloadUrl = null,Object? releaseNotes = freezed,Object? isForceUpdate = null,}) {
  return _then(AppVersionInfo(
latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,versionCode: null == versionCode ? _self.versionCode : versionCode // ignore: cast_nullable_to_non_nullable
as int,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,isForceUpdate: null == isForceUpdate ? _self.isForceUpdate : isForceUpdate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppVersionInfo].
extension AppVersionInfoPatterns on AppVersionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppVersionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppVersionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppVersionInfo value)  $default,){
final _that = this;
switch (_that) {
case _AppVersionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppVersionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _AppVersionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String latestVersion,  int versionCode,  String downloadUrl,  String? releaseNotes,  bool isForceUpdate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppVersionInfo() when $default != null:
return $default(_that.latestVersion,_that.versionCode,_that.downloadUrl,_that.releaseNotes,_that.isForceUpdate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String latestVersion,  int versionCode,  String downloadUrl,  String? releaseNotes,  bool isForceUpdate)  $default,) {final _that = this;
switch (_that) {
case _AppVersionInfo():
return $default(_that.latestVersion,_that.versionCode,_that.downloadUrl,_that.releaseNotes,_that.isForceUpdate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String latestVersion,  int versionCode,  String downloadUrl,  String? releaseNotes,  bool isForceUpdate)?  $default,) {final _that = this;
switch (_that) {
case _AppVersionInfo() when $default != null:
return $default(_that.latestVersion,_that.versionCode,_that.downloadUrl,_that.releaseNotes,_that.isForceUpdate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppVersionInfo extends AppVersionInfo {
  const _AppVersionInfo({required this.latestVersion, required this.versionCode, required this.downloadUrl, this.releaseNotes, this.isForceUpdate = false}): super._();
  factory _AppVersionInfo.fromJson(Map<String, dynamic> json) => _$AppVersionInfoFromJson(json);

@override final  String latestVersion;
@override final  int versionCode;
@override final  String downloadUrl;
@override final  String? releaseNotes;
@override@JsonKey() final  bool isForceUpdate;

/// Create a copy of AppVersionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppVersionInfoCopyWith<_AppVersionInfo> get copyWith => __$AppVersionInfoCopyWithImpl<_AppVersionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppVersionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppVersionInfo&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.versionCode, versionCode) || other.versionCode == versionCode)&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes)&&(identical(other.isForceUpdate, isForceUpdate) || other.isForceUpdate == isForceUpdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,latestVersion,versionCode,downloadUrl,releaseNotes,isForceUpdate);
}

@override
String toString() {
    return 'AppVersionInfo(latestVersion: $latestVersion, versionCode: $versionCode, downloadUrl: $downloadUrl, releaseNotes: $releaseNotes, isForceUpdate: $isForceUpdate)';
}


}

/// @nodoc
abstract mixin class _$AppVersionInfoCopyWith<$Res> implements $AppVersionInfoCopyWith<$Res> {
  factory _$AppVersionInfoCopyWith(_AppVersionInfo value, $Res Function(_AppVersionInfo) _then) = __$AppVersionInfoCopyWithImpl;
@override @useResult
$Res call({
 String latestVersion, int versionCode, String downloadUrl, String? releaseNotes, bool isForceUpdate
});




}
/// @nodoc
class __$AppVersionInfoCopyWithImpl<$Res>
    implements _$AppVersionInfoCopyWith<$Res> {
  __$AppVersionInfoCopyWithImpl(this._self, this._then);

  final _AppVersionInfo _self;
  final $Res Function(_AppVersionInfo) _then;

/// Create a copy of AppVersionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latestVersion = null,Object? versionCode = null,Object? downloadUrl = null,Object? releaseNotes = freezed,Object? isForceUpdate = null,}) {
  return _then(_AppVersionInfo(
latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,versionCode: null == versionCode ? _self.versionCode : versionCode // ignore: cast_nullable_to_non_nullable
as int,downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,isForceUpdate: null == isForceUpdate ? _self.isForceUpdate : isForceUpdate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
