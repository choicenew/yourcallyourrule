// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_contacts_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneContactsControlCenter)
final phoneContactsControlCenterProvider =
    PhoneContactsControlCenterProvider._();

final class PhoneContactsControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneContactsControlCenter,
          PhoneContactsControlCenter,
          PhoneContactsControlCenter
        >
    with $Provider<PhoneContactsControlCenter> {
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
  String debugGetCreateSourceHash() => _$phoneContactsControlCenterHash();

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

String _$phoneContactsControlCenterHash() =>
    r'c81e0262ff9535d678bdf295dbc6e9798569853d';
