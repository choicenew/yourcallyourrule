// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_contacts_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// PhoneContactsControlCenter Provider

@ProviderFor(phoneContactsControlCenter)
final phoneContactsControlCenterProvider = PhoneContactsControlCenterProvider._();

/// PhoneContactsControlCenter Provider

final class PhoneContactsControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneContactsControlCenter,
          PhoneContactsControlCenter,
          PhoneContactsControlCenter
        >
    with $Provider<PhoneContactsControlCenter> {
  /// PhoneContactsControlCenter Provider
  PhoneContactsControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneContactsControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'phone_contacts_control_center_hash_v2';

  @$internal
  @override
  $ProviderElement<PhoneContactsControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneContactsControlCenter create(Ref ref) {
    return phoneContactsControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneContactsControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneContactsControlCenter>(value),
    );
  }
}
