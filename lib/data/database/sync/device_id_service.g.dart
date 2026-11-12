// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_id_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DeviceIdService Provider (主 App 极简设备服务兼容层)

@ProviderFor(deviceIdService)
final deviceIdServiceProvider = DeviceIdServiceProvider._();

/// DeviceIdService Provider (主 App 极简设备服务兼容层)

final class DeviceIdServiceProvider
    extends
        $FunctionalProvider<DeviceIdService, DeviceIdService, DeviceIdService>
    with $Provider<DeviceIdService> {
  /// DeviceIdService Provider (主 App 极简设备服务兼容层)
  DeviceIdServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceIdServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceIdServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceIdService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DeviceIdService create(Ref ref) {
    return deviceIdService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceIdService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceIdService>(value),
    );
  }
}

String _$deviceIdServiceHash() => r'9e5f265efde563bf6fb162b190739a544cbe17a7';
