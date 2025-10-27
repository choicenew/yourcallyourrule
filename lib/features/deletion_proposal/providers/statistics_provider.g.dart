// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 一个【专属】的 FutureProvider，只负责异步获取“提议统计”数据。
///
/// 它与 `deletionProposalProvider` 完全解耦。
/// `autoDispose` 意味着当没有任何 Widget 监听它时，它会自动销毁，节省资源。
/// 再次被监听时，它会自动重新获取数据。

@ProviderFor(proposalStatistics)
const proposalStatisticsProvider = ProposalStatisticsProvider._();

/// 一个【专属】的 FutureProvider，只负责异步获取“提议统计”数据。
///
/// 它与 `deletionProposalProvider` 完全解耦。
/// `autoDispose` 意味着当没有任何 Widget 监听它时，它会自动销毁，节省资源。
/// 再次被监听时，它会自动重新获取数据。

final class ProposalStatisticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, int>>,
          Map<String, int>,
          FutureOr<Map<String, int>>
        >
    with $FutureModifier<Map<String, int>>, $FutureProvider<Map<String, int>> {
  /// 一个【专属】的 FutureProvider，只负责异步获取“提议统计”数据。
  ///
  /// 它与 `deletionProposalProvider` 完全解耦。
  /// `autoDispose` 意味着当没有任何 Widget 监听它时，它会自动销毁，节省资源。
  /// 再次被监听时，它会自动重新获取数据。
  const ProposalStatisticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalStatisticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalStatisticsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, int>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, int>> create(Ref ref) {
    return proposalStatistics(ref);
  }
}

String _$proposalStatisticsHash() =>
    r'b8dd46121bdbaac60abea6b1a5d3d1bcc7a81359';

/// 一个【专属】的 StreamProvider，只负责提供“用户投票总数”的流。
///
/// 它与 `deletionProposalProvider` 完全解耦。

@ProviderFor(userVoteCountStream)
const userVoteCountStreamProvider = UserVoteCountStreamProvider._();

/// 一个【专属】的 StreamProvider，只负责提供“用户投票总数”的流。
///
/// 它与 `deletionProposalProvider` 完全解耦。

final class UserVoteCountStreamProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  /// 一个【专属】的 StreamProvider，只负责提供“用户投票总数”的流。
  ///
  /// 它与 `deletionProposalProvider` 完全解耦。
  const UserVoteCountStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userVoteCountStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userVoteCountStreamHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return userVoteCountStream(ref);
  }
}

String _$userVoteCountStreamHash() =>
    r'b6cb4d811d90a17098d74a6823bcd0ec59fee3c3';
