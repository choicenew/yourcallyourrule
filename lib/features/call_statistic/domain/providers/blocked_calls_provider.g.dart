// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_calls_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BlockedCalls)
const blockedCallsProvider = BlockedCallsProvider._();

final class BlockedCallsProvider
    extends $AsyncNotifierProvider<BlockedCalls, BlockedCallsState> {
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

String _$blockedCallsHash() => r'64fececbe461120517b5deaa6c68691090e2f53e';

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
