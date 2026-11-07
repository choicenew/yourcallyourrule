// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outgoing_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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

  Override overrideWithValue(OutgoingCallHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OutgoingCallHandler>(value),
    );
  }
}

String _$outgoingCallHandlerHash() =>
    r'2d1be458a31e353f7053ea1253fe6ac1b938c2bc';
