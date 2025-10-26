// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_profile_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DeviceProfileService 的 Provider。
///
/// 使用 @riverpod 注解，使其可以在整个应用中被依赖注入。
/// 由于 DeviceProfileService 没有任何构造函数依赖，所以它的 Provider 非常简单。

@ProviderFor(deviceProfileService)
const deviceProfileServiceProvider = DeviceProfileServiceProvider._();

/// DeviceProfileService 的 Provider。
///
/// 使用 @riverpod 注解，使其可以在整个应用中被依赖注入。
/// 由于 DeviceProfileService 没有任何构造函数依赖，所以它的 Provider 非常简单。

final class DeviceProfileServiceProvider
    extends
        $FunctionalProvider<
          DeviceProfileService,
          DeviceProfileService,
          DeviceProfileService
        >
    with $Provider<DeviceProfileService> {
  /// DeviceProfileService 的 Provider。
  ///
  /// 使用 @riverpod 注解，使其可以在整个应用中被依赖注入。
  /// 由于 DeviceProfileService 没有任何构造函数依赖，所以它的 Provider 非常简单。
  const DeviceProfileServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceProfileServiceProvider',
        isAutoDispose: true,
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
    r'0b487a4101a1833c86f225fa3584e766cf0a5aff';
