// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_limit_config_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalLimitConfigService)
const proposalLimitConfigServiceProvider =
    ProposalLimitConfigServiceProvider._();

final class ProposalLimitConfigServiceProvider
    extends
        $FunctionalProvider<
          ProposalLimitConfigService,
          ProposalLimitConfigService,
          ProposalLimitConfigService
        >
    with $Provider<ProposalLimitConfigService> {
  const ProposalLimitConfigServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalLimitConfigServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalLimitConfigServiceHash();

  @$internal
  @override
  $ProviderElement<ProposalLimitConfigService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalLimitConfigService create(Ref ref) {
    return proposalLimitConfigService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalLimitConfigService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalLimitConfigService>(value),
    );
  }
}

String _$proposalLimitConfigServiceHash() =>
    r'f3cda02054654d8c467cc010ff4bed1fb28ed5a2';
