// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_control_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(overlayControlHandler)
final overlayControlHandlerProvider = OverlayControlHandlerProvider._();

final class OverlayControlHandlerProvider
    extends
        $FunctionalProvider<
          OverlayControlHandler,
          OverlayControlHandler,
          OverlayControlHandler
        >
    with $Provider<OverlayControlHandler> {
  OverlayControlHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overlayControlHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overlayControlHandlerHash();

  @$internal
  @override
  $ProviderElement<OverlayControlHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OverlayControlHandler create(Ref ref) {
    return overlayControlHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverlayControlHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverlayControlHandler>(value),
    );
  }
}

String _$overlayControlHandlerHash() =>
    r'7e93bac24caeb4f2852259b4f1873f89987cb341';
