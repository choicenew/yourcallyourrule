// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foreground_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foregroundSyncService)
final foregroundSyncServiceProvider = ForegroundSyncServiceProvider._();

final class ForegroundSyncServiceProvider
    extends
        $FunctionalProvider<
          ForegroundSyncService,
          ForegroundSyncService,
          ForegroundSyncService
        >
    with $Provider<ForegroundSyncService> {
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
    r'00c9af473923f70b7ae11527fd60e7150c0ddb5b';
