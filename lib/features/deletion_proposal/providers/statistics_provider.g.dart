// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalStatistics)
final proposalStatisticsProvider = ProposalStatisticsProvider._();

final class ProposalStatisticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, int>>,
          Map<String, int>,
          FutureOr<Map<String, int>>
        >
    with $FutureModifier<Map<String, int>>, $FutureProvider<Map<String, int>> {
  ProposalStatisticsProvider._()
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

@ProviderFor(userVoteCountStream)
final userVoteCountStreamProvider = UserVoteCountStreamProvider._();

final class UserVoteCountStreamProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  UserVoteCountStreamProvider._()
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
    r'a467e529aab2c57b0ed4569702f889d220b4c6cb';
