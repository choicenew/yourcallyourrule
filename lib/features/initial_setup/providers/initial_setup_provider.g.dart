// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_setup_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(initialSetupService)
const initialSetupServiceProvider = InitialSetupServiceProvider._();

final class InitialSetupServiceProvider
    extends
        $FunctionalProvider<
          InitialSetupService,
          InitialSetupService,
          InitialSetupService
        >
    with $Provider<InitialSetupService> {
  const InitialSetupServiceProvider._()
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

  Override overrideWithValue(InitialSetupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InitialSetupService>(value),
    );
  }
}

String _$initialSetupServiceHash() =>
    r'a1b2c3d4e5f60718293a4b5c6d7e8f9012345678';

@ProviderFor(setupConfig)
const setupConfigProvider = SetupConfigProvider._();

final class SetupConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<SetupConfig>,
          SetupConfig,
          FutureOr<SetupConfig>
        >
    with $FutureModifier<SetupConfig>, $FutureProvider<SetupConfig> {
  const SetupConfigProvider._()
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

String _$setupConfigHash() =>
    r'b2c3d4e5f60718293a4b5c6d7e8f90123456789a';

@ProviderFor(detectedCountryCode)
const detectedCountryCodeProvider = DetectedCountryCodeProvider._();

final class DetectedCountryCodeProvider
    extends
        $FunctionalProvider<
          AsyncValue<String?>,
          String?,
          FutureOr<String?>
        >
    with $FutureModifier<String?>, $FutureProvider<String?> {
  const DetectedCountryCodeProvider._()
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
  $FutureProviderElement<String?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return detectedCountryCode(ref);
  }
}

String _$detectedCountryCodeHash() =>
    r'c3d4e5f60718293a4b5c6d7e8f90123456789ab1';
