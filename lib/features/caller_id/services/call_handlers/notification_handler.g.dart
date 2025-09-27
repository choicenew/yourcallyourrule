// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationHandler)
const notificationHandlerProvider = NotificationHandlerProvider._();

final class NotificationHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationHandler>,
          NotificationHandler,
          FutureOr<NotificationHandler>
        >
    with
        $FutureModifier<NotificationHandler>,
        $FutureProvider<NotificationHandler> {
  const NotificationHandlerProvider._()
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
  $FutureProviderElement<NotificationHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationHandler> create(Ref ref) {
    return notificationHandler(ref);
  }
}

String _$notificationHandlerHash() =>
    r'6148af052f13e58e9dda26132f2764358c6600b8';
