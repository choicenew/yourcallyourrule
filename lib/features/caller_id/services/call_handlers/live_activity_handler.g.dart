// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_activity_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveActivityHandler)
const liveActivityHandlerProvider = LiveActivityHandlerProvider._();

final class LiveActivityHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<LiveActivityHandler>,
          LiveActivityHandler,
          FutureOr<LiveActivityHandler>
        >
    with
        $FutureModifier<LiveActivityHandler>,
        $FutureProvider<LiveActivityHandler> {
  const LiveActivityHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveActivityHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveActivityHandlerHash();

  @$internal
  @override
  $FutureProviderElement<LiveActivityHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LiveActivityHandler> create(Ref ref) {
    return liveActivityHandler(ref);
  }
}

String _$liveActivityHandlerHash() =>
    r'1d116f6773e01addf51ed62376021450a23583e6';
