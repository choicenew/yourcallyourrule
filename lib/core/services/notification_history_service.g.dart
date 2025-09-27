// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_history_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'48e60558ea6530114ea20ea03e69b9fb339ab129';

@ProviderFor(notificationHistoryService)
const notificationHistoryServiceProvider =
    NotificationHistoryServiceProvider._();

final class NotificationHistoryServiceProvider
    extends
        $FunctionalProvider<
          NotificationHistoryService,
          NotificationHistoryService,
          NotificationHistoryService
        >
    with $Provider<NotificationHistoryService> {
  const NotificationHistoryServiceProvider._()
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
    r'80ec23f526eeae9369824753f9746a881c8366c1';
