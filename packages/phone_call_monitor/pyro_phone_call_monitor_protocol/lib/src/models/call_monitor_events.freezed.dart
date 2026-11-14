// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_monitor_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CallMonitorEvent {

 String get phoneNumber; int? get timestamp;
/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallMonitorEventCopyWith<CallMonitorEvent> get copyWith => _$CallMonitorEventCopyWithImpl<CallMonitorEvent>(this as CallMonitorEvent, _$identity);

  /// Serializes this CallMonitorEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CallMonitorEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallMonitorEvent&&(identical(other.phoneNumber, _this.phoneNumber) || other.phoneNumber == _this.phoneNumber)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CallMonitorEvent;
  return Object.hash(runtimeType,_this.phoneNumber,_this.timestamp);
}

@override
String toString() {
  final _this = this as CallMonitorEvent;
  return 'CallMonitorEvent(phoneNumber: ${_this.phoneNumber}, timestamp: ${_this.timestamp})';
}


}

/// @nodoc
abstract mixin class $CallMonitorEventCopyWith<$Res>  {
  factory $CallMonitorEventCopyWith(CallMonitorEvent value, $Res Function(CallMonitorEvent) _then) = _$CallMonitorEventCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, int? timestamp
});




}
/// @nodoc
class _$CallMonitorEventCopyWithImpl<$Res>
    implements $CallMonitorEventCopyWith<$Res> {
  _$CallMonitorEventCopyWithImpl(this._self, this._then);

  final CallMonitorEvent _self;
  final $Res Function(CallMonitorEvent) _then;

/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallMonitorEvent].
extension CallMonitorEventPatterns on CallMonitorEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IncomingCallEvent value)?  incoming,TResult Function( OutgoingCallEvent value)?  outgoing,TResult Function( CallEndedEvent value)?  ended,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IncomingCallEvent() when incoming != null:
return incoming(_that);case OutgoingCallEvent() when outgoing != null:
return outgoing(_that);case CallEndedEvent() when ended != null:
return ended(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IncomingCallEvent value)  incoming,required TResult Function( OutgoingCallEvent value)  outgoing,required TResult Function( CallEndedEvent value)  ended,}){
final _that = this;
switch (_that) {
case IncomingCallEvent():
return incoming(_that);case OutgoingCallEvent():
return outgoing(_that);case CallEndedEvent():
return ended(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IncomingCallEvent value)?  incoming,TResult? Function( OutgoingCallEvent value)?  outgoing,TResult? Function( CallEndedEvent value)?  ended,}){
final _that = this;
switch (_that) {
case IncomingCallEvent() when incoming != null:
return incoming(_that);case OutgoingCallEvent() when outgoing != null:
return outgoing(_that);case CallEndedEvent() when ended != null:
return ended(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String phoneNumber,  int? timestamp)?  incoming,TResult Function( String phoneNumber,  int? timestamp)?  outgoing,TResult Function( String phoneNumber,  int? timestamp)?  ended,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IncomingCallEvent() when incoming != null:
return incoming(_that.phoneNumber,_that.timestamp);case OutgoingCallEvent() when outgoing != null:
return outgoing(_that.phoneNumber,_that.timestamp);case CallEndedEvent() when ended != null:
return ended(_that.phoneNumber,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String phoneNumber,  int? timestamp)  incoming,required TResult Function( String phoneNumber,  int? timestamp)  outgoing,required TResult Function( String phoneNumber,  int? timestamp)  ended,}) {final _that = this;
switch (_that) {
case IncomingCallEvent():
return incoming(_that.phoneNumber,_that.timestamp);case OutgoingCallEvent():
return outgoing(_that.phoneNumber,_that.timestamp);case CallEndedEvent():
return ended(_that.phoneNumber,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String phoneNumber,  int? timestamp)?  incoming,TResult? Function( String phoneNumber,  int? timestamp)?  outgoing,TResult? Function( String phoneNumber,  int? timestamp)?  ended,}) {final _that = this;
switch (_that) {
case IncomingCallEvent() when incoming != null:
return incoming(_that.phoneNumber,_that.timestamp);case OutgoingCallEvent() when outgoing != null:
return outgoing(_that.phoneNumber,_that.timestamp);case CallEndedEvent() when ended != null:
return ended(_that.phoneNumber,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class IncomingCallEvent extends CallMonitorEvent {
  const IncomingCallEvent({required this.phoneNumber, this.timestamp,  String? $type}): $type = $type ?? 'incoming',super._();
  factory IncomingCallEvent.fromJson(Map<String, dynamic> json) => _$IncomingCallEventFromJson(json);

@override final  String phoneNumber;
@override final  int? timestamp;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomingCallEventCopyWith<IncomingCallEvent> get copyWith => _$IncomingCallEventCopyWithImpl<IncomingCallEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncomingCallEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomingCallEvent&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,timestamp);
}

@override
String toString() {
    return 'CallMonitorEvent.incoming(phoneNumber: $phoneNumber, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $IncomingCallEventCopyWith<$Res> implements $CallMonitorEventCopyWith<$Res> {
  factory $IncomingCallEventCopyWith(IncomingCallEvent value, $Res Function(IncomingCallEvent) _then) = _$IncomingCallEventCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, int? timestamp
});




}
/// @nodoc
class _$IncomingCallEventCopyWithImpl<$Res>
    implements $IncomingCallEventCopyWith<$Res> {
  _$IncomingCallEventCopyWithImpl(this._self, this._then);

  final IncomingCallEvent _self;
  final $Res Function(IncomingCallEvent) _then;

/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? timestamp = freezed,}) {
  return _then(IncomingCallEvent(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class OutgoingCallEvent extends CallMonitorEvent {
  const OutgoingCallEvent({required this.phoneNumber, this.timestamp,  String? $type}): $type = $type ?? 'outgoing',super._();
  factory OutgoingCallEvent.fromJson(Map<String, dynamic> json) => _$OutgoingCallEventFromJson(json);

@override final  String phoneNumber;
@override final  int? timestamp;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OutgoingCallEventCopyWith<OutgoingCallEvent> get copyWith => _$OutgoingCallEventCopyWithImpl<OutgoingCallEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OutgoingCallEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OutgoingCallEvent&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,timestamp);
}

@override
String toString() {
    return 'CallMonitorEvent.outgoing(phoneNumber: $phoneNumber, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $OutgoingCallEventCopyWith<$Res> implements $CallMonitorEventCopyWith<$Res> {
  factory $OutgoingCallEventCopyWith(OutgoingCallEvent value, $Res Function(OutgoingCallEvent) _then) = _$OutgoingCallEventCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, int? timestamp
});




}
/// @nodoc
class _$OutgoingCallEventCopyWithImpl<$Res>
    implements $OutgoingCallEventCopyWith<$Res> {
  _$OutgoingCallEventCopyWithImpl(this._self, this._then);

  final OutgoingCallEvent _self;
  final $Res Function(OutgoingCallEvent) _then;

/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? timestamp = freezed,}) {
  return _then(OutgoingCallEvent(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CallEndedEvent extends CallMonitorEvent {
  const CallEndedEvent({required this.phoneNumber, this.timestamp,  String? $type}): $type = $type ?? 'ended',super._();
  factory CallEndedEvent.fromJson(Map<String, dynamic> json) => _$CallEndedEventFromJson(json);

@override final  String phoneNumber;
@override final  int? timestamp;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallEndedEventCopyWith<CallEndedEvent> get copyWith => _$CallEndedEventCopyWithImpl<CallEndedEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallEndedEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CallEndedEvent&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,phoneNumber,timestamp);
}

@override
String toString() {
    return 'CallMonitorEvent.ended(phoneNumber: $phoneNumber, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $CallEndedEventCopyWith<$Res> implements $CallMonitorEventCopyWith<$Res> {
  factory $CallEndedEventCopyWith(CallEndedEvent value, $Res Function(CallEndedEvent) _then) = _$CallEndedEventCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, int? timestamp
});




}
/// @nodoc
class _$CallEndedEventCopyWithImpl<$Res>
    implements $CallEndedEventCopyWith<$Res> {
  _$CallEndedEventCopyWithImpl(this._self, this._then);

  final CallEndedEvent _self;
  final $Res Function(CallEndedEvent) _then;

/// Create a copy of CallMonitorEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? timestamp = freezed,}) {
  return _then(CallEndedEvent(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
