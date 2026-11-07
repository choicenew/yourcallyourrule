// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlay_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(overlayHandler)
final overlayHandlerProvider = OverlayHandlerProvider._();

final class OverlayHandlerProvider
    extends $FunctionalProvider<OverlayHandler, OverlayHandler, OverlayHandler>
    with $Provider<OverlayHandler> {
  OverlayHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overlayHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overlayHandlerHash();

  @$internal
  @override
  $ProviderElement<OverlayHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OverlayHandler create(Ref ref) {
    return overlayHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OverlayHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OverlayHandler>(value),
    );
  }
}

String _$overlayHandlerHash() => r'91667c19b83acd40dea4c5146e5c815b9a9f44f5';
