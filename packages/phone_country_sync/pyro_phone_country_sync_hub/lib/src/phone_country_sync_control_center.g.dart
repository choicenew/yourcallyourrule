// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_country_sync_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneCountrySyncControlCenter)
final phoneCountrySyncControlCenterProvider =
    PhoneCountrySyncControlCenterProvider._();

final class PhoneCountrySyncControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneCountrySyncControlCenter,
          PhoneCountrySyncControlCenter,
          PhoneCountrySyncControlCenter
        >
    with $Provider<PhoneCountrySyncControlCenter> {
  PhoneCountrySyncControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneCountrySyncControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneCountrySyncControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneCountrySyncControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneCountrySyncControlCenter create(Ref ref) {
    return phoneCountrySyncControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneCountrySyncControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneCountrySyncControlCenter>(
        value,
      ),
    );
  }
}

String _$phoneCountrySyncControlCenterHash() =>
    r'9daed326ab9cf78519644f341b6a28575bf74e5a';
