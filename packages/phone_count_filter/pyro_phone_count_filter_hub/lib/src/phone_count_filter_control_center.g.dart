// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_count_filter_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneCountFilterControlCenter)
final phoneCountFilterControlCenterProvider =
    PhoneCountFilterControlCenterProvider._();

final class PhoneCountFilterControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneCountFilterControlCenter,
          PhoneCountFilterControlCenter,
          PhoneCountFilterControlCenter
        >
    with $Provider<PhoneCountFilterControlCenter> {
  PhoneCountFilterControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneCountFilterControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneCountFilterControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneCountFilterControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneCountFilterControlCenter create(Ref ref) {
    return phoneCountFilterControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneCountFilterControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneCountFilterControlCenter>(
        value,
      ),
    );
  }
}

String _$phoneCountFilterControlCenterHash() =>
    r'b84395cc23f0a4c7e57631efea874ca3dffdf231';
