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

String _$stirCallHandlerHash() => r'a2ecd5ff4360ec2a7d27067d2103574cb6d7239d';

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
