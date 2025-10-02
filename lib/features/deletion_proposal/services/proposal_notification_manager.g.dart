// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_notification_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalNotificationManager)
const proposalNotificationManagerProvider =
    ProposalNotificationManagerProvider._();

final class ProposalNotificationManagerProvider
    extends
        $FunctionalProvider<
          ProposalNotificationManager,
          ProposalNotificationManager,
          ProposalNotificationManager
        >
    with $Provider<ProposalNotificationManager> {
  const ProposalNotificationManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalNotificationManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalNotificationManagerHash();

  @$internal
  @override
  $ProviderElement<ProposalNotificationManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalNotificationManager create(Ref ref) {
    return proposalNotificationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalNotificationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalNotificationManager>(value),
    );
  }
}

String _$proposalNotificationManagerHash() =>
    r'3d795f0dad6fbc0a35da793b6cdebdd22227609a';
