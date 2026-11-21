// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_management_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceManagementService)
final deviceManagementServiceProvider = DeviceManagementServiceProvider._();

final class DeviceManagementServiceProvider
    extends
        $FunctionalProvider<
          DeviceManagementService,
          DeviceManagementService,
          DeviceManagementService
        >
    with $Provider<DeviceManagementService> {
  DeviceManagementServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceManagementServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceManagementServiceHash();

  @$internal
  @override
  $ProviderElement<DeviceManagementService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceManagementService create(Ref ref) {
    return deviceManagementService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceManagementService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceManagementService>(value),
    );
  }
}

String _$deviceManagementServiceHash() =>
    r'c5f259ee3dc3a224c137b243ea60b78b11397e07';

@ProviderFor(currentDevice)
final currentDeviceProvider = CurrentDeviceProvider._();

final class CurrentDeviceProvider
    extends
        $FunctionalProvider<
          AsyncValue<DeviceNode>,
          DeviceNode,
          FutureOr<DeviceNode>
        >
    with $FutureModifier<DeviceNode>, $FutureProvider<DeviceNode> {
  CurrentDeviceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDeviceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDeviceHash();

  @$internal
  @override
  $FutureProviderElement<DeviceNode> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DeviceNode> create(Ref ref) {
    return currentDevice(ref);
  }
}

String _$currentDeviceHash() => r'515042c99ec44b5362ce71202456148597b1007f';

@ProviderFor(registeredDevices)
final registeredDevicesProvider = RegisteredDevicesProvider._();

final class RegisteredDevicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DeviceNode>>,
          List<DeviceNode>,
          FutureOr<List<DeviceNode>>
        >
    with $FutureModifier<List<DeviceNode>>, $FutureProvider<List<DeviceNode>> {
  RegisteredDevicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registeredDevicesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registeredDevicesHash();

  @$internal
  @override
  $FutureProviderElement<List<DeviceNode>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DeviceNode>> create(Ref ref) {
    return registeredDevices(ref);
  }
}

String _$registeredDevicesHash() => r'9e395098f0ca03dedafcb916be6a7e3c6c1bada4';
