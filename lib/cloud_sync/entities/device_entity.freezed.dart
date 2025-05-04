// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceEntity _$DeviceEntityFromJson(Map<String, dynamic> json) {
  return _DeviceEntity.fromJson(json);
}

/// @nodoc
mixin _$DeviceEntity {
  /// Unique device identifier
  String get id => throw _privateConstructorUsedError;

  /// User-friendly device name
  String get name => throw _privateConstructorUsedError;

  /// Device model information
  String get model => throw _privateConstructorUsedError;

  /// Last sync timestamp
  DateTime get lastSyncTime => throw _privateConstructorUsedError;

  /// Device status (active, inactive)
  bool get isActive => throw _privateConstructorUsedError;

  /// Additional device information
  Map<String, dynamic>? get deviceInfo => throw _privateConstructorUsedError;

  /// Serializes this DeviceEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeviceEntityCopyWith<DeviceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceEntityCopyWith<$Res> {
  factory $DeviceEntityCopyWith(
          DeviceEntity value, $Res Function(DeviceEntity) then) =
      _$DeviceEntityCopyWithImpl<$Res, DeviceEntity>;
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
class _$DeviceEntityCopyWithImpl<$Res, $Val extends DeviceEntity>
    implements $DeviceEntityCopyWith<$Res> {
  _$DeviceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceInfo: freezed == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceEntityImplCopyWith<$Res>
    implements $DeviceEntityCopyWith<$Res> {
  factory _$$DeviceEntityImplCopyWith(
          _$DeviceEntityImpl value, $Res Function(_$DeviceEntityImpl) then) =
      __$$DeviceEntityImplCopyWithImpl<$Res>;
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
class __$$DeviceEntityImplCopyWithImpl<$Res>
    extends _$DeviceEntityCopyWithImpl<$Res, _$DeviceEntityImpl>
    implements _$$DeviceEntityImplCopyWith<$Res> {
  __$$DeviceEntityImplCopyWithImpl(
      _$DeviceEntityImpl _value, $Res Function(_$DeviceEntityImpl) _then)
      : super(_value, _then);

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
    return _then(_$DeviceEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      lastSyncTime: null == lastSyncTime
          ? _value.lastSyncTime
          : lastSyncTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      deviceInfo: freezed == deviceInfo
          ? _value._deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceEntityImpl implements _DeviceEntity {
  const _$DeviceEntityImpl(
      {required this.id,
      required this.name,
      required this.model,
      required this.lastSyncTime,
      this.isActive = true,
      final Map<String, dynamic>? deviceInfo})
      : _deviceInfo = deviceInfo;

  factory _$DeviceEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceEntityImplFromJson(json);

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

  @override
  String toString() {
    return 'DeviceEntity(id: $id, name: $name, model: $model, lastSyncTime: $lastSyncTime, isActive: $isActive, deviceInfo: $deviceInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceEntityImpl &&
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

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceEntityImplCopyWith<_$DeviceEntityImpl> get copyWith =>
      __$$DeviceEntityImplCopyWithImpl<_$DeviceEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceEntityImplToJson(
      this,
    );
  }
}

abstract class _DeviceEntity implements DeviceEntity {
  const factory _DeviceEntity(
      {required final String id,
      required final String name,
      required final String model,
      required final DateTime lastSyncTime,
      final bool isActive,
      final Map<String, dynamic>? deviceInfo}) = _$DeviceEntityImpl;

  factory _DeviceEntity.fromJson(Map<String, dynamic> json) =
      _$DeviceEntityImpl.fromJson;

  /// Unique device identifier
  @override
  String get id;

  /// User-friendly device name
  @override
  String get name;

  /// Device model information
  @override
  String get model;

  /// Last sync timestamp
  @override
  DateTime get lastSyncTime;

  /// Device status (active, inactive)
  @override
  bool get isActive;

  /// Additional device information
  @override
  Map<String, dynamic>? get deviceInfo;

  /// Create a copy of DeviceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeviceEntityImplCopyWith<_$DeviceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
