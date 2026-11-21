// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_selection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the [CountrySelectionService].

@ProviderFor(countrySelectionService)
final countrySelectionServiceProvider = CountrySelectionServiceProvider._();

/// Provider for the [CountrySelectionService].

final class CountrySelectionServiceProvider
    extends
        $FunctionalProvider<
          CountrySelectionService,
          CountrySelectionService,
          CountrySelectionService
        >
    with $Provider<CountrySelectionService> {
  /// Provider for the [CountrySelectionService].
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

/// Notifier for managing the list of selected country iso codes.

@ProviderFor(SelectedCountries)
final selectedCountriesProvider = SelectedCountriesProvider._();

/// Notifier for managing the list of selected country iso codes.
final class SelectedCountriesProvider
    extends $AsyncNotifierProvider<SelectedCountries, List<String>> {
  /// Notifier for managing the list of selected country iso codes.
  SelectedCountriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCountriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCountriesHash();

  @$internal
  @override
  SelectedCountries create() => SelectedCountries();
}

String _$selectedCountriesHash() => r'f5a01d816ec2f2eb82fc9126f60d1acf5398485b';

/// Notifier for managing the list of selected country iso codes.

abstract class _$SelectedCountries extends $AsyncNotifier<List<String>> {
  FutureOr<List<String>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
