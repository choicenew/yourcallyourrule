// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proposal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Proposal {

/// 提议的电话号码 (主键)。
 String get phoneNumber;/// 提议的起始时间。
 DateTime get proposalStartTime;/// 提议的当前状态 (pending, approved, rejected, etc.)。
 ProposalStatus get status;/// 在所有提交的验证报告中记录到的最高风险等级强类型枚举。
 RiskLevel get highestRiskLevel;/// 此号码被提议删除的总次数。
 int get proposalCount;/// 提议者被验证为号码所有者的次数。
 int get verifiedOwnerCount;/// 此记录在数据库中最后一次被更新的时间。
 DateTime get lastUpdated;/// 包含详细验证报告的原始JSON字符串。
/// `reason` 字段被封装在此JSON中。
 String? get verificationReportJson;/// 【MODIFIED】: 新增了 `labelsJson` 字段，以匹配从服务器同步回来的数据。
 String? get labelsJson;
/// Create a copy of Proposal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProposalCopyWith<Proposal> get copyWith => _$ProposalCopyWithImpl<Proposal>(this as Proposal, _$identity);

  /// Serializes this Proposal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Proposal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Proposal&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.proposalStartTime, _this.proposalStartTime) || other.proposalStartTime == _this.proposalStartTime)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.highestRiskLevel, _this.highestRiskLevel) || other.highestRiskLevel == _this.highestRiskLevel)&&(identical(other.proposalCount, _this.proposalCount) || other.proposalCount == _this.proposalCount)&&(identical(other.verifiedOwnerCount, _this.verifiedOwnerCount) || other.verifiedOwnerCount == _this.verifiedOwnerCount)&&(identical(other.lastUpdated, _this.lastUpdated) || other.lastUpdated == _this.lastUpdated)&&(identical(other.verificationReportJson, _this.verificationReportJson) || other.verificationReportJson == _this.verificationReportJson)&&(identical(other.labelsJson, _this.labelsJson) || other.labelsJson == _this.labelsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Proposal;
  return Object.hash(runtimeType,_this.phoneNumber,_this.proposalStartTime,_this.status,_this.highestRiskLevel,_this.proposalCount,_this.verifiedOwnerCount,_this.lastUpdated,_this.verificationReportJson,_this.labelsJson);
}

@override
String toString() {
  final _this = this as Proposal;
  return 'Proposal(phoneNumber: ${_this.phoneNumber}, proposalStartTime: ${_this.proposalStartTime}, status: ${_this.status}, highestRiskLevel: ${_this.highestRiskLevel}, proposalCount: ${_this.proposalCount}, verifiedOwnerCount: ${_this.verifiedOwnerCount}, lastUpdated: ${_this.lastUpdated}, verificationReportJson: ${_this.verificationReportJson}, labelsJson: ${_this.labelsJson})';
}


}

