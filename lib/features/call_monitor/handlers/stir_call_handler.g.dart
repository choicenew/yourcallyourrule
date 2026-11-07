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
    extends $NotifierProvider<StirCallHandler, StirInfo?> {
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
  Override overrideWithValue(StirInfo? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StirInfo?>(value),
    );
  }
}

String _$stirCallHandlerHash() => r'9dcc65f4029e5286e999e5f83d238c38714a2d0b';

abstract class _$StirCallHandler extends $Notifier<StirInfo?> {
  StirInfo? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<StirInfo?, StirInfo?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StirInfo?, StirInfo?>,
              StirInfo?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
