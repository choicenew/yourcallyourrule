// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 后台同步服务提供者

@ProviderFor(backgroundSyncService)
final backgroundSyncServiceProvider = BackgroundSyncServiceProvider._();

/// 后台同步服务提供者

final class BackgroundSyncServiceProvider
    extends
        $FunctionalProvider<
          BackgroundSyncService,
          BackgroundSyncService,
          BackgroundSyncService
        >
    with $Provider<BackgroundSyncService> {
  /// 后台同步服务提供者
  BackgroundSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backgroundSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backgroundSyncServiceHash();

  @$internal
  @override
  $ProviderElement<BackgroundSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackgroundSyncService create(Ref ref) {
    return backgroundSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackgroundSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackgroundSyncService>(value),
    );
  }
}

String _$backgroundSyncServiceHash() =>
    r'e5ac1419f20f161977c8b3af615fc567deb140da';
