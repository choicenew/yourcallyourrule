// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_asset_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 通知资源服务 Provider
///
/// 这是一个简单的服务型 Provider，提供一个 NotificationAssetService 的单例。

@ProviderFor(notificationAssetService)
const notificationAssetServiceProvider = NotificationAssetServiceProvider._();

/// 通知资源服务 Provider
///
/// 这是一个简单的服务型 Provider，提供一个 NotificationAssetService 的单例。

final class NotificationAssetServiceProvider
    extends
        $FunctionalProvider<
          NotificationAssetService,
          NotificationAssetService,
          NotificationAssetService
        >
    with $Provider<NotificationAssetService> {
  /// 通知资源服务 Provider
  ///
  /// 这是一个简单的服务型 Provider，提供一个 NotificationAssetService 的单例。
  const NotificationAssetServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationAssetServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationAssetServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationAssetService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationAssetService create(Ref ref) {
    return notificationAssetService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationAssetService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationAssetService>(value),
    );
  }
}

String _$notificationAssetServiceHash() =>
    r'7f8b5280e8d3a484d45bd9e14a16d72d85ab9d93';
