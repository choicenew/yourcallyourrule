// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_verification_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServerVerificationReport {

 String get simState; String get finalRisk; String? get deviceId; bool get isRoaming; String? get simCountry; String? get ipCountry; bool get isNumberMatch; int? get riskScore;
/// Create a copy of ServerVerificationReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerVerificationReportCopyWith<ServerVerificationReport> get copyWith => _$ServerVerificationReportCopyWithImpl<ServerVerificationReport>(this as ServerVerificationReport, _$identity);

  /// Serializes this ServerVerificationReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ServerVerificationReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerVerificationReport&&(identical(other.simState, _this.simState) || other.simState == _this.simState)&&(identical(other.finalRisk, _this.finalRisk) || other.finalRisk == _this.finalRisk)&&(identical(other.deviceId, _this.deviceId) || other.deviceId == _this.deviceId)&&(identical(other.isRoaming, _this.isRoaming) || other.isRoaming == _this.isRoaming)&&(identical(other.simCountry, _this.simCountry) || other.simCountry == _this.simCountry)&&(identical(other.ipCountry, _this.ipCountry) || other.ipCountry == _this.ipCountry)&&(identical(other.isNumberMatch, _this.isNumberMatch) || other.isNumberMatch == _this.isNumberMatch)&&(identical(other.riskScore, _this.riskScore) || other.riskScore == _this.riskScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ServerVerificationReport;
  return Object.hash(runtimeType,_this.simState,_this.finalRisk,_this.deviceId,_this.isRoaming,_this.simCountry,_this.ipCountry,_this.isNumberMatch,_this.riskScore);
}

@override
String toString() {
  final _this = this as ServerVerificationReport;
  return 'ServerVerificationReport(simState: ${_this.simState}, finalRisk: ${_this.finalRisk}, deviceId: ${_this.deviceId}, isRoaming: ${_this.isRoaming}, simCountry: ${_this.simCountry}, ipCountry: ${_this.ipCountry}, isNumberMatch: ${_this.isNumberMatch}, riskScore: ${_this.riskScore})';
}


}

