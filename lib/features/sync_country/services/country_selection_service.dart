import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// A service to manage user-selected countries for data synchronization.
class CountrySelectionService {
  final ConfigRepository _configRepository;

  /// The key used to store the list of selected country dial codes in the config.
  /// The key is prefixed with "config_" as requested.
  static const String configKey = 'config_selected_countries';

  CountrySelectionService(this._configRepository);

  /// Retrieves the list of selected country dial codes.
  ///
  /// Returns a list of strings, where each string is a dial code (e.g., "+86").
  Future<List<String>> getSelectedCountryDialCodes() async {
    final config = await _configRepository.getConfig(configKey);
    if (config != null && config['codes'] is List) {
      // Ensure all items from the stored list are treated as strings.
      return List<String>.from(config['codes'].map((item) => item.toString()));
    }
    // Return an empty list if no configuration is found.
    return [];
  }

  /// Saves the list of selected country dial codes. This is now a private method.
  ///
  /// Takes a list of strings, where each string is a dial code.
  Future<void> _saveSelectedCountryDialCodes(List<String> dialCodes) async {
    await _configRepository.saveConfig(configKey, {'codes': dialCodes});
  }

  /// Adds a country to the selection.
  ///
  /// Takes a dial code string and adds it to the list of selected countries.
  Future<void> addCountry(String dialCode) async {
    final currentCodes = await getSelectedCountryDialCodes();
    if (!currentCodes.contains(dialCode)) {
      final newCodes = [...currentCodes, dialCode];
      await _saveSelectedCountryDialCodes(newCodes);
    }
  }

  /// Removes a country from the selection.
  ///
  /// Takes a dial code string and removes it from the list of selected countries.
  Future<void> removeCountry(String dialCode) async {
    final currentCodes = await getSelectedCountryDialCodes();
    if (currentCodes.contains(dialCode)) {
      final newCodes = currentCodes.where((code) => code != dialCode).toList();
      await _saveSelectedCountryDialCodes(newCodes);
    }
  }
}