// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stir_call_handler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StirCallHandler)
final stirCallHandlerProvider = StirCallHandlerProvider._();

final class StirCallHandlerProvider
    extends $NotifierProvider<StirCallHandler, StirResultEntity?> {
  StirCallHandlerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stirCallHandlerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stirCallHandlerHash();

  @$internal
  @override
  StirCallHandler create() => StirCallHandler();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StirResultEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StirResultEntity?>(value),
    );
  }
}

String _$stirCallHandlerHash() => r'a2ecd5ff4360ec2a7d27067d2103574cb6d7239d';

abstract class _$StirCallHandler extends $Notifier<StirResultEntity?> {
  StirResultEntity? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final state = build();
    return (state: state, result: null);
  }
}
