// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_submission_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ProposalSubmissionManager 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解声明，替代了旧的手动 `Provider` 定义。

@ProviderFor(proposalSubmissionManager)
const proposalSubmissionManagerProvider = ProposalSubmissionManagerProvider._();

/// ProposalSubmissionManager 的 Provider。
///
/// 【MODIFIED】: 使用 @riverpod 注解声明，替代了旧的手动 `Provider` 定义。

final class ProposalSubmissionManagerProvider
    extends
        $FunctionalProvider<
          ProposalSubmissionManager,
          ProposalSubmissionManager,
          ProposalSubmissionManager
        >
    with $Provider<ProposalSubmissionManager> {
  /// ProposalSubmissionManager 的 Provider。
  ///
  /// 【MODIFIED】: 使用 @riverpod 注解声明，替代了旧的手动 `Provider` 定义。
  const ProposalSubmissionManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalSubmissionManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalSubmissionManagerHash();

  @$internal
  @override
  $ProviderElement<ProposalSubmissionManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalSubmissionManager create(Ref ref) {
    return proposalSubmissionManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalSubmissionManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalSubmissionManager>(value),
    );
  }
}

String _$proposalSubmissionManagerHash() =>
    r'f25a3e7d54f3da68ba073a1ea8ba8ed072f306f6';
