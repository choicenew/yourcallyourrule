// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_limit_config_sync_scheduler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalLimitConfigSyncScheduler)
const proposalLimitConfigSyncSchedulerProvider =
    ProposalLimitConfigSyncSchedulerProvider._();

final class ProposalLimitConfigSyncSchedulerProvider
    extends
        $FunctionalProvider<
          ProposalLimitConfigSyncScheduler,
          ProposalLimitConfigSyncScheduler,
          ProposalLimitConfigSyncScheduler
        >
    with $Provider<ProposalLimitConfigSyncScheduler> {
  const ProposalLimitConfigSyncSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalLimitConfigSyncSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalLimitConfigSyncSchedulerHash();

  @$internal
  @override
  $ProviderElement<ProposalLimitConfigSyncScheduler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalLimitConfigSyncScheduler create(Ref ref) {
    return proposalLimitConfigSyncScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalLimitConfigSyncScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalLimitConfigSyncScheduler>(
        value,
      ),
    );
  }
}

String _$proposalLimitConfigSyncSchedulerHash() =>
    r'34a718721e113f2351ccf271880aa962d48333e0';
