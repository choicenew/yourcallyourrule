// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_setup_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// InitialSetupService Riverpod Provider

@ProviderFor(initialSetupService)
final initialSetupServiceProvider = InitialSetupServiceProvider._();

/// InitialSetupService Riverpod Provider

final class InitialSetupServiceProvider
    extends
        $FunctionalProvider<
          InitialSetupService,
          InitialSetupService,
          InitialSetupService
        >
    with $Provider<InitialSetupService> {
  /// InitialSetupService Riverpod Provider
  InitialSetupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialSetupServiceProvider',
        isAutoDispose: false,
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
    r'df7b408adbfb2a37405dbacb588b9a9a12b2480c';
