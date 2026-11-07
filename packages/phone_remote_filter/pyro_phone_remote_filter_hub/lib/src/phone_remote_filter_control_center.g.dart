// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_remote_filter_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneRemoteFilterControlCenter)
final phoneRemoteFilterControlCenterProvider =
    PhoneRemoteFilterControlCenterProvider._();

final class PhoneRemoteFilterControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneRemoteFilterControlCenter,
          PhoneRemoteFilterControlCenter,
          PhoneRemoteFilterControlCenter
        >
    with $Provider<PhoneRemoteFilterControlCenter> {
  PhoneRemoteFilterControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneRemoteFilterControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneRemoteFilterControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneRemoteFilterControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneRemoteFilterControlCenter create(Ref ref) {
    return phoneRemoteFilterControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneRemoteFilterControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneRemoteFilterControlCenter>(
        value,
      ),
    );
  }
}

String _$phoneRemoteFilterControlCenterHash() =>
    r'5751458619f215cb7eb4af122af8120aa6274ab1';