/// @nodoc
abstract mixin class $ServerVerificationReportCopyWith<$Res>  {
  factory $ServerVerificationReportCopyWith(ServerVerificationReport value, $Res Function(ServerVerificationReport) _then) = _$ServerVerificationReportCopyWithImpl;
@useResult
$Res call({
 String simState, String finalRisk, String? deviceId, bool isRoaming, String? simCountry, String? ipCountry, bool isNumberMatch, int? riskScore
});




}
/// @nodoc
class _$ServerVerificationReportCopyWithImpl<$Res>
    implements $ServerVerificationReportCopyWith<$Res> {
  _$ServerVerificationReportCopyWithImpl(this._self, this._then);

  final ServerVerificationReport _self;
  final $Res Function(ServerVerificationReport) _then;

/// Create a copy of ServerVerificationReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? simState = null,Object? finalRisk = null,Object? deviceId = freezed,Object? isRoaming = null,Object? simCountry = freezed,Object? ipCountry = freezed,Object? isNumberMatch = null,Object? riskScore = freezed,}) {
  return _then(ServerVerificationReport(
simState: null == simState ? _self.simState : simState // ignore: cast_nullable_to_non_nullable
as String,finalRisk: null == finalRisk ? _self.finalRisk : finalRisk // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,isRoaming: null == isRoaming ? _self.isRoaming : isRoaming // ignore: cast_nullable_to_non_nullable
as bool,simCountry: freezed == simCountry ? _self.simCountry : simCountry // ignore: cast_nullable_to_non_nullable
as String?,ipCountry: freezed == ipCountry ? _self.ipCountry : ipCountry // ignore: cast_nullable_to_non_nullable
as String?,isNumberMatch: null == isNumberMatch ? _self.isNumberMatch : isNumberMatch // ignore: cast_nullable_to_non_nullable
as bool,riskScore: freezed == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerVerificationReport].
extension ServerVerificationReportPatterns on ServerVerificationReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerVerificationReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerVerificationReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerVerificationReport value)  $default,){
final _that = this;
switch (_that) {
case _ServerVerificationReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerVerificationReport value)?  $default,){
final _that = this;
switch (_that) {
case _ServerVerificationReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String simState,  String finalRisk,  String? deviceId,  bool isRoaming,  String? simCountry,  String? ipCountry,  bool isNumberMatch,  int? riskScore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerVerificationReport() when $default != null:
return $default(_that.simState,_that.finalRisk,_that.deviceId,_that.isRoaming,_that.simCountry,_that.ipCountry,_that.isNumberMatch,_that.riskScore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String simState,  String finalRisk,  String? deviceId,  bool isRoaming,  String? simCountry,  String? ipCountry,  bool isNumberMatch,  int? riskScore)  $default,) {final _that = this;
switch (_that) {
case _ServerVerificationReport():
return $default(_that.simState,_that.finalRisk,_that.deviceId,_that.isRoaming,_that.simCountry,_that.ipCountry,_that.isNumberMatch,_that.riskScore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String simState,  String finalRisk,  String? deviceId,  bool isRoaming,  String? simCountry,  String? ipCountry,  bool isNumberMatch,  int? riskScore)?  $default,) {final _that = this;
switch (_that) {
case _ServerVerificationReport() when $default != null:
return $default(_that.simState,_that.finalRisk,_that.deviceId,_that.isRoaming,_that.simCountry,_that.ipCountry,_that.isNumberMatch,_that.riskScore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServerVerificationReport implements ServerVerificationReport {
  const _ServerVerificationReport({required this.simState, required this.finalRisk, this.deviceId, this.isRoaming = false, this.simCountry, this.ipCountry, this.isNumberMatch = false, this.riskScore});
  factory _ServerVerificationReport.fromJson(Map<String, dynamic> json) => _$ServerVerificationReportFromJson(json);

@override final  String simState;
@override final  String finalRisk;
@override final  String? deviceId;
@override@JsonKey() final  bool isRoaming;
@override final  String? simCountry;
@override final  String? ipCountry;
@override@JsonKey() final  bool isNumberMatch;
@override final  int? riskScore;

/// Create a copy of ServerVerificationReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerVerificationReportCopyWith<_ServerVerificationReport> get copyWith => __$ServerVerificationReportCopyWithImpl<_ServerVerificationReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerVerificationReportToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerVerificationReport&&(identical(other.simState, simState) || other.simState == simState)&&(identical(other.finalRisk, finalRisk) || other.finalRisk == finalRisk)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.isRoaming, isRoaming) || other.isRoaming == isRoaming)&&(identical(other.simCountry, simCountry) || other.simCountry == simCountry)&&(identical(other.ipCountry, ipCountry) || other.ipCountry == ipCountry)&&(identical(other.isNumberMatch, isNumberMatch) || other.isNumberMatch == isNumberMatch)&&(identical(other.riskScore, riskScore) || other.riskScore == riskScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,simState,finalRisk,deviceId,isRoaming,simCountry,ipCountry,isNumberMatch,riskScore);
}

@override
String toString() {
    return 'ServerVerificationReport(simState: $simState, finalRisk: $finalRisk, deviceId: $deviceId, isRoaming: $isRoaming, simCountry: $simCountry, ipCountry: $ipCountry, isNumberMatch: $isNumberMatch, riskScore: $riskScore)';
}


}

/// @nodoc
abstract mixin class _$ServerVerificationReportCopyWith<$Res> implements $ServerVerificationReportCopyWith<$Res> {
  factory _$ServerVerificationReportCopyWith(_ServerVerificationReport value, $Res Function(_ServerVerificationReport) _then) = __$ServerVerificationReportCopyWithImpl;
@override @useResult
$Res call({
 String simState, String finalRisk, String? deviceId, bool isRoaming, String? simCountry, String? ipCountry, bool isNumberMatch, int? riskScore
});




}
/// @nodoc
class __$ServerVerificationReportCopyWithImpl<$Res>
    implements _$ServerVerificationReportCopyWith<$Res> {
  __$ServerVerificationReportCopyWithImpl(this._self, this._then);

  final _ServerVerificationReport _self;
  final $Res Function(_ServerVerificationReport) _then;

/// Create a copy of ServerVerificationReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? simState = null,Object? finalRisk = null,Object? deviceId = freezed,Object? isRoaming = null,Object? simCountry = freezed,Object? ipCountry = freezed,Object? isNumberMatch = null,Object? riskScore = freezed,}) {
  return _then(_ServerVerificationReport(
simState: null == simState ? _self.simState : simState // ignore: cast_nullable_to_non_nullable
as String,finalRisk: null == finalRisk ? _self.finalRisk : finalRisk // ignore: cast_nullable_to_non_nullable
as String,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,isRoaming: null == isRoaming ? _self.isRoaming : isRoaming // ignore: cast_nullable_to_non_nullable
as bool,simCountry: freezed == simCountry ? _self.simCountry : simCountry // ignore: cast_nullable_to_non_nullable
as String?,ipCountry: freezed == ipCountry ? _self.ipCountry : ipCountry // ignore: cast_nullable_to_non_nullable
as String?,isNumberMatch: null == isNumberMatch ? _self.isNumberMatch : isNumberMatch // ignore: cast_nullable_to_non_nullable
as bool,riskScore: freezed == riskScore ? _self.riskScore : riskScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
