// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_coordinator_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallCoordinatorData {

 String get phoneNumber; String? get name; String? get region; String? get carrier; List<String> get labels; int get localCount; int get pluginCount; int get remoteCount; String get actionName;
/// Create a copy of CallCoordinatorData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallCoordinatorDataCopyWith<CallCoordinatorData> get copyWith => _$CallCoordinatorDataCopyWithImpl<CallCoordinatorData>(this as CallCoordinatorData, _$identity);

  /// Serializes this CallCoordinatorData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CallCoordinatorData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallCoordinatorData&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.region, _this.region) || other.region == _this.region)&&(identical(other.carrier, _this.carrier) || other.carrier == _this.carrier)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.localCount, _this.localCount) || other.localCount == _this.localCount)&&(identical(other.pluginCount, _this.pluginCount) || other.pluginCount == _this.pluginCount)&&(identical(other.remoteCount, _this.remoteCount) || other.remoteCount == _this.remoteCount)&&(identical(other.actionName, _this.actionName) || other.actionName == _this.actionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CallCoordinatorData;
  return Object.hash(runtimeType,_this.phoneNumber,_this.name,_this.region,_this.carrier,const DeepCollectionEquality().hash(_this.labels),_this.localCount,_this.pluginCount,_this.remoteCount,_this.actionName);
}

@override
String toString() {
  final _this = this as CallCoordinatorData;
  return 'CallCoordinatorData(phoneNumber: ${_this.phoneNumber}, name: ${_this.name}, region: ${_this.region}, carrier: ${_this.carrier}, labels: ${_this.labels}, localCount: ${_this.localCount}, pluginCount: ${_this.pluginCount}, remoteCount: ${_this.remoteCount}, actionName: ${_this.actionName})';
}


}

/// @nodoc
abstract mixin class $CallCoordinatorDataCopyWith<$Res>  {
  factory $CallCoordinatorDataCopyWith(CallCoordinatorData value, $Res Function(CallCoordinatorData) _then) = _$CallCoordinatorDataCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String? name, String? region, String? carrier, List<String> labels, int localCount, int pluginCount, int remoteCount, String actionName
});




}
/// @nodoc
class _$CallCoordinatorDataCopyWithImpl<$Res>
    implements $CallCoordinatorDataCopyWith<$Res> {
  _$CallCoordinatorDataCopyWithImpl(this._self, this._then);

  final CallCoordinatorData _self;
  final $Res Function(CallCoordinatorData) _then;

/// Create a copy of CallCoordinatorData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? name = freezed,Object? region = freezed,Object? carrier = freezed,Object? labels = null,Object? localCount = null,Object? pluginCount = null,Object? remoteCount = null,Object? actionName = null,}) {
  return _then(CallCoordinatorData(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,localCount: null == localCount ? _self.localCount : localCount // ignore: cast_nullable_to_non_nullable
as int,pluginCount: null == pluginCount ? _self.pluginCount : pluginCount // ignore: cast_nullable_to_non_nullable
as int,remoteCount: null == remoteCount ? _self.remoteCount : remoteCount // ignore: cast_nullable_to_non_nullable
as int,actionName: null == actionName ? _self.actionName : actionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CallCoordinatorData].
extension CallCoordinatorDataPatterns on CallCoordinatorData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallCoordinatorData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallCoordinatorData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallCoordinatorData value)  $default,){
final _that = this;
switch (_that) {
case _CallCoordinatorData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallCoordinatorData value)?  $default,){
final _that = this;
switch (_that) {
case _CallCoordinatorData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String? name,  String? region,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount,  String actionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallCoordinatorData() when $default != null:
return $default(_that.phoneNumber,_that.name,_that.region,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount,_that.actionName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String? name,  String? region,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount,  String actionName)  $default,) {final _that = this;
switch (_that) {
case _CallCoordinatorData():
return $default(_that.phoneNumber,_that.name,_that.region,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount,_that.actionName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String? name,  String? region,  String? carrier,  List<String> labels,  int localCount,  int pluginCount,  int remoteCount,  String actionName)?  $default,) {final _that = this;
switch (_that) {
case _CallCoordinatorData() when $default != null:
return $default(_that.phoneNumber,_that.name,_that.region,_that.carrier,_that.labels,_that.localCount,_that.pluginCount,_that.remoteCount,_that.actionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallCoordinatorData extends CallCoordinatorData {
  const _CallCoordinatorData({required this.phoneNumber, this.name, this.region, this.carrier,  List<String> labels = const [], this.localCount = 0, this.pluginCount = 0, this.remoteCount = 0, this.actionName = 'allow'}): _labels = labels,super._();
  factory _CallCoordinatorData.fromJson(Map<String, dynamic> json) => _$CallCoordinatorDataFromJson(json);

@override final  String phoneNumber;
@override final  String? name;
@override final  String? region;
@override final  String? carrier;
 final  List<String> _labels;
@override@JsonKey() List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override@JsonKey() final  int localCount;
@override@JsonKey() final  int pluginCount;
@override@JsonKey() final  int remoteCount;
@override@JsonKey() final  String actionName;

/// Create a copy of CallCoordinatorData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallCoordinatorDataCopyWith<_CallCoordinatorData> get copyWith => __$CallCoordinatorDataCopyWithImpl<_CallCoordinatorData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallCoordinatorDataToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallCoordinatorData&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.carrier, carrier) || other.carrier == carrier)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.localCount, localCount) || other.localCount == localCount)&&(identical(other.pluginCount, pluginCount) || other.pluginCount == pluginCount)&&(identical(other.remoteCount, remoteCount) || other.remoteCount == remoteCount)&&(identical(other.actionName, actionName) || other.actionName == actionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,name,region,carrier,const DeepCollectionEquality().hash(_labels),localCount,pluginCount,remoteCount,actionName);
}

@override
String toString() {
    return 'CallCoordinatorData(phoneNumber: $phoneNumber, name: $name, region: $region, carrier: $carrier, labels: $labels, localCount: $localCount, pluginCount: $pluginCount, remoteCount: $remoteCount, actionName: $actionName)';
}


}

/// @nodoc
abstract mixin class _$CallCoordinatorDataCopyWith<$Res> implements $CallCoordinatorDataCopyWith<$Res> {
  factory _$CallCoordinatorDataCopyWith(_CallCoordinatorData value, $Res Function(_CallCoordinatorData) _then) = __$CallCoordinatorDataCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String? name, String? region, String? carrier, List<String> labels, int localCount, int pluginCount, int remoteCount, String actionName
});




}
/// @nodoc
class __$CallCoordinatorDataCopyWithImpl<$Res>
    implements _$CallCoordinatorDataCopyWith<$Res> {
  __$CallCoordinatorDataCopyWithImpl(this._self, this._then);

  final _CallCoordinatorData _self;
  final $Res Function(_CallCoordinatorData) _then;

/// Create a copy of CallCoordinatorData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? name = freezed,Object? region = freezed,Object? carrier = freezed,Object? labels = null,Object? localCount = null,Object? pluginCount = null,Object? remoteCount = null,Object? actionName = null,}) {
  return _then(_CallCoordinatorData(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,carrier: freezed == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as String?,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,localCount: null == localCount ? _self.localCount : localCount // ignore: cast_nullable_to_non_nullable
as int,pluginCount: null == pluginCount ? _self.pluginCount : pluginCount // ignore: cast_nullable_to_non_nullable
as int,remoteCount: null == remoteCount ? _self.remoteCount : remoteCount // ignore: cast_nullable_to_non_nullable
as int,actionName: null == actionName ? _self.actionName : actionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
