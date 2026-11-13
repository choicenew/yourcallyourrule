// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'caller_id_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallerIdData {

 String get phoneNumber; String? get name; String? get region; String? get countryName; String? get carrier; List<String> get labels; int get localCount; int get pluginCount; int get remoteCount;
/// Create a copy of CallerIdData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallerIdDataCopyWith<CallerIdData> get copyWith => _$CallerIdDataCopyWithImpl<CallerIdData>(this as CallerIdData, _$identity);

  /// Serializes this CallerIdData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CallerIdData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallerIdData&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.region, _this.region) || other.region == _this.region)&&(identical(other.countryName, _this.countryName) || other.countryName == _this.countryName)&&(identical(other.carrier, _this.carrier) || other.carrier == _this.carrier)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.localCount, _this.localCount) || other.localCount == _this.localCount)&&(identical(other.pluginCount, _this.pluginCount) || other.pluginCount == _this.pluginCount)&&(identical(other.remoteCount, _this.remoteCount) || other.remoteCount == _this.remoteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CallerIdData;
  return Object.hash(runtimeType,_this.phoneNumber,_this.name,_this.region,_this.countryName,_this.carrier,const DeepCollectionEquality().hash(_this.labels),_this.localCount,_this.pluginCount,_this.remoteCount);
}

@override
String toString() {
  final _this = this as CallerIdData;
  return 'CallerIdData(phoneNumber: ${_this.phoneNumber}, name: ${_this.name}, region: ${_this.region}, countryName: ${_this.countryName}, carrier: ${_this.carrier}, labels: ${_this.labels}, localCount: ${_this.localCount}, pluginCount: ${_this.pluginCount}, remoteCount: ${_this.remoteCount})';
}


}

/// @nodoc
abstract mixin class $CallerIdDataCopyWith<$Res>  {
  factory $CallerIdDataCopyWith(CallerIdData value, $Res Function(CallerIdData) _then) = _$CallerIdDataCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String? name, String? region, String? countryName, String? carrier, List<String> labels, int localCount, int pluginCount, int remoteCount
});




}
/// @nodoc
class _$CallerIdDataCopyWithImpl<$Res>
    implements $CallerIdDataCopyWith<$Res> {
  _$CallerIdDataCopyWithImpl(this._self, this._then);

  final CallerIdData _self;
  final $Res Function(CallerIdData) _then;

/// Create a copy of CallerIdData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? name = freezed,Object? region = freezed,Object? countryName = freezed,Object? carrier = freezed,Object? labels = null,Object? localCount = null,Object? pluginCount = null,Object? remoteCount = null,}) {
  return _then(CallerIdData(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,countryName: freezed == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,localCount: null == localCount ? _self.localCount : localCount // ignore: cast_nullable_to_non_nullable
as int,pluginCount: null == pluginCount ? _self.pluginCount : pluginCount // ignore: cast_nullable_to_non_nullable
as int,remoteCount: null == remoteCount ? _self.remoteCount : remoteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CallerIdData].
extension CallerIdDataPatterns on CallerIdData {

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallerIdData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallerIdData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallerIdData value)  $default,){
final _that = this;
switch (_that) {
case _CallerIdData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallerIdData value)?  $default,){
final _that = this;
switch (_that) {
case _CallerIdData() when $default != null:
return $default(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String? name,  String? region,  String? countryName,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallerIdData() when $default != null:
return $default(_that.phoneNumber,_that.name,_that.region,_that.countryName,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String? name,  String? region,  String? countryName,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount)  $default,) {final _that = this;
switch (_that) {
case _CallerIdData():
return $default(_that.phoneNumber,_that.name,_that.region,_that.countryName,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String? name,  String? region,  String? countryName,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount)?  $default,) {final _that = this;
switch (_that) {
case _CallerIdData() when $default != null:
return $default(_that.phoneNumber,_that.name,_that.region,_that.countryName,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallerIdData extends CallerIdData {
  const _CallerIdData({required this.phoneNumber, this.name, this.region, this.countryName, this.carrier,  List<String> labels = const [], this.localCount = 0, this.pluginCount = 0, this.remoteCount = 0}): _labels = labels,super._();
  factory _CallerIdData.fromJson(Map<String, dynamic> json) => _$CallerIdDataFromJson(json);

@override final  String phoneNumber;
@override final  String? name;
@override final  String? region;
@override final  String? countryName;
@override final  String? carrier;
 final  List<String> _labels;
@override@JsonKey() List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  return EqualUnmodifiableListView(_labels);
}

@override@JsonKey() final  int localCount;
@override@JsonKey() final  int pluginCount;
@override@JsonKey() final  int remoteCount;

@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallerIdDataCopyWith<_CallerIdData> get copyWith => __$CallerIdDataCopyWithImpl<_CallerIdData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallerIdDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallerIdData&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.carrier, carrier) || other.carrier == carrier)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.localCount, localCount) || other.localCount == localCount)&&(identical(other.pluginCount, pluginCount) || other.pluginCount == pluginCount)&&(identical(other.remoteCount, remoteCount) || other.remoteCount == remoteCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,name,region,countryName,carrier,const DeepCollectionEquality().hash(_labels),localCount,pluginCount,remoteCount);
}

@override
String toString() {
    return 'CallerIdData(phoneNumber: $phoneNumber, name: $name, region: $region, countryName: $countryName, carrier: $carrier, labels: $labels, localCount: $localCount, pluginCount: $pluginCount, remoteCount: $remoteCount)';
}


}

/// @nodoc
abstract mixin class _$CallerIdDataCopyWith<$Res> implements $CallerIdDataCopyWith<$Res> {
  factory _$CallerIdDataCopyWith(_CallerIdData value, $Res Function(_CallerIdData) _then) = __$CallerIdDataCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String? name, String? region, String? countryName, String? carrier, List<String> labels, int localCount, int pluginCount, int remoteCount
});




}
/// @nodoc
class __$CallerIdDataCopyWithImpl<$Res>
    implements _$CallerIdDataCopyWith<$Res> {
  __$CallerIdDataCopyWithImpl(this._self, this._then);

  final _CallerIdData _self;
  final $Res Function(_CallerIdData) _then;

@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? name = freezed,Object? region = freezed,Object? countryName = freezed,Object? carrier = freezed,Object? labels = null,Object? localCount = null,Object? pluginCount = null,Object? remoteCount = null,}) {
  return _then(_CallerIdData(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber
as String,name: freezed == name ? _self.name : name
as String?,region: freezed == region ? _self.region : region
as String?,countryName: freezed == countryName ? _self.countryName : countryName
as String?,carrier: freezed == carrier ? _self.carrier : carrier
as String?,labels: null == labels ? _self._labels : labels
as List<String>,localCount: null == localCount ? _self.localCount : localCount
as int,pluginCount: null == pluginCount ? _self.pluginCount : pluginCount
as int,remoteCount: null == remoteCount ? _self.remoteCount : remoteCount
as int,
  ));
}


}

// dart format on
