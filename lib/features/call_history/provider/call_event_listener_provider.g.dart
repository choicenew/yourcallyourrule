// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_event_listener_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CallEventListenerService Riverpod Provider

@ProviderFor(callEventListener)
final callEventListenerProvider = CallEventListenerProvider._();

/// CallEventListenerService Riverpod Provider

final class CallEventListenerProvider
    extends
        $FunctionalProvider<
          AsyncValue<CallEventListenerService>,
          CallEventListenerService,
          FutureOr<CallEventListenerService>
        >
    with
        $FutureModifier<CallEventListenerService>,
        $FutureProvider<CallEventListenerService> {
  /// CallEventListenerService Riverpod Provider
  CallEventListenerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callEventListenerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callEventListenerHash();

  @$internal
  @override
  $FutureProviderElement<CallEventListenerService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CallEventListenerService> create(Ref ref) {
    return callEventListener(ref);
  }
}

String _$callEventListenerHash() => r'2a0c0afada6ead893b7d1d1dee8e22e1c1c7c828';
