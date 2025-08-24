import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// A service to manage user-selected countries for data synchronization.
class CountrySelectionService {
  final ConfigRepository _configRepository;

  /// The key used to store the list of selected country ISO codes in the config.
  static const String configKey = 'config_selected_country_iso_codes';

  CountrySelectionService(this._configRepository);

  /// Retrieves the list of selected country ISO codes.
  ///
  /// Returns a list of strings, where each string is an ISO code (e.g., "US").
  Future<List<String>> getSelectedCountryCodes() async {
    final config = await _configRepository.getConfig(configKey);
    if (config != null && config['codes'] is List) {
      // Ensure all items from the stored list are treated as strings.
      return List<String>.from(config['codes'].map((item) => item.toString()));
    }
    // Return an empty list if no configuration is found.
    return [];
  }

  /// Saves the list of selected country ISO codes.
  ///
  /// Takes a list of strings, where each string is an ISO code.
  Future<void> _saveSelectedCountryCodes(List<String> isoCodes) async {
    await _configRepository.saveConfig(configKey, {'codes': isoCodes});
  }

  /// Adds a country to the selection.
  ///
  /// Takes an ISO code string and adds it to the list of selected countries.
  Future<void> addCountry(String isoCode) async {
    final currentCodes = await getSelectedCountryCodes();
    if (!currentCodes.contains(isoCode)) {
      final newCodes = [...currentCodes, isoCode];
      await _saveSelectedCountryCodes(newCodes);
    }
  }

  /// Removes a country from the selection.
  ///
  /// Takes an ISO code string and removes it from the list of selected countries.
  Future<void> removeCountry(String isoCode) async {
    final currentCodes = await getSelectedCountryCodes();
    if (currentCodes.contains(isoCode)) {
      final newCodes = currentCodes.where((code) => code != isoCode).toList();
      await _saveSelectedCountryCodes(newCodes);
    }
  }
}