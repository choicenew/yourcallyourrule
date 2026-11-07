// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_drive_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cloudDriveHub)
const cloudDriveHubProvider = CloudDriveHubProvider._();

final class CloudDriveHubProvider
    extends $FunctionalProvider<CloudDriveHub, CloudDriveHub, CloudDriveHub>
    with $Provider<CloudDriveHub> {
  const CloudDriveHubProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'cloudDriveHubProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$cloudDriveHubHash();

  @$internal
  @override
  $ProviderElement<CloudDriveHub> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CloudDriveHub create(Ref ref) {
    return cloudDriveHub(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudDriveHub value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudDriveHub>(value),
    );
  }
}

String _$cloudDriveHubHash() => r'bafda5c43c311f3c9dd30985f9a19e84a7947497';

@ProviderFor(cloudDriveCryptoStorage)
const cloudDriveCryptoStorageProvider = CloudDriveCryptoStorageProvider._();

final class CloudDriveCryptoStorageProvider extends $FunctionalProvider<
    CloudDriveSecureStorage,
    CloudDriveSecureStorage,
    CloudDriveSecureStorage> with $Provider<CloudDriveSecureStorage> {
  const CloudDriveCryptoStorageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'cloudDriveCryptoStorageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$cloudDriveCryptoStorageHash();

  @$internal
  @override
  $ProviderElement<CloudDriveSecureStorage> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CloudDriveSecureStorage create(Ref ref) {
    return cloudDriveCryptoStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CloudDriveSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CloudDriveSecureStorage>(value),
    );
  }
}

String _$cloudDriveCryptoStorageHash() =>
    r'14f6fb973b9e227cba239de15ad4fc1f4185731b';

@ProviderFor(encryptionEnabled)
const encryptionEnabledProvider = EncryptionEnabledProvider._();

final class EncryptionEnabledProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const EncryptionEnabledProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'encryptionEnabledProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$encryptionEnabledHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return encryptionEnabled(ref);
  }
}

String _$encryptionEnabledHash() => r'87fecbcdbfe0418ef1a639ba2750ca7a23029eaf';

@ProviderFor(availableCloudProviders)
const availableCloudProvidersProvider = AvailableCloudProvidersProvider._();

final class AvailableCloudProvidersProvider
    extends $FunctionalProvider<List<Type>, List<Type>, List<Type>>
    with $Provider<List<Type>> {
  const AvailableCloudProvidersProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'availableCloudProvidersProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$availableCloudProvidersHash();

  @$internal
  @override
  $ProviderElement<List<Type>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Type> create(Ref ref) {
    return availableCloudProviders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Type> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Type>>(value),
    );
  }
}

String _$availableCloudProvidersHash() =>
    r'69d9ba54d2bd26d7d4434e91eec4e41533b56bd8';

@ProviderFor(providerConnectionState)
const providerConnectionStateProvider = ProviderConnectionStateFamily._();

final class ProviderConnectionStateProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const ProviderConnectionStateProvider._(
      {required ProviderConnectionStateFamily super.from,
      required dynamic super.argument})
      : super(
          retry: null,
          name: r'providerConnectionStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$providerConnectionStateHash();

  @override
  String toString() {
    return r'providerConnectionStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as dynamic;
    return providerConnectionState(
      ref,
      argument as Type,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProviderConnectionStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$providerConnectionStateHash() =>
    r'6ee3b85051ff604de8b30fcea93842b1a9fd9b27';

final class ProviderConnectionStateFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, dynamic> {
  const ProviderConnectionStateFamily._()
      : super(
          retry: null,
          name: r'providerConnectionStateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProviderConnectionStateProvider call(
    dynamic providerId,
  ) =>
      ProviderConnectionStateProvider._(argument: providerId, from: this);

  @override
  String toString() => r'providerConnectionStateProvider';
}
