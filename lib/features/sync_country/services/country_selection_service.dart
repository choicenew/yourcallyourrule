import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

part 'country_selection_service.g.dart';

/// CountrySelectionService Riverpod Provider
@Riverpod(keepAlive: true)
CountrySelectionService countrySelectionService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return CountrySelectionService(configRepository);
}

/// A service to manage user-selected countries for data synchronization.
class CountrySelectionService {
  final ConfigRepository _configRepository;

  /// The key used to store the list of selected country ISO codes in the config.
  static const String configKey = 'config_selected_country_iso_codes';

  /// The key used inside the stored map for the codes list.
  static const String codesMapKey = 'codes';

  CountrySelectionService(this._configRepository);

  /// Retrieves the list of selected country ISO codes.
  Future<List<String>> getSelectedCountryCodes() async {
    final config = await _configRepository.getConfig(configKey);
    if (config != null && config[codesMapKey] is List) {
      return List<String>.from(config[codesMapKey].map((item) => item.toString()));
    }
    return [];
  }

  /// Saves the list of selected country ISO codes.
  Future<void> _saveSelectedCountryCodes(List<String> isoCodes) async {
    await _configRepository.saveConfig(configKey, {codesMapKey: isoCodes});
  }

  /// Adds a country to the selection.
  Future<void> addCountry(String isoCode) async {
    final currentCodes = await getSelectedCountryCodes();
    if (!currentCodes.contains(isoCode)) {
      final newCodes = [...currentCodes, isoCode];
      await _saveSelectedCountryCodes(newCodes);
    }
  }

  /// Removes a country from the selection.
  Future<void> removeCountry(String isoCode) async {
    final currentCodes = await getSelectedCountryCodes();
    if (currentCodes.contains(isoCode)) {
      final newCodes = currentCodes.where((code) => code != isoCode).toList();
      await _saveSelectedCountryCodes(newCodes);
    }
  }
}