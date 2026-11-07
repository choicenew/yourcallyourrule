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
  String debugGetCreateSourceHash() => _$contactServiceHash();

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

String _$contactServiceHash() => r'f6bdc87b992010321bf93b88aa5797a885036f88';
