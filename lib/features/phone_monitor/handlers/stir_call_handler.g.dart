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

String _$stirCallHandlerHash() => r'40f6390f198bfb625899097d79d0fa1f64ad9510';

abstract class _$StirCallHandler extends $Notifier<StirResultEntity?> {
  StirResultEntity? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<StirResultEntity?, StirResultEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StirResultEntity?, StirResultEntity?>,
              StirResultEntity?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
