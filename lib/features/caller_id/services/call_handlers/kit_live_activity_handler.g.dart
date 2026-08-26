// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kit_live_activity_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kitLiveActivityHandler)
const kitLiveActivityHandlerProvider = KitLiveActivityHandlerProvider._();

final class KitLiveActivityHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<KitLiveActivityHandler>,
          KitLiveActivityHandler,
          FutureOr<KitLiveActivityHandler>
        >
    with
        $FutureModifier<KitLiveActivityHandler>,
        $FutureProvider<KitLiveActivityHandler> {
  const KitLiveActivityHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kitLiveActivityHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kitLiveActivityHandlerHash();

  @$internal
  @override
  $FutureProviderElement<KitLiveActivityHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<KitLiveActivityHandler> create(Ref ref) {
    return kitLiveActivityHandler(ref);
  }
}

String _$kitLiveActivityHandlerHash() =>
    r'8f321d2837482910fedca1239847162983746192';
