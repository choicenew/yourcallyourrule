// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposal_control_center.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deletionProposalControlCenter)
final deletionProposalControlCenterProvider =
    DeletionProposalControlCenterProvider._();

final class DeletionProposalControlCenterProvider
    extends
        $FunctionalProvider<
          DeletionProposalControlCenter,
          DeletionProposalControlCenter,
          DeletionProposalControlCenter
        >
    with $Provider<DeletionProposalControlCenter> {
  DeletionProposalControlCenterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposalControlCenterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletionProposalControlCenterHash();

  @$internal
  @override
  $ProviderElement<DeletionProposalControlCenter> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletionProposalControlCenter create(Ref ref) {
    return deletionProposalControlCenter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletionProposalControlCenter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletionProposalControlCenter>(
        value,
      ),
    );
  }
}

String _$deletionProposalControlCenterHash() =>
    r'53712a222284c53b362846612548253d1bc8dfc4';
