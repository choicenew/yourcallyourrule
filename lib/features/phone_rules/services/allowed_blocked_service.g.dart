// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowed_blocked_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// AllowedBlockedService 的 @Riverpod Provider

@ProviderFor(allowedBlockedService)
final allowedBlockedServiceProvider = AllowedBlockedServiceProvider._();

/// AllowedBlockedService 的 @Riverpod Provider

final class AllowedBlockedServiceProvider
    extends
        $FunctionalProvider<
          AllowedBlockedService,
          AllowedBlockedService,
          AllowedBlockedService
        >
    with $Provider<AllowedBlockedService> {
  /// AllowedBlockedService 的 @Riverpod Provider
  AllowedBlockedServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allowedBlockedServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => r'allowed_blocked_service_hash';

  @$internal
  @override
  $ProviderElement<AllowedBlockedService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AllowedBlockedService create(Ref ref) {
    return allowedBlockedService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AllowedBlockedService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AllowedBlockedService>(value),
    );
  }
}
