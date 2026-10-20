// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_mark_statistics_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// LabelMarkStatisticsSyncService 的 @Riverpod Provider

@ProviderFor(labelMarkStatisticsSyncService)
final labelMarkStatisticsSyncServiceProvider =
    LabelMarkStatisticsSyncServiceProvider._();

/// LabelMarkStatisticsSyncService 的 @Riverpod Provider

final class LabelMarkStatisticsSyncServiceProvider
    extends
        $FunctionalProvider<
          LabelMarkStatisticsSyncService,
          LabelMarkStatisticsSyncService,
          LabelMarkStatisticsSyncService
        >
    with $Provider<LabelMarkStatisticsSyncService> {
  /// LabelMarkStatisticsSyncService 的 @Riverpod Provider
  LabelMarkStatisticsSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelMarkStatisticsSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelMarkStatisticsSyncServiceHash();

  @$internal
  @override
  $ProviderElement<LabelMarkStatisticsSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabelMarkStatisticsSyncService create(Ref ref) {
    return labelMarkStatisticsSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelMarkStatisticsSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelMarkStatisticsSyncService>(
        value,
      ),
    );
  }
}

String _$labelMarkStatisticsSyncServiceHash() =>
    r'5a8b51b10c46ceb58dc67faab9d8ab9b805cb0a1';
