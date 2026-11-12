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
    extends
        $FunctionalProvider<
          AsyncValue<OverlayHandler>,
          OverlayHandler,
          FutureOr<OverlayHandler>
        >
    with $FutureModifier<OverlayHandler>, $FutureProvider<OverlayHandler> {
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
  $FutureProviderElement<OverlayHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OverlayHandler> create(Ref ref) {
    return overlayHandler(ref);
  }
}

String _$overlayHandlerHash() => r'f79ddc561babfb41eeab16434c257c0c23844c22';
