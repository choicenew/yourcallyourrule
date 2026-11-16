// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outgoing_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(outgoingCallHandler)
final outgoingCallHandlerProvider = OutgoingCallHandlerProvider._();

final class OutgoingCallHandlerProvider
    extends
        $FunctionalProvider<
          OutgoingCallHandler,
          OutgoingCallHandler,
          OutgoingCallHandler
        >
    with $Provider<OutgoingCallHandler> {
  OutgoingCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'outgoingCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$outgoingCallHandlerHash();

  @$internal
  @override
  $ProviderElement<OutgoingCallHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OutgoingCallHandler create(Ref ref) {
    return outgoingCallHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OutgoingCallHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OutgoingCallHandler>(value),
    );
  }
}

String _$outgoingCallHandlerHash() =>
    r'a26852eb9dcebc7aed68b3d7c9ff3f8259bc0f1b';
