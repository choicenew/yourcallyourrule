import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';
import 'package:yourcallyourrule/features/sync_country/services/country_selection_service.dart';

part 'country_selection_provider.g.dart';

/// Provider for the [CountrySelectionService].
///
/// This provider creates an instance of the service, injecting the necessary
/// [ConfigRepository] dependency.
final countrySelectionServiceProvider = Provider<CountrySelectionService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return CountrySelectionService(configRepository);
});

/// Notifier for managing the list of selected country iso codes.
///
/// This notifier handles loading, adding, and removing selected countries.
@riverpod
class SelectedCountries extends _$SelectedCountries {
  @override
  FutureOr<List<String>> build() async {
    final service = ref.watch(countrySelectionServiceProvider);
    return await service.getSelectedCountryCodes();
  }

  /// Adds a country by delegating to the service and reloads the list.
  Future<void> addCountry(String countryIsoCode) async {
    final service = ref.read(countrySelectionServiceProvider);
    await service.addCountry(countryIsoCode);
    ref.invalidateSelf();
  }

  /// Removes a country by delegating to the service and reloads the list.
  Future<void> removeCountry(String countryIsoCode) async {
    final service = ref.read(countrySelectionServiceProvider);
    await service.removeCountry(countryIsoCode);
    ref.invalidateSelf();
  }
}