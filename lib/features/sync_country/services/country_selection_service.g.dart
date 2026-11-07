// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_selection_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CountrySelectionService 的 @Riverpod Provider

@ProviderFor(countrySelectionService)
final countrySelectionServiceProvider = CountrySelectionServiceProvider._();

/// CountrySelectionService 的 @Riverpod Provider

final class CountrySelectionServiceProvider
    extends
        $FunctionalProvider<
          CountrySelectionService,
          CountrySelectionService,
          CountrySelectionService
        >
    with $Provider<CountrySelectionService> {
  /// CountrySelectionService 的 @Riverpod Provider
  CountrySelectionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countrySelectionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countrySelectionServiceHash();

  @$internal
  @override
  $ProviderElement<CountrySelectionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CountrySelectionService create(Ref ref) {
    return countrySelectionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountrySelectionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountrySelectionService>(value),
    );
  }
}

String _$countrySelectionServiceHash() =>
    r'6e2881c68f307fd53c8bb675876cc9e0389a046a';
