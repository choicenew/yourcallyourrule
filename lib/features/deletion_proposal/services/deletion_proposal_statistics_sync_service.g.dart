// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_statistics_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 使用 Notifier 模式的删除提议统计同步服务。
///
/// 这个 Provider 本身不管理任何需要暴露给 UI 的状态 (其 state 类型为 void)，
/// 它的主要作用是作为一个后台服务，响应其他 Provider 的状态变化来执行任务。
///
/// - `@Riverpod(keepAlive: true)`:
///   使用 `keepAlive: true` 可以确保这个服务在被监听后，即使没有 UI 在 `watch` 它，
///   也能持续在后台运行，直到被手动销毁或应用关闭。对于这类后台服务来说通常是必要的。

@ProviderFor(DeletionProposalStatisticsSyncService)
const deletionProposalStatisticsSyncServiceProvider =
    DeletionProposalStatisticsSyncServiceProvider._();

/// 使用 Notifier 模式的删除提议统计同步服务。
///
/// 这个 Provider 本身不管理任何需要暴露给 UI 的状态 (其 state 类型为 void)，
/// 它的主要作用是作为一个后台服务，响应其他 Provider 的状态变化来执行任务。
///
/// - `@Riverpod(keepAlive: true)`:
///   使用 `keepAlive: true` 可以确保这个服务在被监听后，即使没有 UI 在 `watch` 它，
///   也能持续在后台运行，直到被手动销毁或应用关闭。对于这类后台服务来说通常是必要的。
final class DeletionProposalStatisticsSyncServiceProvider
    extends $NotifierProvider<DeletionProposalStatisticsSyncService, void> {
  /// 使用 Notifier 模式的删除提议统计同步服务。
  ///
  /// 这个 Provider 本身不管理任何需要暴露给 UI 的状态 (其 state 类型为 void)，
  /// 它的主要作用是作为一个后台服务，响应其他 Provider 的状态变化来执行任务。
  ///
  /// - `@Riverpod(keepAlive: true)`:
  ///   使用 `keepAlive: true` 可以确保这个服务在被监听后，即使没有 UI 在 `watch` 它，
  ///   也能持续在后台运行，直到被手动销毁或应用关闭。对于这类后台服务来说通常是必要的。
  const DeletionProposalStatisticsSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalStatisticsSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deletionProposalStatisticsSyncServiceHash();

  @$internal
  @override
  DeletionProposalStatisticsSyncService create() =>
      DeletionProposalStatisticsSyncService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$deletionProposalStatisticsSyncServiceHash() =>
    r'1048cf1419253105f1ee59ce68f7c5317b582c41';

/// 使用 Notifier 模式的删除提议统计同步服务。
///
/// 这个 Provider 本身不管理任何需要暴露给 UI 的状态 (其 state 类型为 void)，
/// 它的主要作用是作为一个后台服务，响应其他 Provider 的状态变化来执行任务。
///
/// - `@Riverpod(keepAlive: true)`:
///   使用 `keepAlive: true` 可以确保这个服务在被监听后，即使没有 UI 在 `watch` 它，
///   也能持续在后台运行，直到被手动销毁或应用关闭。对于这类后台服务来说通常是必要的。

abstract class _$DeletionProposalStatisticsSyncService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
