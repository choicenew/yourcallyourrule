// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_rules_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneRulesControlCenter)
final phoneRulesControlCenterProvider = PhoneRulesControlCenterProvider._();

final class PhoneRulesControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneRulesControlCenter,
          PhoneRulesControlCenter,
          PhoneRulesControlCenter
        >
    with $Provider<PhoneRulesControlCenter> {
  PhoneRulesControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneRulesControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneRulesControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneRulesControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneRulesControlCenter create(Ref ref) {
    return phoneRulesControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneRulesControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneRulesControlCenter>(value),
    );
  }
}

String _$phoneRulesControlCenterHash() =>
    r'c331fcb6d7ba1b3930bf2bc0966d8a5c657e9018';
