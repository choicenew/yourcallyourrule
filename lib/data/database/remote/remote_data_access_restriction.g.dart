// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_data_access_restriction.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// RemoteDataAccessRestriction 的 @Riverpod Provider

@ProviderFor(remoteDataAccessRestriction)
final remoteDataAccessRestrictionProvider =
    RemoteDataAccessRestrictionProvider._();

/// RemoteDataAccessRestriction 的 @Riverpod Provider

final class RemoteDataAccessRestrictionProvider
    extends
        $FunctionalProvider<
          RemoteDataAccessRestriction,
          RemoteDataAccessRestriction,
          RemoteDataAccessRestriction
        >
    with $Provider<RemoteDataAccessRestriction> {
  /// RemoteDataAccessRestriction 的 @Riverpod Provider
  RemoteDataAccessRestrictionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteDataAccessRestrictionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteDataAccessRestrictionHash();

  @$internal
  @override
  $ProviderElement<RemoteDataAccessRestriction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteDataAccessRestriction create(Ref ref) {
    return remoteDataAccessRestriction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteDataAccessRestriction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteDataAccessRestriction>(value),
    );
  }
}

String _$remoteDataAccessRestrictionHash() =>
    r'3afb692094b31397c090ae59a62a2d363badce7c';
