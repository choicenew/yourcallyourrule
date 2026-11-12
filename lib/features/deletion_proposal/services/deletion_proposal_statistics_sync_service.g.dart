// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_statistics_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeletionProposalStatisticsSyncService)
final deletionProposalStatisticsSyncServiceProvider =
    DeletionProposalStatisticsSyncServiceProvider._();

final class DeletionProposalStatisticsSyncServiceProvider
    extends $NotifierProvider<DeletionProposalStatisticsSyncService, void> {
  DeletionProposalStatisticsSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalStatisticsSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deletionProposalStatisticsSyncServiceHash();

  @$internal
  @override
  DeletionProposalStatisticsSyncService create() =>
      DeletionProposalStatisticsSyncService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$deletionProposalStatisticsSyncServiceHash() =>
    r'91b9d4e6427a0810f2b41b81382d7921e2320b5a';

abstract class _$DeletionProposalStatisticsSyncService extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
