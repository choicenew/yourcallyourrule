// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_lookup_plugin_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(phoneLookupPluginControlCenter)
final phoneLookupPluginControlCenterProvider =
    PhoneLookupPluginControlCenterProvider._();

final class PhoneLookupPluginControlCenterProvider
    extends
        $FunctionalProvider<
          PhoneLookupPluginControlCenter,
          PhoneLookupPluginControlCenter,
          PhoneLookupPluginControlCenter
        >
    with $Provider<PhoneLookupPluginControlCenter> {
  PhoneLookupPluginControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneLookupPluginControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneLookupPluginControlCenterHash();

  @$internal
  @override
  $ProviderElement<PhoneLookupPluginControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhoneLookupPluginControlCenter create(Ref ref) {
    return phoneLookupPluginControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneLookupPluginControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneLookupPluginControlCenter>(
        value,
      ),
    );
  }
}

String _$phoneLookupPluginControlCenterHash() =>
    r'8dbd8650ae36b785fac63a03ad2dba9e9d745cff';
