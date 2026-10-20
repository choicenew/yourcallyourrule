// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// DeletionProposalService 的 @Riverpod Provider

@ProviderFor(deletionProposalService)
final deletionProposalServiceProvider = DeletionProposalServiceProvider._();

/// DeletionProposalService 的 @Riverpod Provider

final class DeletionProposalServiceProvider
    extends
        $FunctionalProvider<
          DeletionProposalService,
          DeletionProposalService,
          DeletionProposalService
        >
    with $Provider<DeletionProposalService> {
  /// DeletionProposalService 的 @Riverpod Provider
  DeletionProposalServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletionProposalServiceHash();

  @$internal
  @override
  $ProviderElement<DeletionProposalService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletionProposalService create(Ref ref) {
    return deletionProposalService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletionProposalService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletionProposalService>(value),
    );
  }
}

String _$deletionProposalServiceHash() =>
    r'd5148d80f0cc5e813bbb0631d43be8240b4c4989';
