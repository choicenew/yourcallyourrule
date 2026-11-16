// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_log_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 通话日志仓库提供者 (直连 Drift LocalDatabase)

@ProviderFor(callLogRepository)
final callLogRepositoryProvider = CallLogRepositoryProvider._();

/// 通话日志仓库提供者 (直连 Drift LocalDatabase)

final class CallLogRepositoryProvider
    extends
        $FunctionalProvider<
          CallLogRepository,
          CallLogRepository,
          CallLogRepository
        >
    with $Provider<CallLogRepository> {
  /// 通话日志仓库提供者 (直连 Drift LocalDatabase)
  CallLogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'callLogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$callLogRepositoryHash();

  @$internal
  @override
  $ProviderElement<CallLogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CallLogRepository create(Ref ref) {
    return callLogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CallLogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CallLogRepository>(value),
    );
  }
}

String _$callLogRepositoryHash() => r'6586eee9cadf42b93da578452c58a3afd58e4112';
