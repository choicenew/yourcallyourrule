// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_filter_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EnhancedFilterConfigNotifier)
const enhancedFilterConfigProvider = EnhancedFilterConfigNotifierProvider._();

final class EnhancedFilterConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          EnhancedFilterConfigNotifier,
          EnhancedFilterConfigState
        > {
  const EnhancedFilterConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enhancedFilterConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enhancedFilterConfigNotifierHash();

  @$internal
  @override
  EnhancedFilterConfigNotifier create() => EnhancedFilterConfigNotifier();
}

String _$enhancedFilterConfigNotifierHash() =>
    r'd6c5cc49d68ca7be72f7854726ede3cab7b19003';

abstract class _$EnhancedFilterConfigNotifier
    extends $AsyncNotifier<EnhancedFilterConfigState> {
  FutureOr<EnhancedFilterConfigState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EnhancedFilterConfigState>,
              EnhancedFilterConfigState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EnhancedFilterConfigState>,
                EnhancedFilterConfigState
              >,
              AsyncValue<EnhancedFilterConfigState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
