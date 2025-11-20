// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_sync_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(syncLogService)
const syncLogServiceProvider = SyncLogServiceProvider._();

final class SyncLogServiceProvider
    extends $FunctionalProvider<SyncLogService, SyncLogService, SyncLogService>
    with $Provider<SyncLogService> {
  const SyncLogServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncLogServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncLogServiceHash();

  @$internal
  @override
  $ProviderElement<SyncLogService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncLogService create(Ref ref) {
    return syncLogService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncLogService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncLogService>(value),
    );
  }
}

String _$syncLogServiceHash() => r'9c3a35473d82e12de66adecd149fcdd5a25db309';

@ProviderFor(SupabaseConfigNotifier)
const supabaseConfigProvider = SupabaseConfigNotifierProvider._();

final class SupabaseConfigNotifierProvider
    extends $AsyncNotifierProvider<SupabaseConfigNotifier, SupabaseConfig> {
  const SupabaseConfigNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseConfigNotifierHash();

  @$internal
  @override
  SupabaseConfigNotifier create() => SupabaseConfigNotifier();
}

String _$supabaseConfigNotifierHash() =>
    r'bf999c1262f694c93158f8962380772312051ad9';

abstract class _$SupabaseConfigNotifier extends $AsyncNotifier<SupabaseConfig> {
  FutureOr<SupabaseConfig> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SupabaseConfig>, SupabaseConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SupabaseConfig>, SupabaseConfig>,
              AsyncValue<SupabaseConfig>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(SupabaseSyncController)
const supabaseSyncControllerProvider = SupabaseSyncControllerProvider._();

final class SupabaseSyncControllerProvider
    extends $AsyncNotifierProvider<SupabaseSyncController, SyncResult?> {
  const SupabaseSyncControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseSyncControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseSyncControllerHash();

  @$internal
  @override
  SupabaseSyncController create() => SupabaseSyncController();
}

String _$supabaseSyncControllerHash() =>
    r'fe83144fc3ad1a41096fe114f60281882a7260b1';

abstract class _$SupabaseSyncController extends $AsyncNotifier<SyncResult?> {
  FutureOr<SyncResult?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SyncResult?>, SyncResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SyncResult?>, SyncResult?>,
              AsyncValue<SyncResult?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