/// @nodoc
abstract mixin class $ProposalCopyWith<$Res>  {
  factory $ProposalCopyWith(Proposal value, $Res Function(Proposal) _then) = _$ProposalCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, DateTime proposalStartTime, ProposalStatus status, RiskLevel highestRiskLevel, int proposalCount, int verifiedOwnerCount, DateTime lastUpdated, String? verificationReportJson, String? labelsJson
});




}
/// @nodoc
class _$ProposalCopyWithImpl<$Res>
    implements $ProposalCopyWith<$Res> {
  _$ProposalCopyWithImpl(this._self, this._then);

  final Proposal _self;
  final $Res Function(Proposal) _then;

/// Create a copy of Proposal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? proposalStartTime = null,Object? status = null,Object? highestRiskLevel = null,Object? proposalCount = null,Object? verifiedOwnerCount = null,Object? lastUpdated = null,Object? verificationReportJson = freezed,Object? labelsJson = freezed,}) {
  return _then(Proposal(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,proposalStartTime: null == proposalStartTime ? _self.proposalStartTime : proposalStartTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProposalStatus,highestRiskLevel: null == highestRiskLevel ? _self.highestRiskLevel : highestRiskLevel // ignore: cast_nullable_to_non_nullable
as RiskLevel,proposalCount: null == proposalCount ? _self.proposalCount : proposalCount // ignore: cast_nullable_to_non_nullable
as int,verifiedOwnerCount: null == verifiedOwnerCount ? _self.verifiedOwnerCount : verifiedOwnerCount // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,verificationReportJson: freezed == verificationReportJson ? _self.verificationReportJson : verificationReportJson // ignore: cast_nullable_to_non_nullable
as String?,labelsJson: freezed == labelsJson ? _self.labelsJson : labelsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Proposal].
extension ProposalPatterns on Proposal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Proposal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Proposal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Proposal value)  $default,){
final _that = this;
switch (_that) {
case _Proposal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Proposal value)?  $default,){
final _that = this;
switch (_that) {
case _Proposal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  DateTime proposalStartTime,  ProposalStatus status,  RiskLevel highestRiskLevel,  int proposalCount,  int verifiedOwnerCount,  DateTime lastUpdated,  String? verificationReportJson,  String? labelsJson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Proposal() when $default != null:
return $default(_that.phoneNumber,_that.proposalStartTime,_that.status,_that.highestRiskLevel,_that.proposalCount,_that.verifiedOwnerCount,_that.lastUpdated,_that.verificationReportJson,_that.labelsJson);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  DateTime proposalStartTime,  ProposalStatus status,  RiskLevel highestRiskLevel,  int proposalCount,  int verifiedOwnerCount,  DateTime lastUpdated,  String? verificationReportJson,  String? labelsJson)  $default,) {final _that = this;
switch (_that) {
case _Proposal():
return $default(_that.phoneNumber,_that.proposalStartTime,_that.status,_that.highestRiskLevel,_that.proposalCount,_that.verifiedOwnerCount,_that.lastUpdated,_that.verificationReportJson,_that.labelsJson);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  DateTime proposalStartTime,  ProposalStatus status,  RiskLevel highestRiskLevel,  int proposalCount,  int verifiedOwnerCount,  DateTime lastUpdated,  String? verificationReportJson,  String? labelsJson)?  $default,) {final _that = this;
switch (_that) {
case _Proposal() when $default != null:
return $default(_that.phoneNumber,_that.proposalStartTime,_that.status,_that.highestRiskLevel,_that.proposalCount,_that.verifiedOwnerCount,_that.lastUpdated,_that.verificationReportJson,_that.labelsJson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Proposal extends Proposal {
  const _Proposal({required this.phoneNumber, required this.proposalStartTime, required this.status, required this.highestRiskLevel, required this.proposalCount, required this.verifiedOwnerCount, required this.lastUpdated, this.verificationReportJson, this.labelsJson}): super._();
  factory _Proposal.fromJson(Map<String, dynamic> json) => _$ProposalFromJson(json);

/// 提议的电话号码 (主键)。
@override final  String phoneNumber;
/// 提议的起始时间。
@override final  DateTime proposalStartTime;
/// 提议的当前状态 (pending, approved, rejected, etc.)。
@override final  ProposalStatus status;
/// 在所有提交的验证报告中记录到的最高风险等级强类型枚举。
@override final  RiskLevel highestRiskLevel;
/// 此号码被提议删除的总次数。
@override final  int proposalCount;
/// 提议者被验证为号码所有者的次数。
@override final  int verifiedOwnerCount;
/// 此记录在数据库中最后一次被更新的时间。
@override final  DateTime lastUpdated;
/// 包含详细验证报告的原始JSON字符串。
/// `reason` 字段被封装在此JSON中。
@override final  String? verificationReportJson;
/// 【MODIFIED】: 新增了 `labelsJson` 字段，以匹配从服务器同步回来的数据。
@override final  String? labelsJson;

/// Create a copy of Proposal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProposalCopyWith<_Proposal> get copyWith => __$ProposalCopyWithImpl<_Proposal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProposalToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Proposal&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.proposalStartTime, proposalStartTime) || other.proposalStartTime == proposalStartTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.highestRiskLevel, highestRiskLevel) || other.highestRiskLevel == highestRiskLevel)&&(identical(other.proposalCount, proposalCount) || other.proposalCount == proposalCount)&&(identical(other.verifiedOwnerCount, verifiedOwnerCount) || other.verifiedOwnerCount == verifiedOwnerCount)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.verificationReportJson, verificationReportJson) || other.verificationReportJson == verificationReportJson)&&(identical(other.labelsJson, labelsJson) || other.labelsJson == labelsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,proposalStartTime,status,highestRiskLevel,proposalCount,verifiedOwnerCount,lastUpdated,verificationReportJson,labelsJson);
}

@override
String toString() {
    return 'Proposal(phoneNumber: $phoneNumber, proposalStartTime: $proposalStartTime, status: $status, highestRiskLevel: $highestRiskLevel, proposalCount: $proposalCount, verifiedOwnerCount: $verifiedOwnerCount, lastUpdated: $lastUpdated, verificationReportJson: $verificationReportJson, labelsJson: $labelsJson)';
}


}

/// @nodoc
abstract mixin class _$ProposalCopyWith<$Res> implements $ProposalCopyWith<$Res> {
  factory _$ProposalCopyWith(_Proposal value, $Res Function(_Proposal) _then) = __$ProposalCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, DateTime proposalStartTime, ProposalStatus status, RiskLevel highestRiskLevel, int proposalCount, int verifiedOwnerCount, DateTime lastUpdated, String? verificationReportJson, String? labelsJson
});




}
/// @nodoc
class __$ProposalCopyWithImpl<$Res>
    implements _$ProposalCopyWith<$Res> {
  __$ProposalCopyWithImpl(this._self, this._then);

  final _Proposal _self;
  final $Res Function(_Proposal) _then;

/// Create a copy of Proposal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? proposalStartTime = null,Object? status = null,Object? highestRiskLevel = null,Object? proposalCount = null,Object? verifiedOwnerCount = null,Object? lastUpdated = null,Object? verificationReportJson = freezed,Object? labelsJson = freezed,}) {
  return _then(_Proposal(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,proposalStartTime: null == proposalStartTime ? _self.proposalStartTime : proposalStartTime // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProposalStatus,highestRiskLevel: null == highestRiskLevel ? _self.highestRiskLevel : highestRiskLevel // ignore: cast_nullable_to_non_nullable
as RiskLevel,proposalCount: null == proposalCount ? _self.proposalCount : proposalCount // ignore: cast_nullable_to_non_nullable
as int,verifiedOwnerCount: null == verifiedOwnerCount ? _self.verifiedOwnerCount : verifiedOwnerCount // ignore: cast_nullable_to_non_nullable
as int,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,verificationReportJson: freezed == verificationReportJson ? _self.verificationReportJson : verificationReportJson // ignore: cast_nullable_to_non_nullable
as String?,labelsJson: freezed == labelsJson ? _self.labelsJson : labelsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
