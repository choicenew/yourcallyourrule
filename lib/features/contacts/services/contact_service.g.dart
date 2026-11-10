// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ContactService 的 @Riverpod Provider

@ProviderFor(contactService)
final contactServiceProvider = ContactServiceProvider._();

/// ContactService 的 @Riverpod Provider

final class ContactServiceProvider
    extends $FunctionalProvider<ContactService, ContactService, ContactService>
    with $Provider<ContactService> {
  /// ContactService 的 @Riverpod Provider
  ContactServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'contact_service_hash_v2';

  @$internal
  @override
  $ProviderElement<ContactService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ContactService create(Ref ref) {
    return contactService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactService>(value),
    );
  }
}
