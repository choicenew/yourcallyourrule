// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 远程号码仓库提供者

@ProviderFor(remoteNumberRepository)
final remoteNumberRepositoryProvider = RemoteNumberRepositoryProvider._();

/// 远程号码仓库提供者

final class RemoteNumberRepositoryProvider
    extends
        $FunctionalProvider<
          RemoteNumberRepositoryImpl,
          RemoteNumberRepositoryImpl,
          RemoteNumberRepositoryImpl
        >
    with $Provider<RemoteNumberRepositoryImpl> {
  /// 远程号码仓库提供者
  RemoteNumberRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteNumberRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteNumberRepositoryHash();

  @$internal
  @override
  $ProviderElement<RemoteNumberRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteNumberRepositoryImpl create(Ref ref) {
    return remoteNumberRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteNumberRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteNumberRepositoryImpl>(value),
    );
  }
}

String _$remoteNumberRepositoryHash() =>
    r'7e9781ac6189f2e315798ca9a9b2de1d9b825220';
