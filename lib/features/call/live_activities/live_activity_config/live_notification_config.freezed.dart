// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_notification_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveNotificationConfig {

// --- 全局 ---
 LiveGlobalSettings get globalSettings;// --- 元素配置 (100% 参照你的 CallerIdConfig) ---
 LiveAvatarConfig get avatar; LiveTextConfig get name; LiveTextConfig get number; LiveTextConfig get location;// 对应你的 region
 LiveTextConfig get carrier; LiveTextConfig get countryName;// 独立的国家名
 LiveTextConfig get labels; LiveTextConfig get count; LiveTextConfig get numberType; LiveTextConfig get stir; LiveTextConfig get simCard; LiveIconConfig get callType; LiveSecurityMessageConfig get securityMessage;
/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveNotificationConfigCopyWith<LiveNotificationConfig> get copyWith => _$LiveNotificationConfigCopyWithImpl<LiveNotificationConfig>(this as LiveNotificationConfig, _$identity);

  /// Serializes this LiveNotificationConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveNotificationConfig&&(identical(other.globalSettings, globalSettings) || other.globalSettings == globalSettings)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.name, name) || other.name == name)&&(identical(other.number, number) || other.number == number)&&(identical(other.location, location) || other.location == location)&&(identical(other.carrier, carrier) || other.carrier == carrier)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.labels, labels) || other.labels == labels)&&(identical(other.count, count) || other.count == count)&&(identical(other.numberType, numberType) || other.numberType == numberType)&&(identical(other.stir, stir) || other.stir == stir)&&(identical(other.simCard, simCard) || other.simCard == simCard)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.securityMessage, securityMessage) || other.securityMessage == securityMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,globalSettings,avatar,name,number,location,carrier,countryName,labels,count,numberType,stir,simCard,callType,securityMessage);

@override
String toString() {
  return 'LiveNotificationConfig(globalSettings: $globalSettings, avatar: $avatar, name: $name, number: $number, location: $location, carrier: $carrier, countryName: $countryName, labels: $labels, count: $count, numberType: $numberType, stir: $stir, simCard: $simCard, callType: $callType, securityMessage: $securityMessage)';
}


}

