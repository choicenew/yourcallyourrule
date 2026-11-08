// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foreground_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ForegroundSyncService Provider

@ProviderFor(foregroundSyncService)
final foregroundSyncServiceProvider = ForegroundSyncServiceProvider._();

/// ForegroundSyncService Provider

final class ForegroundSyncServiceProvider
    extends
        $FunctionalProvider<
          ForegroundSyncService,
          ForegroundSyncService,
          ForegroundSyncService
        >
    with $Provider<ForegroundSyncService> {
  /// ForegroundSyncService Provider
  ForegroundSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foregroundSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foregroundSyncServiceHash();

  @$internal
  @override
  $ProviderElement<ForegroundSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ForegroundSyncService create(Ref ref) {
    return foregroundSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForegroundSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForegroundSyncService>(value),
    );
  }
}

String _$foregroundSyncServiceHash() =>
    r'd612f387331aa24fa110466e5e065eb6a1a45da2';
