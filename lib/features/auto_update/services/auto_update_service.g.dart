// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auto_update_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AutoUpdateService 的 @Riverpod Provider

@ProviderFor(autoUpdateService)
final autoUpdateServiceProvider = AutoUpdateServiceProvider._();

/// AutoUpdateService 的 @Riverpod Provider

final class AutoUpdateServiceProvider
    extends
        $FunctionalProvider<
          AutoUpdateService,
          AutoUpdateService,
          AutoUpdateService
        >
    with $Provider<AutoUpdateService> {
  /// AutoUpdateService 的 @Riverpod Provider
  AutoUpdateServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoUpdateServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoUpdateServiceHash();

  @$internal
  @override
  $ProviderElement<AutoUpdateService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AutoUpdateService create(Ref ref) {
    return autoUpdateService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutoUpdateService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutoUpdateService>(value),
    );
  }
}

String _$autoUpdateServiceHash() => r'db3f2e75ff65d822a1c86669ef40f64b92b38bbf';
