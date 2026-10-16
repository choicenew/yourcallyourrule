// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
SyncPayload _$SyncPayloadFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'numberUpdate':
          return NumberUpdatePayload.fromJson(
            json
          );
                case 'proposeDeletion':
          return ProposeDeletionPayload.fromJson(
            json
          );
                case 'voteDeletion':
          return VoteDeletionPayload.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SyncPayload',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SyncPayload {



  /// Serializes this SyncPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncPayload);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SyncPayload()';
}


}

/// @nodoc
class $SyncPayloadCopyWith<$Res>  {
$SyncPayloadCopyWith(SyncPayload _, $Res Function(SyncPayload) __);
}


/// Adds pattern-matching-related methods to [SyncPayload].
extension SyncPayloadPatterns on SyncPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NumberUpdatePayload value)?  numberUpdate,TResult Function( ProposeDeletionPayload value)?  proposeDeletion,TResult Function( VoteDeletionPayload value)?  voteDeletion,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NumberUpdatePayload() when numberUpdate != null:
return numberUpdate(_that);case ProposeDeletionPayload() when proposeDeletion != null:
return proposeDeletion(_that);case VoteDeletionPayload() when voteDeletion != null:
return voteDeletion(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NumberUpdatePayload value)  numberUpdate,required TResult Function( ProposeDeletionPayload value)  proposeDeletion,required TResult Function( VoteDeletionPayload value)  voteDeletion,}){
final _that = this;
switch (_that) {
case NumberUpdatePayload():
return numberUpdate(_that);case ProposeDeletionPayload():
return proposeDeletion(_that);case VoteDeletionPayload():
return voteDeletion(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NumberUpdatePayload value)?  numberUpdate,TResult? Function( ProposeDeletionPayload value)?  proposeDeletion,TResult? Function( VoteDeletionPayload value)?  voteDeletion,}){
final _that = this;
switch (_that) {
case NumberUpdatePayload() when numberUpdate != null:
return numberUpdate(_that);case ProposeDeletionPayload() when proposeDeletion != null:
return proposeDeletion(_that);case VoteDeletionPayload() when voteDeletion != null:
return voteDeletion(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String phoneNumber,  String label,  int action,  int? count,  String? countryIsoCode)?  numberUpdate,TResult Function( ServerVerificationReport report,  String timestamp)?  proposeDeletion,TResult Function( String voteType,  Map<String, dynamic>? additionalData,  String timestamp)?  voteDeletion,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NumberUpdatePayload() when numberUpdate != null:
return numberUpdate(_that.phoneNumber,_that.label,_that.action,_that.count,_that.countryIsoCode);case ProposeDeletionPayload() when proposeDeletion != null:
return proposeDeletion(_that.report,_that.timestamp);case VoteDeletionPayload() when voteDeletion != null:
return voteDeletion(_that.voteType,_that.additionalData,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String phoneNumber,  String label,  int action,  int? count,  String? countryIsoCode)  numberUpdate,required TResult Function( ServerVerificationReport report,  String timestamp)  proposeDeletion,required TResult Function( String voteType,  Map<String, dynamic>? additionalData,  String timestamp)  voteDeletion,}) {final _that = this;
switch (_that) {
case NumberUpdatePayload():
return numberUpdate(_that.phoneNumber,_that.label,_that.action,_that.count,_that.countryIsoCode);case ProposeDeletionPayload():
return proposeDeletion(_that.report,_that.timestamp);case VoteDeletionPayload():
return voteDeletion(_that.voteType,_that.additionalData,_that.timestamp);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String phoneNumber,  String label,  int action,  int? count,  String? countryIsoCode)?  numberUpdate,TResult? Function( ServerVerificationReport report,  String timestamp)?  proposeDeletion,TResult? Function( String voteType,  Map<String, dynamic>? additionalData,  String timestamp)?  voteDeletion,}) {final _that = this;
switch (_that) {
case NumberUpdatePayload() when numberUpdate != null:
return numberUpdate(_that.phoneNumber,_that.label,_that.action,_that.count,_that.countryIsoCode);case ProposeDeletionPayload() when proposeDeletion != null:
return proposeDeletion(_that.report,_that.timestamp);case VoteDeletionPayload() when voteDeletion != null:
return voteDeletion(_that.voteType,_that.additionalData,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class NumberUpdatePayload implements SyncPayload {
  const NumberUpdatePayload({required this.phoneNumber, required this.label, required this.action, this.count, this.countryIsoCode,  String? $type}): $type = $type ?? 'numberUpdate';
  factory NumberUpdatePayload.fromJson(Map<String, dynamic> json) => _$NumberUpdatePayloadFromJson(json);

 final  String phoneNumber;
 final  String label;
 final  int action;
 final  int? count;
 final  String? countryIsoCode;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SyncPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NumberUpdatePayloadCopyWith<NumberUpdatePayload> get copyWith => _$NumberUpdatePayloadCopyWithImpl<NumberUpdatePayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NumberUpdatePayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NumberUpdatePayload&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.label, label) || other.label == label)&&(identical(other.action, action) || other.action == action)&&(identical(other.count, count) || other.count == count)&&(identical(other.countryIsoCode, countryIsoCode) || other.countryIsoCode == countryIsoCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,label,action,count,countryIsoCode);
}

@override
String toString() {
    return 'SyncPayload.numberUpdate(phoneNumber: $phoneNumber, label: $label, action: $action, count: $count, countryIsoCode: $countryIsoCode)';
}


}

