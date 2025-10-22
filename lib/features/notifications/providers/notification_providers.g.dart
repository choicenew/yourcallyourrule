// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 这个 Provider 将 NotificationService 的实例绑定到 NotificationServiceContract 接口上。

@ProviderFor(notificationService)
const notificationServiceProvider = NotificationServiceProvider._();

/// 这个 Provider 将 NotificationService 的实例绑定到 NotificationServiceContract 接口上。

final class NotificationServiceProvider
    extends
        $FunctionalProvider<
          NotificationServiceContract,
          NotificationServiceContract,
          NotificationServiceContract
        >
    with $Provider<NotificationServiceContract> {
  /// 这个 Provider 将 NotificationService 的实例绑定到 NotificationServiceContract 接口上。
  const NotificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationServiceContract> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationServiceContract create(Ref ref) {
    return notificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationServiceContract value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationServiceContract>(value),
    );
  }
}

String _$notificationServiceHash() =>
    r'80ed6afcd03b32d754ae237b5835e37df1dc9aed';
