// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalRepository)
final proposalRepositoryProvider = ProposalRepositoryProvider._();

final class ProposalRepositoryProvider
    extends
        $FunctionalProvider<
          ProposalRepository,
          ProposalRepository,
          ProposalRepository
        >
    with $Provider<ProposalRepository> {
  ProposalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProposalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalRepository create(Ref ref) {
    return proposalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalRepository>(value),
    );
  }
}

String _$proposalRepositoryHash() =>
    r'fd3516b3899631922eb77f30cb088c55357ec164';
