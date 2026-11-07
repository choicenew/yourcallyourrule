// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(overlayControlCenter)
final overlayControlCenterProvider = OverlayControlCenterProvider._();

final class OverlayControlCenterProvider
    extends
        $FunctionalProvider<
          OverlayControlCenter,
          OverlayControlCenter,
          OverlayControlCenter
        >
    with $Provider<OverlayControlCenter> {
  OverlayControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overlayControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overlayControlCenterHash();

  @$internal
  @override
  $ProviderElement<OverlayControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OverlayControlCenter create(Ref ref) {
    return overlayControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverlayControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverlayControlCenter>(value),
    );
  }
}

String _$overlayControlCenterHash() =>
    r'5fd270aeebf536a10a81ffcf2777003a6c79e8a3';
