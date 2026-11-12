// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_scheduler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SyncScheduler Provider

@ProviderFor(syncScheduler)
final syncSchedulerProvider = SyncSchedulerProvider._();

/// SyncScheduler Provider

final class SyncSchedulerProvider
    extends $FunctionalProvider<SyncScheduler, SyncScheduler, SyncScheduler>
    with $Provider<SyncScheduler> {
  /// SyncScheduler Provider
  SyncSchedulerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'syncSchedulerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$syncSchedulerHash();

  @$internal
  @override
  $ProviderElement<SyncScheduler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SyncScheduler create(Ref ref) {
    return syncScheduler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SyncScheduler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SyncScheduler>(value),
    );
  }
}

String _$syncSchedulerHash() => r'4ae0a9f3fcb65a6fd8389f06fdc915ef7d154b53';
