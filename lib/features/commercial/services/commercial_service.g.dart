// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commercial_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(commercialService)
final commercialServiceProvider = CommercialServiceProvider._();

final class CommercialServiceProvider
    extends
        $FunctionalProvider<
          CommercialService,
          CommercialService,
          CommercialService
        >
    with $Provider<CommercialService> {
  CommercialServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commercialServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commercialServiceHash();

  @$internal
  @override
  $ProviderElement<CommercialService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommercialService create(Ref ref) {
    return commercialService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommercialService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommercialService>(value),
    );
  }
}

String _$commercialServiceHash() => r'00f4d40c611926319b5074ab83b30308e48ce48b';