/// @nodoc
abstract mixin class $LiveNotificationConfigCopyWith<$Res>  {
  factory $LiveNotificationConfigCopyWith(LiveNotificationConfig value, $Res Function(LiveNotificationConfig) _then) = _$LiveNotificationConfigCopyWithImpl;
@useResult
$Res call({
 LiveGlobalSettings globalSettings, LiveAvatarConfig avatar, LiveTextConfig name, LiveTextConfig number, LiveTextConfig location, LiveTextConfig carrier, LiveTextConfig countryName, LiveTextConfig labels, LiveTextConfig count, LiveTextConfig numberType, LiveTextConfig stir, LiveTextConfig simCard, LiveIconConfig callType, LiveSecurityMessageConfig securityMessage
});


$LiveGlobalSettingsCopyWith<$Res> get globalSettings;$LiveAvatarConfigCopyWith<$Res> get avatar;$LiveTextConfigCopyWith<$Res> get name;$LiveTextConfigCopyWith<$Res> get number;$LiveTextConfigCopyWith<$Res> get location;$LiveTextConfigCopyWith<$Res> get carrier;$LiveTextConfigCopyWith<$Res> get countryName;$LiveTextConfigCopyWith<$Res> get labels;$LiveTextConfigCopyWith<$Res> get count;$LiveTextConfigCopyWith<$Res> get numberType;$LiveTextConfigCopyWith<$Res> get stir;$LiveTextConfigCopyWith<$Res> get simCard;$LiveIconConfigCopyWith<$Res> get callType;$LiveSecurityMessageConfigCopyWith<$Res> get securityMessage;

}
/// @nodoc
class _$LiveNotificationConfigCopyWithImpl<$Res>
    implements $LiveNotificationConfigCopyWith<$Res> {
  _$LiveNotificationConfigCopyWithImpl(this._self, this._then);

  final LiveNotificationConfig _self;
  final $Res Function(LiveNotificationConfig) _then;

/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? globalSettings = null,Object? avatar = null,Object? name = null,Object? number = null,Object? location = null,Object? carrier = null,Object? countryName = null,Object? labels = null,Object? count = null,Object? numberType = null,Object? stir = null,Object? simCard = null,Object? callType = null,Object? securityMessage = null,}) {
  return _then(_self.copyWith(
globalSettings: null == globalSettings ? _self.globalSettings : globalSettings // ignore: cast_nullable_to_non_nullable
as LiveGlobalSettings,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as LiveAvatarConfig,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,carrier: null == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,countryName: null == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,numberType: null == numberType ? _self.numberType : numberType // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,stir: null == stir ? _self.stir : stir // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,simCard: null == simCard ? _self.simCard : simCard // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as LiveIconConfig,securityMessage: null == securityMessage ? _self.securityMessage : securityMessage // ignore: cast_nullable_to_non_nullable
as LiveSecurityMessageConfig,
  ));
}
/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGlobalSettingsCopyWith<$Res> get globalSettings {
  
  return $LiveGlobalSettingsCopyWith<$Res>(_self.globalSettings, (value) {
    return _then(_self.copyWith(globalSettings: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAvatarConfigCopyWith<$Res> get avatar {
  
  return $LiveAvatarConfigCopyWith<$Res>(_self.avatar, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get name {
  
  return $LiveTextConfigCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get number {
  
  return $LiveTextConfigCopyWith<$Res>(_self.number, (value) {
    return _then(_self.copyWith(number: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get location {
  
  return $LiveTextConfigCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get carrier {
  
  return $LiveTextConfigCopyWith<$Res>(_self.carrier, (value) {
    return _then(_self.copyWith(carrier: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get countryName {
  
  return $LiveTextConfigCopyWith<$Res>(_self.countryName, (value) {
    return _then(_self.copyWith(countryName: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get labels {
  
  return $LiveTextConfigCopyWith<$Res>(_self.labels, (value) {
    return _then(_self.copyWith(labels: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get count {
  
  return $LiveTextConfigCopyWith<$Res>(_self.count, (value) {
    return _then(_self.copyWith(count: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get numberType {
  
  return $LiveTextConfigCopyWith<$Res>(_self.numberType, (value) {
    return _then(_self.copyWith(numberType: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get stir {
  
  return $LiveTextConfigCopyWith<$Res>(_self.stir, (value) {
    return _then(_self.copyWith(stir: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get simCard {
  
  return $LiveTextConfigCopyWith<$Res>(_self.simCard, (value) {
    return _then(_self.copyWith(simCard: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveIconConfigCopyWith<$Res> get callType {
  
  return $LiveIconConfigCopyWith<$Res>(_self.callType, (value) {
    return _then(_self.copyWith(callType: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveSecurityMessageConfigCopyWith<$Res> get securityMessage {
  
  return $LiveSecurityMessageConfigCopyWith<$Res>(_self.securityMessage, (value) {
    return _then(_self.copyWith(securityMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveNotificationConfig].
extension LiveNotificationConfigPatterns on LiveNotificationConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveNotificationConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveNotificationConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveNotificationConfig value)  $default,){
final _that = this;
switch (_that) {
case _LiveNotificationConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveNotificationConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LiveNotificationConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LiveGlobalSettings globalSettings,  LiveAvatarConfig avatar,  LiveTextConfig name,  LiveTextConfig number,  LiveTextConfig location,  LiveTextConfig carrier,  LiveTextConfig countryName,  LiveTextConfig labels,  LiveTextConfig count,  LiveTextConfig numberType,  LiveTextConfig stir,  LiveTextConfig simCard,  LiveIconConfig callType,  LiveSecurityMessageConfig securityMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveNotificationConfig() when $default != null:
return $default(_that.globalSettings,_that.avatar,_that.name,_that.number,_that.location,_that.carrier,_that.countryName,_that.labels,_that.count,_that.numberType,_that.stir,_that.simCard,_that.callType,_that.securityMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LiveGlobalSettings globalSettings,  LiveAvatarConfig avatar,  LiveTextConfig name,  LiveTextConfig number,  LiveTextConfig location,  LiveTextConfig carrier,  LiveTextConfig countryName,  LiveTextConfig labels,  LiveTextConfig count,  LiveTextConfig numberType,  LiveTextConfig stir,  LiveTextConfig simCard,  LiveIconConfig callType,  LiveSecurityMessageConfig securityMessage)  $default,) {final _that = this;
switch (_that) {
case _LiveNotificationConfig():
return $default(_that.globalSettings,_that.avatar,_that.name,_that.number,_that.location,_that.carrier,_that.countryName,_that.labels,_that.count,_that.numberType,_that.stir,_that.simCard,_that.callType,_that.securityMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LiveGlobalSettings globalSettings,  LiveAvatarConfig avatar,  LiveTextConfig name,  LiveTextConfig number,  LiveTextConfig location,  LiveTextConfig carrier,  LiveTextConfig countryName,  LiveTextConfig labels,  LiveTextConfig count,  LiveTextConfig numberType,  LiveTextConfig stir,  LiveTextConfig simCard,  LiveIconConfig callType,  LiveSecurityMessageConfig securityMessage)?  $default,) {final _that = this;
switch (_that) {
case _LiveNotificationConfig() when $default != null:
return $default(_that.globalSettings,_that.avatar,_that.name,_that.number,_that.location,_that.carrier,_that.countryName,_that.labels,_that.count,_that.numberType,_that.stir,_that.simCard,_that.callType,_that.securityMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveNotificationConfig implements LiveNotificationConfig {
  const _LiveNotificationConfig({this.globalSettings = const LiveGlobalSettings(), this.avatar = const LiveAvatarConfig(), this.name = const LiveTextConfig(fontSize: 18.0), this.number = const LiveTextConfig(), this.location = const LiveTextConfig(), this.carrier = const LiveTextConfig(), this.countryName = const LiveTextConfig(), this.labels = const LiveTextConfig(), this.count = const LiveTextConfig(), this.numberType = const LiveTextConfig(), this.stir = const LiveTextConfig(), this.simCard = const LiveTextConfig(), this.callType = const LiveIconConfig(), this.securityMessage = const LiveSecurityMessageConfig()});
  factory _LiveNotificationConfig.fromJson(Map<String, dynamic> json) => _$LiveNotificationConfigFromJson(json);

// --- 全局 ---
@override@JsonKey() final  LiveGlobalSettings globalSettings;
// --- 元素配置 (100% 参照你的 CallerIdConfig) ---
@override@JsonKey() final  LiveAvatarConfig avatar;
@override@JsonKey() final  LiveTextConfig name;
@override@JsonKey() final  LiveTextConfig number;
@override@JsonKey() final  LiveTextConfig location;
// 对应你的 region
@override@JsonKey() final  LiveTextConfig carrier;
@override@JsonKey() final  LiveTextConfig countryName;
// 独立的国家名
@override@JsonKey() final  LiveTextConfig labels;
@override@JsonKey() final  LiveTextConfig count;
@override@JsonKey() final  LiveTextConfig numberType;
@override@JsonKey() final  LiveTextConfig stir;
@override@JsonKey() final  LiveTextConfig simCard;
@override@JsonKey() final  LiveIconConfig callType;
@override@JsonKey() final  LiveSecurityMessageConfig securityMessage;

/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveNotificationConfigCopyWith<_LiveNotificationConfig> get copyWith => __$LiveNotificationConfigCopyWithImpl<_LiveNotificationConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveNotificationConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveNotificationConfig&&(identical(other.globalSettings, globalSettings) || other.globalSettings == globalSettings)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.name, name) || other.name == name)&&(identical(other.number, number) || other.number == number)&&(identical(other.location, location) || other.location == location)&&(identical(other.carrier, carrier) || other.carrier == carrier)&&(identical(other.countryName, countryName) || other.countryName == countryName)&&(identical(other.labels, labels) || other.labels == labels)&&(identical(other.count, count) || other.count == count)&&(identical(other.numberType, numberType) || other.numberType == numberType)&&(identical(other.stir, stir) || other.stir == stir)&&(identical(other.simCard, simCard) || other.simCard == simCard)&&(identical(other.callType, callType) || other.callType == callType)&&(identical(other.securityMessage, securityMessage) || other.securityMessage == securityMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,globalSettings,avatar,name,number,location,carrier,countryName,labels,count,numberType,stir,simCard,callType,securityMessage);

@override
String toString() {
  return 'LiveNotificationConfig(globalSettings: $globalSettings, avatar: $avatar, name: $name, number: $number, location: $location, carrier: $carrier, countryName: $countryName, labels: $labels, count: $count, numberType: $numberType, stir: $stir, simCard: $simCard, callType: $callType, securityMessage: $securityMessage)';
}


}

/// @nodoc
abstract mixin class _$LiveNotificationConfigCopyWith<$Res> implements $LiveNotificationConfigCopyWith<$Res> {
  factory _$LiveNotificationConfigCopyWith(_LiveNotificationConfig value, $Res Function(_LiveNotificationConfig) _then) = __$LiveNotificationConfigCopyWithImpl;
@override @useResult
$Res call({
 LiveGlobalSettings globalSettings, LiveAvatarConfig avatar, LiveTextConfig name, LiveTextConfig number, LiveTextConfig location, LiveTextConfig carrier, LiveTextConfig countryName, LiveTextConfig labels, LiveTextConfig count, LiveTextConfig numberType, LiveTextConfig stir, LiveTextConfig simCard, LiveIconConfig callType, LiveSecurityMessageConfig securityMessage
});


@override $LiveGlobalSettingsCopyWith<$Res> get globalSettings;@override $LiveAvatarConfigCopyWith<$Res> get avatar;@override $LiveTextConfigCopyWith<$Res> get name;@override $LiveTextConfigCopyWith<$Res> get number;@override $LiveTextConfigCopyWith<$Res> get location;@override $LiveTextConfigCopyWith<$Res> get carrier;@override $LiveTextConfigCopyWith<$Res> get countryName;@override $LiveTextConfigCopyWith<$Res> get labels;@override $LiveTextConfigCopyWith<$Res> get count;@override $LiveTextConfigCopyWith<$Res> get numberType;@override $LiveTextConfigCopyWith<$Res> get stir;@override $LiveTextConfigCopyWith<$Res> get simCard;@override $LiveIconConfigCopyWith<$Res> get callType;@override $LiveSecurityMessageConfigCopyWith<$Res> get securityMessage;

}
/// @nodoc
class __$LiveNotificationConfigCopyWithImpl<$Res>
    implements _$LiveNotificationConfigCopyWith<$Res> {
  __$LiveNotificationConfigCopyWithImpl(this._self, this._then);

  final _LiveNotificationConfig _self;
  final $Res Function(_LiveNotificationConfig) _then;

/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? globalSettings = null,Object? avatar = null,Object? name = null,Object? number = null,Object? location = null,Object? carrier = null,Object? countryName = null,Object? labels = null,Object? count = null,Object? numberType = null,Object? stir = null,Object? simCard = null,Object? callType = null,Object? securityMessage = null,}) {
  return _then(_LiveNotificationConfig(
globalSettings: null == globalSettings ? _self.globalSettings : globalSettings // ignore: cast_nullable_to_non_nullable
as LiveGlobalSettings,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as LiveAvatarConfig,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,carrier: null == carrier ? _self.carrier : carrier // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,countryName: null == countryName ? _self.countryName : countryName // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,numberType: null == numberType ? _self.numberType : numberType // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,stir: null == stir ? _self.stir : stir // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,simCard: null == simCard ? _self.simCard : simCard // ignore: cast_nullable_to_non_nullable
as LiveTextConfig,callType: null == callType ? _self.callType : callType // ignore: cast_nullable_to_non_nullable
as LiveIconConfig,securityMessage: null == securityMessage ? _self.securityMessage : securityMessage // ignore: cast_nullable_to_non_nullable
as LiveSecurityMessageConfig,
  ));
}

/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveGlobalSettingsCopyWith<$Res> get globalSettings {
  
  return $LiveGlobalSettingsCopyWith<$Res>(_self.globalSettings, (value) {
    return _then(_self.copyWith(globalSettings: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveAvatarConfigCopyWith<$Res> get avatar {
  
  return $LiveAvatarConfigCopyWith<$Res>(_self.avatar, (value) {
    return _then(_self.copyWith(avatar: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get name {
  
  return $LiveTextConfigCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get number {
  
  return $LiveTextConfigCopyWith<$Res>(_self.number, (value) {
    return _then(_self.copyWith(number: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get location {
  
  return $LiveTextConfigCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get carrier {
  
  return $LiveTextConfigCopyWith<$Res>(_self.carrier, (value) {
    return _then(_self.copyWith(carrier: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get countryName {
  
  return $LiveTextConfigCopyWith<$Res>(_self.countryName, (value) {
    return _then(_self.copyWith(countryName: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get labels {
  
  return $LiveTextConfigCopyWith<$Res>(_self.labels, (value) {
    return _then(_self.copyWith(labels: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get count {
  
  return $LiveTextConfigCopyWith<$Res>(_self.count, (value) {
    return _then(_self.copyWith(count: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get numberType {
  
  return $LiveTextConfigCopyWith<$Res>(_self.numberType, (value) {
    return _then(_self.copyWith(numberType: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get stir {
  
  return $LiveTextConfigCopyWith<$Res>(_self.stir, (value) {
    return _then(_self.copyWith(stir: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<$Res> get simCard {
  
  return $LiveTextConfigCopyWith<$Res>(_self.simCard, (value) {
    return _then(_self.copyWith(simCard: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveIconConfigCopyWith<$Res> get callType {
  
  return $LiveIconConfigCopyWith<$Res>(_self.callType, (value) {
    return _then(_self.copyWith(callType: value));
  });
}/// Create a copy of LiveNotificationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveSecurityMessageConfigCopyWith<$Res> get securityMessage {
  
  return $LiveSecurityMessageConfigCopyWith<$Res>(_self.securityMessage, (value) {
    return _then(_self.copyWith(securityMessage: value));
  });
}
}


/// @nodoc
mixin _$LiveGlobalSettings {

 String get backgroundColor;// 深灰色背景
 LiveBorderConfig get border;
/// Create a copy of LiveGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGlobalSettingsCopyWith<LiveGlobalSettings> get copyWith => _$LiveGlobalSettingsCopyWithImpl<LiveGlobalSettings>(this as LiveGlobalSettings, _$identity);

  /// Serializes this LiveGlobalSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGlobalSettings&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.border, border) || other.border == border));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,border);

@override
String toString() {
  return 'LiveGlobalSettings(backgroundColor: $backgroundColor, border: $border)';
}


}

/// @nodoc
abstract mixin class $LiveGlobalSettingsCopyWith<$Res>  {
  factory $LiveGlobalSettingsCopyWith(LiveGlobalSettings value, $Res Function(LiveGlobalSettings) _then) = _$LiveGlobalSettingsCopyWithImpl;
@useResult
$Res call({
 String backgroundColor, LiveBorderConfig border
});


$LiveBorderConfigCopyWith<$Res> get border;

}
/// @nodoc
class _$LiveGlobalSettingsCopyWithImpl<$Res>
    implements $LiveGlobalSettingsCopyWith<$Res> {
  _$LiveGlobalSettingsCopyWithImpl(this._self, this._then);

  final LiveGlobalSettings _self;
  final $Res Function(LiveGlobalSettings) _then;

/// Create a copy of LiveGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = null,Object? border = null,}) {
  return _then(_self.copyWith(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,border: null == border ? _self.border : border // ignore: cast_nullable_to_non_nullable
as LiveBorderConfig,
  ));
}
/// Create a copy of LiveGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveBorderConfigCopyWith<$Res> get border {
  
  return $LiveBorderConfigCopyWith<$Res>(_self.border, (value) {
    return _then(_self.copyWith(border: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveGlobalSettings].
extension LiveGlobalSettingsPatterns on LiveGlobalSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGlobalSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGlobalSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGlobalSettings value)  $default,){
final _that = this;
switch (_that) {
case _LiveGlobalSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGlobalSettings value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGlobalSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String backgroundColor,  LiveBorderConfig border)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGlobalSettings() when $default != null:
return $default(_that.backgroundColor,_that.border);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String backgroundColor,  LiveBorderConfig border)  $default,) {final _that = this;
switch (_that) {
case _LiveGlobalSettings():
return $default(_that.backgroundColor,_that.border);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String backgroundColor,  LiveBorderConfig border)?  $default,) {final _that = this;
switch (_that) {
case _LiveGlobalSettings() when $default != null:
return $default(_that.backgroundColor,_that.border);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGlobalSettings implements LiveGlobalSettings {
  const _LiveGlobalSettings({this.backgroundColor = '#FF2E2E2E', this.border = const LiveBorderConfig()});
  factory _LiveGlobalSettings.fromJson(Map<String, dynamic> json) => _$LiveGlobalSettingsFromJson(json);

@override@JsonKey() final  String backgroundColor;
// 深灰色背景
@override@JsonKey() final  LiveBorderConfig border;

/// Create a copy of LiveGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGlobalSettingsCopyWith<_LiveGlobalSettings> get copyWith => __$LiveGlobalSettingsCopyWithImpl<_LiveGlobalSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGlobalSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGlobalSettings&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.border, border) || other.border == border));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,border);

@override
String toString() {
  return 'LiveGlobalSettings(backgroundColor: $backgroundColor, border: $border)';
}


}

/// @nodoc
abstract mixin class _$LiveGlobalSettingsCopyWith<$Res> implements $LiveGlobalSettingsCopyWith<$Res> {
  factory _$LiveGlobalSettingsCopyWith(_LiveGlobalSettings value, $Res Function(_LiveGlobalSettings) _then) = __$LiveGlobalSettingsCopyWithImpl;
@override @useResult
$Res call({
 String backgroundColor, LiveBorderConfig border
});


@override $LiveBorderConfigCopyWith<$Res> get border;

}
/// @nodoc
class __$LiveGlobalSettingsCopyWithImpl<$Res>
    implements _$LiveGlobalSettingsCopyWith<$Res> {
  __$LiveGlobalSettingsCopyWithImpl(this._self, this._then);

  final _LiveGlobalSettings _self;
  final $Res Function(_LiveGlobalSettings) _then;

/// Create a copy of LiveGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? backgroundColor = null,Object? border = null,}) {
  return _then(_LiveGlobalSettings(
backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,border: null == border ? _self.border : border // ignore: cast_nullable_to_non_nullable
as LiveBorderConfig,
  ));
}

/// Create a copy of LiveGlobalSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveBorderConfigCopyWith<$Res> get border {
  
  return $LiveBorderConfigCopyWith<$Res>(_self.border, (value) {
    return _then(_self.copyWith(border: value));
  });
}
}


/// @nodoc
mixin _$LiveBorderConfig {

 double get width; String get color; double get radius;
/// Create a copy of LiveBorderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveBorderConfigCopyWith<LiveBorderConfig> get copyWith => _$LiveBorderConfigCopyWithImpl<LiveBorderConfig>(this as LiveBorderConfig, _$identity);

  /// Serializes this LiveBorderConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveBorderConfig&&(identical(other.width, width) || other.width == width)&&(identical(other.color, color) || other.color == color)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,color,radius);

@override
String toString() {
  return 'LiveBorderConfig(width: $width, color: $color, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $LiveBorderConfigCopyWith<$Res>  {
  factory $LiveBorderConfigCopyWith(LiveBorderConfig value, $Res Function(LiveBorderConfig) _then) = _$LiveBorderConfigCopyWithImpl;
@useResult
$Res call({
 double width, String color, double radius
});




}
/// @nodoc
class _$LiveBorderConfigCopyWithImpl<$Res>
    implements $LiveBorderConfigCopyWith<$Res> {
  _$LiveBorderConfigCopyWithImpl(this._self, this._then);

  final LiveBorderConfig _self;
  final $Res Function(LiveBorderConfig) _then;

/// Create a copy of LiveBorderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? color = null,Object? radius = null,}) {
  return _then(_self.copyWith(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveBorderConfig].
extension LiveBorderConfigPatterns on LiveBorderConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveBorderConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveBorderConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveBorderConfig value)  $default,){
final _that = this;
switch (_that) {
case _LiveBorderConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveBorderConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LiveBorderConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double width,  String color,  double radius)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveBorderConfig() when $default != null:
return $default(_that.width,_that.color,_that.radius);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double width,  String color,  double radius)  $default,) {final _that = this;
switch (_that) {
case _LiveBorderConfig():
return $default(_that.width,_that.color,_that.radius);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double width,  String color,  double radius)?  $default,) {final _that = this;
switch (_that) {
case _LiveBorderConfig() when $default != null:
return $default(_that.width,_that.color,_that.radius);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveBorderConfig implements LiveBorderConfig {
  const _LiveBorderConfig({this.width = 0.0, this.color = '#00000000', this.radius = 16.0});
  factory _LiveBorderConfig.fromJson(Map<String, dynamic> json) => _$LiveBorderConfigFromJson(json);

@override@JsonKey() final  double width;
@override@JsonKey() final  String color;
@override@JsonKey() final  double radius;

/// Create a copy of LiveBorderConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveBorderConfigCopyWith<_LiveBorderConfig> get copyWith => __$LiveBorderConfigCopyWithImpl<_LiveBorderConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveBorderConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveBorderConfig&&(identical(other.width, width) || other.width == width)&&(identical(other.color, color) || other.color == color)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,color,radius);

@override
String toString() {
  return 'LiveBorderConfig(width: $width, color: $color, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$LiveBorderConfigCopyWith<$Res> implements $LiveBorderConfigCopyWith<$Res> {
  factory _$LiveBorderConfigCopyWith(_LiveBorderConfig value, $Res Function(_LiveBorderConfig) _then) = __$LiveBorderConfigCopyWithImpl;
@override @useResult
$Res call({
 double width, String color, double radius
});




}
/// @nodoc
class __$LiveBorderConfigCopyWithImpl<$Res>
    implements _$LiveBorderConfigCopyWith<$Res> {
  __$LiveBorderConfigCopyWithImpl(this._self, this._then);

  final _LiveBorderConfig _self;
  final $Res Function(_LiveBorderConfig) _then;

/// Create a copy of LiveBorderConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? color = null,Object? radius = null,}) {
  return _then(_LiveBorderConfig(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$LiveAvatarConfig {

 bool get visible; double get size; double get borderWidth; String get borderColor; LivePositionConfig get position;
/// Create a copy of LiveAvatarConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveAvatarConfigCopyWith<LiveAvatarConfig> get copyWith => _$LiveAvatarConfigCopyWithImpl<LiveAvatarConfig>(this as LiveAvatarConfig, _$identity);

  /// Serializes this LiveAvatarConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveAvatarConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.size, size) || other.size == size)&&(identical(other.borderWidth, borderWidth) || other.borderWidth == borderWidth)&&(identical(other.borderColor, borderColor) || other.borderColor == borderColor)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,size,borderWidth,borderColor,position);

@override
String toString() {
  return 'LiveAvatarConfig(visible: $visible, size: $size, borderWidth: $borderWidth, borderColor: $borderColor, position: $position)';
}


}

/// @nodoc
abstract mixin class $LiveAvatarConfigCopyWith<$Res>  {
  factory $LiveAvatarConfigCopyWith(LiveAvatarConfig value, $Res Function(LiveAvatarConfig) _then) = _$LiveAvatarConfigCopyWithImpl;
@useResult
$Res call({
 bool visible, double size, double borderWidth, String borderColor, LivePositionConfig position
});


$LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class _$LiveAvatarConfigCopyWithImpl<$Res>
    implements $LiveAvatarConfigCopyWith<$Res> {
  _$LiveAvatarConfigCopyWithImpl(this._self, this._then);

  final LiveAvatarConfig _self;
  final $Res Function(LiveAvatarConfig) _then;

/// Create a copy of LiveAvatarConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visible = null,Object? size = null,Object? borderWidth = null,Object? borderColor = null,Object? position = null,}) {
  return _then(_self.copyWith(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,borderWidth: null == borderWidth ? _self.borderWidth : borderWidth // ignore: cast_nullable_to_non_nullable
as double,borderColor: null == borderColor ? _self.borderColor : borderColor // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}
/// Create a copy of LiveAvatarConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveAvatarConfig].
extension LiveAvatarConfigPatterns on LiveAvatarConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveAvatarConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveAvatarConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveAvatarConfig value)  $default,){
final _that = this;
switch (_that) {
case _LiveAvatarConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveAvatarConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LiveAvatarConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool visible,  double size,  double borderWidth,  String borderColor,  LivePositionConfig position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveAvatarConfig() when $default != null:
return $default(_that.visible,_that.size,_that.borderWidth,_that.borderColor,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool visible,  double size,  double borderWidth,  String borderColor,  LivePositionConfig position)  $default,) {final _that = this;
switch (_that) {
case _LiveAvatarConfig():
return $default(_that.visible,_that.size,_that.borderWidth,_that.borderColor,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool visible,  double size,  double borderWidth,  String borderColor,  LivePositionConfig position)?  $default,) {final _that = this;
switch (_that) {
case _LiveAvatarConfig() when $default != null:
return $default(_that.visible,_that.size,_that.borderWidth,_that.borderColor,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveAvatarConfig implements LiveAvatarConfig {
  const _LiveAvatarConfig({this.visible = true, this.size = 60.0, this.borderWidth = 1.0, this.borderColor = '#FFFFFFFF', this.position = const LivePositionConfig(x: 16, y: 16)});
  factory _LiveAvatarConfig.fromJson(Map<String, dynamic> json) => _$LiveAvatarConfigFromJson(json);

@override@JsonKey() final  bool visible;
@override@JsonKey() final  double size;
@override@JsonKey() final  double borderWidth;
@override@JsonKey() final  String borderColor;
@override@JsonKey() final  LivePositionConfig position;

/// Create a copy of LiveAvatarConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveAvatarConfigCopyWith<_LiveAvatarConfig> get copyWith => __$LiveAvatarConfigCopyWithImpl<_LiveAvatarConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveAvatarConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveAvatarConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.size, size) || other.size == size)&&(identical(other.borderWidth, borderWidth) || other.borderWidth == borderWidth)&&(identical(other.borderColor, borderColor) || other.borderColor == borderColor)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,size,borderWidth,borderColor,position);

@override
String toString() {
  return 'LiveAvatarConfig(visible: $visible, size: $size, borderWidth: $borderWidth, borderColor: $borderColor, position: $position)';
}


}

/// @nodoc
abstract mixin class _$LiveAvatarConfigCopyWith<$Res> implements $LiveAvatarConfigCopyWith<$Res> {
  factory _$LiveAvatarConfigCopyWith(_LiveAvatarConfig value, $Res Function(_LiveAvatarConfig) _then) = __$LiveAvatarConfigCopyWithImpl;
@override @useResult
$Res call({
 bool visible, double size, double borderWidth, String borderColor, LivePositionConfig position
});


@override $LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class __$LiveAvatarConfigCopyWithImpl<$Res>
    implements _$LiveAvatarConfigCopyWith<$Res> {
  __$LiveAvatarConfigCopyWithImpl(this._self, this._then);

  final _LiveAvatarConfig _self;
  final $Res Function(_LiveAvatarConfig) _then;

/// Create a copy of LiveAvatarConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visible = null,Object? size = null,Object? borderWidth = null,Object? borderColor = null,Object? position = null,}) {
  return _then(_LiveAvatarConfig(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,borderWidth: null == borderWidth ? _self.borderWidth : borderWidth // ignore: cast_nullable_to_non_nullable
as double,borderColor: null == borderColor ? _self.borderColor : borderColor // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}

/// Create a copy of LiveAvatarConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// @nodoc
mixin _$LiveIconConfig {

 bool get visible; double get size; String get color; LivePositionConfig get position;
/// Create a copy of LiveIconConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveIconConfigCopyWith<LiveIconConfig> get copyWith => _$LiveIconConfigCopyWithImpl<LiveIconConfig>(this as LiveIconConfig, _$identity);

  /// Serializes this LiveIconConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveIconConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,size,color,position);

@override
String toString() {
  return 'LiveIconConfig(visible: $visible, size: $size, color: $color, position: $position)';
}


}

/// @nodoc
abstract mixin class $LiveIconConfigCopyWith<$Res>  {
  factory $LiveIconConfigCopyWith(LiveIconConfig value, $Res Function(LiveIconConfig) _then) = _$LiveIconConfigCopyWithImpl;
@useResult
$Res call({
 bool visible, double size, String color, LivePositionConfig position
});


$LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class _$LiveIconConfigCopyWithImpl<$Res>
    implements $LiveIconConfigCopyWith<$Res> {
  _$LiveIconConfigCopyWithImpl(this._self, this._then);

  final LiveIconConfig _self;
  final $Res Function(LiveIconConfig) _then;

/// Create a copy of LiveIconConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visible = null,Object? size = null,Object? color = null,Object? position = null,}) {
  return _then(_self.copyWith(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}
/// Create a copy of LiveIconConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveIconConfig].
extension LiveIconConfigPatterns on LiveIconConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveIconConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveIconConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveIconConfig value)  $default,){
final _that = this;
switch (_that) {
case _LiveIconConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveIconConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LiveIconConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool visible,  double size,  String color,  LivePositionConfig position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveIconConfig() when $default != null:
return $default(_that.visible,_that.size,_that.color,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool visible,  double size,  String color,  LivePositionConfig position)  $default,) {final _that = this;
switch (_that) {
case _LiveIconConfig():
return $default(_that.visible,_that.size,_that.color,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool visible,  double size,  String color,  LivePositionConfig position)?  $default,) {final _that = this;
switch (_that) {
case _LiveIconConfig() when $default != null:
return $default(_that.visible,_that.size,_that.color,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveIconConfig implements LiveIconConfig {
  const _LiveIconConfig({this.visible = true, this.size = 20.0, this.color = '#FF21F375', this.position = const LivePositionConfig()});
  factory _LiveIconConfig.fromJson(Map<String, dynamic> json) => _$LiveIconConfigFromJson(json);

@override@JsonKey() final  bool visible;
@override@JsonKey() final  double size;
@override@JsonKey() final  String color;
@override@JsonKey() final  LivePositionConfig position;

/// Create a copy of LiveIconConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveIconConfigCopyWith<_LiveIconConfig> get copyWith => __$LiveIconConfigCopyWithImpl<_LiveIconConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveIconConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveIconConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,size,color,position);

@override
String toString() {
  return 'LiveIconConfig(visible: $visible, size: $size, color: $color, position: $position)';
}


}

/// @nodoc
abstract mixin class _$LiveIconConfigCopyWith<$Res> implements $LiveIconConfigCopyWith<$Res> {
  factory _$LiveIconConfigCopyWith(_LiveIconConfig value, $Res Function(_LiveIconConfig) _then) = __$LiveIconConfigCopyWithImpl;
@override @useResult
$Res call({
 bool visible, double size, String color, LivePositionConfig position
});


@override $LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class __$LiveIconConfigCopyWithImpl<$Res>
    implements _$LiveIconConfigCopyWith<$Res> {
  __$LiveIconConfigCopyWithImpl(this._self, this._then);

  final _LiveIconConfig _self;
  final $Res Function(_LiveIconConfig) _then;

/// Create a copy of LiveIconConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visible = null,Object? size = null,Object? color = null,Object? position = null,}) {
  return _then(_LiveIconConfig(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}

/// Create a copy of LiveIconConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// @nodoc
mixin _$LiveTextConfig {

 bool get visible; String get color; double get fontSize; LivePositionConfig get position;
/// Create a copy of LiveTextConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveTextConfigCopyWith<LiveTextConfig> get copyWith => _$LiveTextConfigCopyWithImpl<LiveTextConfig>(this as LiveTextConfig, _$identity);

  /// Serializes this LiveTextConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTextConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.color, color) || other.color == color)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,color,fontSize,position);

@override
String toString() {
  return 'LiveTextConfig(visible: $visible, color: $color, fontSize: $fontSize, position: $position)';
}


}

/// @nodoc
abstract mixin class $LiveTextConfigCopyWith<$Res>  {
  factory $LiveTextConfigCopyWith(LiveTextConfig value, $Res Function(LiveTextConfig) _then) = _$LiveTextConfigCopyWithImpl;
@useResult
$Res call({
 bool visible, String color, double fontSize, LivePositionConfig position
});


$LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class _$LiveTextConfigCopyWithImpl<$Res>
    implements $LiveTextConfigCopyWith<$Res> {
  _$LiveTextConfigCopyWithImpl(this._self, this._then);

  final LiveTextConfig _self;
  final $Res Function(LiveTextConfig) _then;

/// Create a copy of LiveTextConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visible = null,Object? color = null,Object? fontSize = null,Object? position = null,}) {
  return _then(_self.copyWith(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}
/// Create a copy of LiveTextConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveTextConfig].
extension LiveTextConfigPatterns on LiveTextConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveTextConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveTextConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveTextConfig value)  $default,){
final _that = this;
switch (_that) {
case _LiveTextConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveTextConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LiveTextConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool visible,  String color,  double fontSize,  LivePositionConfig position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveTextConfig() when $default != null:
return $default(_that.visible,_that.color,_that.fontSize,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool visible,  String color,  double fontSize,  LivePositionConfig position)  $default,) {final _that = this;
switch (_that) {
case _LiveTextConfig():
return $default(_that.visible,_that.color,_that.fontSize,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool visible,  String color,  double fontSize,  LivePositionConfig position)?  $default,) {final _that = this;
switch (_that) {
case _LiveTextConfig() when $default != null:
return $default(_that.visible,_that.color,_that.fontSize,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveTextConfig implements LiveTextConfig {
  const _LiveTextConfig({this.visible = true, this.color = '#FFFFFFFF', this.fontSize = 14.0, this.position = const LivePositionConfig()});
  factory _LiveTextConfig.fromJson(Map<String, dynamic> json) => _$LiveTextConfigFromJson(json);

@override@JsonKey() final  bool visible;
@override@JsonKey() final  String color;
@override@JsonKey() final  double fontSize;
@override@JsonKey() final  LivePositionConfig position;

/// Create a copy of LiveTextConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveTextConfigCopyWith<_LiveTextConfig> get copyWith => __$LiveTextConfigCopyWithImpl<_LiveTextConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveTextConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveTextConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.color, color) || other.color == color)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,color,fontSize,position);

@override
String toString() {
  return 'LiveTextConfig(visible: $visible, color: $color, fontSize: $fontSize, position: $position)';
}


}

/// @nodoc
abstract mixin class _$LiveTextConfigCopyWith<$Res> implements $LiveTextConfigCopyWith<$Res> {
  factory _$LiveTextConfigCopyWith(_LiveTextConfig value, $Res Function(_LiveTextConfig) _then) = __$LiveTextConfigCopyWithImpl;
@override @useResult
$Res call({
 bool visible, String color, double fontSize, LivePositionConfig position
});


@override $LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class __$LiveTextConfigCopyWithImpl<$Res>
    implements _$LiveTextConfigCopyWith<$Res> {
  __$LiveTextConfigCopyWithImpl(this._self, this._then);

  final _LiveTextConfig _self;
  final $Res Function(_LiveTextConfig) _then;

/// Create a copy of LiveTextConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visible = null,Object? color = null,Object? fontSize = null,Object? position = null,}) {
  return _then(_LiveTextConfig(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}

/// Create a copy of LiveTextConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// @nodoc
mixin _$LiveSecurityMessageConfig {

 bool get visible; String get color; double get fontSize; String get backgroundColor; double get height; double get containerWidth; LivePositionConfig get position;
/// Create a copy of LiveSecurityMessageConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveSecurityMessageConfigCopyWith<LiveSecurityMessageConfig> get copyWith => _$LiveSecurityMessageConfigCopyWithImpl<LiveSecurityMessageConfig>(this as LiveSecurityMessageConfig, _$identity);

  /// Serializes this LiveSecurityMessageConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveSecurityMessageConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.color, color) || other.color == color)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.height, height) || other.height == height)&&(identical(other.containerWidth, containerWidth) || other.containerWidth == containerWidth)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,color,fontSize,backgroundColor,height,containerWidth,position);

@override
String toString() {
  return 'LiveSecurityMessageConfig(visible: $visible, color: $color, fontSize: $fontSize, backgroundColor: $backgroundColor, height: $height, containerWidth: $containerWidth, position: $position)';
}


}

/// @nodoc
abstract mixin class $LiveSecurityMessageConfigCopyWith<$Res>  {
  factory $LiveSecurityMessageConfigCopyWith(LiveSecurityMessageConfig value, $Res Function(LiveSecurityMessageConfig) _then) = _$LiveSecurityMessageConfigCopyWithImpl;
@useResult
$Res call({
 bool visible, String color, double fontSize, String backgroundColor, double height, double containerWidth, LivePositionConfig position
});


$LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class _$LiveSecurityMessageConfigCopyWithImpl<$Res>
    implements $LiveSecurityMessageConfigCopyWith<$Res> {
  _$LiveSecurityMessageConfigCopyWithImpl(this._self, this._then);

  final LiveSecurityMessageConfig _self;
  final $Res Function(LiveSecurityMessageConfig) _then;

/// Create a copy of LiveSecurityMessageConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? visible = null,Object? color = null,Object? fontSize = null,Object? backgroundColor = null,Object? height = null,Object? containerWidth = null,Object? position = null,}) {
  return _then(_self.copyWith(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,containerWidth: null == containerWidth ? _self.containerWidth : containerWidth // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}
/// Create a copy of LiveSecurityMessageConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveSecurityMessageConfig].
extension LiveSecurityMessageConfigPatterns on LiveSecurityMessageConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveSecurityMessageConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveSecurityMessageConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveSecurityMessageConfig value)  $default,){
final _that = this;
switch (_that) {
case _LiveSecurityMessageConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveSecurityMessageConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LiveSecurityMessageConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool visible,  String color,  double fontSize,  String backgroundColor,  double height,  double containerWidth,  LivePositionConfig position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveSecurityMessageConfig() when $default != null:
return $default(_that.visible,_that.color,_that.fontSize,_that.backgroundColor,_that.height,_that.containerWidth,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool visible,  String color,  double fontSize,  String backgroundColor,  double height,  double containerWidth,  LivePositionConfig position)  $default,) {final _that = this;
switch (_that) {
case _LiveSecurityMessageConfig():
return $default(_that.visible,_that.color,_that.fontSize,_that.backgroundColor,_that.height,_that.containerWidth,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool visible,  String color,  double fontSize,  String backgroundColor,  double height,  double containerWidth,  LivePositionConfig position)?  $default,) {final _that = this;
switch (_that) {
case _LiveSecurityMessageConfig() when $default != null:
return $default(_that.visible,_that.color,_that.fontSize,_that.backgroundColor,_that.height,_that.containerWidth,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveSecurityMessageConfig implements LiveSecurityMessageConfig {
  const _LiveSecurityMessageConfig({this.visible = true, this.color = '#FFFFFFFF', this.fontSize = 14.0, this.backgroundColor = '#B0515151', this.height = 30.0, this.containerWidth = 300.0, this.position = const LivePositionConfig()});
  factory _LiveSecurityMessageConfig.fromJson(Map<String, dynamic> json) => _$LiveSecurityMessageConfigFromJson(json);

@override@JsonKey() final  bool visible;
@override@JsonKey() final  String color;
@override@JsonKey() final  double fontSize;
@override@JsonKey() final  String backgroundColor;
@override@JsonKey() final  double height;
@override@JsonKey() final  double containerWidth;
@override@JsonKey() final  LivePositionConfig position;

/// Create a copy of LiveSecurityMessageConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveSecurityMessageConfigCopyWith<_LiveSecurityMessageConfig> get copyWith => __$LiveSecurityMessageConfigCopyWithImpl<_LiveSecurityMessageConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveSecurityMessageConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveSecurityMessageConfig&&(identical(other.visible, visible) || other.visible == visible)&&(identical(other.color, color) || other.color == color)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.height, height) || other.height == height)&&(identical(other.containerWidth, containerWidth) || other.containerWidth == containerWidth)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,visible,color,fontSize,backgroundColor,height,containerWidth,position);

@override
String toString() {
  return 'LiveSecurityMessageConfig(visible: $visible, color: $color, fontSize: $fontSize, backgroundColor: $backgroundColor, height: $height, containerWidth: $containerWidth, position: $position)';
}


}

/// @nodoc
abstract mixin class _$LiveSecurityMessageConfigCopyWith<$Res> implements $LiveSecurityMessageConfigCopyWith<$Res> {
  factory _$LiveSecurityMessageConfigCopyWith(_LiveSecurityMessageConfig value, $Res Function(_LiveSecurityMessageConfig) _then) = __$LiveSecurityMessageConfigCopyWithImpl;
@override @useResult
$Res call({
 bool visible, String color, double fontSize, String backgroundColor, double height, double containerWidth, LivePositionConfig position
});


@override $LivePositionConfigCopyWith<$Res> get position;

}
/// @nodoc
class __$LiveSecurityMessageConfigCopyWithImpl<$Res>
    implements _$LiveSecurityMessageConfigCopyWith<$Res> {
  __$LiveSecurityMessageConfigCopyWithImpl(this._self, this._then);

  final _LiveSecurityMessageConfig _self;
  final $Res Function(_LiveSecurityMessageConfig) _then;

/// Create a copy of LiveSecurityMessageConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? visible = null,Object? color = null,Object? fontSize = null,Object? backgroundColor = null,Object? height = null,Object? containerWidth = null,Object? position = null,}) {
  return _then(_LiveSecurityMessageConfig(
visible: null == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,containerWidth: null == containerWidth ? _self.containerWidth : containerWidth // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LivePositionConfig,
  ));
}

/// Create a copy of LiveSecurityMessageConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<$Res> get position {
  
  return $LivePositionConfigCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}
}


/// @nodoc
mixin _$LivePositionConfig {

 double get x; double get y;
/// Create a copy of LivePositionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePositionConfigCopyWith<LivePositionConfig> get copyWith => _$LivePositionConfigCopyWithImpl<LivePositionConfig>(this as LivePositionConfig, _$identity);

  /// Serializes this LivePositionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePositionConfig&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'LivePositionConfig(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $LivePositionConfigCopyWith<$Res>  {
  factory $LivePositionConfigCopyWith(LivePositionConfig value, $Res Function(LivePositionConfig) _then) = _$LivePositionConfigCopyWithImpl;
@useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class _$LivePositionConfigCopyWithImpl<$Res>
    implements $LivePositionConfigCopyWith<$Res> {
  _$LivePositionConfigCopyWithImpl(this._self, this._then);

  final LivePositionConfig _self;
  final $Res Function(LivePositionConfig) _then;

/// Create a copy of LivePositionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePositionConfig].
extension LivePositionConfigPatterns on LivePositionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePositionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePositionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePositionConfig value)  $default,){
final _that = this;
switch (_that) {
case _LivePositionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePositionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LivePositionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double x,  double y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePositionConfig() when $default != null:
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double x,  double y)  $default,) {final _that = this;
switch (_that) {
case _LivePositionConfig():
return $default(_that.x,_that.y);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double x,  double y)?  $default,) {final _that = this;
switch (_that) {
case _LivePositionConfig() when $default != null:
return $default(_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePositionConfig implements LivePositionConfig {
  const _LivePositionConfig({this.x = 0.0, this.y = 0.0});
  factory _LivePositionConfig.fromJson(Map<String, dynamic> json) => _$LivePositionConfigFromJson(json);

@override@JsonKey() final  double x;
@override@JsonKey() final  double y;

/// Create a copy of LivePositionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePositionConfigCopyWith<_LivePositionConfig> get copyWith => __$LivePositionConfigCopyWithImpl<_LivePositionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePositionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePositionConfig&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'LivePositionConfig(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$LivePositionConfigCopyWith<$Res> implements $LivePositionConfigCopyWith<$Res> {
  factory _$LivePositionConfigCopyWith(_LivePositionConfig value, $Res Function(_LivePositionConfig) _then) = __$LivePositionConfigCopyWithImpl;
@override @useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class __$LivePositionConfigCopyWithImpl<$Res>
    implements _$LivePositionConfigCopyWith<$Res> {
  __$LivePositionConfigCopyWithImpl(this._self, this._then);

  final _LivePositionConfig _self;
  final $Res Function(_LivePositionConfig) _then;

/// Create a copy of LivePositionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_LivePositionConfig(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
