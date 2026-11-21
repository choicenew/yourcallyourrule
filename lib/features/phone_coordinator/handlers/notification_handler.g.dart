// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationHandler)
final notificationHandlerProvider = NotificationHandlerProvider._();

final class NotificationHandlerProvider
    extends
        $FunctionalProvider<
          NotificationHandler,
          NotificationHandler,
          NotificationHandler
        >
    with $Provider<NotificationHandler> {
  NotificationHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHandlerHash();

  @$internal
  @override
  $ProviderElement<NotificationHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationHandler create(Ref ref) {
    return notificationHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationHandler>(value),
    );
  }
}

String _$notificationHandlerHash() =>
    r'46d732daa9e0b66bc6ffb258699579a21e56f14f';
