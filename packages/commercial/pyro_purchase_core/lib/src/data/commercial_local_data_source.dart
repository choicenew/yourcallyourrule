import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pyro_config_local/config_repository.dart';
import 'package:pyro_config_local/config_backup_provider.dart';
import 'package:pyro_purchase_protocol/pyro_purchase_protocol.dart';

part 'commercial_local_data_source.g.dart';

/// 商业变现与权益的本地存储数据源 (Data Source)
/// 隔离存储键名与底层数据库/KV 操作
class CommercialLocalDataSource {
  final ConfigRepository _configRepository;

  static const String _keyIsPurchased = 'config_isPurchasesEnabled';
  static const String _keyHasTempPurchase = 'config_hasTempPurchase';
  static const String _keyTempExpiryDate = 'config_tempPurchaseExpiryDate';

  CommercialLocalDataSource(this._configRepository);

  /// 从本地加载当前 CommercialState 状态
  Future<CommercialState> loadCommercialState() async {
    final isPurchasedConfig = await _configRepository.getConfig(_keyIsPurchased);
    final isPurchased = isPurchasedConfig?['value'] as bool? ?? false;

    final hasTempConfig = await _configRepository.getConfig(_keyHasTempPurchase);
    final isAdFree = hasTempConfig?['value'] as bool? ?? false;

    final expiryConfig = await _configRepository.getConfig(_keyTempExpiryDate);
    final expiryMs = expiryConfig?['value'] as int?;
    DateTime? tempExpiryDate;
    if (expiryMs != null) {
      tempExpiryDate = DateTime.fromMillisecondsSinceEpoch(expiryMs);
    }

    return CommercialState(
      isPurchased: isPurchased,
      isAdFree: isAdFree,
      tempExpiryDate: tempExpiryDate,
    );
  }

  /// 持久化更新付费状态
  Future<void> savePurchasedStatus(bool isPurchased) async {
    await _configRepository.saveConfig(_keyIsPurchased, {'value': isPurchased});
  }

  /// 持久化更新临时免广告/特权状态及到期时间
  Future<void> saveTempAdFreeStatus(bool isAdFree, DateTime expiryDate) async {
    await _configRepository.saveConfig(_keyHasTempPurchase, {'value': isAdFree});
    await _configRepository.saveConfig(_keyTempExpiryDate, {'value': expiryDate.millisecondsSinceEpoch});
  }
}

@Riverpod(keepAlive: true)
CommercialLocalDataSource commercialLocalDataSource(Ref ref) {
  final configRepo = ref.watch(configRepositoryProvider);
  return CommercialLocalDataSource(configRepo);
}
