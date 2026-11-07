// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_update_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(autoUpdateControlCenter)
final autoUpdateControlCenterProvider = AutoUpdateControlCenterProvider._();

final class AutoUpdateControlCenterProvider
    extends
        $FunctionalProvider<
          AutoUpdateControlCenter,
          AutoUpdateControlCenter,
          AutoUpdateControlCenter
        >
    with $Provider<AutoUpdateControlCenter> {
  AutoUpdateControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoUpdateControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoUpdateControlCenterHash();

  @$internal
  @override
  $ProviderElement<AutoUpdateControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AutoUpdateControlCenter create(Ref ref) {
    return autoUpdateControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutoUpdateControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutoUpdateControlCenter>(value),
    );
  }
}

String _$autoUpdateControlCenterHash() =>
    r'19d43ba8588aba8d7e87a186f51d8a09644bd7d7';
