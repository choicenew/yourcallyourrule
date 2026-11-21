// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_mode_config_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(displayModeConfigRepository)
final displayModeConfigRepositoryProvider =
    DisplayModeConfigRepositoryProvider._();

final class DisplayModeConfigRepositoryProvider
    extends
        $FunctionalProvider<
          DisplayModeConfigRepository,
          DisplayModeConfigRepository,
          DisplayModeConfigRepository
        >
    with $Provider<DisplayModeConfigRepository> {
  DisplayModeConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayModeConfigRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayModeConfigRepositoryHash();

  @$internal
  @override
  $ProviderElement<DisplayModeConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DisplayModeConfigRepository create(Ref ref) {
    return displayModeConfigRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DisplayModeConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DisplayModeConfigRepository>(value),
    );
  }
}

String _$displayModeConfigRepositoryHash() =>
    r'1e4426caee74f895b0fcbb5b1b9212c885970c78';

@ProviderFor(DisplayModeConfigNotifier)
final displayModeConfigProvider = DisplayModeConfigNotifierProvider._();

final class DisplayModeConfigNotifierProvider
    extends $NotifierProvider<DisplayModeConfigNotifier, DisplayModeConfig> {
  DisplayModeConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'displayModeConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$displayModeConfigNotifierHash();

  @$internal
  @override
  DisplayModeConfigNotifier create() => DisplayModeConfigNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DisplayModeConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DisplayModeConfig>(value),
    );
  }
}

String _$displayModeConfigNotifierHash() =>
    r'0868f6adcf13776a51ec8554355676e4b51bdbbb';

abstract class _$DisplayModeConfigNotifier
    extends $Notifier<DisplayModeConfig> {
  DisplayModeConfig build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DisplayModeConfig, DisplayModeConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DisplayModeConfig, DisplayModeConfig>,
              DisplayModeConfig,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
