// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_subscription_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ContactSubscriptionService Riverpod Provider

@ProviderFor(contactSubscriptionService)
final contactSubscriptionServiceProvider =
    ContactSubscriptionServiceProvider._();

/// ContactSubscriptionService Riverpod Provider

final class ContactSubscriptionServiceProvider
    extends
        $FunctionalProvider<
          ContactSubscriptionService,
          ContactSubscriptionService,
          ContactSubscriptionService
        >
    with $Provider<ContactSubscriptionService> {
  /// ContactSubscriptionService Riverpod Provider
  ContactSubscriptionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactSubscriptionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactSubscriptionServiceHash();

  @$internal
  @override
  $ProviderElement<ContactSubscriptionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContactSubscriptionService create(Ref ref) {
    return contactSubscriptionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactSubscriptionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactSubscriptionService>(value),
    );
  }
}

String _$contactSubscriptionServiceHash() =>
    r'a57bfddcf0e64e7b73a0eb61c055480df2b38a81';
