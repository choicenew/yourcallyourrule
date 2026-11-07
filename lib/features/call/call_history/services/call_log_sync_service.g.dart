// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_sync_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 通话记录同步服务提供者

@ProviderFor(callLogSyncService)
final callLogSyncServiceProvider = CallLogSyncServiceProvider._();

/// 通话记录同步服务提供者

final class CallLogSyncServiceProvider
    extends
        $FunctionalProvider<
          CallLogSyncService,
          CallLogSyncService,
          CallLogSyncService
        >
    with $Provider<CallLogSyncService> {
  /// 通话记录同步服务提供者
  CallLogSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLogSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callLogSyncServiceHash();

  @$internal
  @override
  $ProviderElement<CallLogSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallLogSyncService create(Ref ref) {
    return callLogSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallLogSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallLogSyncService>(value),
    );
  }
}

String _$callLogSyncServiceHash() =>
    r'5762717826746a1d64dae5ef66d0952efea6fac6';
