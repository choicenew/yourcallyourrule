import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

part 'download_status_service.g.dart';

/// DownloadStatusService Riverpod Provider
@Riverpod(keepAlive: true)
DownloadStatusService downloadStatusService(Ref ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return DownloadStatusService(configRepository);
}

/// 一个专门的服务，只负责追踪哪些国家的数据已被完整下载到本地。
class DownloadStatusService {
  final ConfigRepository _configRepository;

  static const String _downloadedCountriesKey = 'config_downloaded_country_iso_codes';

  const DownloadStatusService(this._configRepository);

  /// 获取已完整下载的国家列表。
  Future<List<String>> getDownloadedCountries() async {
    final config = await _configRepository.getConfig(_downloadedCountriesKey);
    if (config != null && config['codes'] is List) {
      return List<String>.from(config['codes']);
    }
    return [];
  }

  /// 标记一个国家为已下载。
  Future<void> markAsDownloaded(String countryCode) async {
    final currentCodes = (await getDownloadedCountries()).toSet();
    if (!currentCodes.contains(countryCode)) {
      currentCodes.add(countryCode);
      await _configRepository.saveConfig(_downloadedCountriesKey, {'codes': currentCodes.toList()});
    }
  }

  /// 移除一个国家的已下载标记。
  Future<void> unmarkAsDownloaded(String countryCode) async {
    final currentCodes = (await getDownloadedCountries()).toSet();
    if (currentCodes.contains(countryCode)) {
      currentCodes.remove(countryCode);
      await _configRepository.saveConfig(_downloadedCountriesKey, {'codes': currentCodes.toList()});
    }
  }
}