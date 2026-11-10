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
    extends $AsyncNotifierProvider<IncomingCallHandlerNotifier, IncomingCallHandler> {
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
  String debugGetCreateSourceHash() => r'incoming_call_handler_hash_v2';

  @$internal
  @override
  IncomingCallHandlerNotifier create() => IncomingCallHandlerNotifier();
}

abstract class _$IncomingCallHandlerNotifier extends $AsyncNotifier<IncomingCallHandler> {
  FutureOr<IncomingCallHandler> build();
}

class IncomingCallHandlerNotifier extends _$IncomingCallHandlerNotifier {
  @override
  Future<IncomingCallHandler> build() async {
    return IncomingCallHandler();
  }
}
