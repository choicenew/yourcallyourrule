// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_subscription_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PhoneSubscriptionService 的 @Riverpod Provider

@ProviderFor(phoneSubscriptionService)
final phoneSubscriptionServiceProvider = PhoneSubscriptionServiceProvider._();

/// PhoneSubscriptionService 的 @Riverpod Provider

final class PhoneSubscriptionServiceProvider
    extends
        $FunctionalProvider<
          PhoneSubscriptionService,
          PhoneSubscriptionService,
          PhoneSubscriptionService
        >
    with $Provider<PhoneSubscriptionService> {
  /// PhoneSubscriptionService 的 @Riverpod Provider
  PhoneSubscriptionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneSubscriptionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneSubscriptionServiceHash();

  @$internal
  @override
  $ProviderElement<PhoneSubscriptionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneSubscriptionService create(Ref ref) {
    return phoneSubscriptionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneSubscriptionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneSubscriptionService>(value),
    );
  }
}

String _$phoneSubscriptionServiceHash() =>
    r'49b0684490769c82e92701ae40d5b21071b38909';
