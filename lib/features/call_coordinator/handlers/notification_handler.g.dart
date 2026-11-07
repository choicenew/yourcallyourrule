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
          AsyncValue<NotificationHandler>,
          NotificationHandler,
          FutureOr<NotificationHandler>
        >
    with
        $FutureModifier<NotificationHandler>,
        $FutureProvider<NotificationHandler> {
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
  $FutureProviderElement<NotificationHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationHandler> create(Ref ref) {
    return notificationHandler(ref);
  }
}

String _$notificationHandlerHash() =>
    r'8dc4933c28faf37d3d064541de2aa77297f3c71e';
