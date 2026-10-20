// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deletion_proposer_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deletionProposerService)
final deletionProposerServiceProvider = DeletionProposerServiceProvider._();

final class DeletionProposerServiceProvider
    extends
        $FunctionalProvider<
          DeletionProposerService,
          DeletionProposerService,
          DeletionProposerService
        >
    with $Provider<DeletionProposerService> {
  DeletionProposerServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionProposerServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletionProposerServiceHash();

  @$internal
  @override
  $ProviderElement<DeletionProposerService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletionProposerService create(Ref ref) {
    return deletionProposerService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletionProposerService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletionProposerService>(value),
    );
  }
}

String _$deletionProposerServiceHash() =>
    r'99cc0695ce4f1d3d87b30352ac9992e27cd70d28';
