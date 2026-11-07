// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plugin_source_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PluginSourceData {

 String? get predefinedLabel; String? get sourceLabel; String? get avatar; int? get count; String? get province; String? get city; String? get carrier; String? get name; String? get phoneNumber; String get actionName;
/// Create a copy of PluginSourceData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PluginSourceDataCopyWith<PluginSourceData> get copyWith => _$PluginSourceDataCopyWithImpl<PluginSourceData>(this as PluginSourceData, _$identity);

  /// Serializes this PluginSourceData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PluginSourceData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PluginSourceData&&(identical(other.predefinedLabel, _this.predefinedLabel) || other.predefinedLabel == _this.predefinedLabel)&&(identical(other.sourceLabel, _this.sourceLabel) || other.sourceLabel == _this.sourceLabel)&&(identical(other.avatar, _this.avatar) || other.avatar == _this.avatar)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.province, _this.province) || other.province == _this.province)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.carrier, _this.carrier) || other.carrier == _this.carrier)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.actionName, _this.actionName) || other.actionName == _this.actionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PluginSourceData;
  return Object.hash(runtimeType,_this.predefinedLabel,_this.sourceLabel,_this.avatar,_this.count,_this.province,_this.city,_this.carrier,_this.name,_this.phoneNumber,_this.actionName);
}

@override
String toString() {
  final _this = this as PluginSourceData;
  return 'PluginSourceData(predefinedLabel: ${_this.predefinedLabel}, sourceLabel: ${_this.sourceLabel}, avatar: ${_this.avatar}, count: ${_this.count}, province: ${_this.province}, city: ${_this.city}, carrier: ${_this.carrier}, name: ${_this.name}, phoneNumber: ${_this.phoneNumber}, actionName: ${_this.actionName})';
}


}

