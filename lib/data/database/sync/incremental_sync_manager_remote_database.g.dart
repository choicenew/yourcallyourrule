// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incremental_sync_manager_remote_database.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 提供IncrementalSyncManager的Provider

@ProviderFor(incrementalSyncManager)
final incrementalSyncManagerProvider = IncrementalSyncManagerProvider._();

/// 提供IncrementalSyncManager的Provider

final class IncrementalSyncManagerProvider
    extends
        $FunctionalProvider<
          IncrementalSyncManager,
          IncrementalSyncManager,
          IncrementalSyncManager
        >
    with $Provider<IncrementalSyncManager> {
  /// 提供IncrementalSyncManager的Provider
  IncrementalSyncManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incrementalSyncManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incrementalSyncManagerHash();

  @$internal
  @override
  $ProviderElement<IncrementalSyncManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IncrementalSyncManager create(Ref ref) {
    return incrementalSyncManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IncrementalSyncManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IncrementalSyncManager>(value),
    );
  }
}

String _$incrementalSyncManagerHash() =>
    r'99610f46f9b97a2f8f42933fdd0252b5ef647e2e';
