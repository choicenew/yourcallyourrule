// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_storage_driver.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contactStorageDriver)
final contactStorageDriverProvider = ContactStorageDriverProvider._();

final class ContactStorageDriverProvider
    extends
        $FunctionalProvider<
          ContactStorageDriver,
          ContactStorageDriver,
          ContactStorageDriver
        >
    with $Provider<ContactStorageDriver> {
  ContactStorageDriverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contactStorageDriverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contactStorageDriverHash();

  @$internal
  @override
  $ProviderElement<ContactStorageDriver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContactStorageDriver create(Ref ref) {
    return contactStorageDriver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContactStorageDriver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContactStorageDriver>(value),
    );
  }
}

String _$contactStorageDriverHash() =>
    r'2c777d58687383f009c377a17cda642e1906b693';
