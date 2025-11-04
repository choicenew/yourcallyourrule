// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalDataSource)
const proposalDataSourceProvider = ProposalDataSourceProvider._();

final class ProposalDataSourceProvider
    extends
        $FunctionalProvider<
          ProposalDataSource,
          ProposalDataSource,
          ProposalDataSource
        >
    with $Provider<ProposalDataSource> {
  const ProposalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProposalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalDataSource create(Ref ref) {
    return proposalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalDataSource>(value),
    );
  }
}

String _$proposalDataSourceHash() =>
    r'b85a3d4cfb7204cf9fff31038852ea8d262746a1';

@ProviderFor(proposalRepository)
const proposalRepositoryProvider = ProposalRepositoryProvider._();

final class ProposalRepositoryProvider
    extends
        $FunctionalProvider<
          ProposalRepository,
          ProposalRepository,
          ProposalRepository
        >
    with $Provider<ProposalRepository> {
  const ProposalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalRepositoryProvider',
        isAutoDispose: true,
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
    r'9ac41f94fde800730e3915e7fafc9bf568b9bb9c';
