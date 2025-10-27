// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 一个专门用于提供用户总投票数流的 StreamProvider。
///
/// 【MODIFIED】: 这是一个全新的、之前被遗漏的 Provider。
/// REASON: 这是 Riverpod 中处理流数据的最佳实践，它将流的监听和状态管理
///         封装在一个独立的、可复用的 Provider 中。

@ProviderFor(voteCountStream)
const voteCountStreamProvider = VoteCountStreamProvider._();

/// 一个专门用于提供用户总投票数流的 StreamProvider。
///
/// 【MODIFIED】: 这是一个全新的、之前被遗漏的 Provider。
/// REASON: 这是 Riverpod 中处理流数据的最佳实践，它将流的监听和状态管理
///         封装在一个独立的、可复用的 Provider 中。

final class VoteCountStreamProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  /// 一个专门用于提供用户总投票数流的 StreamProvider。
  ///
  /// 【MODIFIED】: 这是一个全新的、之前被遗漏的 Provider。
  /// REASON: 这是 Riverpod 中处理流数据的最佳实践，它将流的监听和状态管理
  ///         封装在一个独立的、可复用的 Provider 中。
  const VoteCountStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voteCountStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voteCountStreamHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return voteCountStream(ref);
  }
}

String _$voteCountStreamHash() => r'15a91b28a2fd0c7d79efe867310f013d96ec7ce3';
