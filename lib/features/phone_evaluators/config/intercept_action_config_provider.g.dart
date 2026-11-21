// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intercept_action_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InterceptActionConfig)
final interceptActionConfigProvider = InterceptActionConfigProvider._();

final class InterceptActionConfigProvider
    extends $NotifierProvider<InterceptActionConfig, InterceptAction> {
  InterceptActionConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interceptActionConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interceptActionConfigHash();

  @$internal
  @override
  InterceptActionConfig create() => InterceptActionConfig();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InterceptAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InterceptAction>(value),
    );
  }
}

String _$interceptActionConfigHash() =>
    r'65499140756e9d203057e084aa9b1190cc2e9dbd';

abstract class _$InterceptActionConfig extends $Notifier<InterceptAction> {
  InterceptAction build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<InterceptAction, InterceptAction>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InterceptAction, InterceptAction>,
              InterceptAction,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
