import 'package:yourcallyourrule/features/language/config/locale_config.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

class LocaleService {
  final ConfigRepository _configRepository;

  LocaleService(this._configRepository);

  Future<LocaleConfig?> loadConfig() async {
    final configMap = await _configRepository.getConfig('locale_settings');
    return configMap != null 
      ? LocaleConfig.fromMap(configMap)
      : LocaleConfig(languageCode: 'en', countryCode: 'US');
  }

  Future<void> saveConfig(dynamic configOrLanguageCode, [String? countryCode]) async {
    if (configOrLanguageCode is LocaleConfig) {
      await _configRepository.saveConfig('locale_settings', configOrLanguageCode.toMap());
    } else if (configOrLanguageCode is String) {
      final config = LocaleConfig(
        languageCode: configOrLanguageCode,
        countryCode: countryCode ?? 'US',
      );
      await _configRepository.saveConfig('locale_settings', config.toMap());
    }
  }
}