// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// CountryDataService 的 @Riverpod Provider

@ProviderFor(countryDataService)
final countryDataServiceProvider = CountryDataServiceProvider._();

/// CountryDataService 的 @Riverpod Provider

final class CountryDataServiceProvider
    extends
        $FunctionalProvider<
          CountryDataService,
          CountryDataService,
          CountryDataService
        >
    with $Provider<CountryDataService> {
  /// CountryDataService 的 @Riverpod Provider
  CountryDataServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryDataServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryDataServiceHash();

  @$internal
  @override
  $ProviderElement<CountryDataService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CountryDataService create(Ref ref) {
    return countryDataService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountryDataService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountryDataService>(value),
    );
  }
}

String _$countryDataServiceHash() =>
    r'82825c507a04751b8d522e977939583169a300a9';
