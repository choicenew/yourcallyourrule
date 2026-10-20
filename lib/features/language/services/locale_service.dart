import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/language/config/locale_config.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

part 'locale_service.g.dart';

/// LocaleService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
LocaleService localeService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return LocaleService(configRepository);
}

class LocaleService {
  final ConfigRepository _configRepository;
  static const String _configKey = 'config_locale_settings';

  LocaleService(this._configRepository);

  Future<LocaleConfig?> loadConfig() async {
    final configMap = await _configRepository.getConfig(_configKey);
    return configMap != null 
      ? LocaleConfig.fromMap(configMap)
      : LocaleConfig(languageCode: 'en', countryCode: 'US');
  }

  Future<void> saveConfig(dynamic configOrLanguageCode, [String? countryCode]) async {
    if (configOrLanguageCode is LocaleConfig) {
      await _configRepository.saveConfig(_configKey, configOrLanguageCode.toMap());
    } else if (configOrLanguageCode is String) {
      final config = LocaleConfig(
        languageCode: configOrLanguageCode,
        countryCode: countryCode ?? 'US',
      );
      await _configRepository.saveConfig(_configKey, config.toMap());
    }
  }
}