// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'should_accept_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shouldAcceptCallHandler)
final shouldAcceptCallHandlerProvider = ShouldAcceptCallHandlerProvider._();

final class ShouldAcceptCallHandlerProvider
    extends
        $FunctionalProvider<
          ShouldAcceptCallHandler,
          ShouldAcceptCallHandler,
          ShouldAcceptCallHandler
        >
    with $Provider<ShouldAcceptCallHandler> {
  ShouldAcceptCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shouldAcceptCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shouldAcceptCallHandlerHash();

  @$internal
  @override
  $ProviderElement<ShouldAcceptCallHandler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShouldAcceptCallHandler create(Ref ref) {
    return shouldAcceptCallHandler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShouldAcceptCallHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShouldAcceptCallHandler>(value),
    );
  }
}

String _$shouldAcceptCallHandlerHash() =>
    r'776f0cfe79f13efce3e1a9aacd98a56271979106';
