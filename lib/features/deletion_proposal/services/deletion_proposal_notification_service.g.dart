// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_notification_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deletionProposalNotificationService)
const deletionProposalNotificationServiceProvider =
    DeletionProposalNotificationServiceProvider._();

final class DeletionProposalNotificationServiceProvider
    extends
        $FunctionalProvider<
          DeletionProposalNotificationService,
          DeletionProposalNotificationService,
          DeletionProposalNotificationService
        >
    with $Provider<DeletionProposalNotificationService> {
  const DeletionProposalNotificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalNotificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$deletionProposalNotificationServiceHash();

  @$internal
  @override
  $ProviderElement<DeletionProposalNotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletionProposalNotificationService create(Ref ref) {
    return deletionProposalNotificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletionProposalNotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletionProposalNotificationService>(
        value,
      ),
    );
  }
}

String _$deletionProposalNotificationServiceHash() =>
    r'bb4fb93b4fa33da6f48dd0a00f7f8ce0fd865a23';
