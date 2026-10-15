// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_setup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(initialSetupService)
final initialSetupServiceProvider = InitialSetupServiceProvider._();

final class InitialSetupServiceProvider
    extends
        $FunctionalProvider<
          InitialSetupService,
          InitialSetupService,
          InitialSetupService
        >
    with $Provider<InitialSetupService> {
  InitialSetupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialSetupServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialSetupServiceHash();

  @$internal
  @override
  $ProviderElement<InitialSetupService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InitialSetupService create(Ref ref) {
    return initialSetupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InitialSetupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InitialSetupService>(value),
    );
  }
}

String _$initialSetupServiceHash() =>
    r'610a929454c72a3bec602a55c1affd6de1a2e502';

@ProviderFor(setupConfig)
final setupConfigProvider = SetupConfigProvider._();

final class SetupConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<SetupConfig>,
          SetupConfig,
          FutureOr<SetupConfig>
        >
    with $FutureModifier<SetupConfig>, $FutureProvider<SetupConfig> {
  SetupConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setupConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setupConfigHash();

  @$internal
  @override
  $FutureProviderElement<SetupConfig> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SetupConfig> create(Ref ref) {
    return setupConfig(ref);
  }
}

String _$setupConfigHash() => r'1c21799d73766aab2d62b30057b8bfb8bd1c3bb0';

@ProviderFor(detectedCountryCode)
final detectedCountryCodeProvider = DetectedCountryCodeProvider._();

final class DetectedCountryCodeProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  DetectedCountryCodeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'detectedCountryCodeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$detectedCountryCodeHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return detectedCountryCode(ref);
  }
}

String _$detectedCountryCodeHash() =>
    r'ea54911a283ceb9e8614752a4014c4f788b88701';
