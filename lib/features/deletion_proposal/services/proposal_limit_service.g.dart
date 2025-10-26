// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_limit_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalLimitService)
const proposalLimitServiceProvider = ProposalLimitServiceProvider._();

final class ProposalLimitServiceProvider
    extends
        $FunctionalProvider<
          ProposalLimitService,
          ProposalLimitService,
          ProposalLimitService
        >
    with $Provider<ProposalLimitService> {
  const ProposalLimitServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalLimitServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalLimitServiceHash();

  @$internal
  @override
  $ProviderElement<ProposalLimitService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalLimitService create(Ref ref) {
    return proposalLimitService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalLimitService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalLimitService>(value),
    );
  }
}

String _$proposalLimitServiceHash() =>
    r'feaf94ec0e2a0546360b9741351472ad44ea48fb';
