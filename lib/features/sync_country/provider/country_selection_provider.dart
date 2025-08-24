import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/features/sync_country/services/country_selection_service.dart';

/// Provider for the [CountrySelectionService].
///
/// This provider creates an instance of the service, injecting the necessary
/// [ConfigRepository] dependency.
final countrySelectionServiceProvider = Provider<CountrySelectionService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return CountrySelectionService(configRepository);
});

/// StateNotifierProvider for managing the list of selected country iso codes.
///
/// This provider exposes a [CountrySelectionNotifier] that handles loading,
/// adding, and removing selected countries.
final selectedCountriesProvider = StateNotifierProvider<CountrySelectionNotifier, AsyncValue<List<String>>>((ref) {
  final service = ref.watch(countrySelectionServiceProvider);
  return CountrySelectionNotifier(service);
});

/// A StateNotifier that manages the state of selected country iso codes.
class CountrySelectionNotifier extends StateNotifier<AsyncValue<List<String>>> {
  final CountrySelectionService _service;

  CountrySelectionNotifier(this._service) : super(const AsyncValue.loading()) {
    _loadSelectedCountries();
  }

  /// Loads the selected countries from the service and updates the state.
  Future<void> _loadSelectedCountries() async {
    try {
      state = const AsyncValue.loading();
      final countries = await _service.getSelectedCountryCodes();
      state = AsyncValue.data(countries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Adds a country by delegating to the service and reloads the list.
  Future<void> addCountry(String countryIsoCode) async {
    try {
      await _service.addCountry(countryIsoCode);
      _loadSelectedCountries();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Removes a country by delegating to the service and reloads the list.
  Future<void> removeCountry(String countryIsoCode) async {
    try {
      await _service.removeCountry(countryIsoCode);
      _loadSelectedCountries();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}