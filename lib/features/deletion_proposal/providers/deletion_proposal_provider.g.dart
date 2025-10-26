// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 删除提议状态的 Notifier。

@ProviderFor(DeletionProposalNotifier)
const deletionProposalProvider = DeletionProposalNotifierProvider._();

/// 删除提议状态的 Notifier。
final class DeletionProposalNotifierProvider
    extends $NotifierProvider<DeletionProposalNotifier, DeletionProposalState> {
  /// 删除提议状态的 Notifier。
  const DeletionProposalNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletionProposalNotifierHash();

  @$internal
  @override
  DeletionProposalNotifier create() => DeletionProposalNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletionProposalState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletionProposalState>(value),
    );
  }
}

String _$deletionProposalNotifierHash() =>
    r'0ef7810af03576dd14725972910c628dc9548879';

/// 删除提议状态的 Notifier。

abstract class _$DeletionProposalNotifier
    extends $Notifier<DeletionProposalState> {
  DeletionProposalState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DeletionProposalState, DeletionProposalState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DeletionProposalState, DeletionProposalState>,
              DeletionProposalState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(proposalDetails)
const proposalDetailsProvider = ProposalDetailsFamily._();

final class ProposalDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Proposal?>,
          Proposal?,
          FutureOr<Proposal?>
        >
    with $FutureModifier<Proposal?>, $FutureProvider<Proposal?> {
  const ProposalDetailsProvider._({
    required ProposalDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'proposalDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$proposalDetailsHash();

  @override
  String toString() {
    return r'proposalDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Proposal?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Proposal?> create(Ref ref) {
    final argument = this.argument as String;
    return proposalDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProposalDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$proposalDetailsHash() => r'c89c293f08476dbe70f142b08dc721f2cd3ffc38';

final class ProposalDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Proposal?>, String> {
  const ProposalDetailsFamily._()
    : super(
        retry: null,
        name: r'proposalDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProposalDetailsProvider call(String proposalId) =>
      ProposalDetailsProvider._(argument: proposalId, from: this);

  @override
  String toString() => r'proposalDetailsProvider';
}
