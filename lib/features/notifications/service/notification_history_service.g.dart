// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_history_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationHistoryService)
final notificationHistoryServiceProvider =
    NotificationHistoryServiceProvider._();

final class NotificationHistoryServiceProvider
    extends
        $FunctionalProvider<
          NotificationHistoryService,
          NotificationHistoryService,
          NotificationHistoryService
        >
    with $Provider<NotificationHistoryService> {
  NotificationHistoryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationHistoryServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationHistoryServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationHistoryService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationHistoryService create(Ref ref) {
    return notificationHistoryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationHistoryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationHistoryService>(value),
    );
  }
}

String _$notificationHistoryServiceHash() =>
    r'ffc9b1e2db6609c719929996dafdfd937e5a4206';
