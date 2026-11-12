// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_submission_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalSubmissionManager)
final proposalSubmissionManagerProvider = ProposalSubmissionManagerProvider._();

final class ProposalSubmissionManagerProvider
    extends
        $FunctionalProvider<
          ProposalSubmissionManager,
          ProposalSubmissionManager,
          ProposalSubmissionManager
        >
    with $Provider<ProposalSubmissionManager> {
  ProposalSubmissionManagerProvider._()
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
