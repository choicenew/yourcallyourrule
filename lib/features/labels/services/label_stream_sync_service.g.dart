// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_stream_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(labelStreamSyncService)
final labelStreamSyncServiceProvider = LabelStreamSyncServiceProvider._();

final class LabelStreamSyncServiceProvider
    extends
        $FunctionalProvider<
          LabelStreamSyncService,
          LabelStreamSyncService,
          LabelStreamSyncService
        >
    with $Provider<LabelStreamSyncService> {
  LabelStreamSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelStreamSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelStreamSyncServiceHash();

  @$internal
  @override
  $ProviderElement<LabelStreamSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LabelStreamSyncService create(Ref ref) {
    return labelStreamSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelStreamSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelStreamSyncService>(value),
    );
  }
}

String _$labelStreamSyncServiceHash() =>
    r'5d88d1002b4f56138ce827b2eeb6fffbf6e2783e';
