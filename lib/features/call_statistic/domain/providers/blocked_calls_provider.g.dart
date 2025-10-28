// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_calls_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 一个异步 Notifier，用于根据选择的 Tab 异步加载和管理拦截记录列表。

@ProviderFor(BlockedCalls)
const blockedCallsProvider = BlockedCallsProvider._();

/// 一个异步 Notifier，用于根据选择的 Tab 异步加载和管理拦截记录列表。
final class BlockedCallsProvider
    extends $AsyncNotifierProvider<BlockedCalls, BlockedCallsState> {
  /// 一个异步 Notifier，用于根据选择的 Tab 异步加载和管理拦截记录列表。
  const BlockedCallsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockedCallsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockedCallsHash();

  @$internal
  @override
  BlockedCalls create() => BlockedCalls();
}

String _$blockedCallsHash() => r'42cf974c7dc9b9211ed7b1dca25b1e91e5a9f7b1';

/// 一个异步 Notifier，用于根据选择的 Tab 异步加载和管理拦截记录列表。

abstract class _$BlockedCalls extends $AsyncNotifier<BlockedCallsState> {
  FutureOr<BlockedCallsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<BlockedCallsState>, BlockedCallsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BlockedCallsState>, BlockedCallsState>,
              AsyncValue<BlockedCallsState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
