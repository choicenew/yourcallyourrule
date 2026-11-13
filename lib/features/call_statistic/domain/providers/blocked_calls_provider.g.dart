// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_calls_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BlockedCalls)
final blockedCallsProvider = BlockedCallsProvider._();

final class BlockedCallsProvider
    extends $AsyncNotifierProvider<BlockedCalls, BlockedCallsState> {
  BlockedCallsProvider._()
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

String _$blockedCallsHash() => r'c03bcf1430efaf0f174f8021929ea15eb7f61226';

abstract class _$BlockedCalls extends $AsyncNotifier<BlockedCallsState> {
  FutureOr<BlockedCallsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, build);
  }
}
