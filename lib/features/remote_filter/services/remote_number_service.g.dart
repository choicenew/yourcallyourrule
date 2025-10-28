// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_number_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RemoteNumberService 的 @riverpod Provider

@ProviderFor(remoteNumberService)
const remoteNumberServiceProvider = RemoteNumberServiceProvider._();

/// RemoteNumberService 的 @riverpod Provider

final class RemoteNumberServiceProvider
    extends
        $FunctionalProvider<
          RemoteNumberService,
          RemoteNumberService,
          RemoteNumberService
        >
    with $Provider<RemoteNumberService> {
  /// RemoteNumberService 的 @riverpod Provider
  const RemoteNumberServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteNumberServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteNumberServiceHash();

  @$internal
  @override
  $ProviderElement<RemoteNumberService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteNumberService create(Ref ref) {
    return remoteNumberService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteNumberService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteNumberService>(value),
    );
  }
}

String _$remoteNumberServiceHash() =>
    r'd414362505b6866f4dd649c02c0e31fb18f47bef';
