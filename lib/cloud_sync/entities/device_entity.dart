import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_entity.freezed.dart';
part 'device_entity.g.dart';

/// Entity representing a device for multi-device synchronization
@freezed
class DeviceEntity with _$DeviceEntity {
  /// Default constructor
  const factory DeviceEntity({
    /// Unique device identifier
    required String id,
    
    /// User-friendly device name
    required String name,
    
    /// Device model information
    required String model,
    
    /// Last sync timestamp
    required DateTime lastSyncTime,
    
    /// Device status (active, inactive)
    @Default(true) bool isActive,
    
    /// Additional device information
    Map<String, dynamic>? deviceInfo,
  }) = _DeviceEntity;

  /// Create from JSON
  factory DeviceEntity.fromJson(Map<String, dynamic> json) =>
      _$DeviceEntityFromJson(json);
}