// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_frequency_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationFrequencyService)
const notificationFrequencyServiceProvider =
    NotificationFrequencyServiceProvider._();

final class NotificationFrequencyServiceProvider
    extends
        $FunctionalProvider<
          NotificationFrequencyService,
          NotificationFrequencyService,
          NotificationFrequencyService
        >
    with $Provider<NotificationFrequencyService> {
  const NotificationFrequencyServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationFrequencyServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationFrequencyServiceHash();

  @$internal
  @override
  $ProviderElement<NotificationFrequencyService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationFrequencyService create(Ref ref) {
    return notificationFrequencyService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationFrequencyService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationFrequencyService>(value),
    );
  }
}

String _$notificationFrequencyServiceHash() =>
    r'76713e3206ddbecc30ee25c62b2d25b6550bdca0';
