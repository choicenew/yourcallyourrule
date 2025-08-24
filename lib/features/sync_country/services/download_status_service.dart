// 文件: features/sync_country/services/download_status_service.dart

import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';

/// 一个专门的服务，只负责追踪哪些国家的数据已被完整下载到本地。
class DownloadStatusService {
  final ConfigRepository _configRepository;

  // 使用一个独立的 Key 来存储下载状态，与用户选择完全分开。
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