// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_database_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userDatabaseService)
final userDatabaseServiceProvider = UserDatabaseServiceProvider._();

final class UserDatabaseServiceProvider
    extends
        $FunctionalProvider<
          UserDatabaseService,
          UserDatabaseService,
          UserDatabaseService
        >
    with $Provider<UserDatabaseService> {
  UserDatabaseServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDatabaseServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDatabaseServiceHash();

  @$internal
  @override
  $ProviderElement<UserDatabaseService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserDatabaseService create(Ref ref) {
    return userDatabaseService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserDatabaseService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserDatabaseService>(value),
    );
  }
}

String _$userDatabaseServiceHash() =>
    r'9ee4493446d0054717e16d490987403f2692e3b3';
