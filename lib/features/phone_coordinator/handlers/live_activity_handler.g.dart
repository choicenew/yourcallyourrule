// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_activity_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(liveActivityHandler)
final liveActivityHandlerProvider = LiveActivityHandlerProvider._();

final class LiveActivityHandlerProvider
    extends
        $FunctionalProvider<
          LiveActivityHandler,
          LiveActivityHandler,
          LiveActivityHandler
        >
    with $Provider<LiveActivityHandler> {
  LiveActivityHandlerProvider._()
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
  $ProviderElement<LiveActivityHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LiveActivityHandler create(Ref ref) {
    return liveActivityHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LiveActivityHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LiveActivityHandler>(value),
    );
  }
}

String _$liveActivityHandlerHash() =>
    r'3e793ba327af6aa64be54ce68f12899958e55d71';