/// @nodoc
abstract mixin class $PluginSourceDataCopyWith<$Res>  {
  factory $PluginSourceDataCopyWith(PluginSourceData value, $Res Function(PluginSourceData) _then) = _$PluginSourceDataCopyWithImpl;
@useResult
$Res call({
 String? predefinedLabel, String? sourceLabel, String? avatar, int? count, String? province, String? city, String? carrier, String? name, String? phoneNumber, String actionName
});




}
/// @nodoc
class _$PluginSourceDataCopyWithImpl<$Res>
    implements $PluginSourceDataCopyWith<$Res> {
  _$PluginSourceDataCopyWithImpl(this._self, this._then);

  final PluginSourceData _self;
  final $Res Function(PluginSourceData) _then;

/// Create a copy of PluginSourceData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? predefinedLabel = freezed,Object? sourceLabel = freezed,Object? avatar = freezed,Object? count = freezed,Object? province = freezed,Object? city = freezed,Object? carrier = freezed,Object? name = freezed,Object? phoneNumber = freezed,Object? actionName = null,}) {
  return _then(PluginSourceData(
predefinedLabel: freezed == predefinedLabel ? _self.predefinedLabel : predefinedLabel // ignore: cast_nullable_to_non_nullable
as String?,sourceLabel: freezed == sourceLabel ? _self.sourceLabel : sourceLabel // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,actionName: null == actionName ? _self.actionName : actionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PluginSourceData].
extension PluginSourceDataPatterns on PluginSourceData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PluginSourceData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PluginSourceData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PluginSourceData value)  $default,){
final _that = this;
switch (_that) {
case _PluginSourceData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PluginSourceData value)?  $default,){
final _that = this;
switch (_that) {
case _PluginSourceData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? predefinedLabel,  String? sourceLabel,  String? avatar,  int? count,  String? province,  String? city,  String? carrier,  String? name,  String? phoneNumber,  String actionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PluginSourceData() when $default != null:
return $default(_that.predefinedLabel,_that.sourceLabel,_that.avatar,_that.count,_that.province,_that.city,_that.carrier,_that.name,_that.phoneNumber,_that.actionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? predefinedLabel,  String? sourceLabel,  String? avatar,  int? count,  String? province,  String? city,  String? carrier,  String? name,  String? phoneNumber,  String actionName)  $default,) {final _that = this;
switch (_that) {
case _PluginSourceData():
return $default(_that.predefinedLabel,_that.sourceLabel,_that.avatar,_that.count,_that.province,_that.city,_that.carrier,_that.name,_that.phoneNumber,_that.actionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? predefinedLabel,  String? sourceLabel,  String? avatar,  int? count,  String? province,  String? city,  String? carrier,  String? name,  String? phoneNumber,  String actionName)?  $default,) {final _that = this;
switch (_that) {
case _PluginSourceData() when $default != null:
return $default(_that.predefinedLabel,_that.sourceLabel,_that.avatar,_that.count,_that.province,_that.city,_that.carrier,_that.name,_that.phoneNumber,_that.actionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PluginSourceData extends PluginSourceData {
  const _PluginSourceData({this.predefinedLabel, this.sourceLabel, this.avatar, this.count, this.province, this.city, this.carrier, this.name, this.phoneNumber, this.actionName = 'none'}): super._();
  factory _PluginSourceData.fromJson(Map<String, dynamic> json) => _$PluginSourceDataFromJson(json);

@override final  String? predefinedLabel;
@override final  String? sourceLabel;
@override final  String? avatar;
@override final  int? count;
@override final  String? province;
@override final  String? city;
@override final  String? carrier;
@override final  String? name;
@override final  String? phoneNumber;
@override@JsonKey() final  String actionName;

/// Create a copy of PluginSourceData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PluginSourceDataCopyWith<_PluginSourceData> get copyWith => __$PluginSourceDataCopyWithImpl<_PluginSourceData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PluginSourceDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PluginSourceData&&(identical(other.predefinedLabel, predefinedLabel) || other.predefinedLabel == predefinedLabel)&&(identical(other.sourceLabel, sourceLabel) || other.sourceLabel == sourceLabel)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.count, count) || other.count == count)&&(identical(other.province, province) || other.province == province)&&(identical(other.city, city) || other.city == city)&&(identical(other.carrier, carrier) || other.carrier == carrier)&&(identical(other.name, name) || other.name == name)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.actionName, actionName) || other.actionName == actionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,predefinedLabel,sourceLabel,avatar,count,province,city,carrier,name,phoneNumber,actionName);
}

@override
String toString() {
    return 'PluginSourceData(predefinedLabel: $predefinedLabel, sourceLabel: $sourceLabel, avatar: $avatar, count: $count, province: $province, city: $city, carrier: $carrier, name: $name, phoneNumber: $phoneNumber, actionName: $actionName)';
}


}

/// @nodoc
abstract mixin class _$PluginSourceDataCopyWith<$Res> implements $PluginSourceDataCopyWith<$Res> {
  factory _$PluginSourceDataCopyWith(_PluginSourceData value, $Res Function(_PluginSourceData) _then) = __$PluginSourceDataCopyWithImpl;
@override @useResult
$Res call({
 String? predefinedLabel, String? sourceLabel, String? avatar, int? count, String? province, String? city, String? carrier, String? name, String? phoneNumber, String actionName
});




}
/// @nodoc
class __$PluginSourceDataCopyWithImpl<$Res>
    implements _$PluginSourceDataCopyWith<$Res> {
  __$PluginSourceDataCopyWithImpl(this._self, this._then);

  final _PluginSourceData _self;
  final $Res Function(_PluginSourceData) _then;

/// Create a copy of PluginSourceData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? predefinedLabel = freezed,Object? sourceLabel = freezed,Object? avatar = freezed,Object? count = freezed,Object? province = freezed,Object? city = freezed,Object? carrier = freezed,Object? name = freezed,Object? phoneNumber = freezed,Object? actionName = null,}) {
  return _then(_PluginSourceData(
predefinedLabel: freezed == predefinedLabel ? _self.predefinedLabel : predefinedLabel // ignore: cast_nullable_to_non_nullable
as String?,sourceLabel: freezed == sourceLabel ? _self.sourceLabel : sourceLabel // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,province: freezed == province ? _self.province : province // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,actionName: null == actionName ? _self.actionName : actionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
