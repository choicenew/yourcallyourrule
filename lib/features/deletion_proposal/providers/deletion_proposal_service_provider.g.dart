// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DeletionProposalService 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解，并从 `proposalRepositoryProvider` 获取依赖。
/// 这使得依赖关系更加清晰和可测试。

@ProviderFor(deletionProposalService)
const deletionProposalServiceProvider = DeletionProposalServiceProvider._();

/// DeletionProposalService 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解，并从 `proposalRepositoryProvider` 获取依赖。
/// 这使得依赖关系更加清晰和可测试。

final class DeletionProposalServiceProvider
    extends
        $FunctionalProvider<
          DeletionProposalService,
          DeletionProposalService,
          DeletionProposalService
        >
    with $Provider<DeletionProposalService> {
  /// DeletionProposalService 的 Provider。
  ///
  /// 【MODIFIED】: 使用 @riverpod 注解，并从 `proposalRepositoryProvider` 获取依赖。
  /// 这使得依赖关系更加清晰和可测试。
  const DeletionProposalServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletionProposalServiceHash();

  @$internal
  @override
  $ProviderElement<DeletionProposalService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletionProposalService create(Ref ref) {
    return deletionProposalService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletionProposalService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletionProposalService>(value),
    );
  }
}

String _$deletionProposalServiceHash() =>
    r'23ca2a2a5659879c41057e0acb617467a229cca2';
