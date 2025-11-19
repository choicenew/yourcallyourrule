// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_sync_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 管理 Supabase 配置的 Notifier (Riverpod 3.0)

@ProviderFor(SupabaseConfigNotifier)
const supabaseConfigProvider = SupabaseConfigNotifierProvider._();

/// 管理 Supabase 配置的 Notifier (Riverpod 3.0)
final class SupabaseConfigNotifierProvider
    extends $AsyncNotifierProvider<SupabaseConfigNotifier, SupabaseConfig> {
  /// 管理 Supabase 配置的 Notifier (Riverpod 3.0)
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
    r'429a62f43f5e6b2d625b5bbebc7c53d27b521675';

/// 管理 Supabase 配置的 Notifier (Riverpod 3.0)

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

/// 控制同步操作的 Controller (Riverpod 3.0)
/// 状态为 AsyncValue<SyncResult?>，null 表示未开始

@ProviderFor(SupabaseSyncController)
const supabaseSyncControllerProvider = SupabaseSyncControllerProvider._();

/// 控制同步操作的 Controller (Riverpod 3.0)
/// 状态为 AsyncValue<SyncResult?>，null 表示未开始
final class SupabaseSyncControllerProvider
    extends $AsyncNotifierProvider<SupabaseSyncController, SyncResult?> {
  /// 控制同步操作的 Controller (Riverpod 3.0)
  /// 状态为 AsyncValue<SyncResult?>，null 表示未开始
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
    r'86d8ed2cb52e3b8b783a85276070629d914eaa04';

/// 控制同步操作的 Controller (Riverpod 3.0)
/// 状态为 AsyncValue<SyncResult?>，null 表示未开始

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
