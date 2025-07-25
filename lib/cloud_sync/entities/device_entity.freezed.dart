// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceEntity {
  /// Unique device identifier
  String get id;

  /// User-friendly device name
  String get name;

  /// Device model information
  String get model;

  /// Last sync timestamp
  DateTime get lastSyncTime;

  /// Device status (active, inactive)
  bool get isActive;

  /// Additional device information
  Map<String, dynamic>? get deviceInfo;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeviceEntityCopyWith<DeviceEntity> get copyWith =>
      _$DeviceEntityCopyWithImpl<DeviceEntity>(
          this as DeviceEntity, _$identity);

  /// Serializes this DeviceEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeviceEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality()
                .equals(other.deviceInfo, deviceInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, model, lastSyncTime,
      isActive, const DeepCollectionEquality().hash(deviceInfo));

  @override
  String toString() {
    return 'DeviceEntity(id: $id, name: $name, model: $model, lastSyncTime: $lastSyncTime, isActive: $isActive, deviceInfo: $deviceInfo)';
  }
}

/// @nodoc
abstract mixin class $DeviceEntityCopyWith<$Res> {
  factory $DeviceEntityCopyWith(
          DeviceEntity value, $Res Function(DeviceEntity) _then) =
      _$DeviceEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String model,
      DateTime lastSyncTime,
      bool isActive,
      Map<String, dynamic>? deviceInfo});
}

/// @nodoc
class _$DeviceEntityCopyWithImpl<$Res> implements $DeviceEntityCopyWith<$Res> {
  _$DeviceEntityCopyWithImpl(this._self, this._then);

  final DeviceEntity _self;
  final $Res Function(DeviceEntity) _then;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? model = null,
    Object? lastSyncTime = null,
    Object? isActive = null,
    Object? deviceInfo = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: null == lastSyncTime
          ? _self.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceInfo: freezed == deviceInfo
          ? _self.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DeviceEntity implements DeviceEntity {
  const _DeviceEntity(
      {required this.id,
      required this.name,
      required this.model,
      required this.lastSyncTime,
      this.isActive = true,
      final Map<String, dynamic>? deviceInfo})
      : _deviceInfo = deviceInfo;
  factory _DeviceEntity.fromJson(Map<String, dynamic> json) =>
      _$DeviceEntityFromJson(json);

  /// Unique device identifier
  @override
  final String id;

  /// User-friendly device name
  @override
  final String name;

  /// Device model information
  @override
  final String model;

  /// Last sync timestamp
  @override
  final DateTime lastSyncTime;

  /// Device status (active, inactive)
  @override
  @JsonKey()
  final bool isActive;

  /// Additional device information
  final Map<String, dynamic>? _deviceInfo;

  /// Additional device information
  @override
  Map<String, dynamic>? get deviceInfo {
    final value = _deviceInfo;
    if (value == null) return null;
    if (_deviceInfo is EqualUnmodifiableMapView) return _deviceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeviceEntityCopyWith<_DeviceEntity> get copyWith =>
      __$DeviceEntityCopyWithImpl<_DeviceEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DeviceEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeviceEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.lastSyncTime, lastSyncTime) ||
                other.lastSyncTime == lastSyncTime) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality()
                .equals(other._deviceInfo, _deviceInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, model, lastSyncTime,
      isActive, const DeepCollectionEquality().hash(_deviceInfo));

  @override
  String toString() {
    return 'DeviceEntity(id: $id, name: $name, model: $model, lastSyncTime: $lastSyncTime, isActive: $isActive, deviceInfo: $deviceInfo)';
  }
}

/// @nodoc
abstract mixin class _$DeviceEntityCopyWith<$Res>
    implements $DeviceEntityCopyWith<$Res> {
  factory _$DeviceEntityCopyWith(
          _DeviceEntity value, $Res Function(_DeviceEntity) _then) =
      __$DeviceEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String model,
      DateTime lastSyncTime,
      bool isActive,
      Map<String, dynamic>? deviceInfo});
}

/// @nodoc
class __$DeviceEntityCopyWithImpl<$Res>
    implements _$DeviceEntityCopyWith<$Res> {
  __$DeviceEntityCopyWithImpl(this._self, this._then);

  final _DeviceEntity _self;
  final $Res Function(_DeviceEntity) _then;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? model = null,
    Object? lastSyncTime = null,
    Object? isActive = null,
    Object? deviceInfo = freezed,
  }) {
    return _then(_DeviceEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: null == lastSyncTime
          ? _self.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceInfo: freezed == deviceInfo
          ? _self._deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

// dart format on