/// @nodoc
abstract mixin class $NumberUpdatePayloadCopyWith<$Res> implements $SyncPayloadCopyWith<$Res> {
  factory $NumberUpdatePayloadCopyWith(NumberUpdatePayload value, $Res Function(NumberUpdatePayload) _then) = _$NumberUpdatePayloadCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String label, int action, int? count, String? countryIsoCode
});




}
/// @nodoc
class _$NumberUpdatePayloadCopyWithImpl<$Res>
    implements $NumberUpdatePayloadCopyWith<$Res> {
  _$NumberUpdatePayloadCopyWithImpl(this._self, this._then);

  final NumberUpdatePayload _self;
  final $Res Function(NumberUpdatePayload) _then;

/// Create a copy of SyncPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? label = null,Object? action = null,Object? count = freezed,Object? countryIsoCode = freezed,}) {
  return _then(NumberUpdatePayload(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as int,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,countryIsoCode: freezed == countryIsoCode ? _self.countryIsoCode : countryIsoCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ProposeDeletionPayload implements SyncPayload {
  const ProposeDeletionPayload({required this.report, required this.timestamp,  String? $type}): $type = $type ?? 'proposeDeletion';
  factory ProposeDeletionPayload.fromJson(Map<String, dynamic> json) => _$ProposeDeletionPayloadFromJson(json);

 final  ServerVerificationReport report;
 final  String timestamp;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SyncPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProposeDeletionPayloadCopyWith<ProposeDeletionPayload> get copyWith => _$ProposeDeletionPayloadCopyWithImpl<ProposeDeletionPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProposeDeletionPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProposeDeletionPayload&&(identical(other.report, report) || other.report == report)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,report,timestamp);
}

@override
String toString() {
    return 'SyncPayload.proposeDeletion(report: $report, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ProposeDeletionPayloadCopyWith<$Res> implements $SyncPayloadCopyWith<$Res> {
  factory $ProposeDeletionPayloadCopyWith(ProposeDeletionPayload value, $Res Function(ProposeDeletionPayload) _then) = _$ProposeDeletionPayloadCopyWithImpl;
@useResult
$Res call({
 ServerVerificationReport report, String timestamp
});


$ServerVerificationReportCopyWith<$Res> get report;

}
/// @nodoc
class _$ProposeDeletionPayloadCopyWithImpl<$Res>
    implements $ProposeDeletionPayloadCopyWith<$Res> {
  _$ProposeDeletionPayloadCopyWithImpl(this._self, this._then);

  final ProposeDeletionPayload _self;
  final $Res Function(ProposeDeletionPayload) _then;

/// Create a copy of SyncPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? report = null,Object? timestamp = null,}) {
  return _then(ProposeDeletionPayload(
report: null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as ServerVerificationReport,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SyncPayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerVerificationReportCopyWith<$Res> get report {
  
  return $ServerVerificationReportCopyWith<$Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class VoteDeletionPayload implements SyncPayload {
  const VoteDeletionPayload({required this.voteType,  Map<String, dynamic>? additionalData, required this.timestamp,  String? $type}): _additionalData = additionalData,$type = $type ?? 'voteDeletion';
  factory VoteDeletionPayload.fromJson(Map<String, dynamic> json) => _$VoteDeletionPayloadFromJson(json);

 final  String voteType;
 final  Map<String, dynamic>? _additionalData;
 Map<String, dynamic>? get additionalData {
  final value = _additionalData;
  if (value == null) return null;
  if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  String timestamp;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SyncPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoteDeletionPayloadCopyWith<VoteDeletionPayload> get copyWith => _$VoteDeletionPayloadCopyWithImpl<VoteDeletionPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoteDeletionPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is VoteDeletionPayload&&(identical(other.voteType, voteType) || other.voteType == voteType)&&const DeepCollectionEquality().equals(other.additionalData, _additionalData)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,voteType,const DeepCollectionEquality().hash(_additionalData),timestamp);
}

@override
String toString() {
    return 'SyncPayload.voteDeletion(voteType: $voteType, additionalData: $additionalData, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $VoteDeletionPayloadCopyWith<$Res> implements $SyncPayloadCopyWith<$Res> {
  factory $VoteDeletionPayloadCopyWith(VoteDeletionPayload value, $Res Function(VoteDeletionPayload) _then) = _$VoteDeletionPayloadCopyWithImpl;
@useResult
$Res call({
 String voteType, Map<String, dynamic>? additionalData, String timestamp
});




}
/// @nodoc
class _$VoteDeletionPayloadCopyWithImpl<$Res>
    implements $VoteDeletionPayloadCopyWith<$Res> {
  _$VoteDeletionPayloadCopyWithImpl(this._self, this._then);

  final VoteDeletionPayload _self;
  final $Res Function(VoteDeletionPayload) _then;

/// Create a copy of SyncPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? voteType = null,Object? additionalData = freezed,Object? timestamp = null,}) {
  return _then(VoteDeletionPayload(
voteType: null == voteType ? _self.voteType : voteType // ignore: cast_nullable_to_non_nullable
as String,additionalData: freezed == additionalData ? _self._additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
