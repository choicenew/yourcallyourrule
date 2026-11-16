// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enhanced_filter_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EnhancedFilterConfigNotifier)
final enhancedFilterConfigProvider = EnhancedFilterConfigNotifierProvider._();

final class EnhancedFilterConfigNotifierProvider
    extends
        $AsyncNotifierProvider<
          EnhancedFilterConfigNotifier,
          EnhancedFilterConfigState
        > {
  EnhancedFilterConfigNotifierProvider._()
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
    r'b9b7a2c4e9200a5d1b2193f5344cbba5b4229266';

abstract class _$EnhancedFilterConfigNotifier
    extends $AsyncNotifier<EnhancedFilterConfigState> {
  FutureOr<EnhancedFilterConfigState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}
