// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incoming_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(incomingCallHandler)
final incomingCallHandlerProvider = IncomingCallHandlerProvider._();

final class IncomingCallHandlerProvider
    extends
        $FunctionalProvider<
          AsyncValue<IncomingCallHandler>,
          IncomingCallHandler,
          FutureOr<IncomingCallHandler>
        >
    with
        $FutureModifier<IncomingCallHandler>,
        $FutureProvider<IncomingCallHandler> {
  IncomingCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingCallHandlerHash();

  @$internal
  @override
  $FutureProviderElement<IncomingCallHandler> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<IncomingCallHandler> create(Ref ref) {
    return incomingCallHandler(ref);
  }
}

String _$incomingCallHandlerHash() =>
    r'67637316c7ea5eed5ad86bf4f7f8ad1dc88a9e06';
