// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_subscription_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SmsSubscriptionService 的 @Riverpod Provider

@ProviderFor(smsSubscriptionService)
final smsSubscriptionServiceProvider = SmsSubscriptionServiceProvider._();

/// SmsSubscriptionService 的 @Riverpod Provider

final class SmsSubscriptionServiceProvider
    extends
        $FunctionalProvider<
          SmsSubscriptionService,
          SmsSubscriptionService,
          SmsSubscriptionService
        >
    with $Provider<SmsSubscriptionService> {
  /// SmsSubscriptionService 的 @Riverpod Provider
  SmsSubscriptionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'smsSubscriptionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$smsSubscriptionServiceHash();

  @$internal
  @override
  $ProviderElement<SmsSubscriptionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SmsSubscriptionService create(Ref ref) {
    return smsSubscriptionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SmsSubscriptionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SmsSubscriptionService>(value),
    );
  }
}

String _$smsSubscriptionServiceHash() =>
    r'fcce99aad40a2187035a580f77901c910d125601';
