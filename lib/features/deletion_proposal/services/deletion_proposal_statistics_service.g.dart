// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_statistics_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DeletionProposalStatisticsService 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解声明 Provider，自动处理依赖注入和实例生命周期。

@ProviderFor(deletionProposalStatisticsService)
const deletionProposalStatisticsServiceProvider =
    DeletionProposalStatisticsServiceProvider._();

/// DeletionProposalStatisticsService 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解声明 Provider，自动处理依赖注入和实例生命周期。

final class DeletionProposalStatisticsServiceProvider
    extends
        $FunctionalProvider<
          DeletionProposalStatisticsService,
          DeletionProposalStatisticsService,
          DeletionProposalStatisticsService
        >
    with $Provider<DeletionProposalStatisticsService> {
  /// DeletionProposalStatisticsService 的 Provider。
  ///
  /// 【MODIFIED】: 使用 @riverpod 注解声明 Provider，自动处理依赖注入和实例生命周期。
  const DeletionProposalStatisticsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalStatisticsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deletionProposalStatisticsServiceHash();

  @$internal
  @override
  $ProviderElement<DeletionProposalStatisticsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletionProposalStatisticsService create(Ref ref) {
    return deletionProposalStatisticsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletionProposalStatisticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletionProposalStatisticsService>(
        value,
      ),
    );
  }
}

String _$deletionProposalStatisticsServiceHash() =>
    r'aa1f61c827a7642fee9ad13d5f21c0de90a74749';
