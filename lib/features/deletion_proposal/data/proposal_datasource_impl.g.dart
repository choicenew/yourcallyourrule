// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_datasource_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalDataSource)
final proposalDataSourceProvider = ProposalDataSourceProvider._();

final class ProposalDataSourceProvider
    extends
        $FunctionalProvider<
          ProposalDataSource,
          ProposalDataSource,
          ProposalDataSource
        >
    with $Provider<ProposalDataSource> {
  ProposalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalDataSourceProvider',
        isAutoDispose: false,
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
    r'4514a7abc02cd2ecab807fa75548defa245dd02e';
