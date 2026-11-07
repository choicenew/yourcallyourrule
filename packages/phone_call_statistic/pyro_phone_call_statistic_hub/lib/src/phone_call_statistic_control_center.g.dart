// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_call_statistic_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneCallStatisticControlCenter)
final phoneCallStatisticControlCenterProvider =
    PhoneCallStatisticControlCenterProvider._();

final class PhoneCallStatisticControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneCallStatisticControlCenter,
          PhoneCallStatisticControlCenter,
          PhoneCallStatisticControlCenter
        >
    with $Provider<PhoneCallStatisticControlCenter> {
  PhoneCallStatisticControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneCallStatisticControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneCallStatisticControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneCallStatisticControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneCallStatisticControlCenter create(Ref ref) {
    return phoneCallStatisticControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneCallStatisticControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneCallStatisticControlCenter>(
        value,
      ),
    );
  }
}

String _$phoneCallStatisticControlCenterHash() =>
    r'1a3044734229af30683a5038b50953bc9dcc03fc';
