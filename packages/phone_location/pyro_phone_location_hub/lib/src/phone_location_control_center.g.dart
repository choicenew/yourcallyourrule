// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_location_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneLocationControlCenter)
final phoneLocationControlCenterProvider =
    PhoneLocationControlCenterProvider._();

final class PhoneLocationControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneLocationControlCenter,
          PhoneLocationControlCenter,
          PhoneLocationControlCenter
        >
    with $Provider<PhoneLocationControlCenter> {
  PhoneLocationControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneLocationControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneLocationControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneLocationControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneLocationControlCenter create(Ref ref) {
    return phoneLocationControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneLocationControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneLocationControlCenter>(value),
    );
  }
}

String _$phoneLocationControlCenterHash() =>
    r'bc0b4cb33f83f7caef578f47850c683ba4e27a74';
