// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_profile_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DeviceProfileService 的 @Riverpod Provider

@ProviderFor(deviceProfileService)
final deviceProfileServiceProvider = DeviceProfileServiceProvider._();

/// DeviceProfileService 的 @Riverpod Provider

final class DeviceProfileServiceProvider
    extends
        $FunctionalProvider<
          DeviceProfileService,
          DeviceProfileService,
          DeviceProfileService
        >
    with $Provider<DeviceProfileService> {
  /// DeviceProfileService 的 @Riverpod Provider
  DeviceProfileServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceProfileServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceProfileServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceProfileService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceProfileService create(Ref ref) {
    return deviceProfileService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceProfileService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceProfileService>(value),
    );
  }
}

String _$deviceProfileServiceHash() =>
    r'f42adce61a5fb42d32f448c7c29be64166af83ec';
