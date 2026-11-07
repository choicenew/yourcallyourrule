// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_profile_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceProfileControlCenter)
final deviceProfileControlCenterProvider =
    DeviceProfileControlCenterProvider._();

final class DeviceProfileControlCenterProvider
    extends
        $FunctionalProvider<
          DeviceProfileControlCenter,
          DeviceProfileControlCenter,
          DeviceProfileControlCenter
        >
    with $Provider<DeviceProfileControlCenter> {
  DeviceProfileControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceProfileControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceProfileControlCenterHash();

  @$internal
  @override
  $ProviderElement<DeviceProfileControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceProfileControlCenter create(Ref ref) {
    return deviceProfileControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceProfileControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceProfileControlCenter>(value),
    );
  }
}

String _$deviceProfileControlCenterHash() =>
    r'3eab3b7035e98094bea42801270dcb4534d82435';
